defmodule ReorderModule.Repo do
  use Ecto.Repo,
  otp_app: :reorder_module,
  adapter: Ecto.Adapters.Postgres


  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("postgres://qaomvxxqvpmxef:8b078f8e5d7d14c77924e14ee1af4b0ece6c2d9b02d9f9d3bec6c4ed2f2c27b2@ec2-174-129-226-234.compute-1.amazonaws.com:5432/dfmp7mg58msiju"))}
  end
end
