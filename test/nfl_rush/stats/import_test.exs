defmodule NflRush.Stats.ImportTest do
  use NflRush.DataCase
  alias NflRush.Stats.Import

  describe "call/1" do
    test "process items from json" do
      data = [
        %{
          "Player" => "Le'Veon Bell",
          "Team" => "PIT",
          "Pos" => "RB",
          "Att" => 261,
          "Att/G" => 21.8,
          "Yds" => "1,268",
          "Avg" => 4.9,
          "Yds/G" => 105.7,
          "TD" => 7,
          "Lng" => "44",
          "1st" => 69,
          "1st%" => 26.4,
          "20+" => 4,
          "40+" => 1,
          "FUM" => 3
        }
      ]

      assert Import.call(data) == {:ok, 1}

      assert [created_stats] = Repo.all(NflRush.Stats.Stats)

      assert %{
               longest_rush: 44,
               longest_rush_touchdown?: false,
               player_name: "Le'Veon Bell",
               position: "RB",
               rushing_20_plus_yards_each: 4,
               rushing_40_plus_yards_each: 1,
               rushing_attempts: 261,
               rushing_attempts_per_game_avg: 21.8,
               rushing_avg_yards_per_attempt: 4.9,
               rushing_first_downs: 69,
               rushing_first_downs_percentage: 26.4,
               rushing_fumbles: 3,
               rushing_yards_per_game: 105.7,
               team: "PIT",
               total_rushing_touchdowns: 7,
               total_rushing_yards: 1268
             } = created_stats
    end

    test "when one of multiple items is invalid" do
      data = [
        %{
          "Player" => "Le'Veon Bell",
          "Team" => "PIT",
          "Pos" => "RB",
          "Att" => 261,
          "Att/G" => 21.8,
          "Yds" => "1,268",
          "Avg" => 4.9,
          "Yds/G" => 105.7,
          "TD" => 7,
          "Lng" => "44",
          "1st" => 69,
          "1st%" => 26.4,
          "20+" => 4,
          "40+" => 1,
          "FUM" => 3
        },
        %{
          "Player" => "Josh Huff",
          "Team" => "TBAA",
          "Pos" => "WR",
          "Att" => 1,
          "Att/G" => 0.3,
          "Yds" => 5,
          "Avg" => 5,
          "Yds/G" => 1.7,
          "TD" => 0,
          "Lng" => "5",
          "1st" => 0,
          "1st%" => 0,
          "20+" => 0,
          "40+" => 0,
          "FUM" => 0
        }
      ]

      assert {:error, [changeset]} = Import.call(data)

      refute changeset.valid?
      assert errors_on(changeset) == %{team: ["should be at most 3 character(s)"]}

      assert Repo.all(NflRush.Stats.Stats) == []
    end
  end

  describe "to_stats_attrs/1" do
    test "converts from json format to stats" do
      data = %{
        "Player" => "Robert Griffin III",
        "Team" => "CLE",
        "Pos" => "QB",
        "Att" => 31,
        "Att/G" => 6.2,
        "Yds" => "190",
        "Avg" => 6.1,
        "Yds/G" => 38,
        "TD" => 2,
        "Lng" => "20",
        "1st" => 10,
        "1st%" => 32.3,
        "20+" => 1,
        "40+" => 0,
        "FUM" => 2
      }

      assert Import.to_stats_attrs(data) == %{
               longest_rush: 20,
               longest_rush_touchdown?: false,
               player_name: "Robert Griffin III",
               position: "QB",
               rushing_20_plus_yards_each: 1,
               rushing_40_plus_yards_each: 0,
               rushing_attempts: 31,
               rushing_attempts_per_game_avg: 6.2,
               rushing_avg_yards_per_attempt: 6.1,
               rushing_first_downs: 10,
               rushing_first_downs_percentage: 32.3,
               rushing_fumbles: 2,
               rushing_yards_per_game: 38,
               team: "CLE",
               total_rushing_touchdowns: 2,
               total_rushing_yards: 190
             }
    end

    test "when keys are missing" do
      assert Import.to_stats_attrs(%{}) == %{
               longest_rush: nil,
               longest_rush_touchdown?: false,
               player_name: nil,
               position: nil,
               rushing_20_plus_yards_each: nil,
               rushing_40_plus_yards_each: nil,
               rushing_attempts: nil,
               rushing_attempts_per_game_avg: nil,
               rushing_avg_yards_per_attempt: nil,
               rushing_first_downs: nil,
               rushing_first_downs_percentage: nil,
               rushing_fumbles: nil,
               rushing_yards_per_game: nil,
               team: nil,
               total_rushing_touchdowns: nil,
               total_rushing_yards: nil
             }
    end

    test "converts touchdown from longest_rush" do
      data = %{"Lng" => "19T"}

      assert %{longest_rush_touchdown?: true} = Import.to_stats_attrs(data)
    end
  end
end
