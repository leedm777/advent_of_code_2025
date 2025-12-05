defmodule Day2503Test do
  use ExUnit.Case, async: true

  doctest AoC.Day2503

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[
             "987654321111111",
             "811111111111119",
             "234234234234278",
             "818181911112111"
           ], 357}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2503.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day2503.solve(:part1, AoC.fetch_input("2025", "03"))
    assert 17408 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[
             "987654321111111",
             "811111111111119",
             "234234234234278",
             "818181911112111"
           ], 3_121_910_778_619}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2503.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day2503.solve(:part2, AoC.fetch_input("2025", "03"))
    assert 108_895_478_369_363 < actual
    assert 172_740_584_266_849 == actual
  end
end
