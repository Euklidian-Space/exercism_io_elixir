defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    use Bitwise, only_operators: true 

    (31 &&& code)
      |> Integer.to_string(2)
      |> String.to_integer
      |> Integer.digits 
      |> decode
  end

  defp decode([w]), do: wink(w)
  defp decode([d, w]), do: wink(w) ++ double_blink(d)
  defp decode([c, d, w]), do: wink(w) ++ double_blink(d) ++ close(c)
  defp decode([j, c, d, w]), do: wink(w) ++ double_blink(d) ++ close(c) ++ jump(j)
  defp decode([1, j, c, d, w]), do: jump(j) ++ close(c) ++ double_blink(d) ++ wink(w)

  defp wink(1), do: ["wink"]
  defp wink(0), do: []
  defp double_blink(1), do: ["double blink"] 
  defp double_blink(0), do: []
  defp close(1), do: ["close your eyes"] 
  defp close(0), do: []
  defp jump(1), do: ["jump"]
  defp jump(0), do: []
end
