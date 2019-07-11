defmodule ReorderModule.Session do
  use ReorderModule.Web, :model

  alias ReorderModule.Accounts.User

  schema "sessions" do

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end

  def login(params, repo) do
    user = repo.get_by(User, username: String.downcase(params["username"]))
    case authenticate(user, params["encrypted_password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.crypted_password)
    end
  end
  def current_user(conn) do
  id = Plug.Conn.get_session(conn, :current_user_id)
  if id, do: ReorderModule.Repo.get(User, id)
end

def logged_in?(conn), do: !!current_user_id(conn)
end
