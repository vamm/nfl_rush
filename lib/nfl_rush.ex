defmodule NflRush do
  alias NflRush.Stats

  defdelegate list_stats(params), to: Stats, as: :list
  defdelegate export_stats(params), to: Stats, as: :export

  def import_from_file(file_path) do
    with {:ok, content} <- File.read(file_path),
         {:ok, items} <- Jason.decode(content) do
      Stats.import(items)
    end
  end
end
