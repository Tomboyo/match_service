defmodule MatchService.Application do
  use Application

  def start(_type, _args) do
    children = [
      {MatchService.MatchesSupervisor, []},
    ]

    Supervisor.start_link(children, name: __MODULE__, strategy: :one_for_one)
  end
end
