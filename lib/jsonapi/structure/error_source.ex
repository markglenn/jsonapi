defmodule JsonAPI.Structure.ErrorSource do
  @type t :: %__MODULE__{
          pointer: String.t() | nil,
          parameter: String.t() | nil
        }

  @enforce_keys [:pointer, :parameter]
  defstruct [:pointer, :parameter]

  @spec parse(map | nil) :: t | nil
  def parse(nil), do: nil

  def parse(%{} = source) do
    %__MODULE__{
      pointer: source["pointer"],
      parameter: source["parameter"]
    }
  end
end
