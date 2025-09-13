defmodule Day1512Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1512

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {~s([1,2,3]), 6},
          {~s({"a":2,"b":4}), 6},
          {~s([[[3]]]), 3},
          {~s({"a":{"b":4},"c":-1}), 3},
          {~s({"a":[-1,1]}), 0},
          {~s([-1,{"a":1}]), 0},
          {~s([]), 0},
          {~s({}), 0}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day1512.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day1512.solve(:part1, AoC.fetch_input("2015", "12"))
    assert 156_366 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {~s([1,2,3]), 6},
          {~s([1,{"c":"red","b":2},3]), 4},
          {~s({"d":"red","e":[1,2,3,4],"f":5}), 0},
          {~s([1,"red",5]), 6}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day1512.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day1512.solve(:part2, AoC.fetch_input("2015", "12"))
    assert 96852 == actual
  end
end
