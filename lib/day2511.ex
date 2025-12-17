defmodule AoC.Day2511 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    cabling = input |> Enum.map(&parse_line/1) |> Map.new() |> Map.put("out", ["out"])

    count_paths(cabling, ["you"])
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def parse_line(line) do
    [device, outputs_str] = String.split(line, ": ")
    outputs = String.split(outputs_str, " ")

    {device, outputs}
  end

  def count_paths(cabling, locs) do
    if Enum.all?(locs, &(&1 == "out")) do
      length(locs)
    else
      next_locs = Enum.flat_map(locs, fn loc -> Map.get(cabling, loc) end)

      count_paths(cabling, next_locs)
    end
  end
end
