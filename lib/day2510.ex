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
    init_joltage = Enum.map(wanted_joltage, fn _ -> 0 end)
    solve_joltage(wanted_joltage, buttons, [{init_joltage, []}], MapSet.new())
  end

  def solve_joltage(wanted_joltage, _buttons, [{joltage, keypresses} | _queue], _visited)
      when wanted_joltage == joltage do
    keypresses
  end

  def solve_joltage(_wanted_joltage, _buttons, [], _visited) do
    nil
  end

  def solve_joltage(wanted_joltage, buttons, [{joltage, keypresses} | queue], visited) do
    # IO.puts(:stderr, inspect(%{q_length: length(queue), v_length: MapSet.size(visited)}))

    cond do
      # we've been here before; skip
      MapSet.member?(visited, joltage) ->
        # IO.puts(:stderr, "  skip revisit")
        solve_joltage(wanted_joltage, buttons, queue, visited)

      # keep searching
      true ->
        next_visited = MapSet.put(visited, joltage)

        q2 =
          Enum.map(buttons, &press_button(&1, joltage, keypresses))
          |> Enum.filter(fn {next_joltage, _} ->
            !MapSet.member?(visited, next_joltage) &&
              Enum.zip(wanted_joltage, next_joltage) |> Enum.all?(fn {w, j} -> j <= w end)
          end)

        case Enum.find(q2, fn {next_joltage, _} -> next_joltage == wanted_joltage end) do
          nil ->
            solve_joltage(wanted_joltage, buttons, queue ++ q2, next_visited)

          soln ->
            IO.puts("Skipping #{length(queue)} queue items")
            solve_joltage(wanted_joltage, buttons, [soln], next_visited)
        end
    end
  end

  def press_button(button, joltage, keypresses) do
    j =
      Enum.reduce(button, joltage, fn idx, j ->
        List.update_at(j, idx, &(&1 + 1))
      end)

    {j, [button | keypresses]}
  end
end
