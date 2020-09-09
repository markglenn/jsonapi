defmodule JsonAPI.Structure.Error do
  @moduledoc """
  JSON Error Object
  http://JsonAPI.Structure.org/format/#errors
  """

  alias JsonAPI.Structure.{ErrorLink, ErrorSource}

  @type t :: %__MODULE__{
          id: any,
          links: ErrorLink.t() | nil,
          status: String.t() | nil,
          code: String.t() | nil,
          title: String.t() | nil,
          detail: String.t() | nil,
          meta: JsonAPI.Structure.Document.meta_t() | nil,
          source: ErrorSource.t() | nil
        }

  defstruct [:id, :links, :status, :code, :title, :detail, :meta, :source]

  @spec parse([map] | map | nil) :: t | [t] | nil
  def parse(errors) when is_list(errors), do: Enum.map(errors, &parse/1)

  def parse(%{} = error) do
    %__MODULE__{
      id: error["id"],
      links: ErrorLink.parse(error["links"]),
      status: error["status"],
      code: error["code"],
      title: error["title"],
      detail: error["detail"],
      meta: error["meta"],
      source: ErrorSource.parse(error["source"])
    }
  end

  def parse(nil), do: nil
end
