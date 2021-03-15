defmodule NflRush.Stats.ListTest do
  use NflRush.DataCase
  alias NflRush.Stats.List

  describe "list/1" do
    test "defaults to order by player name" do
      insert(:stats, player_name: "Monica Geller")
      insert(:stats, player_name: "Joseph Francis Tribbiani Jr.")
      insert(:stats, player_name: "Chandler Bing")

      assert [fetched_stats_1, fetched_stats_2, fetched_stats_3] = List.call(%{})

      assert fetched_stats_1.player_name == "Chandler Bing"
      assert fetched_stats_2.player_name == "Joseph Francis Tribbiani Jr."
      assert fetched_stats_3.player_name == "Monica Geller"
    end

    test "filters by name" do
      insert(:stats, player_name: "Phoebe Buffay")
      insert(:stats, player_name: "Joseph Francis Tribbiani Jr.")

      assert [fetched_stats] = List.call(%{"player_name" => "Francis"})

      assert fetched_stats.player_name == "Joseph Francis Tribbiani Jr."
    end

    test "filters by name avoiding like injections" do
    end
  end

  describe "call/1 ordering" do
    test "orders by longest_rush desc" do
      insert(:stats, player_name: "Phoebe Buffay", longest_rush: 20)
      insert(:stats, player_name: "Joseph Francis Tribbiani Jr.", longest_rush: 20_000)
      insert(:stats, player_name: "Ross Geller", longest_rush: 1)

      assert [fetched_stats_1, fetched_stats_2, fetched_stats_3] =
               List.call(%{"order_by" => "longest_rush", "order" => "desc"})

      assert fetched_stats_1.player_name == "Joseph Francis Tribbiani Jr."
      assert fetched_stats_2.player_name == "Phoebe Buffay"
      assert fetched_stats_3.player_name == "Ross Geller"
    end

    test "orders by longest_rush asc" do
      insert(:stats, player_name: "Phoebe Buffay", longest_rush: 20)
      insert(:stats, player_name: "Joseph Francis Tribbiani Jr.", longest_rush: 20_000)
      insert(:stats, player_name: "Ross Geller", longest_rush: 1)

      assert [fetched_stats_1, fetched_stats_2, fetched_stats_3] =
               List.call(%{"order_by" => "longest_rush", "order" => "asc"})

      assert fetched_stats_1.player_name == "Ross Geller"
      assert fetched_stats_2.player_name == "Phoebe Buffay"
      assert fetched_stats_3.player_name == "Joseph Francis Tribbiani Jr."
    end

    test "orders by total_rushing_yards desc" do
      insert(:stats, player_name: "Phoebe Buffay", total_rushing_yards: 80)
      insert(:stats, player_name: "Joseph Francis Tribbiani Jr.", total_rushing_yards: 90_000)
      insert(:stats, player_name: "Ross Geller", total_rushing_yards: 1)

      assert [fetched_stats_1, fetched_stats_2, fetched_stats_3] =
               List.call(%{"order_by" => "total_rushing_yards", "order" => "desc"})

      assert fetched_stats_1.player_name == "Joseph Francis Tribbiani Jr."
      assert fetched_stats_2.player_name == "Phoebe Buffay"
      assert fetched_stats_3.player_name == "Ross Geller"
    end

    test "orders by total_rushing_yards asc" do
      insert(:stats, player_name: "Phoebe Buffay", total_rushing_yards: 80)
      insert(:stats, player_name: "Joseph Francis Tribbiani Jr.", total_rushing_yards: 90_000)
      insert(:stats, player_name: "Ross Geller", total_rushing_yards: 1)

      assert [fetched_stats_1, fetched_stats_2, fetched_stats_3] =
               List.call(%{"order_by" => "total_rushing_yards", "order" => "asc"})

      assert fetched_stats_1.player_name == "Ross Geller"
      assert fetched_stats_2.player_name == "Phoebe Buffay"
      assert fetched_stats_3.player_name == "Joseph Francis Tribbiani Jr."
    end

    test "orders by total_rushing_touchdowns desc" do
      insert(:stats, player_name: "Phoebe Buffay", total_rushing_touchdowns: 100)

      insert(:stats, player_name: "Joseph Francis Tribbiani Jr.", total_rushing_touchdowns: 10_000)

      insert(:stats, player_name: "Ross Geller", total_rushing_touchdowns: 1)

      assert [fetched_stats_1, fetched_stats_2, fetched_stats_3] =
               List.call(%{"order_by" => "total_rushing_touchdowns", "order" => "desc"})

      assert fetched_stats_1.player_name == "Joseph Francis Tribbiani Jr."
      assert fetched_stats_2.player_name == "Phoebe Buffay"
      assert fetched_stats_3.player_name == "Ross Geller"
    end

    test "orders by total_rushing_touchdowns asc" do
      insert(:stats, player_name: "Phoebe Buffay", total_rushing_touchdowns: 100)

      insert(:stats, player_name: "Joseph Francis Tribbiani Jr.", total_rushing_touchdowns: 10_000)

      insert(:stats, player_name: "Ross Geller", total_rushing_touchdowns: 1)

      assert [fetched_stats_1, fetched_stats_2, fetched_stats_3] =
               List.call(%{"order_by" => "total_rushing_touchdowns", "order" => "asc"})

      assert fetched_stats_1.player_name == "Ross Geller"
      assert fetched_stats_2.player_name == "Phoebe Buffay"
      assert fetched_stats_3.player_name == "Joseph Francis Tribbiani Jr."
    end

    test "ignores column when it is invalid" do
      insert(:stats, player_name: "Phoebe Buffay", longest_rush: 20)

      assert [_] = List.call(%{"order_by" => "hey", "order" => "asc"})
    end

    test "ignores order when it is invalid" do
      insert(:stats, player_name: "Phoebe Buffay", longest_rush: 20)

      assert [_] = List.call(%{"order_by" => "longest_rush", "order" => "hi"})
    end
  end
end
