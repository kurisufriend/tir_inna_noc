defmodule TirInnaNoc.Meldh do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: String.to_atom(state.board<>"Meldh"))
  end

  @impl true
  def handle_info({:checkin, no, pid}, state) do
    state = %TirInnaNoc.Imageboard.Board{board: state.board, threads: Map.put(state.threads, no, pid)}
    {:noreply, state}
  end

  @impl true
  def init(state) do
    IO.puts("started meldh to archive board "<>state.board)
    {:ok, res} = TirInnaNoc.Imageboard.threads(state.board)
    res.body
    |> Enum.each(fn page ->
      Enum.each(page["threads"], fn thread ->
        DynamicSupervisor.start_child(
          String.to_atom(state.board<>"Supervisor"),
          {
            TirInnaNoc.Perenelle,
            %TirInnaNoc.Imageboard.Thread{
              board: state.board,
              no: thread["no"],
              last_update: thread["last_modified"],
              reply_number: thread["replies"],
              on_page: page
            }
          }
        )
      end)
    end)
    {:ok, state}
  end
end
