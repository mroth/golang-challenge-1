defmodule Decoder do

  def parse(file_name) do
    case File.read(file_name) do
      {:ok, file} ->
        decode(file)
      _ ->
        IO.puts "Couldn't open #{file_name}"
    end
  end

  def decode(file) do
    file
    |> parse_header
    |> parse_pattern
    |> parse_tracks
  end

  defp parse_header( << "SPLICE", body_length :: 64, rest :: binary >> ) do
    << body :: binary-size(body_length), _ :: binary >> = rest
    body
  end

  defp parse_pattern( contents ) do
    << version    :: binary-size(32),
       tempo      :: little-float-size(32),
       rest       :: binary             >> = contents

    {rest, %Pattern{version: String.rstrip(version, 0), tempo: tempo}}
  end

  defp parse_tracks({contents, results}) when bit_size(contents) > 0 do
    << track_id   :: integer-size(8),
       _padding   :: binary-size(3),
       i_len      :: integer-size(8),
       instrument :: binary-size(i_len),
       beats      :: binary-size(16),
       remainder  :: binary             >> = contents

    beatlist = for <<i <- beats>>, do: i == 1
    track = %Track{id: track_id, instrument: instrument, beats: beatlist}

    parse_tracks {remainder, %{results | tracks: [track | results.tracks]}}
  end

  defp parse_tracks({_, results}), do: results
end
