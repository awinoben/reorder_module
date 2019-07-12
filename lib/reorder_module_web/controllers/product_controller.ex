defmodule ReorderModuleWeb.ProductController do
  use ReorderModuleWeb, :controller

  alias ReorderModule.Products
  alias ReorderModule.Products.Product

  #alias ReorderModule.Products
  #alias ReorderModule.Products.Product

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
        |> redirect(to: product_path(conn, :index, product))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    render(conn, "show.html", product: product)
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

  @moduledoc """
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
  """

  def delete(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    {:ok, _product} = Products.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: product_path(conn, :index))
  end


 @moduledoc """
 plug :check_auth when action in [:new, :create, :edit, :update, :delete]

 defp check_auth(conn, _args) do
  if user_id = get_session(conn, :current_user_id) do
  current_user = Accounts.get_user!(user_id)

  conn
    |> assign(:current_user, current_user)
  else
    conn
    |> put_flash(:error, "You need to be signed in to access that page.")
    |> redirect(to: product_path(conn, :index))
    |> halt()
  end
end
 """
end
