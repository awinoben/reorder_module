# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
 # ReorderModule.Repo.insert!(%ReorderModule.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias ReorderModule.Products
alias ReorderModule.Products.Product
album_data = [
  %{
    name: "productA",
    quantity: "50",
    reorder_level: "20",
    description: "dfghjkjjljbkvnbnmnnnndfgghhhjjkkhjhllll"
  },
  %{
    name: "productB",
    quantity: "50",
    reorder_level: "20",
    description: "dfghjkjjljbkvnbnmnnnndfgghhhjjjuuuk"
  },
  %{
    name: "productC",
    quantity: "50",
    reorder_level: "20",
    description: "dfghjkjjljbkvnbnmnnnndfgghhhjjjjkll"
  },
  %{
    name: "productD",
    quantity: "50",
    reorder_level: "20",
    description: "dfghjkjjljbkvnbnmnnnndfgghhhjjmmmnn"
  },
  %{
    name: "productE",
    quantity: "50",
    reorder_level: "20",
    description: "dfghjkjjljbkvnbnmnnnndfgghhhjjnnlllj"
  }
]

Enum.each(album_data, fn(data) ->
  #Product.create_album!(data)
  Products.create_product(data)
end)
