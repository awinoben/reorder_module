defmodule ReorderModuleWeb.PageController do
  use ReorderModuleWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
