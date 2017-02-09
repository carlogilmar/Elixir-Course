defmodule Test.PageController do
  use Test.Web, :controller

  def index(conn, _params) do
    IO.puts "Holaaaaa"
    IO.inspect self()
    render conn, "index.html"
  end
end
