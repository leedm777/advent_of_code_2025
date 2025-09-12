defmodule AoC.Day1511 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, _input) do
    "TODO"
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

    IO.puts("#{str}, #{cnt}")
    cnt == 3
  end

  def has_invalid_letter?(str) do
    String.match?(str, ~r/[iol]/)
  end
end
