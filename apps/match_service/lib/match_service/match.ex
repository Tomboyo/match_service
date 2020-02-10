defmodule MatchService.Match do
  defstruct [:state, :owner]

  def create_match(owner) do
    %__MODULE__{ state: :open, owner: owner }
  end

  def start_match(match) do
    if match.state == :open do
      {:ok, %{match | state: :running }}
    else
      {:error, "Match is not open"}
    end
  end

  def close_match(match) do
    if match.state == :running do
      {:ok, %{match | state: :closed }}
    else
      {:error, "Match is not running"}
    end
  end
end
