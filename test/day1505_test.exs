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
      {"dvszwmarrgswjxmb", false},
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
      {"dvszwmarrgswjxmb", true},
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
      {"xy", true},
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

  test_with_params "part2 examples", fn input, expected ->
    actual = AoC.Day1505.solve(:part2, input)
    assert expected == actual
  end do
    TestHelper.describe_examples([])
  end

  test "part2 final" do
    actual = AoC.Day1505.solve(:part2, AoC.fetch_input("2015", "05"))
    assert "TODO" == actual
  end
end
