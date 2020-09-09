defmodule JsonAPI.Structure.ErrorLink do
  @type t :: %__MODULE__{
          about: String.t() | JsonAPI.Structure.Link.t() | nil,
          type: String.t() | JsonAPI.Structure.Link.t() | nil
        }

  defstruct [:about, :type]

  @spec parse(map | nil) :: t | nil
  def parse(nil), do: nil

  def parse(%{"about" => about, "type" => type}) do
    %__MODULE__{about: about, type: type}
  end
end
