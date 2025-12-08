defmodule Day2508Test do
  use ExUnit.Case, async: true

  doctest AoC.Day2508

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[
             "162,817,812",
             "57,618,57",
             "906,360,560",
             "592,479,940",
             "352,342,300",
             "466,668,158",
             "542,29,236",
             "431,825,988",
             "739,650,466",
             "52,470,668",
             "216,146,977",
             "819,987,18",
             "117,168,530",
             "805,96,715",
             "346,949,466",
             "970,615,88",
             "941,993,340",
             "862,61,35",
             "984,92,344",
             "425,690,689"
           ], 40}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2508.solve(:part1, input, 10)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day2508.solve(:part1, AoC.fetch_input("2025", "08"))
    assert 54180 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize: TestHelper.map_example_pairs([])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2508.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day2508.solve(:part2, AoC.fetch_input("2025", "08"))
    assert "TODO" == actual
  end
end
