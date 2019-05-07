# EOR
E-commerce using Ruby on Rails

## Table of contents
* [System Dependencies](#system-dependencies)
* [Getting Started](#getting-started)
* [Database Creation](#database-creation)
* [Database Initialization](#database-initialization)
* [Start](#start)



## System dependencies
* ActiveAdmin.
* CanCanCan.
* Devise.
* Bootstrap-rubygem.


## Getting Started

```bash
bundle install
```
## Database Creation

* Create Database in mysql
* Rename 'database.yml.example' to 'database.yml'
* Change database name and password

## Database Initialization

Now run the seeder using this command

```bash
rails db:seed
```
## Start 

Now let's run the server

```bash
rails s
```

## API
API link : http://localhost:3000/api/v1/products/1