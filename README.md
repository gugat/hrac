# HRAC

`Human Resources Assistance Control` is an API that allows management of employees and their daily assistances to the office. 

See the [API documentation live](https://rhac.herokuapp.com/api-docs/index.html) 

#### What you can do  
The `HRAC API` allows you to: 

- Control employees personal information.
- Control assistances of your employees, entries and exits of the office.
- Get reporting about daily worked hours and anomalies like:
   - Absentism
   - Missing registration of assistances
   - Arriving late to the office
   - Leaving the office before the expected time
   - Worked less than the expected hours

#### Employees roles

There are two roles for employees: `admin` and `staff` each one is able to do different things:

|**Feature**| *Admin* | *Staff* |
|-|-|-|
|Create and list employees| Yes | No
|See an employee info| Yes| Yes (*Only her info*)
|Register assistances (entries and exits)| Yes| No |
|List assistances | Yes| Yes (*Only her assistances*)
|See journey report* | Yes| Yes (*Only her journeys*)

`* A 'Journey' is a summary of the daily activity of an employee, it includes assistances, anomalies and worked hours.`

### About the API

- *Responses* follow [Json Api specification](https://jsonapi.org) 
- *Documentation* uses [Swagger - (OpenAPI Specification V2.0)](https://swagger.io/specification/v2/). See the [API documentation live](https://rhac.herokuapp.com/api-docs/index.html) with examples for each response.
- *Authentication* is token based, handled with [Devise Token Auth](https://github.com/lynndylanhurley/devise_token_auth). See how [token management works](https://devise-token-auth.gitbook.io/devise-token-auth/conceptual). After logged in, every request must include [these headers](https://devise-token-auth.gitbook.io/devise-token-auth/usage/controller_methods#token-header-format): `access-token`, `client`, and `uid` which are sent in the login response.
- *Versioning* is handled via [Media Type Specification](https://tools.ietf.org/html/rfc6838#section-3.2) via `Accept` header passing the version **application/vnd.hrac.`v1`+json**. Default version now is v1, even if the header now is not sent it will use version 1 of the API.

Once cloned:

- To access documentation in the browser go to: `/api-docs`.
- To generate Api documentation execute: `rake rswag:specs:swaggerize`.



## Setup

### Dependencies

- Postgres `9.6`
- Rails `5.1.3`
- Ruby `2.3.5`

### Environment variables 

**`SCHEMAS_HOST`**

Host for the schemas references. Set it with the value of the production host because `swagger.json` documention is generated before deployment with the rake task `swagger:host`. See deployment section to see when it is used. 

### Configuration variables

**schedule.yml**

Handles parameters for working hours.

```
  max_arrive_time: 08H00
  min_leave_time: 18H00
  min_worked_hours: 8
```

**api.yml**

Handles parameters for api documentation. For now json schemas information path and host.

```
  schemas_path: <%= "#{Rails.root}/spec/support/api/schemas/" %>
  schemas_host: 'http://localhost:3000'

```

### Test Suite

`bundle exec rspec`

### Deployment

You can use Heroku for deployment.

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


