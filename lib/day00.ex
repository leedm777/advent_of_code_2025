defmodule AoC.Day00 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    input
    |> String.graphemes()
    |> Enum.reduce(
      0,
      fn
        "(", floor -> floor + 1
        ")", floor -> floor - 1
        _, floor -> floor
      end
    )
  end

  @impl true
  def solve(:part2, input) do
    input
    |> String.graphemes()
    |> Enum.reduce_while(
      {0, 0},
      fn
        _, {-1, idx} -> {:halt, {-1, idx}}
        "(", {floor, idx} -> {:cont, {floor + 1, idx + 1}}
        ")", {floor, idx} -> {:cont, {floor - 1, idx + 1}}
        _, {floor, idx} -> {:cont, {floor, idx + 1}}
      end
    )
    |> elem(1)
  end
end
