defmodule AoC.Day1507 do
  @behaviour AoC.Solution
  import AoC.Solution

  import Bitwise

  @impl true
  def solve(:part1, input) do
    solve(:part1, input, "a")
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end

  def solve(:part1, input, wire) do
    circuit =
      for gate <- input |> lines |> Enum.map(&parse_line/1), into: %{} do
        {gate.output, gate}
      end

    eval(circuit, wire)
  end

  def eval(_, val) when is_integer(val) do
    val
  end

  def eval(circuit, wire) do
    gate = circuit[wire]

    case gate.op do
      "in" ->
        eval(circuit, gate.input)

      "AND" ->
        lhs = eval(circuit, gate.lhs)
        rhs = eval(circuit, gate.rhs)
        lhs &&& rhs

      "OR" ->
        lhs = eval(circuit, gate.lhs)
        rhs = eval(circuit, gate.rhs)
        lhs ||| rhs

      "LSHIFT" ->
        lhs = eval(circuit, gate.lhs)
        rhs = eval(circuit, gate.rhs)
        lhs <<< rhs

      "RSHIFT" ->
        lhs = eval(circuit, gate.lhs)
        rhs = eval(circuit, gate.rhs)
        lhs >>> rhs

      "NOT" ->
        ~~~eval(circuit, gate.input) &&& 0xFFFF
    end
  end

  def parse_line(line) when is_binary(line) do
    parse_line(String.split(line, " "))
  end

  def parse_line([input, "->", output]) do
    %{op: "in", input: parse_term(input), output: parse_term(output)}
  end

  def parse_line([lhs, op, rhs, "->", output]) do
    %{op: op, lhs: parse_term(lhs), rhs: parse_term(rhs), output: parse_term(output)}
  end

  def parse_line([op, input, "->", output]) do
    %{op: op, input: parse_term(input), output: parse_term(output)}
  end

  def parse_term(str) do
    if String.match?(str, ~r/^[0-9]+$/) do
      String.to_integer(str)
    else
      str
    end
  end
end
