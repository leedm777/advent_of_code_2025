defmodule AoC.Day1505 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    lines(input) |> Enum.count(&is_nice(&1))
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def is_nice(str) do
    has_three_vowels(str) && has_double_letter(str) && !has_naughty_string(str)
  end

  def has_three_vowels(str) do
    String.match?(str, ~r/[aeiou].*[aeiou].*[aeiou]/)
  end

  def has_double_letter(str) do
    String.match?(str, ~r/(.)\1/)
  end

  def has_naughty_string(str) do
    String.match?(str, ~r/(ab)|(cd)|(pq)|(xy)/)
  end
end
