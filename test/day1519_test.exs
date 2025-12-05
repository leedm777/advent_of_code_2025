defmodule Day1519Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1519

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {["H => HO", "H => OH", "O => HH", "", "HOH"], 4},
          {["H => HO", "H => OH", "O => HH", "", "HOHOHO"], 7}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day1519.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day1519.solve(:part1, AoC.fetch_input("2015", "19"))
    assert 518 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize: TestHelper.map_example_pairs([])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day1519.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day1519.solve(:part2, AoC.fetch_input("2015", "19"))
    assert "TODO" == actual
  end
end
