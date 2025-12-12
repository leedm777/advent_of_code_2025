defmodule AoC.Day2509 do
  @behaviour AoC.Solution

  @blank %{top: false, right: false, bottom: false, left: false}

  @impl true
  def solve(:part1, input) do
    red_tiles = input |> Enum.map(&parse_line/1) |> Enum.with_index()

    for tile1 <- red_tiles,
        tile2 <- red_tiles,
        elem(tile1, 1) < elem(tile2, 1),
        reduce: 0 do
      max_area ->
        {x1, y1} = elem(tile1, 0)
        {x2, y2} = elem(tile2, 0)
        area = (abs(x1 - x2) + 1) * (abs(y1 - y2) + 1)
        max(area, max_area)
    end
  end

  @impl true
  def solve(:part2, input) do
    red_tiles = Enum.map(input, &parse_line/1)
    min_x = red_tiles |> Enum.map(&elem(&1, 0)) |> Enum.min()
    # max_x = red_tiles |> Enum.map(&elem(&1, 0)) |> Enum.max()
    min_y = red_tiles |> Enum.map(&elem(&1, 1)) |> Enum.min()
    # max_y = red_tiles |> Enum.map(&elem(&1, 1)) |> Enum.max()
    edges = Enum.zip(red_tiles, rotate(red_tiles))

    border =
      for {{x1, y1}, {x2, y2}} <- edges, reduce: Map.new() do
        border ->
          # print_border(border, {min_x, min_y}, {max_x, max_y})
          # IO.puts(inspect({{x1, y1}, {x2, y2}}))

          cond do
            x1 == x2 ->
              # up or down
              top_y = min(y1, y2)
              bot_y = max(y1, y2)

              border
              |> Map.update({x1, top_y}, %{@blank | bottom: true}, fn v -> %{v | bottom: true} end)
              |> Map.update({x1, bot_y}, %{@blank | top: true}, fn v -> %{v | top: true} end)
              |> Map.merge(
                (top_y + 1)..(bot_y - 1)
                |> Enum.map(&{x1, &1})
                |> Map.new(fn pos -> {pos, %{@blank | top: true, bottom: true}} end)
              )

            y1 == y2 ->
              # left or right
              left_x = min(x1, x2)
              rght_x = max(x1, x2)

              border
              |> Map.update({left_x, y1}, %{@blank | right: true}, fn v -> %{v | right: true} end)
              |> Map.update({rght_x, y1}, %{@blank | left: true}, fn v -> %{v | left: true} end)
              |> Map.merge(
                (left_x + 1)..(rght_x - 1)
                |> Enum.map(&{&1, y1})
                |> Map.new(fn pos -> {pos, %{@blank | left: true, right: true}} end)
              )
          end
      end

    # print_border(border, {min_x, min_y}, {max_x, max_y})

    areas =
      for {tile1, idx1} <- Enum.with_index(red_tiles),
          {tile2, idx2} <- Enum.with_index(red_tiles),
          idx1 < idx2 do
        {x1, y1} = tile1
        {x2, y2} = tile2
        {(abs(x1 - x2) + 1) * (abs(y1 - y2) + 1), tile1, tile2}
      end
      |> Enum.sort_by(&elem(&1, 0), :desc)

    {largest, _, _} =
      Enum.find(areas, fn {_, t1, t2} ->
        graph_contains(border, t1, t2, {min_x, min_y})
      end)

    largest
  end

  def parse_line(line) do
    [x, y] = String.split(line, ",")
    {String.to_integer(x), String.to_integer(y)}
  end

  def rotate(lst) do
    [head | tail] = lst
    tail ++ [head]
  end

  def graph_contains(edges, tile1, tile2, {min_x, min_y}) do
    x1 = min(elem(tile1, 0), elem(tile2, 0))
    x2 = max(elem(tile1, 0), elem(tile2, 0))
    y1 = min(elem(tile1, 1), elem(tile2, 1))
    y2 = max(elem(tile1, 1), elem(tile2, 1))

    # IO.puts(inspect({tile1, tile2}))

    # confirm the entire perimeter is contained
    Enum.reduce_while(min_x..x2, {false, false}, fn x, {top, bottom} ->
      t = Map.get(edges, {x, y1}, @blank)
      next_top = top != t[:top]
      next_bottom = bottom != t[:bottom]
      inside = top || bottom || t[:top] || t[:bottom]

      if x < x1 || inside do
        {:cont, {next_top, next_bottom}}
      else
        # IO.puts("  #{inspect({x, y1})}")
        {:halt, false}
      end
    end) &&
      Enum.reduce_while(min_x..x2, {false, false}, fn x, {top, bottom} ->
        t = Map.get(edges, {x, y2}, @blank)
        next_top = top != t[:top]
        next_bottom = bottom != t[:bottom]
        inside = top || bottom || t[:top] || t[:bottom]

        if x < x1 || inside do
          {:cont, {next_top, next_bottom}}
        else
          # IO.puts("  #{inspect({x, y2})}")
          {:halt, false}
        end
      end) &&
      Enum.reduce_while(min_y..y2, {false, false}, fn y, {left, right} ->
        t = Map.get(edges, {x1, y}, @blank)
        next_left = left != t[:left]
        next_right = right != t[:right]
        inside = left || right || t[:left] || t[:right]

        if y < y1 || inside do
          {:cont, {next_left, next_right}}
        else
          # IO.puts("  #{inspect({x1, y})}")
          {:halt, false}
        end
      end) &&
      Enum.reduce_while(min_y..y2, {false, false}, fn y, {left, right} ->
        t = Map.get(edges, {x2, y}, @blank)
        next_left = left != t[:left]
        next_right = right != t[:right]
        inside = left || right || t[:left] || t[:right]

        if y < y1 || inside do
          {:cont, {next_left, next_right}}
        else
          # IO.puts("  #{inspect({x2, y})}")
          {:halt, false}
        end
      end) &&
      true
  end

  def print_border(border, {min_x, min_y}, {max_x, max_y}) do
    g =
      for y <- min_y..max_y do
        for x <- min_x..max_x do
          case Map.get(border, {x, y}, @blank) do
            %{top: false, right: true, bottom: true, left: false} ->
              "╔"

            %{top: false, right: true, bottom: false, left: true} ->
              "═"

            %{top: false, right: false, bottom: true, left: true} ->
              "╗"

            %{top: true, right: false, bottom: true, left: false} ->
              "║"

            %{top: true, right: false, bottom: false, left: true} ->
              "╝"

            %{top: true, right: true, bottom: false, left: false} ->
              "╚"

            @blank ->
              "."

            %{top: true, right: false, bottom: false, left: false} ->
              "┸"

            %{top: false, right: true, bottom: false, left: false} ->
              "┝"

            %{top: false, right: false, bottom: true, left: false} ->
              "┰"

            %{top: false, right: false, bottom: false, left: true} ->
              "┥"

            x ->
              IO.puts(inspect(x))
              "▓"
          end
        end
        |> Enum.join()
      end
      |> Enum.join("\n")

    IO.puts("\n" <> g)
  end
end
