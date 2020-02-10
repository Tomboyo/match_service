defmodule MatchService.MatchesSupervisor do
  use DynamicSupervisor
  alias MatchService.MatchServer

  @name __MODULE__

  # API

  def create_match() do
    DynamicSupervisor.start_child(@name, MatchServer)
  end

  # Supervision impl

  def child_spec(args \\ []) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [args]}
    }
  end

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: @name)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
