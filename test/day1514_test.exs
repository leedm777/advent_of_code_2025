defmodule Day1514Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1514

  @example_input [
    "Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.",
    "Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds."
  ]

  @comet %{name: "Comet", speed: 14, duration: 10, rest: 127}
  @dancer %{name: "Dancer", speed: 16, duration: 11, rest: 162}
  @example [@comet, @dancer]

  test "parse_line should parse properly" do
    actual = Enum.map(@example_input, &AoC.Day1514.parse_line(&1))

    assert actual == @example
  end

  defmodule DistanceFlownExamplesTest do
    @comet %{name: "Comet", speed: 14, duration: 10, rest: 127}
    @dancer %{name: "Dancer", speed: 16, duration: 11, rest: 162}

    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {{@comet, 1}, 14},
          {{@dancer, 1}, 16},
          {{@comet, 10}, 140},
          {{@dancer, 10}, 160},
          {{@comet, 11}, 140},
          {{@dancer, 11}, 176},
          {{@comet, 12}, 140},
          {{@dancer, 12}, 176},
          {{@comet, 138}, 154},
          {{@dancer, 138}, 176},
          {{@comet, 1000}, 1120},
          {{@dancer, 1000}, 1056}
        ])

    test "give the expected output", %{input: {deer, duration}, expected: expected} do
      actual = AoC.Day1514.distance_flown(deer, duration)
      assert expected == actual
    end
  end

  test "part 1 should give the expected output" do
    actual = AoC.Day1514.solve(:part1, Enum.join(@example_input, "\n"), 1000)
    assert 1120 == actual
  end

  test "part1 final" do
    actual = AoC.Day1514.solve(:part1, AoC.fetch_input("2015", "14"))
    assert 2696 == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize: TestHelper.map_example_pairs([])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day1514.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day1514.solve(:part2, AoC.fetch_input("2015", "14"))
    assert "TODO" == actual
  end
end
