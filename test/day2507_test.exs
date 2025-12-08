defmodule Day2507Test do
  use ExUnit.Case, async: true

  doctest AoC.Day2507

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[
             ".......S.......",
             "...............",
             ".......^.......",
             "...............",
             "......^.^......",
             "...............",
             ".....^.^.^.....",
             "...............",
             "....^.^...^....",
             "...............",
             "...^.^...^.^...",
             "...............",
             "..^...^.....^..",
             "...............",
             ".^.^.^.^.^...^.",
             "..............."
           ], 21}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2507.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day2507.solve(:part1, AoC.fetch_input("2025", "07"))
    assert 1609 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize: TestHelper.map_example_pairs([])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2507.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day2507.solve(:part2, AoC.fetch_input("2025", "07"))
    assert "TODO" == actual
  end
end
