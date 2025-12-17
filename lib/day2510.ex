defmodule AoC.Day2510 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.map(&solve_buttons/1)
    |> Enum.map(&length/1)
    |> Enum.sum()
  end

  @impl true
  def solve(:part2, input) do
    input
    |> Enum.map(&parse_line_joltage/1)
    |> Enum.map(&solve_joltage/1)
    |> Enum.map(&length/1)
    |> Enum.sum()
  end

  def parse_line(line) do
    [indicators | rest] = String.split(line)
    {_, buttons} = List.pop_at(rest, -1)
    {parse_indicator(indicators), Enum.map(buttons, &parse_button/1)}
  end

  def parse_indicator(str) do
    String.graphemes(str)
    |> Enum.reverse()
    |> Enum.reduce(0, fn ch, acc ->
      case ch do
        "#" -> acc * 2 + 1
        "." -> acc * 2
        _ -> acc
      end
    end)
  end

  def parse_button(str) do
    toggles_str = String.slice(str, 1, String.length(str) - 2)

    toggles_str
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(0, fn bit, acc -> Bitwise.bor(acc, Bitwise.bsl(1, bit)) end)
  end

  def solve_buttons({wanted_indicators, toggles}) do
    solve_buttons(wanted_indicators, [{toggles, 0, []}])
  end

  def solve_buttons(wanted_indicators, [{_, current_indicators, toggled} | _])
      when wanted_indicators == current_indicators do
    toggled
  end

  def solve_buttons(wanted_indicators, [{toggles, current_indicators, toggled} | queue]) do
    q2 = flip_one_of_each(toggles, current_indicators, toggled)
    solve_buttons(wanted_indicators, queue ++ q2)
  end

  def flip_one_of_each([], _, _) do
    []
  end

  def flip_one_of_each([next_toggle | toggles], current_indicators, toggled) do
    [
      {toggles, Bitwise.bxor(current_indicators, next_toggle), [next_toggle | toggled]}
      | flip_one_of_each(toggles, current_indicators, toggled)
    ]
  end

  def parse_line_joltage(line) do
    [_ | rest] = String.split(line)
    {joltage, buttons} = List.pop_at(rest, -1)
    {parse_joltage(joltage), Enum.map(buttons, &parse_joltage/1)}
  end

  def parse_joltage(str) do
    toggles_str = String.slice(str, 1, String.length(str) - 2)

    toggles_str
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def solve_joltage({wanted_joltage, buttons}) do
    IO.puts(:stderr, inspect(buttons) <> " => " <> inspect(wanted_joltage))

    matrix =
      wanted_joltage
      |> Enum.with_index()
      |> Enum.map(fn {j, idx} ->
        Enum.map(buttons, fn b -> if Enum.member?(b, idx), do: 1, else: 0 end) ++ [j]
      end)

    Enum.map(matrix, fn row -> IO.puts(:stderr, inspect(row, charlists: :as_lists)) end)

    # Enum.reduce(Enum.with_index(buttons) |> Enum.reverse(), fns, fn {button, idx}, fns ->
    #   letter = <<idx + ?a>>

    #   Enum.map(Enum.with_index(fns), fn {fnx, fn_idx} ->
    #     if Enum.member?(button, fn_idx) do
    #       [letter | fnx]
    #     else
    #       fnx
    #     end
    #   end)
    # end)
    # |> tap(&IO.puts(:stderr, inspect(wanted_joltage) <> " -> " <> inspect(&1)))
  end
end
