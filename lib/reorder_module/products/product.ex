defmodule ReorderModule.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset


  schema "products" do
    field :description, :string
    field :name, :string
    field :quantity, :integer
    field :reorder_level, :integer
    has_many :orders, ReorderModule.Orders.Order

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :quantity, :reorder_level, :description])
    |> validate_required([:name, :quantity, :reorder_level, :description])
  end
end
