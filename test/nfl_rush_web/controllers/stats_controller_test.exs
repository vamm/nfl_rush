defmodule NflRushWeb.StatsControllerTest do
  use NflRushWeb.ConnCase

  describe "GET /export" do
    test "sends download headers", %{conn: conn} do
      path = Routes.stats_path(conn, :export, %{})

      assert {_, headers, _} =
               conn
               |> get(path)
               |> Plug.Test.sent_resp()

      assert {"content-disposition", "attachment; filename=stats.csv"} in headers
    end

    test "sends file bytes", %{conn: conn} do
      path = Routes.stats_path(conn, :export, %{})

      assert data =
               conn
               |> get(path)
               |> response(:ok)

      assert data != ""
    end
  end
end
