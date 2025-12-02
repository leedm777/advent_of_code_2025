defmodule AoC.Day2502 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, [input]) do
    rangesStr = String.split(input, ",")
    ranges = Enum.map(rangesStr, &parse_range/1)
    for r <- ranges, i <- r, s = "#{i}", Regex.match?(~r/^([0-9]+)\1$/, s), reduce: 0 do
      acc -> acc + i
    end
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def parse_range(str) do
    [lhs, rhs] = String.split(str, "-") |> Enum.map(&String.to_integer/1)
    lhs..rhs
  end
end
