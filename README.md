# Rails Engine

This is a solo project as part of Turing School of Software and Design's Back-End Engineering program, Module 3.  Utilizing knowledge in Ruby on Rails, PostgreSQL, and ActiveRecord, we were tasked to build a back-end API from scratch.  We were given the front end [Rails Driver](https://github.com/turingschool-examples/rails_driver) to run alongside it to fully test its compatability and performance.

## Table of Contents

  - [Introduction](#introduction)
  - [Functional Overview](#functional-overview)
  - [Setup](#setup)
  - [Runing the tests](#running-the-tests)
  - [Deployment](#deployment)
  - [Authors](#authors)

## Introduction
  * [Project Requirements](https://backend.turing.io/module3/projects/rails_engine/)

## Learning Goals
  * Expose API using Test-Driven Development
  * Utilize intermediate ActiveRecord queries to return specific information
  * Format JSON using hand-rolled serializers and serializer gems (I used [jsonapi-serializer](https://github.com/jsonapi-serializer/jsonapi-serializer))

## Functional Overview

Starting a new Rails API from scratch, we were tasked on filling the database with a PostgreSQL dump file containing table and entry information for Merchants, Customers, Invoices, Invoice_Items, and Transactions, alongside a CSV file for the Items data.  I made a table for the Items data and made all the relationships between the tables.

The following endpoints were created:
  * Full CRUD functionality for Merchants and Items.
  * Displaying all Items belonging to a Merchant.
  * Displaying the Merchant that owns a particular Item.
  * Find and Find All search endpoints for both Items and Merchants that drew on attributes including name, description, unit price, date created and date updated, displaying one or all results.
  * Business statistics
    * Merchants with top revenue, dynamic to how many results are desired.
    * Merchants with most items sold, dynamic to how many results are desired.
    * Total store revenue across all Merchants within a dynamic date range.
    * Total all-time revenue for a specified Merchant.


### Database Structure

<img src='https://i.postimg.cc/rsbJ81NP/rails-engine-schema.png'>


## Setup

### Prerequisites

These setup instructions are for Mac OS.

This project requires the use of `Ruby 2.5.3` and `Rails 5.2.4.3`.
I also use `PostgreSQL` as my database.

### Local Setup

To setup locally, follow these instructions:
  * __Fork & Clone Repo__
    * Fork this repo to your own GitHub account.
    * Create a new directory locally or `cd` into whichever directory you wish to clone down to.
    * Enter `git clone git@github.com:<<YOUR GITHUB USERNAME>>/rails-engine.git`
  * __Install Gems__
    * Run `bundle install` to install all gems in the Gemfile
  * __Set Up Local Database and Migrations__
    * Run `rails db:{drop,create,migrate,seed}`

## Running the tests

  * __Server__
    * `cd` into the `rails_engine` folder and run `rails server` to run a server on `localhost:3000`
  * __Fork & Clone Rails Driver Repo__
    * Clone [this repo](https://github.com/turingschool-examples/rails_driver) into the same parent folder that houses the Rails Engine repo you cloned above.
  * `cd` into `rails_driver` in a separate terminal window from the one running `rails server` above.
  * Run `rails server -p 3001` in this new window to simultaneously run the `rails_driver` on a separate port.
  * In a third terminal window, run `bundle exec rspec spec/features/harness_spec.rb` from the `rails_driver` folder. You should see all passing tests.

## Driver & TDD

The `rails_driver` application is a mock front-end program to be run in tandem with `rails_engine`, used for both testing and for accessing the mock front-end online.  I wrote a test suite in `rails_engine` as well that drove all my development and tested my API on a deep level.
