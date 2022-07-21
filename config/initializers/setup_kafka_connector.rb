if ENV["SETUP_KAFKA_CONNECTOR"] == "true"
  config = {
    "name": "user-access-outbox-connector",
    "config": {
      "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
      "tasks.max": "1",
      "plugin.name": "pgoutput",
      "database.hostname": "db",
      "database.port": "5432",
      "database.user": "postgres",
      "database.password": "postgres",
      "database.dbname": "rails_modular_monolith_with_ddd_development",
      "database.server.name": "dbserver1",
      "schema.whitelist": "public",
      "table.whitelist": "public.user_access_outboxes",
      "tombstones.on.delete": "false"
    }
  }

  # Register connector
  # Register the connector once the kafka-connector service is running
  `curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" connect:8083/connectors/ -d #{config.to_json}`
  # To check if the connector registered properly
  # - Run `curl -i -X GET -H "Accept:application/json" localhost:8083/connectors/user-access-outbox-connector`
end
