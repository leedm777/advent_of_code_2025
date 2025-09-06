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
end

defmodule TestHelperTest do
  use ExUnit.Case, async: true
  use ExUnit.Parameterized

  test_with_params "describe_examples", fn input, expected ->
    actual = TestHelper.describe_examples(input)
    assert expected == actual
  end do
    [
      simple: {[{"i", "e"}], [{:"i -> e", {"i", "e"}}]},
      long: {[{"ThisGetsTruncated", "e"}], [{:"ThisG... -> e", {"ThisGetsTruncated", "e"}}]},
      multiple:
        {[
           {"i1", "e1"},
           {"i2", "e2"},
           {"i3", "e3"}
         ],
         [
           "i1 -> e1": {"i1", "e1"},
           "i2 -> e2": {"i2", "e2"},
           "i3 -> e3": {"i3", "e3"}
         ]}
    ]
  end
end
