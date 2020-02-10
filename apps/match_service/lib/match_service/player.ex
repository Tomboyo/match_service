defmodule MatchService.Player do
  defstruct [:id]

  def create_player() do
    %__MODULE__{id: :rand.uniform(100_000)}
  end
end
