# Rails Modular Monolith with DDD

Full Modular Monolith Rails application with Domain-Driven Design approach. This is the Rails version of the [.NET application](https://github.com/kgrzybek/modular-monolith-with-ddd).

## Main Packwerk

This version of the app is a Rails monolith using [packwerk](https://github.com/Shopify/packwerk) to structure its domains into isolated components.

Components can communicate with each other in two different ways:
1. Making use of events. This is accomplished using [ActiveSupport::Notifications](https://api.rubyonrails.org/classes/ActiveSupport/Notifications.html) which is a pub/sub system integrated into Rails, that works in a synchronous fashion.
2. Calling methods on the public API of another component. This would be analogous to performing an HTTP API call to another service in a microservices architecture.

## Table of contents

* [1. Introduction](docs/01_introduction.md#1-Introduction)
  * [1.1 Purpose of this Repository](docs/01_introduction.md#11-purpose-of-this-repository)
  * [1.2 Out of Scope](docs/01_introduction.md#12-out-of-scope)
  * [1.3 Reason](docs/01_introduction.md#13-reason)
  * [1.4 Disclaimer](docs/01_introduction.md#14-disclaimer)
  * [1.5 Give a Star](docs/01_introduction.md#15-give-a-star)
  * [1.6 Share It](docs/01_introduction.md#16-share-it)
* [2. Domain](docs/02_domain.md#2-Domain)
  * [2.1 Description](docs/02_domain.md#21-description)
  * [2.2 Conceptual Model](docs/02_domain.md#22-conceptual-model)
  * [2.3 Event Storming](docs/02_domain.md#23-event-storming)
* [3. Architecture](docs/03_architecture.md#3-Architecture)
  * [3.0 C4 Model](docs/03_architecture.md#30-c4-model)
  * [3.1 High Level View](docs/03_architecture.md#31-high-level-view)
  * [3.2 Module Level View](docs/03_architecture.md#32-module-level-view)
  * [3.3 API and Module Communication](docs/03_architecture.md#33-api-and-module-communication)
  * [3.4 Module Requests Processing via CQRS](docs/03_architecture.md#34-module-requests-processing-via-cqrs)
  * [3.5 Domain Model Principles and Attributes](docs/03_architecture.md#35-domain-model-principles-and-attributes)
  * [3.6 Cross-Cutting Concerns](docs/03_architecture.md#36-cross-cutting-concerns)
  * [3.7 Modules Integration](docs/03_architecture.md#37-modules-integration)
  * [3.8 Internal Processing](docs/03_architecture.md#38-internal-processing)
  * [3.9 Security](docs/03_architecture.md#39-security)
  * [3.10 Unit Tests](docs/03_architecture.md#310-unit-tests)
  * [3.11 Architecture Decision Log](docs/03_architecture.md#311-architecture-decision-log)
  * [3.12 Architecture Unit Tests](docs/03_architecture.md#312-architecture-unit-tests)
  * [3.13 Integration Tests](docs/03_architecture.md#313-integration-tests)
  * [3.14 System Integration Testing](docs/03_architecture.md#314-system-integration-testing)
  * [3.15 Event Sourcing](docs/03_architecture.md#315-event-sourcing)
  * [3.16 Database change management](docs/03_architecture.md#316-database-change-management)
  * [3.17 Continuous Integration](docs/03_architecture.md#317-continuous-integration)
  * [3.18 Static code analysis](docs/03_architecture.md#318-static-code-analysis)
* [4. Technology](#4-technology)
* [5. How to Run](docs/05_how_to_run.md#5-how-to-run)
* [6. Contribution](#6-contribution)
* [7. Roadmap](#7-roadmap)
* [8. Authors](#8-authors)
* [9. License](#9-license)
* [10. Inspirations and Recommendations](docs/10_recommendations.md#10-inspirations-and-recommendations)

## 1. Introduction

See [Introduction](docs/01_introduction.md) document.

## 2. Domain

See [Domain](docs/02_domain.md) document.

## 3. Architecture

See [Architecture](docs/03_architecture.md) document.
## 4. Technology

List of technologies, frameworks and libraries used for implementation:

- [Ruby 3](https://www.ruby-lang.org/) (Programming Language)
- [Rails 7](https://rubyonrails.org/) (Web Framework)
- [PostgreSQL](https://www.postgresql.org/) (Database)
- [Puma](https://puma.io/) (Web Server)
- [Dart Sass](https://sass-lang.com/dart-sass) (CSS Extension Language)
- [Bootstrap](https://getbootstrap.com/) (CSS Framework)
- [esbuild](https://esbuild.github.io/) (JS Bundler)

## 5. How to Run

See [How to Run](docs/05_how_to_run.md) document.

## 6. Contribution

This project is still under analysis and development. I assume its maintenance for a long time and I would appreciate your contribution to it. Please let me know by creating an Issue or Pull Request.

## 7. Roadmap

TBD

## 8. Authors

Original idea by: Kamil Grzybek

## 9. License

The project is under [MIT license](https://opensource.org/licenses/MIT).

## 10. Inspirations and Recommendations
See [Inspirations and Recommendations](docs/10_recommendations.md) document.
