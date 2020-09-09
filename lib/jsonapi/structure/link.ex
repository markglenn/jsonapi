defmodule JsonAPI.Structure.Link do
  @type t :: %__MODULE__{
          href: String.t() | nil,
          meta: JsonAPI.Structure.Document.meta_t()
        }

  defstruct [:href, :meta]

  @spec parse(binary | map | nil) :: binary | t | nil
  def parse(%{} = link) do
    %__MODULE__{
      href: link["href"],
      meta: link["meta"]
    }
  end

  def parse(link) when is_binary(link), do: link
  def parse(nil), do: nil
end
