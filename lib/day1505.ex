defmodule AoC.Day1505 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    input |> Enum.count(&is_nice?(&1))
  end

  @impl true
  def solve(:part2, input) do
    input |> Enum.count(&is_really_nice?(&1))
  end

  def is_really_nice?(str) do
    has_repeating_double_letters?(str) && has_three_letter_palindrome?(str)
  end

  def has_repeating_double_letters?(str) do
    String.match?(str, ~r/(..).*\1/)
  end

  def has_three_letter_palindrome?(str) do
    String.match?(str, ~r/(.).\1/)
  end

  def is_nice?(str) do
    has_three_vowels?(str) && has_double_letter?(str) && !has_naughty_string?(str)
  end

  def has_three_vowels?(str) do
    String.match?(str, ~r/[aeiou].*[aeiou].*[aeiou]/)
  end

  def has_double_letter?(str) do
    String.match?(str, ~r/(.)\1/)
  end

  def has_naughty_string?(str) do
    String.match?(str, ~r/(ab)|(cd)|(pq)|(xy)/)
  end
end
