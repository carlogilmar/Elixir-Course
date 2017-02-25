defmodule Speakers.PageController do
  use Speakers.Web, :controller

  def index(conn, _params) do
    #Imprimiendo el proceso de quien esta atendiendo
    IO.inspect self
    render conn, "index.html"
  end
end
