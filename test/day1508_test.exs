defmodule Day1508Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1508

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"\"\"", 2},
          {"\"abc\"", 2},
          {"\"aaa\\\"aaa\"", 3},
          {"\"\\x27\"", 5},
          {Enum.join(
             [
               "\"\"",
               "\"abc\"",
               "\"aaa\\\"aaa\"",
               "\"\\x27\""
             ],
             "\n"
           ), 12}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day1508.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day1508.solve(:part1, AoC.fetch_input("2015", "08"))
    assert 1371 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"\"\"", 4},
          {"\"abc\"", 4},
          {"\"aaa\\\"aaa\"", 6},
          {"\"\\x27\"", 5},
          {Enum.join(
             [
               "\"\"",
               "\"abc\"",
               "\"aaa\\\"aaa\"",
               "\"\\x27\""
             ],
             "\n"
           ), 19}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day1508.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day1508.solve(:part2, AoC.fetch_input("2015", "08"))
    assert 2117 == actual
  end
end
