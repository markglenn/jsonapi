defmodule JsonAPI.Structure.Version do
  @type t :: %__MODULE__{version: String.t()}
  defstruct [:version]

  @spec parse(map | nil) :: t | nil
  def parse(nil), do: nil

  def parse(%{"version" => version}), do: %__MODULE__{version: version}
end
