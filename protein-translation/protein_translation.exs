defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    result = String.split(rna, "", trim: true)
             |> Stream.chunk(3)
             |> Enum.map(&List.to_string/1)
             |> get_proteins
  end

  defp get_proteins(list, result \\ [])
  defp get_proteins([string | rest], result) do 
    case of_codon(string) do 
      { :error, _ } -> { :error, "invalid RNA" }

      { :ok, "STOP" } -> { :ok, result }

      { :ok, protein } -> get_proteins(rest, result ++ [protein])
    end 
  end 

  defp get_proteins([], result), do: { :ok, result }

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """

  @map %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }
  
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    case protein = @map[codon] do 
      nil -> { :error, "invalid codon" }

      _otherwise -> { :ok, protein } 
    end 
  end
end

