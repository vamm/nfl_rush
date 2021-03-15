defmodule NflRush.Stats.Stats do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  @fields [
    :longest_rush_touchdown?,
    :longest_rush,
    :player_name,
    :position,
    :rushing_20_plus_yards_each,
    :rushing_40_plus_yards_each,
    :rushing_attempts_per_game_avg,
    :rushing_attempts,
    :rushing_avg_yards_per_attempt,
    :rushing_first_downs_percentage,
    :rushing_first_downs,
    :rushing_fumbles,
    :rushing_yards_per_game,
    :team,
    :total_rushing_touchdowns,
    :total_rushing_yards
  ]

  schema "stats" do
    field :longest_rush_touchdown?, :boolean, default: false
    field :longest_rush, :integer
    field :player_name, :string
    field :position, :string
    field :rushing_20_plus_yards_each, :integer
    field :rushing_40_plus_yards_each, :integer
    field :rushing_attempts_per_game_avg, :float
    field :rushing_attempts, :integer
    field :rushing_avg_yards_per_attempt, :float
    field :rushing_first_downs_percentage, :float
    field :rushing_first_downs, :integer
    field :rushing_fumbles, :integer
    field :rushing_yards_per_game, :float
    field :team, :string
    field :total_rushing_touchdowns, :integer
    field :total_rushing_yards, :integer
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_length(:team, max: 3)
    |> validate_length(:position, max: 2)
  end
end
