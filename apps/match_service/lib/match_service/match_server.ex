defmodule MatchService.MatchServer do
  use GenServer
  alias MatchService.Match

  # API

  def inspect_match(server) do
    GenServer.call(server, :inspect_match)
  end

  def start_match(player, server) do
    GenServer.call(server, {:start_match, player})
  end

  def close_match(player, server) do
    GenServer.call(server, {:close_match, player})
  end

  def delete_match(player, server) do
    GenServer.call(server, {:delete_match, player})
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
  def init(args) do
    owner = Keyword.fetch!(args, :owner)
    {:ok, Match.create_match(owner)}
  end

  @impl true
  def handle_call(:inspect_match, _from, match) do
    {:reply, match, match}
  end

  @impl true
  def handle_call({:start_match, player}, _from, match) do
    with {:ok, _} <- require_owner(player, match),
         {:ok, match} <- Match.start_match(match)
    do
      {:reply, :ok, match}
    else
      e = {:error, _reason} -> {:reply, e, match}
    end
  end

  @impl true
  def handle_call({:close_match, player}, _from, match) do
    with {:ok, _} <- require_owner(player, match),
         {:ok, match} <- Match.close_match(match)
    do
      {:reply, :ok, match}
    else
      e = {:error, _reason} -> {:reply, e, match}
    end
  end

  @impl true
  def handle_call({:delete_match, player}, _from, match) do
    with {:ok, _} <- require_owner(player, match) do
      {:stop, :normal, :ok, match}
    else
      e = {:error, _reason} -> {:reply, e, match}
    end
  end

  defp require_owner(player, match) do
    if player.id == match.owner.id do
      {:ok, nil}
    else
      {:error, "player #{inspect(player)} is not the owner of the match"}
    end
  end
end
