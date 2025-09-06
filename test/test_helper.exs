ExUnit.configure(exclude: :slow_as_christmas)
ExUnit.start()

defmodule TestHelper do
  @moduledoc """
  Helper functions for writing tests.
  """

  @doc """
  Add descriptions to a list of parameterized examples.

  ## Examples

      iex> TestHelper.describe_examples([{"in", "expected"}])
      ["in -> expected": {"in", "expected"}]
  """
  def describe_examples(examples) do
    for {i, e} <- examples do
      if String.length(i) <= 5 do
        {:"#{i} -> #{e}", {i, e}}
      else
        {:"#{String.slice(i, 0, 5)}... -> #{e}", {i, e}}
      end
    end
  end

  @doc """
  Expands list of 2-tuples into list of maps for use with parameterized tests.

  ## Examples

      iex> TestHelper.map_example_pairs([{1, "one"}, {2, "two"}])
      [{input: 1, expected: "one"}, {input: 2, expected: "two"}]

      iex> TestHelper.map_example_pairs([{1, "one"}, {2, "two"}], :num, :word)
      [{num: 1, word: "one"}, {num: 2, word: "two"}]
  """
  def map_example_pairs(examples, lhs \\ :input, rhs \\ :expected) do
    for {i, e} <- examples do
      %{lhs => i, rhs => e}
    end
  end
end

defmodule TestHelperTest do
  use ExUnit.Case, async: true

  describe "map_example_pairs" do
    test "should map list of tuples to maps of input/expected" do
      actual = TestHelper.map_example_pairs([{1, "one"}, {2, "two"}])
      assert actual == [%{input: 1, expected: "one"}, %{input: 2, expected: "two"}]
    end

    test "should use custom keys if given" do
      actual = TestHelper.map_example_pairs([{1, "one"}, {2, "two"}], :num, :word)
      assert actual == [%{num: 1, word: "one"}, %{num: 2, word: "two"}]
    end
  end
end
