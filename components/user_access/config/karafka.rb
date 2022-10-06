# frozen_string_literal: true

# Karafka app object
class KarafkaApp < Karafka::App
  routes.draw do
    consumer_group :user_access do
      topic "#{ENV["KAFKA_CONNECT_DB_SERVER_NAME"]}.public.user_access_outboxes" do
        consumer ::UserAccess::BatchBaseConsumer
      end
    end
  end
end
