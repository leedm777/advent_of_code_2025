defmodule Day2510Test do
  use ExUnit.Case, async: true

  doctest AoC.Day2510

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[
             "[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}",
             "[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}",
             "[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}"
           ], 7}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2510.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day2510.solve(:part1, AoC.fetch_input("2025", "10"))
    assert 559 > actual
    assert 520 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {[
             "[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}",
             "[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}",
             "[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}"
           ], 33}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day2510.solve(:part2, input)
      assert expected == actual
    end
  end

  @tag timeout: :infinity
  test "part2 final" do
    actual = AoC.Day2510.solve(:part2, AoC.fetch_input("2025", "10"))
    assert "TODO" == actual
  end
end
