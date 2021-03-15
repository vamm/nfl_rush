defmodule NflRush.Repo.Migrations.CreateStatsTable do
  use Ecto.Migration

  def change do
    create table(:stats, primary_key: false) do
      add :longest_rush_touchdown?, :boolean, default: false, null: false
      add :longest_rush, :integer, null: false
      add :player_name, :string, null: false
      add :position, :string, size: 2, null: false
      add :rushing_20_plus_yards_each, :integer, null: false
      add :rushing_40_plus_yards_each, :integer, null: false
      add :rushing_attempts_per_game_avg, :float, null: false
      add :rushing_attempts, :integer, null: false
      add :rushing_avg_yards_per_attempt, :float, null: false
      add :rushing_first_downs_percentage, :float, null: false
      add :rushing_first_downs, :integer, null: false
      add :rushing_fumbles, :integer, null: false
      add :rushing_yards_per_game, :float, null: false
      add :team, :string, size: 3, null: false
      add :total_rushing_touchdowns, :integer, null: false
      add :total_rushing_yards, :integer, null: false
    end

    create index(:stats, [:longest_rush])
    create index(:stats, [:player_name])
    create index(:stats, [:total_rushing_touchdowns])
    create index(:stats, [:total_rushing_yards])
  end
end
