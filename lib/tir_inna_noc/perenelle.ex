defmodule TirInnaNoc.Perenelle do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: String.to_atom(state.board<>to_string(state.no)<>"Perenelle"))
  end

  @impl true
  def init(state) do
    IO.puts("watching thread "<>inspect(state))
    send(String.to_atom(state.board<>"Meldh"), {:checkin, state.no, self()})
    send(self(), {:update, state.on_page, state.reply_number, true})
    {:ok, state}
  end

  @impl true
  def handle_info({:addpost, post, sage_status}, state) do
    state = %TirInnaNoc.Imageboard.Thread{state | posts: [%TirInnaNoc.Imageboard.Post{post: post, sage: sage_status}]++state.posts}
    TirInnaNoc.Imageboard.Post.save(%TirInnaNoc.Imageboard.Post{post: post, sage: sage_status}, state.board)
    {:noreply, state}
  end

  @impl true
  def handle_info(:save, state) do
    TirInnaNoc.Imageboard.Thread.save(state)
    {:noreply, state}
  end

  @impl true
  def handle_info({:update, new_page, new_replynum, first_run}, state) do
    if (new_replynum > state.reply_number) or first_run do
      {:ok, res} = TirInnaNoc.Imageboard.thread(state.board, state.no)
      if res.status == 200 do
        res.body["posts"]
        |> Enum.each(fn post ->
          sage_status = if (new_page>state.on_page and new_replynum == state.reply_number+1), do: "y", else: "n"
          send(self(), {:addpost, post, sage_status})
        end)
      end
    else
      IO.puts("NOT UPDATING CUZ THERES NO UPDATE!!")
    end
    state = %TirInnaNoc.Imageboard.Thread{state | on_page: new_page, reply_number: new_replynum}
    send(self(), :save)
    {:noreply, state}
  end
end
