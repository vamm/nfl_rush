defmodule NflRush.Stats.ExportTest do
  use NflRush.DataCase
  alias NflRush.Stats.Export

  describe "call/1" do
    test "includes filters" do
      insert(:stats, player_name: "Joseph Anthony")
      insert(:stats, player_name: "Tribiani Joseph Anthony")
      insert(:stats, player_name: "Gabriel Pittol")

      content = Export.call(%{"player_name" => "Joseph"})

      rows = String.split(content, "\n")
      assert [header, row_1, row_2] = rows

      assert header ==
               "player_name;team;position;rushing_attempts_per_game_avg;rushing_attempts;total_rushing_yards;rushing_avg_yards_per_attempt;rushing_yards_per_game;total_rushing_touchdowns;longest_rush;longest_rush_touchdown?;rushing_first_downs;rushing_first_downs_percentage;rushing_20_plus_yards_each;rushing_20_plus_yards_each;rushing_fumbles"

      assert [row_1_name | row_1_columns] = String.split(row_1, ";")
      assert row_1_name == "Joseph Anthony"
      assert Enum.count(row_1_columns) == 15

      assert [row_2_name | row_2_columns] = String.split(row_2, ";")
      assert row_2_name == "Tribiani Joseph Anthony"
      assert Enum.count(row_2_columns) == 15
    end
  end
end
