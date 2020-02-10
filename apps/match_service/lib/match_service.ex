defmodule MatchService do
  alias MatchService.{MatchServer, MatchesSupervisor, Player}

  defdelegate create_player(), to: Player
  defdelegate create_match(owner), to: MatchesSupervisor
  defdelegate inspect_match(pid), to: MatchServer
  defdelegate start_match(player, pid), to: MatchServer
  defdelegate close_match(player, pid), to: MatchServer
  defdelegate delete_match(player, pid), to: MatchServer
end
