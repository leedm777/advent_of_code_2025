defmodule Day1501Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1501

  defmodule PartOneTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"(())", 0},
          {"()()", 0},
          {"(((", 3},
          {"(()(()(", 3},
          {"))(((((", 3},
          {"())", -1},
          {"))(", -1},
          {")))", -3},
          {")())())", -3},
          {AoC.fetch_input("2015", "01"), 232}
        ])

    test "part1 examples", %{input: input, expected: expected} do
      actual = AoC.Day1501.solve(:part1, input)
      assert expected == actual
    end
  end

  defmodule PartTwoTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"))", 1},
          {")", 1},
          {"()())", 5},
          {AoC.fetch_input("2015", "01"), 1783}
        ])

    test "part 2 examples", %{input: input, expected: expected} do
      actual = AoC.Day1501.solve(:part2, input)
      assert expected == actual
    end
  end
end
