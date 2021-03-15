defmodule NflRushWeb.PageLive do
  use NflRushWeb, :live_view

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     assign(socket,
       changeset: changeset(params),
       params: %{},
       stats: NflRush.list_stats(%{})
     )}
  end

  @impl true
  def handle_event("list", %{"list" => params}, socket) do
    updated_params = update_params(socket.assigns.params, params)
    results = NflRush.list_stats(updated_params)

    {:noreply,
     assign(socket, stats: results, params: updated_params, changeset: changeset(updated_params))}
  end

  @impl true
  def handle_event("export", %{}, socket) do
    {:noreply, redirect(socket, to: Routes.stats_path(socket, :export, socket.assigns.params))}
  end

  defp update_params(params, new_params), do: Map.merge(params, new_params)

  defp changeset(attrs) do
    Ecto.Changeset.cast({%{}, %{order_by: :string, order: :string}}, attrs, [:order_by, :order])
  end
end
