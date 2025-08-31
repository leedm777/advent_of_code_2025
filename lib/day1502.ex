defmodule AoC.Day1502 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    input
    |> lines()
    |> Enum.map(&wrapping_area(&1))
    |> Enum.sum()
  end

  @impl true
  def solve(:part2, input) do
    input
    |> lines()
    |> Enum.map(&bow_length(&1))
    |> Enum.sum()
  end

  def wrapping_area(line) do
    [l, w, h] = parse_line(line)
    side1 = l * w
    side2 = w * h
    side3 = h * l
    2 * side1 + 2 * side2 + 2 * side3 + Enum.min([side1, side2, side3])
  end

  def bow_length(line) do
    [l, w, h] = parse_line(line)
    p1 = 2 * l + 2 * w
    p2 = 2 * w + 2 * h
    p3 = 2 * h + 2 * l
    volume = l * w * h
    Enum.min([p1, p2, p3]) + volume
  end

  def parse_line(line) do
    String.split(line, "x") |> Enum.map(&String.to_integer(&1))
  end
end
