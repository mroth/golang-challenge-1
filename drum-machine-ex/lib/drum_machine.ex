defmodule Pattern do
  @moduledoc """
  Pattern is the high level representation of the drum pattern contained in
  a .splice file.
  """
  defstruct version: "", tempo: 0, tracks: []
  @type t :: %Pattern{version: String.t, tempo: float, tracks: [Track.t]}
end

defmodule Track do
  @moduledoc """
  Track is the high level representation of a single instrument within a
  .splice file Pattern.
  """
  defstruct id: 0, instrument: nil, beats: []
  @type t :: %Track{id: integer, instrument: String.t, beats: [boolean]}
end

defimpl String.Chars, for: Pattern do
  def to_string(%Pattern{} = p) do
    """
    Saved with HW Version: #{p.version}
    Tempo: #{p.tempo}
    """ <>
    (Enum.map(p.tracks, &String.Chars.Track.to_string/1)
      |> Enum.reverse |> Enum.join("\n")
    )
  end
end

defimpl String.Chars, for: Track do
  def to_string(%Track{} = t) do
    grid = Enum.map(t.beats, &(if &1, do: "x", else: "-"))
           |> Enum.chunk(4)
           |> Enum.join("|")
    "(#{t.id}) #{t.instrument}\t|#{grid}|"
  end
end
