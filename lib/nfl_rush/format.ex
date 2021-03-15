defmodule NflRush.Format do
  def to_integer(value) when is_integer(value), do: value

  def to_integer(value) when is_binary(value) do
    value
    |> only_digits()
    |> Integer.parse()
    |> case do
      {number, ""} -> number
      _ -> nil
    end
  end

  def to_integer(_), do: nil

  defp only_digits(value) do
    Regex.replace(~r/[^\d]+/, value, "")
  end
end
