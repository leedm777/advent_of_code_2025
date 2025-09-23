defmodule AoC.Day1519 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    {replacements, [_, molecule]} = Enum.split(input, -2)

    molecules =
      for replacement <- replacements,
          %{"from_elem" => from_elem, "to_elem" => to_elem} =
            Regex.named_captures(
              ~r/(?<from_elem>[a-zA-Z]+) => (?<to_elem>[a-zA-Z]+)/,
              replacement
            ),
          [{index, length}] <- Regex.scan(~r/#{from_elem}/, molecule, return: :index),
          into: MapSet.new([]) do
        prefix = String.slice(molecule, 0, index)
        suffix = String.slice(molecule, index + length, String.length(molecule))

        prefix <> to_elem <> suffix
      end

    MapSet.size(molecules)
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end
end
