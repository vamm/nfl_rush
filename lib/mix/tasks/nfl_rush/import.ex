defmodule Mix.Tasks.NflRush.Import do
  use Mix.Task

  def run(file_path) do
    IO.puts("Running import for JSON file #{file_path}")

    {:ok, _, _} =
      Ecto.Migrator.with_repo(NflRush.Repo, fn _repo ->
        file_path
        |> NflRush.import_from_file()
        |> case do
          {:ok, number} ->
            IO.puts("OK! #{number} stats created.")

          {:error, _changesets} ->
            IO.puts("Error! Some data is invalid.")
            IO.puts("Please, run `NflRush.import_from_file/1` manually for debugging.")
        end
      end)
  end
end
