defmodule JsonAPI.Structure.ResourceIdentifier do
  @type t :: %__MODULE__{
          id: String.t(),
          type: String.t(),
          meta: JsonAPI.Structure.Document.meta_t() | nil
        }

  @type resource_linkage_t :: t | [t] | nil

  @enforce_keys [:id, :type]
  defstruct [:id, :type, :meta]

  @spec parse(map | list | nil) :: t | [t] | nil
  def parse(identifiers) when is_list(identifiers), do: Enum.map(identifiers, &parse/1)

  def parse(%{} = identifier) do
    %__MODULE__{
      id: identifier["id"],
      type: identifier["type"],
      meta: identifier["meta"]
    }
  end

  def parse(nil), do: nil
end
