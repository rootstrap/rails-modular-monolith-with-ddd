module TransactionalOutbox
  class << self
    attr_accessor :configuration

    def configuration
      @configuration ||= TransactionalOutbox::Configuration.new
    end

    def reset
      @configuration = TransactionalOutbox::Configuration.new
    end

    def configure
      yield(configuration)
    end
  end

  class Configuration
    attr_accessor :outbox_mapping

    def initialize
      @outbox_mapping = {}
    end
  end
end
