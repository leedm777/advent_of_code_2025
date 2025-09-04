defmodule Day1506Test do
  use ExUnit.Case, async: true
  use ExUnit.Parameterized

  doctest AoC.Day1506

  test "parse_line" do
    for line <- AoC.Solution.lines(AoC.fetch_input("2015", "06")) do
      actual = AoC.Day1506.parse_line(line)

      str =
        "#{actual.cmd} #{actual.start_row},#{actual.start_col} through #{actual.end_row},#{actual.end_col}"

      assert str == line
      assert actual.start_col <= actual.end_col
      assert actual.start_row <= actual.end_row
    end
  end

  test_with_params "part1 examples", fn input, expected ->
    actual = AoC.Day1506.solve(:part1, input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
      {"turn on 0,0 through 999,999", 1_000_000},
      {"toggle 0,0 through 999,0", 1000},
      {"turn off 499,499 through 500,500", 0},
      {"turn on 0,0 through 999,999\nturn off 499,499 through 500,500", 1_000_000 - 4}
    ])
  end

  test "part1 final" do
    actual = AoC.Day1506.solve(:part1, AoC.fetch_input("2015", "06"))
    assert actual < 541_749
    assert 377_891 == actual
  end

  test_with_params "part2 examples", fn input, expected ->
    actual = AoC.Day1506.solve(:part2, input)
    assert expected == actual
  end do
    TestHelper.describe_examples([])
  end

  test "part2 final" do
    actual = AoC.Day1506.solve(:part2, AoC.fetch_input("2015", "06"))
    assert "TODO" == actual
  end
end
