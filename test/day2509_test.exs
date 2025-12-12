defmodule Day2509Test do
  use ExUnit.Case, async: true

  doctest AoC.Day2509

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {
            [
              "7,1",
              "11,1",
              "11,7",
              "9,7",
              "9,5",
              "2,5",
              "2,3",
              "7,3"
            ],
            50
          }
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2509.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day2509.solve(:part1, AoC.fetch_input("2025", "09"))
    assert 4_725_826_296 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[
             "7,1",
             "11,1",
             "11,7",
             "9,7",
             "9,5",
             "2,5",
             "2,3",
             "7,3"
           ], 24}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2509.solve(:part2, input)
      assert expected == actual
    end
  end

  @tag timeout: :infinity
  @tag :slow_as_christmas
  test "part2 final" do
    actual = AoC.Day2509.solve(:part2, AoC.fetch_input("2025", "09"))
    assert 1_637_556_834 == actual
  end
end
