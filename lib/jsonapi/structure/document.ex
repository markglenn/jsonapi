defmodule JsonAPI.Structure.Document do
  @moduledoc """
  JSON API Document Object
  http://JsonAPI.Structure.org/format/#document-structure
  """

  @type meta_t :: %{optional(String.t()) => any}

  alias JsonAPI.Structure.{Error, Links, Resource}

  @type t :: %__MODULE__{
          data: Resource.t() | [Resource.t()] | nil,
          links: Links.t() | nil,
          meta: meta_t | nil,
          included: Resource.t() | [Resource.t()] | nil,
          errors: [Error.t()] | nil
        }

  defstruct [:data, :links, :meta, :included, :errors]

  @spec parse(map) :: t()
  def parse(%{} = document) do
    %__MODULE__{
      data: Resource.parse(document["data"]),
      links: Links.parse(document["links"]),
      meta: document["meta"],
      included: Resource.parse(document["included"]),
      errors: Error.parse(document["errors"])
    }
  end
end
