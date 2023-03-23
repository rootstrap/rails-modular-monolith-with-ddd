module TransactionalOutbox
  class << self
    attr_accessor :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end
  end

  def configuration
    @configuration ||= Configuration.new
  end
end

class Configuration
  attr_accessor :outbox_mapping

  def initialize
    @outbox_mapping = {}
  end
end
