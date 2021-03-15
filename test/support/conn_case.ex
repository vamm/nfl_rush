defmodule NflRushWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Plug.Conn
      import Phoenix.ConnTest
      import Phoenix.LiveViewTest
      import NflRushWeb.ConnCase
      import NflRush.Fixtures

      alias NflRushWeb.Router.Helpers, as: Routes

      @endpoint NflRushWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(NflRush.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(NflRush.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
