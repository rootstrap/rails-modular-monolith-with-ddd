# Rails Modular Monolith with DDD

Full Modular Monolith Rails application with Domain-Driven Design approach. This is the Rails version of the [.NET application](https:/github.com/kgrzybek/modular-monolith-with-ddd).

## CI

![](https://github.com/santib/rails-modular-monolith-with-ddd/workflows/Build%20Pipeline/badge.svg)

## Table of contents

[1. Introduction](#1-Introduction)

&nbsp;&nbsp;[1.1 Purpose of this Repository](#11-purpose-of-this-repository)

&nbsp;&nbsp;[1.2 Out of Scope](#12-out-of-scope)

&nbsp;&nbsp;[1.3 Reason](#13-reason)

&nbsp;&nbsp;[1.4 Disclaimer](#14-disclaimer)

&nbsp;&nbsp;[1.5 Give a Star](#15-give-a-star)

&nbsp;&nbsp;[1.6 Share It](#16-share-it)

[2. Domain](#2-Domain)

&nbsp;&nbsp;[2.1 Description](#21-description)

&nbsp;&nbsp;[2.2 Conceptual Model](#22-conceptual-model)

&nbsp;&nbsp;[2.3 Event Storming](#23-event-storming)

[3. Architecture](#3-Architecture)

&nbsp;&nbsp;[3.0 C4 Model](#30-c4-model)

&nbsp;&nbsp;[3.1 High Level View](#31-high-level-view)

&nbsp;&nbsp;[3.2 Module Level View](#32-module-level-view)

&nbsp;&nbsp;[3.3 API and Module Communication](#33-api-and-module-communication)

&nbsp;&nbsp;[3.4 Module Requests Processing via CQRS](#34-module-requests-processing-via-cqrs)

&nbsp;&nbsp;[3.5 Domain Model Principles and Attributes](#35-domain-model-principles-and-attributes)

&nbsp;&nbsp;[3.6 Cross-Cutting Concerns](#36-cross-cutting-concerns)

&nbsp;&nbsp;[3.7 Modules Integration](#37-modules-integration)

&nbsp;&nbsp;[3.8 Internal Processing](#38-internal-processing)

&nbsp;&nbsp;[3.9 Security](#39-security)

&nbsp;&nbsp;[3.10 Unit Tests](#310-unit-tests)

&nbsp;&nbsp;[3.11 Architecture Decision Log](#311-architecture-decision-log)

&nbsp;&nbsp;[3.12 Architecture Unit Tests](#312-architecture-unit-tests)

&nbsp;&nbsp;[3.13 Integration Tests](#313-integration-tests)

&nbsp;&nbsp;[3.14 System Integration Testing](#314-system-integration-testing)

&nbsp;&nbsp;[3.15 Event Sourcing](#315-event-sourcing)

&nbsp;&nbsp;[3.16 Database change management](#316-database-change-management)

&nbsp;&nbsp;[3.17 Continuous Integration](#317-continuous-integration)

&nbsp;&nbsp;[3.18 Static code analysis](#318-static-code-analysis)

[4. Technology](#4-technology)

[5. How to Run](#5-how-to-run)

[6. Contribution](#6-contribution)

[7. Roadmap](#7-roadmap)

[8. Authors](#8-authors)

[9. License](#9-license)

[10. Inspirations and Recommendations](#10-inspirations-and-recommendations)

## 1. Introduction

### 1.1 Purpose of this Repository

This is a list of the main goals of this repository:

- Showing how you can implement a **monolith** application in a **modular** way
- Presentation of the **full implementation** of an application
  - This is not another simple application
  - This is not another proof of concept (PoC)
  - The goal is to present the implementation of an application that would be ready to run in production
- Showing the application of **best practices** and **object-oriented programming principles**
- Presentation of the use of **design patterns**. When, how and why they can be used
- Presentation of some **architectural** considerations, decisions, approaches
- Presentation of the implementation using **Domain-Driven Design** approach (**tactical** patterns)
- Presentation of the implementation of **Unit Tests** for Domain Model (Testable Design in mind)
- Presentation of the implementation of **Integration Tests**
- Presentation of the implementation of **Event Sourcing**
- Presentation of **C4 Model**
- Presentation of **diagram as text** approach

### 1.2 Out of Scope

This is a list of subjects which are out of scope for this repository:
- Business requirements gathering and analysis
- System analysis
- Domain exploration
- Domain distillation
- Domain-Driven Design **strategic** patterns
- Architecture evaluation, quality attributes analysis
- Integration, system tests
- Project management
- Infrastructure
- Containerization
- Software engineering process
- Deployment process
- Maintenance
- Documentation

### 1.3 Reason

The reason for creating this repository is the lack of something similar. Most sample applications on GitHub have at least one of the following issues:
- Very, very simple - few entities and use cases implemented
- Not finished (for example there is no authentication, logging, etc..)
- Poorly designed (in my opinion)
- Poorly implemented (in my opinion)
- Not well described
- Assumptions and decisions are not clearly explained
- Implements "Orders" domain - yes, everyone knows this domain, but something different is needed
- Implemented in old technology
- Not maintained

To sum up, there are some very good examples, but there are far too few of them. This repository has the task of filling this gap at some level.

### 1.4 Disclaimer

Software architecture should always be created to resolve specific **business problems**. Software architecture always supports some quality attributes and at the same time does not support others. A lot of other factors influence your software architecture - your team, opinions, preferences, experiences, technical constraints, time, budget, etc.

Always functional requirements, quality attributes, technical constraints and other factors should be considered before an architectural decision is made.

Because of the above, the architecture and implementation presented in this repository is **one of the many ways** to solve some problems. Take from this repository as much as you want, use it as you like but remember to **always pick the best solution which is appropriate to the problem class you have**.

### 1.5 Give a Star

My primary focus in this project is on quality. Creating a good quality product involves a lot of analysis, research and work. It takes a lot of time. If you like this project, learned something or you are using it in your applications, please give it a star :star:.  This is the best motivation for me to continue this work. Thanks!

### 1.6 Share It

There are very few really good examples of this type of application. If you think this repository makes a difference and is worth it, please share it with your friends and on social networks. I will be extremely grateful.

## 2. Domain

### 2.1 Description

**Definition:**

> Domain - A sphere of knowledge, influence, or activity. The subject area to which the user applies a program is the domain of the software. [Domain-Driven Design Reference](http://domainlanguage.com/ddd/reference/), Eric Evans

The **Meeting Groups** domain was selected for the purposes of this project based on the [Meetup.com](https://www.meetup.com/) system.

**Main reasons for selecting this domain:**

- It is common, a lot of people use the Meetup site to organize or attend meetings
- There is a system for it, so everyone can check this implementation against a working site which supports this domain
- It is not complex so it is easy to understand
- It is not trivial - there are some business rules and logic and it is not just CRUD operations
- You don't need much specific domain knowledge unlike other domains like financing, banking, medical
- It is not big so it is easier to implement

**Meetings**

The main business entities are `Member`, `Meeting Group` and `Meeting`. A `Member` can create a `Meeting Group`, be part of a `Meeting Group` or can attend a `Meeting`.

A `Meeting Group Member` can be an `Organizer` of this group or a normal `Member`.

Only an `Organizer` of a `Meeting Group` can create a new `Meeting`.

A `Meeting` has attendees, not attendees (`Members` which declare they will not attend the `Meeting`) and `Members` on the `Waitlist`.

A `Meeting` can have an attendee limit. If the limit is reached, `Members` can only sign up to the `Waitlist`.

A `Meeting Attendee` can bring guests to the `Meeting`. The number of guests allowed is an attribute of the `Meeting`. Bringing guests can be unallowed.

A `Meeting Attendee` can have one of two roles: `Attendee` or `Host`. A `Meeting` must have at least one `Host`. The `Host` is a special role which grants permission to edit `Meeting` information or change the attendees list.

A `Member` can comment `Meetings`. A `Member` can reply to, like other `Comments`. `Organizer` manages commenting of `Meeting` by `Meeting Commenting Configuration`. `Organizer` can delete any `Comment`.

Each `Meeting Group` must have an organizer with active `Subscription`. One organizer can cover 3 `Meeting Groups` by his `Subscription`.

Additionally, Meeting organizer can set an `Event Fee`. Each `Meeting Attendee` is obliged to pay the fee. All guests should be paid by `Meeting Attendee` too.

**Administration**

To create a new `Meeting Group`, a `Member` needs to propose the group. A `Meeting Group Proposal` is sent to `Administrators`. An `Administrator` can accept or reject a `Meeting Group Proposal`. If a `Meeting Group Proposal` is accepted, a `Meeting Group` is created.

**Payments**

Each `Member` who is the `Payer` can buy the `Subscription`. He needs to pay the `Subscription Payment`. `Subscription` can expire so `Subscription Renewal` is required (by `Subscription Renewal Payment` payment to keep `Subscription` active).

When the `Meeting` fee is required, the `Payer` needs to pay `Meeting Fee` (through `Meeting Fee Payment`).

**Users**

Each `Administrator`, `Member` and `Payer` is a `User`. To be a `User`, `User Registration` is required and confirmed.

Each `User` is assigned one or more `User Role`.

Each `User Role` has set of `Permissions`. A `Permission` defines whether `User` can invoke a particular action.

### 2.2 Conceptual Model

**Definition:**

> Conceptual Model - A conceptual model is a representation of a system, made of the composition of concepts that are used to help people know, understand, or simulate a subject the model represents. [Wikipedia - Conceptual model](https://en.wikipedia.org/wiki/Conceptual_model)

**Conceptual Model**

PlantUML version:
![](docs/images/conceptual-model-plantuml.png)

VisualParadigm version (not maintained, only for demonstration):
![](docs/images/conceptual-model-visualparadigm.png)

**Conceptual Model of commenting feature**
![](docs/images/conceptual-model-commeting-feature.png)

### 2.3 Event Storming

While a Conceptual Model focuses on structures and relationships between them, **behavior** and **events** that occur in our domain are more important.

There are many ways to show behavior and events. One of them is a light technique called [Event Storming](https://www.eventstorming.com/) which is becoming more popular. Below are presented 3 main business processes using this technique: user registration, meeting group creation and meeting organization.

Note: Event Storming is a light, live workshop. One of the possible outputs of this workshop is presented here. Even if you are not doing Event Storming workshops, this type of process presentation can be very valuable to you and your stakeholders.

**User Registration process**

------

![](docs/images/user-registration.jpeg)

------

**Meeting Group creation**
![](docs/images/meeting-group-creation.jpeg)

------

**Meeting organization**
![](docs/images/meeting-organization.jpeg)

------

**Payments**
![](docs/images/payments-eventstorming-design.jpeg)
[Download high resolution file](docs/images/payments-eventstorming-design-highres.jpeg)

------

## 3. Architecture

TBD

### 3.0 C4 Model

TBD

### 3.1 High Level View

TBD

### 3.2 Module Level View

TBD

### 3.3 API and Module Communication

TBD

### 3.4 Module Requests Processing via CQRS

TBD

### 3.5 Domain Model Principles and Attributes

TBD

### 3.6 Cross-Cutting Concerns

TBD

### 3.7 Modules Integration

TBD

### 3.8 Internal Processing

TBD

### 3.9 Security

TBD

### 3.10 Unit Tests

TBD

### 3.11 Architecture Decision Log

TBD

### 3.12 Architecture Unit Tests

TBD

### 3.13 Integration Tests

TBD

### 3.14 System Integration Testing

TBD

### 3.15 Event Sourcing

TBD

### 3.16 Database change management

TBD

### 3.17 Continuous Integration

TBD

### 3.18 Static code analysis

TBD

## 4. Technology

TBD

## 5. How to Run

TBD


## 6. Contribution

TBD

## 7. Roadmap

TBD

## 8. Authors

TBD

## 9. License

TBD

## 10. Inspirations and Recommendations

TBD

