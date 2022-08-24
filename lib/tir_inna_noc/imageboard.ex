defmodule TirInnaNoc.Imageboard do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://a.4cdn.org"
  #plug Tesla.Middleware.Headers, [{"authorization", "token xyz"}]
  plug Tesla.Middleware.JSON

  def boards() do
    get("/boards.json")
  end
  def threads(board) do
    get("/"<>board<>"/threads.json")
  end
  def thread(board, id) do
    get("/"<>board<>"/thread/"<>to_string(id)<>".json")
  end
  def catalog(board) do
    get("/"<>board<>"/catalog.json")
  end
end
