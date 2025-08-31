defmodule Day1501Test do
  use ExUnit.Case, async: true
  use ExUnit.Parameterized

  doctest AoC.Day1501

  test_with_params "part1", fn input, expected ->
    actual = AoC.Day1501.solve(:part1, input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
      {"(())", 0},
      {"()()", 0},
      {"(((", 3},
      {"(()(()(", 3},
      {"))(((((", 3},
      {"())", -1},
      {"))(", -1},
      {")))", -3},
      {")())())", -3},
      {AoC.fetch_input("2015", "01"), 232}
    ])
  end

  test_with_params "part2", fn input, expected ->
    actual = AoC.Day1501.solve(:part2, input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
      {"))", 1},
      {")", 1},
      {"()())", 5},
      {AoC.fetch_input("2015", "01"), 1783}
    ])
  end
end
