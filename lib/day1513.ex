defmodule AoC.Day1513 do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, input) do
    rules = lines(input) |> Enum.map(&parse_line/1)
    people = rules |> Enum.map(& &1.who) |> Enum.uniq()
    tables = circular_permutations(people)

    tables |> Enum.map(&score_happiness(&1, rules)) |> Enum.max()
  end

  @impl true
  def solve(:part2, input) do
    rules = lines(input) |> Enum.map(&parse_line/1)
    people = rules |> Enum.map(& &1.who) |> Enum.uniq()
    people = [:me | people]
    tables = circular_permutations(people)

    tables |> Enum.map(&score_happiness(&1, rules)) |> Enum.max()
  end

  def parse_line(line) do
    m =
      Regex.named_captures(
        ~r/^(?<who>[A-Za-z]+) would (?<gl>gain|lose) (?<units>[0-9]+) happiness units by sitting next to (?<neighbor>[A-Za-z]+).$/,
        line
      )

    units =
      if m["gl"] == "gain" do
        String.to_integer(m["units"])
      else
        -String.to_integer(m["units"])
      end

    %{who: m["who"], neighbor: m["neighbor"], units: units}
  end

  def score_happiness(table, rules) do
    rot = tl(table) ++ [hd(table)]
    pairs = Enum.zip(table, rot)

    for {a, b} <- pairs,
        a != :me && b != :me,
        r1 = Enum.find(rules, &(&1.who == a && &1.neighbor == b)),
        r2 = Enum.find(rules, &(&1.who == b && &1.neighbor == a)),
        reduce: 0 do
      acc -> acc + r1.units + r2.units
    end
  end
end
