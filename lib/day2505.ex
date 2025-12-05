defmodule AoC.Day2505 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    {fresh_str, [_ | avail_str]} = Enum.split_while(input, fn line -> line != "" end)

    fresh =
      Enum.map(fresh_str, fn s ->
        [first, last] = String.split(s, "-")
        String.to_integer(first)..String.to_integer(last)
      end)

    avail = Enum.map(avail_str, &String.to_integer/1)

    Enum.count(avail, fn id -> Enum.any?(fresh, fn r -> Enum.member?(r, id) end) end)
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end
end
