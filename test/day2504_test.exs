defmodule Day2504Test do
  use ExUnit.Case, async: true

  doctest AoC.Day2504

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs(
          [
            {[
              "..@@.@@@@.",
              "@@@.@.@.@@",
              "@@@@@.@.@@",
              "@.@@@@..@.",
              "@@.@@@@.@@",
              ".@@@@@@@.@",
              ".@.@.@.@@@",
              "@.@@@.@@@@",
              ".@@@@@@@@.",
              "@.@.@@@.@."
            ], 13}
          ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2504.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day2504.solve(:part1, AoC.fetch_input("2025", "04"))
    assert 1428 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs(
          [
          ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2504.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day2504.solve(:part2, AoC.fetch_input("2025", "04"))
    assert "TODO" == actual
  end
end
