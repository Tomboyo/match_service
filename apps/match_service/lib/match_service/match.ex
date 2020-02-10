defmodule MatchService.Match do
  defstruct [:state]

  def open_match() do
    %__MODULE__{ state: :open }
  end

  def start_match(match) do
    if match.state == :open do
      {:ok, %__MODULE__{ state: :running }}
    else
      {:error, "Match is not open"}
    end
  end

  def close_match(match) do
    if match.state == :running do
      {:ok, %__MODULE__{ state: :closed }}
    else
      {:error, "Match is not running"}
    end
  end
end
