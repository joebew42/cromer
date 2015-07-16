defmodule Cromer.Merchant do
  use Cromer.Web, :model

  schema "merchants" do
    field :username, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps
  end

  @required_fields ~w(username password password_confirmation)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_unique(:username, on: Cromer.Repo, downcase: true)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
  end

end
