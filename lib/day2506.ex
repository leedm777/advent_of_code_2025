defmodule AoC.Day2506 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    [ops_line | args_lines] = Enum.reverse(input)
    ops = String.split(ops_line)
    args = args_lines |> Enum.map(&parse_line/1)

    Enum.zip_with([ops | args], fn [op | args] ->
      case op do
        "*" -> Enum.product(args)
        "+" -> Enum.sum(args)
      end
    end)
    |> Enum.sum()

    # |> tap(&IO.puts(:stderr, inspect(&1)))
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def parse_line(line) do
    String.split(line) |> Enum.map(&String.to_integer/1)
  end
end
