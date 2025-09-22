defmodule AoC.Day1509 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    {graph, cities} = parse_input(input)

    {:ok, dist, _} = shortest_path(graph, [:init], 0, cities, &Enum.min_by/2)
    dist
  end

  @impl true
  def solve(:part2, input) do
    {graph, cities} = parse_input(input)

    {:ok, dist, _} = shortest_path(graph, [:init], 0, cities, &Enum.max_by/2)
    dist
  end

  def shortest_path(graph, path, dist, remaining_cities, cmp) do
    if Enum.empty?(remaining_cities) do
      {:ok, dist, path}
    else
      _shortest_path(graph, path, dist, remaining_cities, cmp)
    end
  end

  def _shortest_path(graph, path, dist, remaining_cities, cmp) do
    current_city = List.first(path)

    if MapSet.member?(remaining_cities, current_city) do
      raise "Forgot to remove #{current_city} from remaining_cities"
    end

    candidates =
      for neighbor <- remaining_cities,
          {:ok, d} = edge_distance(graph, current_city, neighbor),
          {:ok, d, p} =
            shortest_path(
              graph,
              [neighbor | path],
              dist + d,
              MapSet.delete(remaining_cities, neighbor),
              cmp
            ) do
        {:ok, d, p}
      end

    cmp.(candidates, fn {_, dist, _} -> dist end)
  end

  def edge_distance(graph, src, dst) do
    case Enum.find_value(graph, fn e ->
           (e.cities == {src, dst} || e.cities == {dst, src}) && e.dist
         end) do
      nil ->
        {:error, "edge not found"}

      dist ->
        {:ok, dist}
    end
  end

  def parse_line(line) do
    %{"src" => src, "dst" => dst, "dist" => dist} =
      Regex.named_captures(
        ~r/^(?<src>[a-zA-Z]+) to (?<dst>[a-zA-Z]+) = (?<dist>[0-9]+)/,
        line
      )

    dist = String.to_integer(dist)
    %{cities: {src, dst}, dist: dist}
  end

  def parse_input(input) do
    graph = input |> Enum.map(&parse_line/1)

    cities = graph |> Enum.flat_map(fn x -> Tuple.to_list(x.cities) end) |> MapSet.new()

    # add a starting point to the graph
    graph = graph ++ Enum.map(cities, fn city -> %{cities: {:init, city}, dist: 0} end)
    {graph, cities}
  end
end
