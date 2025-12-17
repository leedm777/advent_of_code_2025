defmodule Day2511Test do
  use ExUnit.Case, async: true

  doctest AoC.Day2511

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {
            [
              "aaa: you hhh",
              "you: bbb ccc",
              "bbb: ddd eee",
              "ccc: ddd eee fff",
              "ddd: ggg",
              "eee: out",
              "fff: out",
              "ggg: out",
              "hhh: ccc fff iii",
              "iii: out"
            ],
            5
          }
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2511.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day2511.solve(:part1, AoC.fetch_input("2025", "11"))
    assert 643 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize: TestHelper.map_example_pairs([])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2511.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day2511.solve(:part2, AoC.fetch_input("2025", "11"))
    assert "TODO" == actual
  end
end
