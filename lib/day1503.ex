defmodule AoC.Day1503 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    %{visited: visited} = input
    |> String.graphemes()
    |> Enum.reduce(%{pos: {0, 0}, visited: %{{0, 0} => 1}}, fn
      dir, %{pos: p, visited: v} ->
        p = move(p, dir)
        v = Map.update(v, p, 1, &(&1 + 1))
        %{pos: p, visited: v}
    end)
    map_size(visited)
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end
end
