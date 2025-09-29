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

  test "parse_molecule" do
    actual = AoC.Day1519.parse_molecule("CRnFYFYFAr")
    assert actual == ["C", "Rn", "F", "Y", "F", "Y", "F", "Ar"]
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {["e => H", "e => O", "H => HO", "H => OH", "O => HH", "", "HOH"], 3},
          {["e => H", "e => O", "H => HO", "H => OH", "O => HH", "", "HOHOHO"], 6}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day1519.solve(:part2, input)
      assert expected == actual
    end
  end

  @tag timeout: :infinity
  test "part2 final" do
    actual = AoC.Day1519.solve(:part2, AoC.fetch_input("2015", "19"))
    assert "TODO" == actual
  end
end
