defmodule AoC.Day2511 do
  @behaviour AoC.Solution
  use Agent

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
    count_dac_paths(cabling, {"svr", false, false})
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

  def count_dac_paths(cabling, node) do
    {:ok, cache} = Agent.start_link(fn -> Map.new() end)

    try do
      count_dac_paths(cabling, node, cache)
    after
      Agent.stop(cache)
    end
  end

  def cache_get(cache, node) do
    Agent.get(cache, &Map.get(&1, node))
    # |> tap(&IO.puts(:stderr, "  get #{inspect(node)} = #{inspect(&1)}"))
    # |> tap(fn _ -> IO.puts(:stderr, "    " <> inspect(Agent.get(cache, & &1))) end)
  end

  def cache_put(cache, node, val) do
    # IO.puts(:stderr, "  put #{inspect(node)} = #{inspect(val)}")
    Agent.update(cache, &Map.put(&1, node, val))
  end

  def count_dac_paths(cabling, node, cache) do
    # IO.puts(:stderr, inspect(node))

    cache_get(cache, node) ||
      case node do
        {"out", true, true} ->
          1

        {"out", _, _} ->
          0

        {loc, found_dac, found_fft} ->
          Map.get(cabling, loc)
          |> Enum.sum_by(fn next_loc ->
            next_node = {next_loc, found_dac || next_loc == "dac", found_fft || next_loc == "fft"}

            count_dac_paths(cabling, next_node, cache)
          end)
      end
      |> tap(&cache_put(cache, node, &1))
  end
end
