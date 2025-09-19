defmodule Day1515Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1515

  @example [
    "Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8",
    "Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3"
  ]

  test "parse_line" do
    actual = Enum.map(@example, &AoC.Day1515.parse_line(&1))

    assert actual == [
             %{name: "Butterscotch", props: [-1, -2, 6, 3, 8]},
             %{name: "Cinnamon", props: [2, 3, -2, -1, 3]}
           ]
  end

  test "part1 example give the expected output" do
    actual = AoC.Day1515.solve(:part1, Enum.join(@example, "\n"))
    assert 62_842_880 == actual
  end

  test "part1 final" do
    actual = AoC.Day1515.solve(:part1, AoC.fetch_input("2015", "15"))
    assert 21_367_368 == actual
  end

  test "part2 example give the expected output" do
    actual = AoC.Day1515.solve(:part2, Enum.join(@example, "\n"))
    assert 57_600_000 == actual
  end

  test "part2 final" do
    actual = AoC.Day1515.solve(:part2, AoC.fetch_input("2015", "15"))
    assert 1_766_400 == actual
  end
end
