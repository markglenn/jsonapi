defmodule JsonAPI.Structure.Resource do
  alias JsonAPI.Structure.{Document, Links, Relationship}

  @type t :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          attributes: map | nil,
          relationships: Relationships.relationships_t() | nil,
          links: Links.t() | nil,
          meta: Document.meta_t() | nil
        }

  @enforce_keys [:id, :type]
  defstruct [:id, :type, :attributes, :relationships, :links, :meta]

  @spec parse(list | map | nil) :: t | [t] | nil
  def parse(resources) when is_list(resources), do: Enum.map(resources, &parse/1)

  def parse(%{"id" => id, "type" => type} = resource) do
    %__MODULE__{
      id: id,
      type: type,
      attributes: resource["attributes"],
      relationships: Relationship.parse(resource["relationships"]),
      links: Links.parse(resource["links"]),
      meta: resource["meta"]
    }
  end

  def parse(nil), do: nil
end
