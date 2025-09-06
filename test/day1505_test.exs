defmodule Day1505Test do
  use ExUnit.Case, async: true

  doctest AoC.Day1505

  defmodule HasThreeVowelsTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"ugknbfddgicrmopn", true},
          {"aaa", true},
          {"jchzalrnumimnmhp", true},
          {"haegwjzuvuyypxyu", true},
          {"dvszwmarrgswjxmb", false}
        ])

    test "has_three_vowels?", %{input: input, expected: expected} do
      actual = AoC.Day1505.has_three_vowels?(input)
      assert expected == actual
    end
  end

  defmodule HasDoubleLetterTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"ugknbfddgicrmopn", true},
          {"aaa", true},
          {"jchzalrnumimnmhp", false},
          {"haegwjzuvuyypxyu", true},
          {"dvszwmarrgswjxmb", true}
        ])

    test "has_double_letter?", %{input: input, expected: expected} do
      actual = AoC.Day1505.has_double_letter?(input)
      assert expected == actual
    end
  end

  defmodule HasNaughtyStringTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"ugknbfddgicrmopn", false},
          {"aaa", false},
          {"jchzalrnumimnmhp", false},
          {"haegwjzuvuyypxyu", true},
          {"dvszwmarrgswjxmb", false},
          {"ab", true},
          {"cd", true},
          {"pq", true},
          {"xy", true}
        ])

    test "has_naughty_string?", %{input: input, expected: expected} do
      actual = AoC.Day1505.has_naughty_string?(input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day1505.solve(:part1, AoC.fetch_input("2015", "05"))
    assert 238 == actual
  end

  defmodule HasRepeatingDoubleLettersTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"xyxy", true},
          {"aabcdefgaa", true},
          {"qjhvhtzxzqqjkmpb", true},
          {"xxyxx", true},
          {"uurcxstgmygtbstg", true},
          {"ieodomkazucvgmuy", false}
        ])

    test "has_repeating_double_letters?", %{input: input, expected: expected} do
      actual = AoC.Day1505.has_repeating_double_letters?(input)
      assert expected == actual
    end
  end

  defmodule HasThreeLetterPalindromeTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"xyx", true},
          {"abcdefeghi", true},
          {"efe", true},
          {"aaa", true},
          {"qjhvhtzxzqqjkmpb", true},
          {"xxyxx", true},
          {"uurcxstgmygtbstg", false},
          {"ieodomkazucvgmuy", true}
        ])

    test "has_three_letter_palindrome?", %{input: input, expected: expected} do
      actual = AoC.Day1505.has_three_letter_palindrome?(input)
      assert expected == actual
    end
  end

  defmodule PartOneTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"ugknbfddgicrmopn", 1},
          {"aaa", 1},
          {"jchzalrnumimnmhp", 0},
          {"haegwjzuvuyypxyu", 0},
          {"dvszwmarrgswjxmb", 0},
          {Enum.join(
             [
               "ugknbfddgicrmopn",
               "aaa",
               "jchzalrnumimnmhp",
               "haegwjzuvuyypxyu",
               "dvszwmarrgswjxmb"
             ],
             "\n"
           ), 2}
        ])

    test "part1 examples", %{input: input, expected: expected} do
      actual = AoC.Day1505.solve(:part1, input)
      assert expected == actual
    end
  end

  defmodule PartTwoTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs([
          {"qjhvhtzxzqqjkmpb", 1},
          {"xxyxx", 1},
          {"uurcxstgmygtbstg", 0},
          {"ieodomkazucvgmuy", 0},
          {Enum.join(
             ["qjhvhtzxzqqjkmpb", "xxyxx", "uurcxstgmygtbstg", "ieodomkazucvgmuy"],
             "\n"
           ), 2}
        ])

    test "part 2 examples", %{input: input, expected: expected} do
      actual = AoC.Day1505.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day1505.solve(:part2, AoC.fetch_input("2015", "05"))
    assert 69 == actual
  end
end
