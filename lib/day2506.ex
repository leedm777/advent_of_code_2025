defmodule AoC.Day2506 do
  @behaviour AoC.Solution

  @impl true
  def solve(:part1, input) do
    [ops_line | args_lines] = Enum.reverse(input)
    ops = String.split(ops_line)
    args = args_lines |> Enum.map(&parse_line/1)

    Enum.zip_with([ops | args], fn [op | args] ->
      case op do
        "*" -> Enum.product(args)
        "+" -> Enum.sum(args)
      end
    end)
    |> Enum.sum()

    # |> tap(&IO.puts(:stderr, inspect(&1)))
  end

  @impl true
  def solve(:part2, input) do
    # things are a bit easier if the ops line is first
    [ops_line | args_lines] = Enum.reverse(input)
    better_input = [ops_line | Enum.reverse(args_lines)]

    better_input
    # add several spaces to we handle the last term, and fix the trimming we do in the original
    # processing
    |> Enum.map(fn line -> line <> "    " end)
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip_with(&Function.identity/1)
    |> Enum.reduce({0, 0, " "}, fn [op | val_chars], {grand_total, problem_acc, last_op} ->
      val_str = val_chars |> Enum.join() |> String.trim()

      cond do
        # blank columns between problems
        val_str == "" ->
          {grand_total + problem_acc, 0, " "}

        # the operator is in the first column of the problem
        op != " " && last_op == " " && problem_acc == 0 ->
          val = val_str |> String.to_integer()
          {grand_total, val, op}

        # accumulate a multiplication answer
        last_op == "*" ->
          val = val_str |> String.to_integer()
          {grand_total, val * problem_acc, last_op}

        # accumulate an addition answer
        last_op == "+" ->
          val = val_str |> String.to_integer()
          {grand_total, val + problem_acc, last_op}

        true ->
          raise("Should not get here :-/")
      end
    end)
    |> elem(0)
  end

  def parse_line(line) do
    String.split(line) |> Enum.map(&String.to_integer/1)
  end
end
