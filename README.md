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


