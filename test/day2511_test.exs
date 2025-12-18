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
      parameterize:
        TestHelper.map_example_pairs([
          {[
             "svr: aaa bbb",
             "aaa: fft",
             "fft: ccc",
             "bbb: tty",
             "tty: ccc",
             "ccc: ddd eee",
             "ddd: hub",
             "hub: fff",
             "eee: dac",
             "dac: fff",
             "fff: ggg hhh",
             "ggg: out",
             "hhh: out"
           ], 2}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2511.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day2511.solve(:part2, AoC.fetch_input("2025", "11"))
    assert 417_190_406_827_152 == actual
  end
end
