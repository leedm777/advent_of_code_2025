defmodule InputTest do
  use ExUnit.Case, async: true
  doctest AoC.Input

  describe "get_url" do
    test "single digit day" do
      actual = AoC.Input.get_url("2025", "1")
      assert actual == "https://adventofcode.com/2025/day/1/input"
    end

    test "double digit day" do
      actual = AoC.Input.get_url("2025", "25")
      assert actual == "https://adventofcode.com/2025/day/25/input"
    end

    test "leading zero digit day" do
      actual = AoC.Input.get_url("2025", "05")
      assert actual == "https://adventofcode.com/2025/day/5/input"
    end
  end
end
