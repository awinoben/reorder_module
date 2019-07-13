defmodule ReorderModuleWeb.ProductController do
  use ReorderModuleWeb, :controller

  #alias ReorderModule.Products
  alias ReorderModule.Products.Product

  #alias ReorderModule.Reorders
  alias ReorderModule.Reorders.Reorder
  #ReorderModule.{Products.Product, Reorders.Reorder}

  alias ReorderModule.Repo

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, "index.html", products: products)
  end

def new(conn, _params) do
  changeset = Products.change_product(%Product{})
  render(conn, "new.html", changeset: changeset)
end


  def create(conn, %{"product" => product_params}) do
    case Products.create_product(product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: product_path(conn, :show, product))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
@moduledoc """
def show(conn, %{"id" => id}) do
  product = Products.get_product!(id)
  render(conn, "show.html", product: product)
end
"""

  def show(conn, %{"id" => id}) do
    product = Repo.get!(Product, id)
    reorder_changeset = Reorder.changeset(%Reorder{})
    render(conn, "show.html", product: product, reorder_changeset: reorder_changeset)
  end

  def edit(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    changeset = Products.change_product(product)
    render(conn, "edit.html", product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Products.get_product!(id)

    case Products.update_product(product, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: product_path(conn, :show, product))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    {:ok, _product} = Products.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: product_path(conn, :index))
  end
end
