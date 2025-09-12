defmodule Day1511Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1511

  defmodule HasAscendingLettersExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"abc", true},
          {"abcjieurij", true},
          {"kdheieejnixyz", true},
          {"ndhrnekcuensk", false}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day1511.has_ascending_letters?(input)
      assert expected == actual
    end
  end

  defmodule HasInvalidLettersExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"abc", false},
          {"abcjieurij", true},
          {"kdheieejnixyz", true},
          {"ndhrnekcuensk", false}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day1511.has_invalid_letter?(input)
      assert expected == actual
    end
  end

  defmodule HasEnoughPairsExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"", false},
          {"aa", false},
          {"aaa", false},
          {"abcdef", false},
          {"aabb", true}
        ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day1511.has_enough_pairs?(input)
      assert expected == actual
    end
  end

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize: TestHelper.map_example_pairs([])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day1511.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day1511.solve(:part1, AoC.fetch_input("2015", "11"))
    assert "TODO" == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize: TestHelper.map_example_pairs([])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day1511.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day1511.solve(:part2, AoC.fetch_input("2015", "11"))
    assert "TODO" == actual
  end
end
