defmodule NflRush.Stats.List do
  import Ecto.Query
  alias NflRush.Repo
  alias NflRush.Stats.Stats

  def call(params) do
    Stats
    |> filter_name(params)
    |> order(params)
    |> Repo.all()
  end

  defp filter_name(query, %{"player_name" => name}) do
    # TODO: avoid ilike injection
    where(query, [stats], ilike(stats.player_name, ^"%#{name}%"))
  end

  defp filter_name(query, _), do: query

  defp order(query, %{"order_by" => column, "order" => order}) do
    case to_column(column) do
      nil ->
        query

      order_column ->
        order_by(query, [stats], [{^to_order(order), ^order_column}])
    end
  end

  defp order(query, _), do: order_by(query, [stats], stats.player_name)

  defp to_order("asc"), do: :asc
  defp to_order(_), do: :desc

  defp to_column("longest_rush"), do: :longest_rush
  defp to_column("total_rushing_yards"), do: :total_rushing_yards
  defp to_column("total_rushing_touchdowns"), do: :total_rushing_touchdowns
  defp to_column(_), do: nil
end
