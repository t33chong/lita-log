# lita-log

[![Build Status](https://travis-ci.org/tristaneuan/lita-log.png?branch=master)](https://travis-ci.org/tristaneuan/lita-log)
[![Coverage Status](https://coveralls.io/repos/tristaneuan/lita-log/badge.png)](https://coveralls.io/r/tristaneuan/lita-log)

**lita-log** is a handler for [Lita](https://github.com/litaio/lita) that logs arbitrary messages to the bot's Logger object.

## Installation

Add lita-log to your Lita instance's Gemfile:

``` ruby
gem "lita-log"
```

## Usage

In order to record a message in Lita's log, a user must be a member of the `:log_admins` [authorization group](http://docs.lita.io/getting-started/usage/#authorization-groups). Valid log levels are: UNKNOWN, FATAL, ERROR, WARN, INFO, DEBUG

```
<me>   lita: log info Hello world!
<lita> Successfully logged 'Hello world!' with level INFO
<me>   lita: log fatal This is a test. This is a test of the incident alerting system. This is only a test.
<lita> Successfully logged 'This is a test. This is a test of the incident alerting system. This is only a test.' with level FATAL
```

The resulting log entries will look like this:

```
[2015-12-15 19:45:36 UTC] INFO: Hello world!
[2015-12-15 19:45:44 UTC] FATAL: This is a test. This is a test of the incident alerting system. This is only a test.
```

## License

[MIT](http://opensource.org/licenses/MIT)
