defmodule Day1517Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1517

  test "part1 example give the expected output" do
    actual = AoC.Day1517.solve(:part1, ["20", "15", "10", "5", "5"], 25)
    assert 4 == actual
  end

  test "part1 final" do
    actual = AoC.Day1517.solve(:part1, AoC.fetch_input("2015", "17"))
    assert 1638 == actual
  end

  test "part2 example give the expected output" do
    actual = AoC.Day1517.solve(:part2, ["20", "15", "10", "5", "5"], 25)
    assert 3 == actual
  end

  test "part2 final" do
    actual = AoC.Day1517.solve(:part2, AoC.fetch_input("2015", "17"))
    assert 17 == actual
  end
end
