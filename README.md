# Sleep Tracking Service

This service provides an API for tracking sleep records, following users, and clocking in sleep sessions. It includes features such as user authentication, sleep tracking, and pagination.
## Table of Contents

- [Sleep Tracking Service](#sleep-tracking-service)
  - [Table of Contents](#table-of-contents)
  - [Ruby Version](#ruby-version)
  - [System Dependencies](#system-dependencies)
  - [Configuration](#configuration)
  - [Database Creation](#database-creation)
  - [Database Initialization](#database-initialization)
  - [How to Run the Service](#how-to-run-the-service)
  - [How to Run the Test Suite](#how-to-run-the-test-suite)
  - [API List](#api-list)
    - [User Creation](#user-creation)
    - [Clock In](#clock-in)
    - [Follow](#follow)
    - [Unfollow](#unfollow)
    - [Following Sleep Trackings](#following-sleep-trackings)

## Ruby Version

This application requires Ruby version `3.2.2` or later.

## System Dependencies

- Ruby `3.2.2`
- Rails `7.0.8.6`
- PostgreSQL

## Configuration

1. Clone the repository:
   ```sh
   git clone https://github.com/vincentwijaya/sleep-tracking-service.git
   cd sleep-tracking-service
   ```
2. Install required gems:
   ```
   bundle install
   ```
3. Set up environment variables: Create a `.env` file in the root directory and add the necessary environment variables:
  ```yaml
DB_USER = postgres
DB_PASSWORD = postgres
DB_HOST = localhost
  ```

## Database Creation
To create database you can run below command:
```
rails db:create
```

## Database Initialization
Run the database migrations and seed the database:
```
rails db:migrate
rails db:seed
```

## How to Run the Service
To run this service, you can simply run below command:
```
rails s
```

## How to Run the Test Suite
This service using RSpec, to run it simply type below command:
```
rspec
```

## API List
### User Creation
This request sends a POST request to create a new user with the specified name.

```
curl --location 'http://localhost:3000/api/v1/users' \
--header 'Content-Type: application/json' \
--data '{
    "name": "john"
}'
```

### Clock In

This request sends a POST request to clock in sleep.

```
curl --location --request POST 'http://localhost:3000/api/v1/sleep_trackings/clock_in' \
--header 'Authorization: asdasd'
```

### Follow
This request sends a POST request to follow other user.

```
curl --location --request POST 'http://localhost:3000/api/v1/follow/2' \
--header 'Authorization: asdasd'
```

### Unfollow
This request sends a POST request to unfollow followed user.

```
curl --location --request POST 'http://localhost:3000/api/v1/unfollow/2' \
--header 'Authorization: asdasd'
```

### Following Sleep Trackings

This request sends a GET request to retrieve all following sleep trackings ordered by longest sleep duration in a week.

```
curl --location 'http://localhost:3000/api/v1/sleep_trackings?per_page=1&page=1' \
--header 'Authorization: asdasd'
```