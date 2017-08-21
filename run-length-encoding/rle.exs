defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(""), do: ""
  def encode(string) do
    string
    |> do_encode("", 0, "")
  end

  @spec decode(String.t) :: String.t
  def decode(string) do

  end
  
  @spec do_encode(String.t, String.t, number, String.t) :: String.t
  defp do_encode("", res, count, curr) do 
    cond do 
      count > 1 -> "#{res}#{count}#{curr}" 

      true -> "#{res}#{curr}"
    end 
  end 
  defp do_encode(<< head :: binary - 1, tail :: binary >>, res, count, "") do 
    do_encode(tail, res, count + 1, head)  
  end
  defp do_encode(<< head :: binary - 1, tail :: binary >> = str, res, count, curr) do 
    cond do 
      curr == head -> do_encode(tail, res, count + 1, curr)

      count > 1 -> do_encode(str, "#{res}#{count}#{curr}", 0, "")

      true -> do_encode(str, "#{res}#{curr}", 0, "")
    end 
  end 
end






