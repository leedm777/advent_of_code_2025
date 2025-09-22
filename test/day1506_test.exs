defmodule Day1506Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1506

  test "parse_line" do
    for line <- AoC.fetch_input("2015", "06") do
      actual = AoC.Day1506.parse_line(line)

      str =
        "#{actual.cmd} #{actual.start_row},#{actual.start_col} through #{actual.end_row},#{actual.end_col}"

      assert str == line
      assert actual.start_col <= actual.end_col
      assert actual.start_row <= actual.end_row
    end
  end

  defmodule PartOneTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {["turn on 0,0 through 999,999"], 1_000_000},
          {["toggle 0,0 through 999,0"], 1000},
          {["turn off 499,499 through 500,500"], 0},
          {["turn on 0,0 through 999,999"], ["turn off 499,499 through 500,500"], 1_000_000 - 4}
        ])

    test "part1 examples", %{input: input, expected: expected} do
      actual = AoC.Day1506.solve(:part1, input)
      assert expected == actual
    end
  end

  defmodule PartOneFinalTest do
    use ExUnit.Case, async: true

    @tag :slow_as_christmas
    @tag timeout: :infinity
    test "part1 final" do
      actual = AoC.Day1506.solve(:part1, AoC.fetch_input("2015", "06"))
      assert actual < 541_749
      assert 377_891 == actual
    end
  end

  defmodule PartTwoTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"turn on 0,0 through 0,0", 1},
          {"toggle 0,0 through 999,999", 2_000_000}
        ])

    test "part 2 examples", %{input: input, expected: expected} do
      actual = AoC.Day1506.solve(:part2, [input])
      assert expected == actual
    end
  end

  defmodule PartTwoFinalTest do
    use ExUnit.Case, async: true

    @tag :slow_as_christmas
    @tag timeout: :infinity
    test "part2 final" do
      actual = AoC.Day1506.solve(:part2, AoC.fetch_input("2015", "06"))
      assert actual > 13_396_307
      assert 14_110_788 == actual
    end
  end
end
