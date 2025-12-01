defmodule AoC.Day1519 do
  @behaviour AoC.Solution
  import AoC.Solution

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
  def solve(:part2, input) do
    {replacements, [_, target]} = Enum.split(input, -2)

    replacements =
      Enum.reduce(replacements, %{}, fn replacement, acc ->
        %{"from_elem" => from_elem, "to_elem" => to_elem} =
          Regex.named_captures(
            ~r/(?<from_elem>[a-zA-Z]+) => (?<to_elem>[a-zA-Z]+)/,
            replacement
          )

        {_, update} =
          Map.get_and_update(acc, from_elem, fn
            nil -> {from_elem, [parse_molecule(to_elem)]}
            lst -> {from_elem, [parse_molecule(to_elem) | lst]}
          end)

        update
      end)

    build_molecule([{["e"], 0}], parse_molecule(target), replacements, MapSet.new([]))
  end

  def parse_molecule(molecule) do
    Regex.scan(~r/[A-Z][a-z]?/, molecule) |> Enum.map(fn [x] -> x end)
  end

  def build_molecule([], _, _, _) do
    nil
  end

  def build_molecule([{candidate, depth} | rem_candidates], target, replacements, seen) do
    IO.puts(
      "#{now_str()} #{depth}, #{length(rem_candidates)}, #{MapSet.size(seen)}, #{length(candidate)} => #{length(target)}"
    )

    # find the first mismatching element between the candidate and the target
    first_mismatch =
      Enum.zip(candidate, target) |> Enum.find(&(elem(&1, 0) !== elem(&1, 1)))

    cond do
      # if there's no mismatch, and they are the same length, we win!
      first_mismatch == nil && length(candidate) == length(target) ->
        depth

      # if there's no replacement for the candidate's mismatching element,
      # then we are at a dead end and we can drop this candidate
      length(candidate) > length(target) ||
          (first_mismatch != nil && replacements[elem(first_mismatch, 0)] == nil) ->
        build_molecule(rem_candidates, target, replacements, seen)

      # plausible candidate. append all possible replacements to rem_candidates and
      # keep trying
      true ->
        next =
          for {e, index} <- Enum.with_index(candidate),
              rep <- Map.get(replacements, e, []),
              {prefix, [_ | suffix]} = Enum.split(candidate, index),
              into: MapSet.new([]) do
            prefix ++ rep ++ suffix
          end

        next = MapSet.difference(next, seen)
        next_candidates = next |> MapSet.to_list() |> Enum.map(&{&1, depth + 1})

        build_molecule(
          rem_candidates ++ next_candidates,
          target,
          replacements,
          MapSet.union(seen, next)
        )
    end
  end

  def is_viable(candidate, target, replacements) do
    first_mismatch =
      Enum.zip(candidate, target) |> Enum.find(&(elem(&1, 0) !== elem(&1, 1)))

    # if there's no replacement for the candidate's mismatching element,
    # then we are at a dead end and we can drop this candidate
    first_mismatch == nil || replacements[elem(first_mismatch, 0)] != nil
  end
end
