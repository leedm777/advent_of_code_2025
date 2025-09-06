defmodule Day1507Test do
  use ExUnit.Case, async: true

  describe "parse_term" do
    for {input, expected} <- [
          {"123", 123},
          {"x", "x"}
        ] do
      @vars {input, expected}

      test "#{input} -> #{inspect(expected)}}" do
        {input, expected} = @vars
        actual = AoC.Day1507.parse_term(input)
        assert expected == actual
      end
    end
  end

  describe "parse_line" do
    for {input, expected} <- [
          {"123 -> x", %{op: "in", input: 123, output: "x"}},
          {"x AND y -> z", %{op: "AND", lhs: "x", rhs: "y", output: "z"}},
          {"p LSHIFT 2 -> q", %{op: "LSHIFT", lhs: "p", rhs: 2, output: "q"}},
          {"NOT e -> f", %{op: "NOT", input: "e", output: "f"}}
        ] do
      @vars {input, expected}

      test "#{input} -> #{inspect(expected)}" do
        {input, expected} = @vars
        actual = AoC.Day1507.parse_line(input)
        assert expected == actual
      end
    end
  end

  describe "part1 examples" do
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

    for {wire, expected} <- [
          {"d", 72},
          {"e", 507},
          {"f", 492},
          {"g", 114},
          {"h", 65412},
          {"i", 65079},
          {"x", 123},
          {"y", 456}
        ] do
      @vars {wire, expected, input}

      test "#{wire} -> #{expected}}" do
        {wire, expected, input} = @vars
        actual = AoC.Day1507.solve(:part1, input, wire)
        assert expected == actual
      end
    end
  end

  test "part1 final" do
    actual = AoC.Day1507.solve(:part1, AoC.fetch_input("2015", "07"))
    assert 956 == actual
  end

  describe "part2 examples" do
    for {input, expected} <- [] do
      @vars {input, expected}

      test "#{input} -> #{inspect(expected)}}" do
        {input, expected} = @vars
        actual = AoC.Day1507.solve(:part2, input)
        assert expected == actual
      end
    end
  end

  test "part2 final" do
    actual = AoC.Day1507.solve(:part2, AoC.fetch_input("2015", "07"))
    assert "TODO" == actual
  end
end
