# MissionSystem --- 5xRuby training

* Require Ruby 2.7.0, Rails 6.0.2.1
* Table Schema

----

```bash
    User
    account           string
    name              string
    password_digest   string
    is_admin          boolean
```

----

```bash
    Mission
    user_id           integer
    title             string
    contents          text
    status            integer
    priority_order    integer
    initial_time_at   datetime
    finish_time_at    datetime
```

----

## Heroku Deploy steps

* Install heroku toolbelt
* Check version of heroku

```bash
    heroku -v
```

* Heroku login

```bash
    heroku login
```

* Create local heroku

```bash
    heroku create
```

* Add SSH key of Project to heroku

```bash
    heroku keys:add
```

* Push project to heroku

```bash
    git push heroku master
```

* Migrate rails db on heroku

```bash
    heroku run rails db:migrate
```
