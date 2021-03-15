# NflRush

Hey there! Thank you for reviewing my answer for your tech challenge.

My solution is a simple Phoenix app using LiveView. The cool code lives in the
`NflRush.Stats` context.

There are some `TODOs` scattered around the code. I am really sorry for that,
time was a ruling factor in my challenge.

Some interesting modules you may want to explore:
- [NflRush.Stats.Stats](https://github.com/vamm/nfl_rush/blob/master/lib/nfl_rush/stats/stats.ex)
- [NflRush.Stats.Export](https://github.com/vamm/nfl_rush/blob/master/lib/nfl_rush/stats/export.ex)
- [NflRush.Stats.Import](https://github.com/vamm/nfl_rush/blob/master/lib/nfl_rush/stats/import.ex)
- [NflRushWeb.PageLive](https://github.com/vamm/nfl_rush/blob/master/lib/nfl_rush_web/live/page_live.ex)

## Installing and running this solution

Sorry folks, wish I had more time for a proper Dockerized install.

### Requirements

If you use asdf, run `asdf install` to download tools from .tool-versions.

```
erlang 23.1.1
elixir 1.11.1-otp-23
```

### Instructions

```shell
# Unit tests
MIX_ENV=test mix ecto.create && mix test

# Database setup
export MIX_ENV=dev
docke-compose up -d
mix deps.get
mix ecto.create && mix ecto.migrate

# Import data from the rushing json
mix nfl_rush.import priv/stats.json

# Run server locally
mix phx.server
```

And then access [localhost:4000](http//localhost:4000) in your browser.
