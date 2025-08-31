defmodule AoC.Input do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(_state) do
    {:ok, nil}
  end

  @impl true
  def handle_call({:fetch, year, day}, _from, _state) do
    {:reply, fetch_input(year, day), nil}
  end

  defp fetch_input(year, day) do
    filename = "./input/input-#{year}-#{day}.txt"

    case File.read(filename) do
      {:ok, input} ->
        input

      {:error, :enoent} ->
        input = download_input(year, day)
        File.write!(filename, input)
        input

      {:error, err} ->
        raise err
    end
  end

  defp download_input(year, day) do
    case File.read("./.cookie.txt") do
      {:ok, cookie} ->
        cookie = String.trim(cookie)
        url = get_url(year, day)
        IO.puts(:stderr, "Downloading #{url}")

        case Req.get(url, headers: [{"cookie", cookie}]) do
          {:ok, res} ->
            if res.status != 200 do
              raise "Failed to fetch input (#{url}): #{res.body}"
            end

            res.body

          {:error, ex} ->
            IO.puts(:stderr, "Failed to fetch input (#{url}): #{inspect(ex)}")
            raise ex
        end

      {:error, :enoent} ->
        raise ".cookie.txt does not exist; see README.md"

      {:error, err} ->
        raise err
    end
  end

  def get_url(year, "0" <> day) do
    get_url(year, day)
  end

  def get_url(year, day) do
    "https://adventofcode.com/#{year}/day/#{day}/input"
  end
end
