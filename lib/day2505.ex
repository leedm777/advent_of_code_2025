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
  def solve(:part2, input) do
    fresh_str = Enum.take_while(input, fn line -> line != "" end)

    fresh =
      Enum.map(fresh_str, fn s ->
        [first, last] = String.split(s, "-")
        {String.to_integer(first), String.to_integer(last)}
      end)
      |> Enum.sort_by(&elem(&1, 0))

    {c, {f, l}} =
      for {first, last} <- fresh,
          reduce: {0, {0, -1}} do
        {cnt, {prior_first, prior_last}} ->
          # IO.puts(:stderr, "#{cnt} {#{prior_first}, #{prior_last}}: {#{first}, #{last}}")

          if first <= prior_last do
            {cnt, {prior_first, max(prior_last, last)}}
          else
            {cnt + prior_last - prior_first + 1, {first, last}}
          end
      end

    c + l - f + 1
  end
end
