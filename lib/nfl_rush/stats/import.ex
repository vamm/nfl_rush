defmodule NflRush.Stats.Import do
  alias NflRush.{Format, Repo}
  alias NflRush.Stats.Stats

  def call(items) when is_list(items) do
    changesets =
      items
      |> Enum.map(&to_stats_attrs/1)
      |> Enum.map(&Stats.changeset/1)

    if Enum.all?(changesets, & &1.valid?) do
      attrs = Enum.map(changesets, & &1.changes)
      {affected, _} = Repo.insert_all(Stats, attrs)

      {:ok, affected}
    else
      {:error, Enum.reject(changesets, & &1.valid?)}
    end
  end

  def to_stats_attrs(data) do
    %{
      longest_rush_touchdown?: touchdown?(data["Lng"]),
      longest_rush: Format.to_integer(data["Lng"]),
      player_name: data["Player"],
      position: data["Pos"],
      rushing_20_plus_yards_each: data["20+"],
      rushing_40_plus_yards_each: data["40+"],
      rushing_attempts_per_game_avg: data["Att/G"],
      rushing_attempts: data["Att"],
      rushing_avg_yards_per_attempt: data["Avg"],
      rushing_first_downs_percentage: data["1st%"],
      rushing_first_downs: data["1st"],
      rushing_fumbles: data["FUM"],
      rushing_yards_per_game: data["Yds/G"],
      team: data["Team"],
      total_rushing_touchdowns: data["TD"],
      total_rushing_yards: Format.to_integer(data["Yds"])
    }
  end

  defp touchdown?(value) when is_integer(value), do: false
  defp touchdown?(value) when is_binary(value), do: String.contains?(value, "T")
  defp touchdown?(_), do: false
end
