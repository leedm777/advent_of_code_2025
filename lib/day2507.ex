defmodule AoC.Day2507 do
  @behaviour AoC.Solution

  @splitter "^"

  @impl true
  def solve(:part1, input) do
    [start_line | splitter_lines] = input
    {start_idx, 1} = :binary.match(start_line, "S")
    beams = MapSet.new([start_idx])

    Enum.reduce(splitter_lines, {0, beams}, fn line, {total_splits, current_beams} ->
      Enum.reduce(
        current_beams,
        {total_splits, MapSet.new()},
        fn idx, {total_splits, current_beams} ->
          if idx >= 0 && idx < String.length(line) && String.at(line, idx) == @splitter do
            {total_splits + 1, current_beams |> MapSet.put(idx - 1) |> MapSet.put(idx + 1)}
          else
            {total_splits, MapSet.put(current_beams, idx)}
          end
        end
      )
    end)
    |> elem(0)
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end
end
