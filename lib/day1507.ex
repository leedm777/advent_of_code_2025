defmodule AoC.Day1507 do
  @behaviour AoC.Solution
  import AoC.Solution

  import Bitwise

  @impl true
  def solve(:part1, input) do
    solve(:part1, input, "a")
  end

  @impl true
  def solve(:part2, input) do
    circuit = parse_input(input)

    {:ok, agent} = Agent.start_link(fn -> {circuit, %{}} end)
    signal = eval(agent, "a")
    Agent.stop(agent)

    circuit = Map.put(circuit, "b", %{op: "in", input: signal, output: "b"})
    {:ok, agent} = Agent.start_link(fn -> {circuit, %{}} end)
    res = eval(agent, "a")
    Agent.stop(agent)
    res
  end

  def solve(:part1, input, wire) do
    circuit = parse_input(input)

    {:ok, agent} = Agent.start_link(fn -> {circuit, %{}} end)
    res = eval(agent, wire)
    Agent.stop(agent)
    res
  end

  def parse_input(input) do
    for gate <- input |> lines |> Enum.map(&parse_line/1), into: %{} do
      {gate.output, gate}
    end
  end

  def eval(agent, wire) do
    case Agent.get(agent, fn {_, memo} -> memo[wire] end) do
      nil ->
        val = _eval(agent, wire)
        Agent.update(agent, fn {circuit, memo} -> {circuit, Map.put(memo, wire, val)} end)
        val

      val ->
        val
    end
  end

  def _eval(_, val) when is_integer(val) do
    val
  end

  def _eval(agent, wire) do
    gate = Agent.get(agent, fn {circuit, _} -> circuit[wire] end)

    case gate.op do
      "in" ->
        eval(agent, gate.input)

      "AND" ->
        lhs = eval(agent, gate.lhs)
        rhs = eval(agent, gate.rhs)
        lhs &&& rhs

      "OR" ->
        lhs = eval(agent, gate.lhs)
        rhs = eval(agent, gate.rhs)
        lhs ||| rhs

      "LSHIFT" ->
        lhs = eval(agent, gate.lhs)
        rhs = eval(agent, gate.rhs)
        lhs <<< rhs

      "RSHIFT" ->
        lhs = eval(agent, gate.lhs)
        rhs = eval(agent, gate.rhs)
        lhs >>> rhs

      "NOT" ->
        ~~~eval(agent, gate.input) &&& 0xFFFF
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
