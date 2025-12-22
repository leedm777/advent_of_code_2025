defmodule Day2512Test do
  use ExUnit.Case, async: true

  doctest AoC.Day2512

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[
             "0:",
             "###",
             "##.",
             "##.",
             "",
             "1:",
             "###",
             "##.",
             ".##",
             "",
             "2:",
             ".##",
             "###",
             "##.",
             "",
             "3:",
             "##.",
             "###",
             "##.",
             "",
             "4:",
             "###",
             "#..",
             "###",
             "",
             "5:",
             "###",
             ".#.",
             "###",
             "",
             "4x4: 0 0 0 0 2 0",
             "12x5: 1 0 1 0 2 2",
             "12x5: 1 0 1 0 3 2"
           ], 2}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2512.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day2512.solve(:part1, AoC.fetch_input("2025", "12"))
    assert "TODO" == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize: TestHelper.map_example_pairs([])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2512.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day2512.solve(:part2, AoC.fetch_input("2025", "12"))
    assert "TODO" == actual
  end
end
