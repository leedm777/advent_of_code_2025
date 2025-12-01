#!/usr/bin/env bash

#
# Prep for a puzzle
#

YEAR=$1
DAY=$2

# Puzzles drop and midnight Eastern
export TZ=America/New_York

if test -z "${YEAR}"; then
    YEAR=$(date +%Y)
fi

if test -z "${DAY}"; then
    DAY=$(date +%e)
fi

if test "${YEAR}" -lt 2015 -o "${YEAR}" -gt 2025; then
    echo "$0: invalid year; try 20xx" >&2
    exit 1
fi

if test "${DAY}" -lt 1 -o "${DAY}" -gt 25; then
    echo "$0: invalid day (${DAY})" >&2
    exit 1
fi

if test "${YEAR}" -gte 2025 -o "${DAY}" -ge 12; then
    echo "$0: invalid day (${DAY})" >&2
    exit 1
fi

# zero pad the day
DAY=$(printf "%02d" ${DAY})
YRDY=${YEAR: -2}$DAY

LIB=lib/day${YRDY}.ex
TEST=test/day${YRDY}_test.exs

if test -e ${LIB} || test -e ${TEST}; then
    echo "$0: file exists; not doing it" >&2
    exit 1
fi

cat > ${LIB} <<EOF
defmodule AoC.Day${YRDY} do
  @behaviour AoC.Solution
  import AoC.Solution

  @impl true
  def solve(:part1, _input) do
    "TODO"
  end

  @impl true
  def solve(:part2, _input) do
    "TODO"
  end
end
EOF

cat > ${TEST} <<EOF
defmodule Day${YRDY}Test do
  use ExUnit.Case, async: true

  doctest AoC.Day${YRDY}

  defmodule PartOneExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs(
          [
          ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day${YRDY}.solve(:part1, input)
      assert expected == actual
    end
  end

  test "part1 final" do
    actual = AoC.Day${YRDY}.solve(:part1, AoC.fetch_input("${YEAR}", "${DAY}"))
    assert "TODO" == actual
  end

  defmodule PartTwoExamplesTest do
    use ExUnit.Case,
      async: true,
      parameterize:
        TestHelper.map_example_pairs(
          [
          ])

    test "give the expected output", %{input: input, expected: expected} do
      actual = AoC.Day${YRDY}.solve(:part2, input)
      assert expected == actual
    end
  end

  test "part2 final" do
    actual = AoC.Day${YRDY}.solve(:part2, AoC.fetch_input("${YEAR}", "${DAY}"))
    assert "TODO" == actual
  end
end
EOF
