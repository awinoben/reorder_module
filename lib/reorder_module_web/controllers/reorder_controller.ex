defmodule ReorderModuleWeb.ReorderController do
  use ReorderModuleWeb, :controller

  alias ReorderModule.Reorders
  alias ReorderModule.Reorders.Reorder

  alias ReorderModule.Products
  alias ReorderModule.Products.Product

  alias ReorderModule.Repo

  def index(conn, _params) do
    reorders = Reorders.list_reorders()
    products = Products.list_products()
    render(conn, "index.html", reorders: reorders, products: products)
  end

  def new(conn, _params) do
    changeset = Reorders.change_reorder(%Reorder{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"reorder" => reorder_params, "product_id"=>product_id}) do
    #case Reorders.create_reorder(reorder_params) do
      #{:ok, reorder} ->
        #conn
        #|> put_flash(:info, "Reorder created successfully.")
        #|> redirect(to: reorder_path(conn, :show, reorder))
      #{:error, %Ecto.Changeset{} = changeset} ->
        #render(conn, "new.html", changeset: changeset)
    #end
    product = Repo.get(Product, product_id)

    product_quantity = 50
    product_level = 20
    q_difference = (product_quantity)- 40
    #product_changeset = Ecto.build_assoc(product, :products, quantity: q_difference )
    reorder_changeset = Ecto.build_assoc(product, :reorders, amount: reorder_params["amount"], status: reorder_params["status"])
    #if(product_level== product_quantity || product_level> product_quantity) do
      Repo.insert(reorder_changeset)
      #Repo.update(product_changeset)
    #end

    conn
    |> put_flash(:info, "Sale made successfully.")
    |> redirect(to: product_path(conn, :show, product))
  end

  def show(conn, %{"id" => id}) do
    reorder = Reorders.get_reorder!(id)
    render(conn, "show.html", reorder: reorder)
  end

  def edit(conn, %{"id" => id}) do
    reorder = Reorders.get_reorder!(id)
    changeset = Reorders.change_reorder(reorder)
    render(conn, "edit.html", reorder: reorder, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reorder" => reorder_params}) do
    reorder = Reorders.get_reorder!(id)

    case Reorders.update_reorder(reorder, reorder_params) do
      {:ok, reorder} ->
        conn
        |> put_flash(:info, "Reorder updated successfully.")
        |> redirect(to: product_reorder_path(conn, :show, reorder))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", reorder: reorder, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reorder = Reorders.get_reorder!(id)
    {:ok, _reorder} = Reorders.delete_reorder(reorder)

    conn
    |> put_flash(:info, "Reorder deleted successfully.")
    |> redirect(to: product_reorder_path(conn, :index, reorder))
  end
end