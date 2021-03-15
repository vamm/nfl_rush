defmodule NflRush.FormatTest do
  use ExUnit.Case
  alias NflRush.Format

  describe "to_integer/1" do
    test "when value is already an integer" do
      assert Format.to_integer(1337) == 1337
    end

    test "when value is a number string" do
      assert Format.to_integer("13ab,37") == 1337
      assert Format.to_integer("13,37") == 1337
      assert Format.to_integer("13,,37") == 1337
      assert Format.to_integer("1337") == 1337
    end

    test "when value is invalid" do
      assert Format.to_integer("") == nil
      assert Format.to_integer("abc") == nil
      assert Format.to_integer(nil) == nil
      assert Format.to_integer(3141.5) == nil
    end
  end
end
