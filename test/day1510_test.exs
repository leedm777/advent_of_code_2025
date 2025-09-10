defmodule Day1510Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1510

  defmodule LookAndSayExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"1", "11"},
          {"11", "21"},
          {"21", "1211"},
          {"1211", "111221"},
          {"111221", "312211"}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day1510.look_and_say(input)
      assert expected == actual
    end
  end

  test "part1 example" do
    actual = AoC.Day1510.look_and_say_iter("1", 5)
    assert "312211" == actual
  end

  test "part1 final" do
    actual = AoC.Day1510.solve(:part1, AoC.fetch_input("2015", "10"))
    assert actual < 384_442
    assert 252_594 == actual
  end

  @tag :slow_as_christmas
  test "part2 final" do
    actual = AoC.Day1510.solve(:part2, AoC.fetch_input("2015", "10"))
    assert 3_579_328 == actual
  end
end
