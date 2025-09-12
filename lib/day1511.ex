defmodule AoC.Day1511 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    password = String.trim(input)

    next_password(password)
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def has_ascending_letters?(str) do
    {_, cnt} =
      Enum.reduce_while(to_charlist(str), {-1, 1}, fn ch, {prior_ch, cnt} ->
        case {ch - 1, cnt} do
          {^prior_ch, 2} -> {:halt, {ch, 3}}
          {^prior_ch, _} -> {:cont, {ch, cnt + 1}}
          {_, _} -> {:cont, {ch, 1}}
        end
      end)

    cnt == 3
  end

  def has_invalid_letter?(str) do
    String.match?(str, ~r/[iol]/)
  end

  def has_enough_pairs?(str) do
    unique_pairs =
      Regex.scan(~r/([a-z])\1/, str)
      |> Enum.map(&List.first/1)
      |> MapSet.new()

    MapSet.size(unique_pairs) >= 2
  end

  def increment_password("") do
    "a"
  end

  def increment_password(str) do
    {prefix, [last_letter]} = str |> String.graphemes() |> Enum.split(-1)

    if last_letter == "z" do
      increment_password(Enum.join(prefix)) <> "a"
    else
      last_char = (last_letter |> String.to_charlist() |> List.first()) + 1
      # optimize; go ahead and skip character we know are invalid
      if last_char == ?i || last_char == ?o || last_char == ?l do
        Enum.join(prefix) <> <<last_char + 1>>
      else
        Enum.join(prefix) <> <<last_char>>
      end
    end
  end

  def next_password(str) do
    next = increment_password(str)
    if !has_invalid_letter?(next) && has_ascending_letters?(next) && has_enough_pairs?(next) do
      next
    else
      next_password(next)
    end
  end
end
