defmodule Decoder do

  @doc """
  Decodes the drum machine file found at the provided path and returns a
  parsed pattern which is the entry point to the rest of the data.
  """
  @spec decode(String.t) :: Pattern.t
  def decode(file_path) do
    case File.read(file_path) do
      {:ok, file} ->
        parse(file)
      _ ->
        IO.puts "Couldn't open #{file_path}"
    end
  end

  @spec parse(bitstring) :: Pattern.t
  def parse(file) do
    {rest, p} = file |> parse_header |> parse_preamble
    %{p | tracks: parse_tracks(rest)}
  end

  @doc """
  Verifies the file is a valid Splice file, and returns the file contents
  taking into account the reported content-length defined in the header.
  """
  @spec parse_header(bitstring) :: bitstring
  defp parse_header( << "SPLICE", body_length :: 64, rest :: binary >> ) do
    << body :: binary-size(body_length), _ :: binary >> = rest
    body
  end

  @doc """
  Parse the "preamble" to a splice file body, which contains general metadata
	about the overall song.

  Returns initialized Pattern struct with all the metadata (and an empty track
	list placeholder), as well as the remainder of the content body.
  """
  @spec parse_preamble(bitstring) :: {bitstring, Pattern.t}
  defp parse_preamble(contents) do
    << version    :: binary-size(32),
       tempo      :: little-float-size(32),
       rest       :: binary             >> = contents
    {rest, %Pattern{version: String.rstrip(version, 0), tempo: tempo}}
  end

  @doc """
  Recursively parse all tracks contained in the remainder of the content body.
  """
  @spec parse_tracks(bitstring, [Track.t]) :: [Track.t]
  defp parse_tracks(contents, tracks \\ [])
  defp parse_tracks(<<>>, tracks), do: tracks
  defp parse_tracks(contents, tracks) when bit_size(contents) > 0 do
    << track_id   :: integer-size(8),
       _padding   :: binary-size(3),
       i_len      :: integer-size(8),
       instrument :: binary-size(i_len),
       beats      :: binary-size(16),
       remainder  :: binary             >> = contents

    # convert beat grid to local format
    beats = for <<i <- beats>>, do: i != 0

    track = %Track{id: track_id, instrument: instrument, beats: beats}
    parse_tracks(remainder, [track | tracks])
  end

end
