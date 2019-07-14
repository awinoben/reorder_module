defmodule ReorderModule.Reorders.Reorder do
  use Ecto.Schema
  import Ecto.Changeset


  schema "reorders" do
    field :amount, :string
    field :status, :string, default: 0
    field :product_id, :id

    timestamps()
  end

  @doc false
  def changeset(reorder, params \\ %{}) do
    reorder
    |> cast(params, [:amount, :status])
    |> validate_required([:amount, :status])
  end
end
