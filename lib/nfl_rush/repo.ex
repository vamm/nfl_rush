defmodule NflRush.Repo do
  use Ecto.Repo,
    otp_app: :nfl_rush,
    adapter: Ecto.Adapters.Postgres
end
