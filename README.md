# README

#### Dependencies

- Postgres `9.6`
- Rails `5.1.3`
- Ruby `2.3.5`

#### Setup

Environment variables 
- `SCHEMAS_HOST`: Host for the schemas. Ex: `http://localhost:3000` 

#### Api

- Api responses follow [Json Api](https://jsonapi.org) convention
- Generate documentation: `rake rswag:specs:swaggerize`.
- Access documentation: `/api-docs`.

#### Test Suite

`rails s` # Need this to get path to schemas.
`bundle exec rspec`


#### Deployment

Using Heroku.

First deploy

```
heroku login
heroku create
RAILS_ENV=production rake swagger:host
git push heroku master
heroku run rake db:migrate
```

Following deploys

```
RAILS_ENV=production rake swagger:host
git push heroku master
heroku run rake db:migrate
```


#### TODO

1. Reuse json schemas 
2. Reference json schemas without running the server.
3. Install rswag not in production. (Related to point 2.) With this rspec-rails is not needed in production neither.
4. Generate seed data.
5. Namespace `api`
6. Analyze handling WorkDay attribute `day` as string like `2019-02-26`
7. Queue `set_worked_hours`


---

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization



* Documentation: 

 and visit `/api-docs`




* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
