defmodule ReorderModuleWeb.SessionController do
  use ReorderModuleWeb, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => session_params}) do
  case ReorderModuleWeb.Session.login(session_params, ReorderModuleWeb.Repo) do
    {:ok, user} ->
      conn
      |> put_session(:current_user_id, user.id)
      |> put_flash(:info, "Signed in successfully.")
      |> redirect(to: "/")
    {:error, _} ->
      conn
      |> put_flash(:error, "There was a problem with your username/password")
      |> render("new.html")
    end
  end
  def delete(conn, _params) do
   conn
   |> delete_session(:current_user_id)
   |> put_flash(:info, "Signed out successfully.")
   |> redirect(to: user_path(conn, :index))
 end
end
