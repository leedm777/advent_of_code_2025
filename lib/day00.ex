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
        "(", acc -> acc + 1
        ")", acc -> acc - 1
        _, acc -> acc
      end
    )
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end
end
