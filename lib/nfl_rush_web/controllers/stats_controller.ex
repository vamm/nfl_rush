defmodule NflRushWeb.StatsController do
  use NflRushWeb, :controller

  def export(conn, params) do
    csv_content = NflRush.export_stats(params)

    conn
    |> Plug.Conn.put_status(200)
    |> Plug.Conn.put_resp_header("content-disposition", "attachment; filename=stats.csv")
    |> Plug.Conn.send_resp(:ok, csv_content)
  end
end
