defmodule Day1503Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1503

  defmodule PartOneTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[">"], 2},
          {["^>v<"], 4},
          {["^v^v^v^v^v"], 2},
          {AoC.fetch_input("2015", "03"), 2565}
        ])

    test "part1 examples", %{input: input, expected: expected} do
      actual = AoC.Day1503.solve(:part1, input)
      assert expected == actual
    end
  end

  defmodule PartTwoTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {["^v"], 3},
          {["^>v<"], 3},
          {["^v^v^v^v^v"], 11},
          {AoC.fetch_input("2015", "03"), 2639}
        ])

    test "part 2 examples", %{input: input, expected: expected} do
      actual = AoC.Day1503.solve(:part2, input)
      assert expected == actual
    end
  end
end
