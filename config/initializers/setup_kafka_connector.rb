if !Rails.env.test? && defined?(Rails::Server) && ENV["SETUP_KAFKA_CONNECTOR"] == "true"
  # Register the connector once the kafka-connector service is running
  `curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" connect:8083/connectors/ -d @- << EOF
    {
      "name": "user-access-outbox-connector",
      "config": {
        "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
        "tasks.max": "1",
        "plugin.name": "pgoutput",
        "database.hostname": "#{ENV["PG_HOST"]}",
        "database.port": "#{ENV["PG_PORT"]}",
        "database.user": "#{ENV["PG_USER"]}",
        "database.password": "#{ENV["PG_PASSWORD"]}",
        "database.dbname": "user_access_#{Rails.env}",
        "database.server.name": "#{ENV["KAFKA_CONNECT_DB_SERVER_NAME"]}_user_access",
        "schema.include.list": "public",
        "table.include.list": "public.user_access_outboxes",
        "tombstones.on.delete": "false",
        "slot.name" : "user_access",
        "slot.drop_on_stop": "#{Rails.env.development?}"
      }
    }
  EOF`

  `curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" connect:8083/connectors/ -d @- << EOF
    {
      "name": "meetings-outbox-connector",
      "config": {
        "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
        "tasks.max": "1",
        "plugin.name": "pgoutput",
        "database.hostname": "#{ENV["PG_HOST"]}",
        "database.port": "#{ENV["PG_PORT"]}",
        "database.user": "#{ENV["PG_USER"]}",
        "database.password": "#{ENV["PG_PASSWORD"]}",
        "database.dbname": "meetings_#{Rails.env}",
        "database.server.name": "#{ENV["KAFKA_CONNECT_DB_SERVER_NAME"]}_meetings",
        "schema.include.list": "public",
        "table.include.list": "public.meetings_outboxes",
        "tombstones.on.delete": "false",
        "slot.name" : "meetings",
        "slot.drop_on_stop": "#{Rails.env.development?}"
      }
    }
  EOF`

  # To check if the connector registered properly
  # - Run `curl -i -X GET -H "Accept:application/json" localhost:8083/connectors/user-access-outbox-connector`
  # result = `curl -i -X GET -H "Accept:application/json" localhost:8083/connectors/user-access-outbox-connector`
  # puts result
  # # TODO: suggestion to run this with docker-compose to check if everything is working and if not raise an error.
  # if result != 'whatever'
  #   raise "The connector is not registered properly"
  # end
end
