defmodule MatchService do
  alias MatchService.{MatchServer, MatchesSupervisor}

  defdelegate create_match(), to: MatchesSupervisor
  defdelegate inspect_match(pid), to: MatchServer
  defdelegate start_match(pid), to: MatchServer
  defdelegate close_match(pid), to: MatchServer
  defdelegate delete_match(pid), to: MatchServer
end
