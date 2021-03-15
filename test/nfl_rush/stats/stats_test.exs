defmodule NflRush.Stats.StatsTest do
  use NflRush.DataCase
  alias NflRush.Stats.Stats

  describe "changeset/1" do
    test "valid attrs" do
      attrs = %{
        player_name: "Joey Tribbiani",
        team: "PLA",
        position: "MT",
        rushing_attempts_per_game_avg: 2,
        rushing_attempts: 2,
        total_rushing_yards: 2,
        rushing_avg_yards_per_attempt: 2,
        rushing_yards_per_game: 2,
        total_rushing_touchdowns: 2,
        longest_rush: 2,
        longest_rush_touchdown?: true,
        rushing_first_downs: 2,
        rushing_first_downs_percentage: 2,
        rushing_20_plus_yards_each: 2,
        rushing_40_plus_yards_each: 2,
        rushing_fumbles: 2
      }

      changeset = Stats.changeset(attrs)

      assert changeset.valid?
    end

    test "all fields are required" do
      attrs = %{}

      changeset = Stats.changeset(attrs)

      refute changeset.valid?

      assert errors_on(changeset) == %{
               longest_rush: ["can't be blank"],
               player_name: ["can't be blank"],
               position: ["can't be blank"],
               rushing_20_plus_yards_each: ["can't be blank"],
               rushing_40_plus_yards_each: ["can't be blank"],
               rushing_attempts: ["can't be blank"],
               rushing_attempts_per_game_avg: ["can't be blank"],
               rushing_avg_yards_per_attempt: ["can't be blank"],
               rushing_first_downs: ["can't be blank"],
               rushing_first_downs_percentage: ["can't be blank"],
               rushing_fumbles: ["can't be blank"],
               rushing_yards_per_game: ["can't be blank"],
               team: ["can't be blank"],
               total_rushing_touchdowns: ["can't be blank"],
               total_rushing_yards: ["can't be blank"]
             }
    end

    test "when position length is lower than 2" do
      attrs = %{position: "M"}

      changeset = Stats.changeset(attrs)

      refute errors_on(changeset)[:position]
    end

    test "when position length is greater than 2" do
      attrs = %{position: "MAT"}

      changeset = Stats.changeset(attrs)

      refute changeset.valid?
      assert %{position: ["should be at most 2 character(s)"]} = errors_on(changeset)
    end

    test "when team length is lower than 3" do
      attrs = %{team: "MA"}

      changeset = Stats.changeset(attrs)

      refute errors_on(changeset)[:team]
    end

    test "when team length is greater than 3" do
      attrs = %{team: "PLAA"}

      changeset = Stats.changeset(attrs)

      refute changeset.valid?
      assert %{team: ["should be at most 3 character(s)"]} = errors_on(changeset)
    end
  end
end
