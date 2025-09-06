defmodule Day1502Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1502

  defmodule PartOneTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"2x3x4", 58},
          {"1x1x10", 43},
          {"2x3x4\n1x1x10\n", 58 + 43},
          {AoC.fetch_input("2015", "02"), 1_598_415}
        ])

    test "part1 examples", %{input: input, expected: expected} do
      actual = AoC.Day1502.solve(:part1, input)
      assert expected == actual
    end
  end

  defmodule PartTwoTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"2x3x4", 34},
          {"1x1x10", 14},
          {"2x3x4\n1x1x10\n", 34 + 14},
          {AoC.fetch_input("2015", "02"), 3_812_909}
        ])

    test "part 2 examples", %{input: input, expected: expected} do
      actual = AoC.Day1502.solve(:part2, input)
      assert expected == actual
    end
  end
end
