defmodule NflRush.Fixtures do
  def insert(:stats, opts \\ []) do
    attrs =
      Enum.into(opts, %{
        player_name: "John Titor",
        team: "IBM",
        position: "TI",
        rushing_attempts: random_integer(),
        rushing_attempts_per_game_avg: random_decimal(),
        total_rushing_yards: random_integer(),
        rushing_avg_yards_per_attempt: random_decimal(),
        rushing_yards_per_game: random_decimal(),
        total_rushing_touchdowns: random_integer(),
        longest_rush: random_integer(),
        longest_rush_touchdown?: false,
        rushing_first_downs: random_integer(),
        random_decimal: random_integer(),
        rushing_20_plus_yards_each: random_integer(),
        rushing_40_plus_yards_each: random_integer(),
        rushing_fumbles: random_integer(),
        rushing_first_downs_percentage: random_decimal()
      })

    NflRush.Stats.Stats
    |> struct(attrs)
    |> NflRush.Repo.insert!()
  end

  defp random_decimal(max \\ 10_000) do
    random_integer(max) + random_integer(100) / 100 - 1
  end

  defp random_integer(max \\ 10_000) do
    :rand.uniform(max)
  end
end
