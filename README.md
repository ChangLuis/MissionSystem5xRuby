# MissionSystem --- 5xRuby training

* Require Ruby 2.7.0, Rails 6.0.2.1
* Table Schema

----
    User
    account           string
    name              string
    password_digest   string
    is_admin          boolean

----
    Mission
    user_id           integer
    title             string
    contents          text
    status            integer
    priority_order    integer
    initial_time_at   datetime
    finish_time_at    datetime

----

* Heroku Deploy steps

1. Install heroku toobelt
2. Check version of heroku
    heroku -v

3. Heroku login
    heroku login

4. Create local heroku
    heroku create

5. Add SSH key of Project to heroku
    heroku keys:add

6. Push project to heroku
    git push heroku master

7. Migrate rails db on heroku
    heroku run rails db:migrate
