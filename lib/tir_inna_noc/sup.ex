defmodule TirInnaNoc.Sup do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      {TirInnaNoc.Db, [nil]},
      {DynamicSupervisor, strategy: :one_for_one, name: MerlinSupervisor},
      {TirInnaNoc.Merlin, [nil]}
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
