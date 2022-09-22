if ENV["SETUP_KAFKA_CONNECTOR"] == "true"
  # Register the connector once the kafka-connector service is running
  `curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" connect:8083/connectors/ -d @- << EOF
    {
      "name": "user-access-outbox-connector",
      "config": {
        "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
        "tasks.max": "1",
        "plugin.name": "pgoutput",
        "database.hostname": "#{ENV["PG_HOST"]}",
        "database.port": "5432",
        "database.user": "#{ENV["PG_USER"]}",
        "database.password": "#{ENV["PG_PASSWORD"]}",
        "database.dbname": "rails_modular_monolith_with_ddd_development",
        "database.server.name": "#{ENV["KAFKA_CONNECT_DB_SERVER_NAME"]}",
        "schema.whitelist": "public",
        "table.whitelist": "public.user_access_outboxes",
        "tombstones.on.delete": "false"
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
