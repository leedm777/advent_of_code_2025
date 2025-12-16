defmodule AoC.Day2510 do
  @behaviour AoC.Solution
  import AoC.Solution

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
    |> Enum.map(&count_button_pushes/1)
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
    start = Enum.map(wanted_joltage, fn _ -> 0 end)

    # IO.puts(:stderr, inspect(wanted_joltage, charlists: :as_lists))

    find_path(
      start,
      # is_goal
      fn j -> j == wanted_joltage end,
      # get_neighbors
      fn j ->
        buttons
        |> Enum.map(&press_button(&1, j, wanted_joltage))
        |> Enum.filter(&(elem(&1, 0) > 0 && is_valid(wanted_joltage, elem(&1, 1))))
      end,
      # h
      fn joltage ->
        Enum.zip(wanted_joltage, joltage)
        |> Enum.reduce(0, fn {w, j}, acc ->
          acc + (w - j)
        end)
      end
    )

    # |> tap(&IO.puts("  " <> inspect(&1, charlists: :as_lists)))
  end

  def press_button(button, joltage, wanted_joltage) do
    num_presses =
      Enum.zip([joltage, wanted_joltage, 0..1000])
      |> Enum.reduce(:infinity, fn {j, w, idx}, acc ->
        if j < w && Enum.member?(button, idx) do
          min(acc, w - j)
        else
          acc
        end
      end)

    if num_presses == :infinity do
      {0, joltage}
    else
      {num_presses,
       Enum.reduce(button, joltage, fn idx, next_joltage ->
         List.update_at(next_joltage, idx, &(&1 + num_presses))
       end)}
    end
  end

  def is_valid(wanted_joltage, joltage) do
    Enum.zip(wanted_joltage, joltage) |> Enum.all?(fn {w, j} -> w >= j end)
  end

  def count_button_pushes([]) do
    0
  end

  def count_button_pushes([j1]) do
    j1
    |> Enum.drop_while(fn x -> x == 0 end)
    |> Enum.take(1)
    |> Enum.sum()
  end

  def count_button_pushes([j1 | rest]) do
    [j2 | _] = rest

    j1_pushes =
      Enum.zip([j1, j2])
      |> Enum.reduce_while(0, fn {x1, x2}, _ ->
        if x1 == x2 do
          {:cont, 0}
        else
          {:halt, x1 - x2}
        end
      end)

    j1_pushes + count_button_pushes(rest)
  end
end
