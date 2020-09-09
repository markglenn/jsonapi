defmodule JsonAPI.Parser do
  alias JsonAPI.Structure.Document

  @spec parse(iodata) :: {:ok, Document.t()} | {:error, Jason.DecodeError.t()}
  def parse(json) do
    case Jason.decode(json) do
      {:ok, body} -> do_parse(body)
      {:error, _} = error -> error
    end
  end

  defp do_parse(%{} = document), do: Document.parse(document)
end
