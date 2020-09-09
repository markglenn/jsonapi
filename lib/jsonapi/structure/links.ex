defmodule JsonAPI.Structure.Links do
  @moduledoc """
  JSON API JSON Links
  http://JsonAPI.Structure.org/format/#document-links
  """

  alias JsonAPI.Structure.Link

  @type link_t :: String.t() | Link.t() | nil

  @type t :: %__MODULE__{
          self: link_t | nil,
          related: link_t | nil,
          first: link_t | nil,
          prev: link_t | nil,
          next: link_t | nil,
          last: link_t | nil
        }

  defstruct [:self, :related, :first, :prev, :next, :last]

  @spec parse(map | nil) :: t | nil
  def parse(%{} = links) do
    %__MODULE__{
      self: Link.parse(links["self"]),
      related: Link.parse(links["related"]),
      first: Link.parse(links["first"]),
      prev: Link.parse(links["prev"]),
      next: Link.parse(links["next"]),
      last: Link.parse(links["last"])
    }
  end

  def parse(nil), do: nil
end
