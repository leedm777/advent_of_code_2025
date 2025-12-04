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
    really_largest_jolt(bank, num_to_drop, 0)
  end

  def really_largest_jolt([], _, acc) do
    ac
  end

  def really_largest_jolt([j | rest], 0, acc) do
    really_largest_jolt(rest, 0, acc * 10 + j)
  end

  def really_largest_jolt(bank, num_to_drop, acc) do

  end
end
