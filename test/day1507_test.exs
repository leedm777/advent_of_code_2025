defmodule Day1507Test do
  use ExUnit.Case, async: true

  defmodule ParseTermTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"123", 123},
          {"x", "x"}
        ])

    describe "parse_term" do
      test "parses example", %{input: input, expected: expected} do
        actual = AoC.Day1507.parse_term(input)
        assert expected == actual
      end
    end
  end

  defmodule ParseLineTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"123 -> x", %{op: "in", input: 123, output: "x"}},
          {"x AND y -> z", %{op: "AND", lhs: "x", rhs: "y", output: "z"}},
          {"x OR y -> z", %{op: "OR", lhs: "x", rhs: "y", output: "z"}},
          {"p LSHIFT 2 -> q", %{op: "LSHIFT", lhs: "p", rhs: 2, output: "q"}},
          {"p RSHIFT 2 -> q", %{op: "RSHIFT", lhs: "p", rhs: 2, output: "q"}},
          {"NOT e -> f", %{op: "NOT", input: "e", output: "f"}}
        ])

    test "parses example", %{input: input, expected: expected} do
      actual = AoC.Day1507.parse_line(input)
      assert expected == actual
    end
  end

  defmodule PartOneTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs(
          [
            {"d", 72},
            {"e", 507},
            {"f", 492},
            {"g", 114},
            {"h", 65412},
            {"i", 65079},
            {"x", 123},
            {"y", 456}
          ],
          :wire
        )

    test "should put the expected value on the wire", %{wire: wire, expected: expected} do
      input =
        Enum.join(
          [
            "123 -> x",
            "456 -> y",
            "x AND y -> d",
            "x OR y -> e",
            "x LSHIFT 2 -> f",
            "y RSHIFT 2 -> g",
            "NOT x -> h",
            "NOT y -> i"
          ],
          "\n"
        )

      actual = AoC.Day1507.solve(:part1, input, wire)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day1507.solve(:part1, AoC.fetch_input("2015", "07"))
    assert 956 == actual
  end

  test "part2 final" do
    actual = AoC.Day1507.solve(:part2, AoC.fetch_input("2015", "07"))
    assert 40149 == actual
  end
end
