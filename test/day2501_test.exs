defmodule Day2501Test do
  use ExUnit.Case, async: true

  doctest AoC.Day2501

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs(
          [
            {["L68","L30","R48","L5","R60","L55","L1","L99","R14","L82"], 3}
          ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2501.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day2501.solve(:part1, AoC.fetch_input("2025", "01"))
    assert 999 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs(
          [
          ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2501.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day2501.solve(:part2, AoC.fetch_input("2025", "01"))
    assert "TODO" == actual
  end
end
