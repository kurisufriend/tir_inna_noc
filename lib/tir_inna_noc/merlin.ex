defmodule TirInnaNoc.Merlin do
  use GenServer

  def start_link(a) do
    GenServer.start_link(__MODULE__, a)
  end

  @impl true
  def init(a) do
    {:ok, relevant} = TirInnaNoc.Db.smembers("boards")
    relevant
    |> Enum.each(fn board ->
      DynamicSupervisor.start_child(
        MerlinSupervisor, {DynamicSupervisor, strategy: :one_for_one, name: String.to_atom(board<>"Supervisor")}
      )
      DynamicSupervisor.start_child(MerlinSupervisor, {TirInnaNoc.Meldh, {board, %{}}})
    end)
    {:ok, a}
  end
end
