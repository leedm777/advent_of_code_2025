defmodule AoC.Day1517 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    solve(:part1, input, 150)
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def solve(:part1, input, amount) do
    containers = input |> lines() |> Enum.map(&String.to_integer/1)
    count_combinations(amount, containers)
  end

  def count_combinations(0, _) do
    1
  end

  def count_combinations(_, []) do
    0
  end

  def count_combinations(amount, [next | rem]) when amount >= next do
    count_combinations(amount - next, rem) + count_combinations(amount, rem)
  end

  def count_combinations(amount, [next | rem]) when amount < next do
    count_combinations(amount, rem)
  end
end
