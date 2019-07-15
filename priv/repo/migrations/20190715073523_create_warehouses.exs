defmodule ReorderModule.Repo.Migrations.CreateWarehouses do
  use Ecto.Migration

  def change do
    create table(:warehouses) do
      add :name, :string

      timestamps()
    end

  end
end
