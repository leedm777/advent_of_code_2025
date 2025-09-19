defmodule AoC.Day1516 do
  @behaviour AoC.Solution
  import AoC.Solution

  @mfcsam_scan %{
    "children" => 3,
    "cats" => 7,
    "samoyeds" => 2,
    "pomeranians" => 3,
    "akitas" => 0,
    "vizslas" => 0,
    "goldfish" => 5,
    "trees" => 3,
    "cars" => 2,
    "perfumes" => 1
  }

  @impl true
  def solve(:part1, input) do
    sues = input |> lines() |> Enum.map(&parse_line/1)

    {sue_num, _} =
      Enum.find(sues, fn {_, props} ->
        Enum.all?(props, fn {pname, pval} ->
          @mfcsam_scan[pname] == pval
        end)
      end)

    sue_num
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def parse_line(line) do
    m = Regex.named_captures(~r/^Sue (?<num>[0-9]+): (?<props>.*)$/, line)

    props =
      m["props"]
      |> String.split(", ")
      |> Enum.map(fn prop ->
        [n, v] = String.split(prop, ": ")
        {n, String.to_integer(v)}
      end)

    {String.to_integer(m["num"]), props}
  end
end
