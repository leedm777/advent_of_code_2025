defmodule AoC.Day2503 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    input |> Enum.map(&largest_jolt/1) |> Enum.sum()
  end

  @impl true
  def solve(:part2, input) do
    input |> Enum.map(&parse_bank/1) |> Enum.map(&really_largest_jolt/1) |> Enum.sum()
  end

  def largest_jolt(bank) do
    {a, b} =
      for <<byte <- bank>>,
          joltage = byte - ?0,
          reduce: {0, 0} do
        acc ->
          case acc do
            {first, second} when second > first -> {second, joltage}
            {first, second} when joltage >= second -> {first, joltage}
            x -> x
          end
      end

    x = a * 10 + b
    # IO.puts(:stderr, "#{bank} -> #{x}")
    x
  end

  def parse_bank(str) do
    for ch <- :binary.bin_to_list(str), do: ch - ?0
  end

  def really_largest_jolt(bank) do
    num_to_drop = length(bank) - 12
    max_joltage(bank, num_to_drop, 0)
  end

  def max_joltage([], 0, acc) do
    acc
  end

  def max_joltage([n | rest], 0, acc) do
    max_joltage(rest, 0, acc * 10 + n)
  end

  def max_joltage([m, n | rest], num_to_drop, acc) when n >= m do
    # next number is larger, and we have more to drop. Drop it
    max_joltage([n | rest], num_to_drop - 1, acc)
  end

  def max_joltage(bank, num_to_drop, acc) do
    if num_to_drop >= length(bank) do
      acc
    else
      [m | rest] = bank
      max_joltage(rest, num_to_drop, acc * 10 + m)
    end
  end
end
