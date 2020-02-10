defmodule MatchService.MatchServer do
  use GenServer
  alias MatchService.Match

  # API

  def inspect_match(server) do
    GenServer.call(server, :inspect_match)
  end

  def start_match(server) do
    GenServer.call(server, :start_match)
  end

  def close_match(server) do
    GenServer.call(server, :close_match)
  end

  def delete_match(server) do
    GenServer.stop(server)
  end

  # GenServer impl

  def child_spec(args \\ []) do
    %{
      id: MatchService.MatchServer,
      start: {MatchService.MatchServer, :start_link, [args]},
      restart: :transient,
    }
  end

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  @impl true
  def init(_init_arg) do
    {:ok, Match.open_match()}
  end

  @impl true
  def handle_call(:inspect_match, _from, match) do
    {:reply, match, match}
  end

  @impl true
  def handle_call(:start_match, _from, match) do
    with {:ok, match} <- Match.start_match(match) do
      {:reply, :ok, match}
    else
      e = {:error, _reason} -> {:reply, e, match}
    end
  end

  @impl true
  def handle_call(:close_match, _from, match) do
    with {:ok, match} <- Match.close_match(match) do
      {:reply, :ok, match}
    else
      e = {:error, _reason} -> {:reply, e, match}
    end
  end
end
