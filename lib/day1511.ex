defmodule AoC.Day1511 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    password = String.trim(input)

    password |> skip_invalid_passwords() |> next_password()
  end

  @impl true
  def solve(:part2, input) do
    password = String.trim(input)

    password |> skip_invalid_passwords() |> next_password() |> next_password()
  end

  def has_ascending_letters?(str) do
    {_, cnt} =
      Enum.reduce_while(to_charlist(str), {-1, 1}, fn ch, {prior_ch, cnt} ->
        case {ch - 1, cnt} do
          {^prior_ch, 2} -> {:halt, {ch, 3}}
          {^prior_ch, _} -> {:cont, {ch, cnt + 1}}
          {_, _} -> {:cont, {ch, 1}}
        end
      end)

    cnt == 3
  end

  def has_invalid_letter?(str) do
    String.match?(str, ~r/[iol]/)
  end

  def has_enough_pairs?(str) do
    unique_pairs =
      Regex.scan(~r/([a-z])\1/, str)
      |> Enum.map(&List.first/1)
      |> MapSet.new()

    MapSet.size(unique_pairs) >= 2
  end

  def increment_password("") do
    "a"
  end

  def increment_password(str) do
    {prefix, [last_letter]} = str |> String.graphemes() |> Enum.split(-1)

    if last_letter == "z" do
      increment_password(Enum.join(prefix)) <> "a"
    else
      last_char = (last_letter |> String.to_charlist() |> List.first()) + 1
      # optimize; go ahead and skip character we know are invalid
      Enum.join(prefix) <> <<make_valid_char(last_char)>>
    end
  end

  def next_password(str) do
    next = increment_password(str)

    if !has_invalid_letter?(next) && has_ascending_letters?(next) && has_enough_pairs?(next) do
      next
    else
      next_password(next)
    end
  end

  def make_valid_char(ch) do
    if ch == ?i || ch == ?o || ch == ?l do
      ch + 1
    else
      ch
    end
  end

  def skip_invalid_passwords(str) do
    {_, valid_charlist} =
      str
      |> String.to_charlist()
      |> Enum.reduce({:search, ~c""}, fn ch, {state, acc} ->
        case {state, ch} do
          {:skip, _} ->
            {:skip, acc ++ [?a]}

          {:search, ch} ->
            valid_ch = make_valid_char(ch)

            if valid_ch == ch do
              {:search, acc ++ [ch]}
            else
              {:skip, acc ++ [valid_ch]}
            end
        end
      end)

    to_string(valid_charlist)
  end
end
