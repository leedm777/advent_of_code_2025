defmodule Day1505Test do
  use ExUnit.Case, async: true
  use ExUnit.Parameterized

  doctest AoC.Day1505

  test_with_params "has_three_vowels", fn input, expected ->
    actual = AoC.Day1505.has_three_vowels(input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
      {"ugknbfddgicrmopn", true},
      {"aaa", true},
      {"jchzalrnumimnmhp", true},
      {"haegwjzuvuyypxyu", true},
      {"dvszwmarrgswjxmb", false}
    ])
  end

  test_with_params "has_double_letter", fn input, expected ->
    actual = AoC.Day1505.has_double_letter(input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
      {"ugknbfddgicrmopn", true},
      {"aaa", true},
      {"jchzalrnumimnmhp", false},
      {"haegwjzuvuyypxyu", true},
      {"dvszwmarrgswjxmb", true}
    ])
  end

  test_with_params "has_naughty_string", fn input, expected ->
    actual = AoC.Day1505.has_naughty_string(input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
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
  end

  test_with_params "part1 examples", fn input, expected ->
    actual = AoC.Day1505.solve(:part1, input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
      {"ugknbfddgicrmopn", 1},
      {"aaa", 1},
      {"jchzalrnumimnmhp", 0},
      {"haegwjzuvuyypxyu", 0},
      {"dvszwmarrgswjxmb", 0},
      {Enum.join(
         ["ugknbfddgicrmopn", "aaa", "jchzalrnumimnmhp", "haegwjzuvuyypxyu", "dvszwmarrgswjxmb"],
         "\n"
       ), 2}
    ])
  end

  test "part1 final" do
    actual = AoC.Day1505.solve(:part1, AoC.fetch_input("2015", "05"))
    assert 238 == actual
  end

  test_with_params "has_repeating_double_letters", fn input, expected ->
    actual = AoC.Day1505.has_repeating_double_letters(input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
      {"xyxy", true},
      {"aabcdefgaa", true},
      {"qjhvhtzxzqqjkmpb", true},
      {"xxyxx", true},
      {"uurcxstgmygtbstg", true},
      {"ieodomkazucvgmuy", false}
    ])
  end

  test_with_params "has_three_letter_palindrome", fn input, expected ->
    actual = AoC.Day1505.has_three_letter_palindrome(input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
      {"xyx", true},
      {"abcdefeghi", true},
      {"efe", true},
      {"aaa", true},
      {"qjhvhtzxzqqjkmpb", true},
      {"xxyxx", true},
      {"uurcxstgmygtbstg", false},
      {"ieodomkazucvgmuy", true}
    ])
  end

  test_with_params "part2 examples", fn input, expected ->
    actual = AoC.Day1505.solve(:part2, input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
      {"qjhvhtzxzqqjkmpb", 1},
      {"xxyxx", 1},
      {"uurcxstgmygtbstg", 0},
      {"ieodomkazucvgmuy", 0},
      {Enum.join(
         ["qjhvhtzxzqqjkmpb", "xxyxx", "uurcxstgmygtbstg", "ieodomkazucvgmuy"],
         "\n"
       ), 2}
    ])
  end

  test "part2 final" do
    actual = AoC.Day1505.solve(:part2, AoC.fetch_input("2015", "05"))
    assert 69 == actual
  end
end
