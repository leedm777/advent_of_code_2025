defmodule AoC.Day2511 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    cabling =
      input
      |> Enum.map(&parse_line/1)
      |> Map.new()
      |> Map.put("out", ["out"])

    count_paths(cabling, ["you"])
  end

  @impl true
  def solve(:part2, input) do
    cabling =
      input
      |> Enum.map(&parse_line/1)
      |> Map.new()
      |> Map.put("out", ["out"])

    # IO.puts(:stderr, inspect(cabling))
    count_dac_paths(cabling, [{"svr", false, false}])
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

  def count_dac_paths(cabling, locs) do
    if Enum.all?(locs, &(elem(&1, 0) == "out")) do
      length(locs)
    else
      next_locs =
        Enum.flat_map(locs, fn {loc, found_dac, found_fft} ->
          # IO.puts(:stderr, "#{loc} -> #{inspect(Map.get(cabling, loc))}")

          Map.get(cabling, loc)
          |> Enum.map(fn next_loc ->
            {next_loc, found_dac || loc == "dac", found_fft || loc == "fft"}
          end)
        end)
        |> Enum.reject(fn {loc, found_dac, found_fft} ->
          loc == "out" && (!found_dac || !found_fft)
        end)

      count_dac_paths(cabling, next_locs)
    end
  end
end
