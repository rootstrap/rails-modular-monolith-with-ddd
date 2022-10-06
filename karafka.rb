# frozen_string_literal: true

require ::File.expand_path('config/environment', __dir__)
Dir.glob('components/*/config').each do |component_config|
  karafka_path = "#{component_config}/karafka.rb"
  require_relative karafka_path if File.exists? karafka_path
end

# Karafka app object
class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = { 'bootstrap.servers': 'kafka:9092' }
    config.client_id = 'rails-modular-monolith-with-ddd'
    config.concurrency = 2
    config.max_wait_time = 500 # 0.5 second
    config.logger.level = :info
    # Recreate consumers with each batch. This will allow Rails code reload to work in the
    # development mode. Otherwise Karafka process would not be aware of code changes
    config.consumer_persistence = !Rails.env.development?
  end

  # Comment out this part if you are not using instrumentation and/or you are not
  # interested in logging events for certain environments. Since instrumentation
  # notifications add extra boilerplate, if you want to achieve max performance,
  # listen to only what you really need for given environment.
  Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new)
  # Karafka.monitor.subscribe(Karafka::Instrumentation::ProctitleListener.new)
  Karafka.producer.monitor.subscribe(
    WaterDrop::Instrumentation::LoggerListener.new(Karafka.logger)
  )

  routes.draw do
    # This needs to match queues defined in your ActiveJobs
    active_job_topic :default

    consumer_group :meetings do
      topic "#{ENV["KAFKA_CONNECT_DB_SERVER_NAME"]}.public.user_access_outboxes" do
        consumer Meetings::BatchBaseConsumer
      end
    end
  end
end
