defmodule TodoappWeb.ApiController do
  use TodoappWeb, :controller

  def index(conn, _params) do
    render conn, []
  end
end
