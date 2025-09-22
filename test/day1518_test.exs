defmodule Day1518Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1518

  @input [
    ".#.#.#",
    "...##.",
    "#....#",
    "..#...",
    "#.#..#",
    "####.."
  ]

  test "parse_board" do
    actual = AoC.Day1518.parse_board(@input)

    assert actual ==
             {6, 6,
              MapSet.new([
                {0, 1},
                {0, 3},
                {0, 5},
                {1, 3},
                {1, 4},
                {2, 0},
                {2, 5},
                {3, 2},
                {4, 0},
                {4, 2},
                {4, 5},
                {5, 0},
                {5, 1},
                {5, 2},
                {5, 3}
              ])}
  end

  test "part1 example give the expected output" do
    actual = AoC.Day1518.solve(:part1, @input, 4)
    assert 4 == actual
  end

  test "part1 final" do
    actual = AoC.Day1518.solve(:part1, AoC.fetch_input("2015", "18"))
    assert 821 == actual
  end

  test "part2 give the expected output" do
    actual = AoC.Day1518.solve(:part2, @input, 5)
    assert 17 == actual
  end

  test "part2 final" do
    actual = AoC.Day1518.solve(:part2, AoC.fetch_input("2015", "18"))
    assert 886 == actual
  end
end
