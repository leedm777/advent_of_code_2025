defmodule Day1504Test do
  use ExUnit.Case, async: true
  use ExUnit.Parameterized

  doctest AoC.Day1504

  test_with_params "part1", fn input, expected ->
    actual = AoC.Day1504.solve(:part1, input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
      {"abcdef", 609_043},
      {"pqrstuv", 1_048_970}
    ])
  end

  @tag :slow_as_christmas
  test "part1 final" do
    actual = AoC.Day1504.solve(:part1, AoC.fetch_input("2015", "04"))
    assert actual < 3_255_144
    assert actual == 282_749
  end

  @tag :slow_as_christmas
  test "part2 final" do
    actual = AoC.Day1504.solve(:part2, AoC.fetch_input("2015", "04"))
    assert 9_962_624 == actual
  end
end
