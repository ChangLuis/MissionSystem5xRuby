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
