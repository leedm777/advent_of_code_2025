defmodule AoC.Day2509 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    red_tiles = input |> Enum.map(&parse_line/1) |> Enum.with_index()

    for tile1 <- red_tiles,
        tile2 <- red_tiles,
        elem(tile1, 1) < elem(tile2, 1),
        reduce: 0 do
      max_area ->
        {x1, y1} = elem(tile1, 0)
        {x2, y2} = elem(tile2, 0)
        area = (abs(x1 - x2) + 1) * (abs(y1 - y2) + 1)
        max(area, max_area)
    end
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def parse_line(line) do
    [x, y] = String.split(line, ",")
    {String.to_integer(x), String.to_integer(y)}
  end
end
