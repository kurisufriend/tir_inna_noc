defmodule TirInnaNoc.Imageboard do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://a.4cdn.org"
  #plug Tesla.Middleware.Headers, [{"authorization", "token xyz"}]
  plug Tesla.Middleware.JSON

  def wget(uri) do
    if GenServer.call(:ratelimiter, :activate) == :goahead do
      get(uri)
    else
      Process.sleep(1_000)
      wget(uri)
    end
  end
  def boards() do
    wget("/boards.json")
  end
  def threads(board) do
    wget("/"<>board<>"/threads.json")
  end
  def thread(board, id) do
    wget("/"<>board<>"/thread/"<>to_string(id)<>".json")
  end
  def catalog(board) do
    wget("/"<>board<>"/catalog.json")
  end
end
