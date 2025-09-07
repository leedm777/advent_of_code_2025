defmodule Day1504Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1504

  defmodule PartOneTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"abcdef", 609_043},
          {"pqrstuv", 1_048_970}
        ])

    test "part1 examples", %{input: input, expected: expected} do
      actual = AoC.Day1504.solve(:part1, input)
      assert expected == actual
    end
  end

  defmodule PartOneFinalTest do
    use ExUnit.Case, async: true

    @tag :slow_as_christmas
    test "part1 final" do
      actual = AoC.Day1504.solve(:part1, AoC.fetch_input("2015", "04"))
      assert actual < 3_255_144
      assert actual == 282_749
    end
  end

  defmodule PartTwoFinalTest do
    use ExUnit.Case, async: true

    @tag :slow_as_christmas
    test "part2 final" do
      actual = AoC.Day1504.solve(:part2, AoC.fetch_input("2015", "04"))
      assert 9_962_624 == actual
    end
  end
end
