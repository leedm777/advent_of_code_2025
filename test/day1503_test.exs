defmodule Day1503Test do
  use ExUnit.Case, async: true
  use ExUnit.Parameterized

  doctest AoC.Day1503

  test_with_params "part1", fn input, expected ->
    actual = AoC.Day1503.solve(:part1, input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
      {">", 2},
      {"^>v<", 4},
      {"^v^v^v^v^v", 2},
      {AoC.fetch_input("2015", "03"), 2565}
    ])
  end

  test_with_params "part2", fn input, expected ->
    actual = AoC.Day1503.solve(:part2, input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
      {AoC.fetch_input("2015", "03"), "TODO"}
    ])
  end
end
