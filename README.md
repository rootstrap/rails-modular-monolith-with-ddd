# Rails Modular Monolith with DDD

Full Modular Monolith Rails application with Domain-Driven Design approach. This is the Rails version of the [.NET application](https://github.com/kgrzybek/modular-monolith-with-ddd).

## Repository Structure

This repository makes use of branches to organize different versions of the above-mentioned app. The branches with stable versions are prefixed with `main-` and each of them will have their own README with the appropriate details.

### [main-packwerk](https://github.com/rootstrap/rails-modular-monolith-with-ddd/tree/main-packwerk)

This version of the app is a Rails monolith using [packwerk](https://github.com/Shopify/packwerk) to structure its domains into isolated components.

Components can communicate with each other in two different ways:
1. Making use of events. This is accomplished using [ActiveSupport::Notifications](https://api.rubyonrails.org/classes/ActiveSupport/Notifications.html) which is a pub/sub system integrated into Rails, that works in a synchronous fashion.
2. Calling methods on the public API of another component. This would be analogous to performing an HTTP API call to another service in a microservices architecture.

### [main-transactional-outbox](https://github.com/rootstrap/rails-modular-monolith-with-ddd/tree/main-transactional-outbox)

This version of the app extends `main-packwerk` to replace `ActiveSupport::Notifications` for [Kafka](https://kafka.apache.org/) for sending and consuming events. This means that events are now processed asynchronously, and a step towards a microservices architecture.

It implements the [Transactional Outbox pattern](https://microservices.io/patterns/data/transactional-outbox.html) to guarantee delivery of all the events, and makes use of [Kafka Connect](https://docs.confluent.io/platform/current/connect/index.html) to do the log tailing on the DB and pushing the events to `Kafka`.

`Kafka` is used through the [Karafka gem](https://github.com/karafka/karafka) which simplifies its usage.

The app and all the required services are dockerized to make it easy to work with.

### [main-multi-dbs](https://github.com/rootstrap/rails-modular-monolith-with-ddd/tree/main-multi-dbs)

This version of the app extends `main-transactional-outbox` and splits the single database into multiple databases, one per domain. To achieve this, it uses [Rails Multi DB support](https://guides.rubyonrails.org/active_record_multiple_databases.html)

### [main-saga](https://github.com/rootstrap/rails-modular-monolith-with-ddd/tree/main-saga)

This version of the app extends `main-multi-dbs` and implements the [Saga pattern](https://microservices.io/patterns/data/saga.html) to coordinate a transaction across the multiple DBs. It uses a Choreography-based Saga so that each local transaction publishes domain events that trigger local transactions in other domains.
