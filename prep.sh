#!/usr/bin/env bash

#
# Prep for a puzzle
#

YEAR=$1
DAY=$2

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
  use ExUnit.Parameterized

  doctest AoC.Day${YRDY}

  test_with_params "part1 examples", fn input, expected ->
    actual = AoC.Day${YRDY}.solve(:part1, input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
    ])
  end

  test "part1 final" do
    actual = AoC.Day${YRDY}.solve(:part1, AoC.fetch_input("${YEAR}", "${DAY}"))
    assert "TODO" == actual
  end

  test_with_params "part2 examples", fn input, expected ->
    actual = AoC.Day${YRDY}.solve(:part2, input)
    assert expected == actual
  end do
    TestHelper.describe_examples([
    ])
  end

  test "part2 final" do
    actual = AoC.Day${YRDY}.solve(:part2, AoC.fetch_input("${YEAR}", "${DAY}"))
    assert "TODO" == actual
  end
end
EOF
