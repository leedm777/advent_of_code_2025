defmodule Day1516Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1516

  test "parse_line" do
    actual = AoC.Day1516.parse_line("Sue 1: cars: 78465, akitas: 5375, goldfish: 8163")
    assert actual == {1, [{"cars", 78465}, {"akitas", 5375}, {"goldfish", 8163}]}
  end

  test "part1 final" do
    actual = AoC.Day1516.solve(:part1, AoC.fetch_input("2015", "16"))
    assert 373 == actual
  end

  test "part2 final" do
    actual = AoC.Day1516.solve(:part2, AoC.fetch_input("2015", "16"))
    assert "TODO" == actual
  end
end
