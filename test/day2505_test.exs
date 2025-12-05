defmodule Day2505Test do
  use ExUnit.Case, async: true

  doctest AoC.Day2505

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[
             "3-5",
             "10-14",
             "16-20",
             "12-18",
             "",
             "1",
             "5",
             "8",
             "11",
             "17",
             "32"
           ], 3}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2505.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day2505.solve(:part1, AoC.fetch_input("2025", "05"))
    assert 707 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[
             "3-5",
             "10-14",
             "16-20",
             "12-18",
             "",
             "1",
             "5",
             "8",
             "11",
             "17",
             "32"
           ], 14}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2505.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day2505.solve(:part2, AoC.fetch_input("2025", "05"))
    assert 321_632_467_001_013 < actual
    assert 361_615_643_045_059 == actual
  end
end
