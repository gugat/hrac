# README


#### Setup

Environment variables 
- `SCHEMAS_HOST`: Host for the schemas. Ex: `http://localhost:3000` 

#### Api

- Api responses follow [Json Api](https://jsonapi.org) convention
- Generate documentation: `rake rswag:specs:swaggerize`.
- Access documentation: `/api-docs`.

#### Test Suite

`bundle exec rspec`


#### Deploy

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

- Reuse schemas.

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
