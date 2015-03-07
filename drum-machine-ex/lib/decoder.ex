defmodule Decoder do

  def decode(file_name) do
    case File.read(file_name) do
      {:ok, file} ->
        parse(file)
      _ ->
        IO.puts "Couldn't open #{file_name}"
    end
  end

  def parse(file) do
    file
    |> parse_header
    |> parse_preamble
    |> parse_tracks
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

  Returns initialized Pattern struct with all the metadata and an empty track
	list (ready to be populated!), as well as the remainder of the content body.
  """
  @spec parse_preamble(bitstring) :: {bitstring, Pattern.t}
  defp parse_preamble(contents) do
    << version    :: binary-size(32),
       tempo      :: little-float-size(32),
       rest       :: binary             >> = contents
    {rest, %Pattern{version: String.rstrip(version, 0), tempo: tempo}}
  end

  @doc """
  Parses all tracks contained in the remainder of the content body.

  Takes as secondary element an initialized Pattern as template, it will then
  fully populate its Tracks field with the parsed tracks, and returns a copy.
  """
  @spec parse_tracks({bitstring, Pattern.t}) :: Pattern.t
  defp parse_tracks({contents, results}) when bit_size(contents) > 0 do
    << track_id   :: integer-size(8),
       _padding   :: binary-size(3),
       i_len      :: integer-size(8),
       instrument :: binary-size(i_len),
       beats      :: binary-size(16),
       remainder  :: binary             >> = contents

    # convert beat grid to local format
    beatlist = for <<i <- beats>>, do: i != 0

    track = %Track{id: track_id, instrument: instrument, beats: beatlist}
    parse_tracks {remainder, %{results | tracks: [track | results.tracks]}}
  end
  defp parse_tracks({_, results}), do: results
end
