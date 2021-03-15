defmodule NflRush.Stats do
  alias NflRush.Stats.{List, Import, Export}

  defdelegate list(params), to: List, as: :call
  defdelegate import(data), to: Import, as: :call
  defdelegate export(params), to: Export, as: :call
end
