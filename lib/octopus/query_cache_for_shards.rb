# query cache methods are moved to ConnectionPool for Rails >= 5.0
#
# when ActiveJob # deliver_later is invoked in test mode, this fails with
# undefined method `shards' for #<ActiveRecord::ConnectionAdapters::PostgreSQLAdapter:0x00007facb9b9a2b8>
# this is the reason for the respond_to? check
module Octopus
  module ConnectionPool
    module QueryCacheForShards
      %i(enable_query_cache! disable_query_cache!).each do |method|
        define_method(method) do
          if(Octopus.enabled? &&
            ActiveRecord::Base.connection.respond_to?(:shards) &&
            (shards = ActiveRecord::Base.connection.shards)['master'] == self)
            shards.each do |shard_name, v|
              if shard_name == 'master'
                super()
              else
                v.public_send(method)
              end
            end
          else
            super()
          end
        end
      end
    end
  end
end

ActiveRecord::ConnectionAdapters::ConnectionPool.send(:prepend, Octopus::ConnectionPool::QueryCacheForShards)
