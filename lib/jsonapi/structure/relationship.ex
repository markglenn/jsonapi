defmodule JsonAPI.Structure.Relationship do
  @type t :: %__MODULE__{
          links: JsonAPI.Structure.Links.t() | nil,
          meta: JsonAPI.Structure.Document.meta_t() | nil,
          data: JsonAPI.Structure.ResourceIdentifier.resource_linkage_t()
        }

  @type relationships_t :: %{optional(String.t()) => t}

  defstruct [:links, :meta, :data]

  @spec parse(map | nil) :: relationships_t
  def parse(%{} = relationships) do
    relationships
    |> Enum.map(fn {k, v} -> {k, do_parse(v)} end)
    |> Map.new()
  end

  def parse(nil), do: nil

  defp do_parse(%{} = relationship) do
    %__MODULE__{
      links: JsonAPI.Structure.Links.parse(relationship["links"]),
      meta: relationship["meta"],
      data: JsonAPI.Structure.ResourceIdentifier.parse(relationship["data"])
    }
  end
end
