defmodule Day1509Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1509

  defmodule ParseLineTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"London to Dublin = 464", %{cities: {"London", "Dublin"}, dist: 464}},
          {"London to Belfast = 518", %{cities: {"London", "Belfast"}, dist: 518}},
          {"Dublin to Belfast = 141", %{cities: {"Dublin", "Belfast"}, dist: 141}}
        ])

    test "parse_line", %{input: input, expected: expected} do
      actual = AoC.Day1509.parse_line(input)
      assert expected == actual
    end
  end

  defmodule EdgeDistanceTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {{"London", "Dublin"}, {:ok, 464}},
          {{"Belfast", "London"}, {:ok, 518}},
          {{"Dublin", "Belfast"}, {:error, "edge not found"}}
        ])

    @graph [
      %{cities: {"London", "Dublin"}, dist: 464},
      %{cities: {"London", "Belfast"}, dist: 518}
    ]

    test "edge_distance", %{input: {src, dst}, expected: expected} do
      actual = AoC.Day1509.edge_distance(@graph, src, dst)
      assert expected == actual
    end
  end

  defmodule PartOneExamplesTest do
    use ExUnit.Case, async: true

    test "give the expected output" do
      input =
        Enum.join(
          [
            "London to Dublin = 464",
            "London to Belfast = 518",
            "Dublin to Belfast = 141"
          ],
          "\n"
        )

      actual = AoC.Day1509.solve(:part1, input)
      assert 605 == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day1509.solve(:part1, AoC.fetch_input("2015", "09"))
    assert 251 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case, async: true

    test "give the expected output" do
      input =
        Enum.join(
          [
            "London to Dublin = 464",
            "London to Belfast = 518",
            "Dublin to Belfast = 141"
          ],
          "\n"
        )

      actual = AoC.Day1509.solve(:part2, input)
      assert 982 == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day1509.solve(:part2, AoC.fetch_input("2015", "09"))
    assert 898 == actual
  end
end
