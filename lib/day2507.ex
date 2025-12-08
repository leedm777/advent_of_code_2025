defmodule AoC.Day2507 do
  @behaviour AoC.Solution

  @splitter "^"
  @start "S"

  @impl true
  def solve(:part1, input) do
    [start_line | splitter_lines] = input
    {start_idx, 1} = :binary.match(start_line, @start)
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
  def solve(:part2, input) do
    [start_line | splitter_lines] = input

    beam_ctr =
      Enum.map(String.graphemes(start_line), fn ch ->
        if ch == @start do
          1
        else
          0
        end
      end)

    Enum.reduce(splitter_lines, beam_ctr, fn line, beam_ctr ->
      next_beam_ctr = Enum.map(beam_ctr, fn _ -> 0 end)

      Enum.zip([0..999, String.graphemes(line), beam_ctr])
      |> Enum.reduce(next_beam_ctr, fn {idx, ch, num_beams}, next_beam_ctr ->
        if ch == @splitter do
          if idx == 0 do
            next_beam_ctr
            |> List.update_at(idx + 1, &(&1 + num_beams))
          else
            next_beam_ctr
            |> List.update_at(idx - 1, &(&1 + num_beams))
            |> List.update_at(idx + 1, &(&1 + num_beams))
          end
        else
          List.update_at(next_beam_ctr, idx, &(&1 + num_beams))
        end
      end)

      # |> tap(&IO.puts(:stderr, inspect(&1)))
    end)
    |> Enum.sum()
  end
end
