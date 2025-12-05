defmodule AoC.Day2503 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    input |> Enum.map(&largest_jolt/1) |> Enum.sum()
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def largest_jolt(bank) do
    {a, b} = for <<byte <- bank>>,
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
end
