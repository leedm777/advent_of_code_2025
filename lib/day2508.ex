defmodule AoC.Day2508 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    solve(:part1, input, 1000)
  end

  def solve(:part1, input, num) do
    boxes =
      input
      |> Enum.map(fn line ->
        line |> String.split(",") |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.with_index()

    distances =
      for {b1, id1} <- boxes, {b2, id2} <- boxes, id1 < id2 do
        dist =
          Enum.zip(b1, b2) |> Enum.map(fn {v1, v2} -> (v1 - v2) * (v1 - v2) end) |> Enum.sum()

        {id1, id2, dist}
      end

    shortest_distances = Enum.sort_by(distances, &elem(&1, 2)) |> Enum.take(num)

    circuits =
      input
      |> Enum.with_index()
      |> Enum.map(fn {_, idx} -> MapSet.new([idx]) end)

    circuits =
      Enum.reduce(
        shortest_distances,
        circuits,
        fn {id1, id2, _}, circuits ->
          # IO.puts(:stderr, inspect([id1, id2]))

          Enum.reduce(
            circuits,
            {false, nil, []},
            fn circuit, {found_both, first_circuit, circuits} ->
              # IO.puts(:stderr, "  " <> inspect([circuit, found_both, first_circuit, circuits]))

              cond do
                found_both ->
                  {true, nil, [circuit | circuits]}

                first_circuit != nil &&
                    (MapSet.member?(circuit, id1) || MapSet.member?(circuit, id2)) ->
                  {true, nil, [MapSet.union(first_circuit, circuit) | circuits]}

                MapSet.member?(circuit, id1) && MapSet.member?(circuit, id2) ->
                  {true, nil, [circuit | circuits]}

                MapSet.member?(circuit, id1) || MapSet.member?(circuit, id2) ->
                  {found_both, circuit, circuits}

                true ->
                  {found_both, first_circuit, [circuit | circuits]}
              end
            end
          )
          |> elem(2)
        end
      )

    # IO.puts(:stderr, inspect(circuits))
    circuits
    |> Enum.map(&MapSet.size/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end
end
