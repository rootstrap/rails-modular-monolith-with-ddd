module UserAccess
  class BaseService
    def initialize(rollback: false)
      @rollback = rollback
    end

    def self.call
      new
    end

    def self.rollback
      new(rollback: true)
    end

    def perform(event_payload)
      @identifier = event_payload['identifier']
      @rollback ? rollback : call
    end

    def call
      raise 'You have to implement this method'
    end

    def rollback
      raise 'You have to implement this method'
    end
  end
end
