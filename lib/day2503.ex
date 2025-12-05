defmodule AoC.Day2503 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    input |> Enum.map(&largest_jolt/1) |> Enum.sum()
  end

  @impl true
  def solve(:part2, input) do
    input
    |> Enum.map(&parse_bank/1)
    |> Enum.map(&really_largest_jolt/1)
    |> Enum.sum()
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

  def really_largest_jolt(b) do
    really_largest_jolt(b, 12, 0)
    # |> tap(&IO.puts(:stderr, "#{Enum.join(b)} -> #{&1}"))
  end

  def really_largest_jolt(bank, num_cells, acc) when num_cells > length(bank) do
    raise "Not enough cells left: #{inspect(bank)}, #{num_cells}, #{acc}"
  end

  def really_largest_jolt(_, 0, acc) do
    acc
  end

  def really_largest_jolt(bank, num_cells, acc) when num_cells == length(bank) do
    [n | rest] = bank
    really_largest_jolt(rest, num_cells - 1, acc * 10 + n)
  end

  def really_largest_jolt(bank, num_cells, acc) do
    # IO.puts(:stderr, "  #{acc} #{Enum.join(bank)}, #{num_cells}")
    head = Enum.slice(bank, 0, length(bank) - num_cells + 1)
    max = Enum.max(head)
    idx = Enum.find_index(head, fn x -> x == max end)

    really_largest_jolt(Enum.slice(bank, idx + 1, 9999), num_cells - 1, acc * 10 + max)
  end
end
