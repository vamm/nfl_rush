defmodule NflRush.Stats.Export do
  alias NflRush.Stats

  @fields [
    :player_name,
    :team,
    :position,
    :rushing_attempts_per_game_avg,
    :rushing_attempts,
    :total_rushing_yards,
    :rushing_avg_yards_per_attempt,
    :rushing_yards_per_game,
    :total_rushing_touchdowns,
    :longest_rush,
    :longest_rush_touchdown?,
    :rushing_first_downs,
    :rushing_first_downs_percentage,
    :rushing_20_plus_yards_each,
    :rushing_20_plus_yards_each,
    :rushing_fumbles
  ]

  @header_row @fields |> Enum.map(&to_string/1) |> Enum.join(";")

  def call(params) do
    results = Stats.list(params)

    results
    |> Enum.map(&to_row/1)
    |> Enum.map(&Enum.join(&1, ";"))
    |> make_csv()
  end

  defp to_row(stats) do
    stats
    |> take_csv_fields()
    |> Enum.map(&to_string/1)
  end

  defp take_csv_fields(stats) do
    Enum.map(@fields, &Map.get(stats, &1))
  end

  defp make_csv(rows) do
    Enum.join([@header_row | rows], "\n")
  end
end
