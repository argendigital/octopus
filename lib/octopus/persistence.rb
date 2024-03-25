module Octopus
  module Persistence
    def update_attribute(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end

    def update_attributes(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end

    def update_attributes!(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end

    def update(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end

    def update!(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end

    def reload(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end

    def delete
      run_on_shard { super }
    end

    def destroy
      run_on_shard { super }
    end

    def touch(*args, **kwargs)
      run_on_shard { super(*args, **kwargs) }
    end

    def update_column(*args, **kwargs)
      run_on_shard { super }
    end

    def increment!(...)
      run_on_shard { super(...) }
    end

    def decrement!(*args, **kwargs)
      run_on_shard { super }
    end
  end
end

ActiveRecord::Base.send(:include, Octopus::Persistence)
