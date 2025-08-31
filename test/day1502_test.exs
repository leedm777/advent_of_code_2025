defmodule Day1502Test do
  use ExUnit.Case, async: true
  use ExUnit.Parameterized

  doctest AoC.Day1502

  test_with_params "part1", fn input, expected ->
    actual = AoC.Day1502.solve(:part1, input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
      {"2x3x4", 58},
      {"1x1x10", 43},
      {"2x3x4\n1x1x10\n", 58 + 43},
      {AoC.fetch_input("2015", "02"), 1_598_415}
    ])
  end

  test_with_params "part2", fn input, expected ->
    actual = AoC.Day1502.solve(:part2, input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
      {"2x3x4", 34},
      {"1x1x10", 14},
      {"2x3x4\n1x1x10\n", 34 + 14},
      {AoC.fetch_input("2015", "02"), 3_812_909}
    ])
  end
end
