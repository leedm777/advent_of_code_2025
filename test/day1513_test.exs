defmodule Day1513Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1513

  @input [
    "Alice would gain 54 happiness units by sitting next to Bob.",
    "Alice would lose 79 happiness units by sitting next to Carol.",
    "Alice would lose 2 happiness units by sitting next to David.",
    "Bob would gain 83 happiness units by sitting next to Alice.",
    "Bob would lose 7 happiness units by sitting next to Carol.",
    "Bob would lose 63 happiness units by sitting next to David.",
    "Carol would lose 62 happiness units by sitting next to Alice.",
    "Carol would gain 60 happiness units by sitting next to Bob.",
    "Carol would gain 55 happiness units by sitting next to David.",
    "David would gain 46 happiness units by sitting next to Alice.",
    "David would lose 7 happiness units by sitting next to Bob.",
    "David would gain 41 happiness units by sitting next to Carol."
  ]

  test "parse_line" do
    for line <- @input do
      actual = AoC.Day1513.parse_line(line)

      assert String.starts_with?(line, actual.who)
      assert String.ends_with?(line, "#{actual.neighbor}.")

      if actual.units < 0 do
        assert String.contains?(line, "lose #{-actual.units}")
      else
        assert String.contains?(line, "gain #{actual.units}")
      end
    end
  end

  test "the example" do
    actual = AoC.Day1513.solve(:part1, @input)
    assert 330 == actual
  end

  test "part1 final" do
    actual = AoC.Day1513.solve(:part1, AoC.fetch_input("2015", "13"))
    assert 618 == actual
  end

  test "part2 final" do
    actual = AoC.Day1513.solve(:part2, AoC.fetch_input("2015", "13"))
    assert 601 == actual
  end
end
