defmodule ReorderModuleWeb.WarehouseController do
  use ReorderModuleWeb, :controller

  alias ReorderModule.Warehouses
  alias ReorderModule.Warehouses.Warehouse

  alias ReorderModule.Products
  alias ReorderModule.Products.Product
  
  alias ReorderModule.Reorders
  alias ReorderModule.Reorders.Reorder

  alias ReorderModule.Repo
  import Ecto.Query

  def query do
  query =  from p in Product,
        join: r in Reorder, on: r.product_id == p.id,
        select: [p.name, r.amount, r.status] #|> where([r], r.status == ^0)
end

  def index(conn, _params) do
    #warehouses = Warehouses.list_warehouses()
    processed = Repo.all(query)
    render(conn, "index.html", processed: processed)
  end

  def new(conn, _params) do
    changeset = Warehouses.change_warehouse(%Warehouse{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"warehouse" => warehouse_params}) do
    case Warehouses.create_warehouse(warehouse_params) do
      {:ok, warehouse} ->
        conn
        |> put_flash(:info, "Warehouse created successfully.")
        |> redirect(to: warehouse_path(conn, :show, warehouse))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    warehouse = Warehouses.get_warehouse!(id)
    render(conn, "show.html", warehouse: warehouse)
  end

  def edit(conn, %{"id" => id}) do
    warehouse = Warehouses.get_warehouse!(id)
    changeset = Warehouses.change_warehouse(warehouse)
    render(conn, "edit.html", warehouse: warehouse, changeset: changeset)
  end

  def update(conn, %{"id" => id, "warehouse" => warehouse_params}) do
    warehouse = Warehouses.get_warehouse!(id)

    case Warehouses.update_warehouse(warehouse, warehouse_params) do
      {:ok, warehouse} ->
        conn
        |> put_flash(:info, "Warehouse updated successfully.")
        |> redirect(to: warehouse_path(conn, :show, warehouse))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", warehouse: warehouse, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    warehouse = Warehouses.get_warehouse!(id)
    {:ok, _warehouse} = Warehouses.delete_warehouse(warehouse)

    conn
    |> put_flash(:info, "Warehouse deleted successfully.")
    |> redirect(to: warehouse_path(conn, :index))
  end
end
