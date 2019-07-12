defmodule ReorderModule.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :product_id, :integer
      add :status, :integer

      timestamps()
    end

  end
end
