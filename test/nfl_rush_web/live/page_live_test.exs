defmodule NflRushWeb.PageLiveTest do
  use NflRushWeb.ConnCase

  test "filter", %{conn: conn} do
    insert(:stats, player_name: "Joseph Tribiani")
    insert(:stats, player_name: "Phoebes")

    {:ok, view, _html} = live(conn, "/")

    assert rendered_view = render(view)
    assert rendered_view =~ "Joseph Tribiani"
    assert rendered_view =~ "Phoebes"

    assert ordered_view =
             view
             |> element("form")
             |> render_change(%{list: %{player_name: "Joseph"}})

    assert ordered_view =~ "Joseph Tribiani"
    refute ordered_view =~ "Phoebes"
  end

  test "order", %{conn: conn} do
    insert(:stats, player_name: "Joseph Tribiani", longest_rush: 20_000)
    insert(:stats, player_name: "Phoebes", longest_rush: 10_000)

    {:ok, view, _html} = live(conn, "/")

    assert ordered_view =
             view
             |> element("form")
             |> render_change(%{list: %{order_by: :longest_rush, order: :asc}})

    assert [_, {"tr", [], row_1}, {"tr", [], row_2}] =
             ordered_view |> Floki.parse_fragment!() |> Floki.find("tr")

    assert [{"td", [], [player_name_1]} | _] = row_1
    assert player_name_1 == "Phoebes"

    assert [{"td", [], [player_name_2]} | _] = row_2
    assert player_name_2 == "Joseph Tribiani"
  end
end
