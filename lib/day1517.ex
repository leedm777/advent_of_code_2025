defmodule AoC.Day1517 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    solve(:part1, input, 150)
  end

  @impl true
  def solve(:part2, input) do
    solve(:part2, input, 150)
  end

  def solve(:part1, input, amount) do
    containers = input |> lines() |> Enum.map(&String.to_integer/1)
    count_combinations(amount, containers)
  end

  def solve(:part2, input, amount) do
    containers = input |> lines() |> Enum.map(&String.to_integer/1)
    combinations = find_combinations(amount, containers, [])
    smallest_combinations = combinations |> Enum.map(&length(&1)) |> Enum.min()
    Enum.count(combinations, fn c -> length(c) == smallest_combinations end)
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

  def find_combinations(0, _, acc) do
    [acc]
  end

  def find_combinations(_, [], _) do
    []
  end

  def find_combinations(amount, [next | rem], acc) when amount >= next do
    find_combinations(amount - next, rem, [next | acc]) ++ find_combinations(amount, rem, acc)
  end

  def find_combinations(amount, [next | rem], acc) when amount < next do
    find_combinations(amount, rem, acc)
  end
end
