defmodule DrumMachineTest do
  use ExUnit.Case

  @outputs [
    """
    Saved with HW Version: 0.808-alpha
    Tempo: 120
    (0) kick	|x---|x---|x---|x---|
    (1) snare	|----|x---|----|x---|
    (2) clap	|----|x-x-|----|----|
    (3) hh-open	|--x-|--x-|x-x-|--x-|
    (4) hh-close	|x---|x---|----|x--x|
    (5) cowbell	|----|----|--x-|----|
    """,
    """
    Saved with HW Version: 0.808-alpha
    Tempo: 98.4
    (0) kick	|x---|----|x---|----|
    (1) snare	|----|x---|----|x---|
    (3) hh-open	|--x-|--x-|x-x-|--x-|
    (5) cowbell	|----|----|x---|----|
    """,
    """
    Saved with HW Version: 0.808-alpha
    Tempo: 118
    (40) kick	|x---|----|x---|----|
    (1) clap	|----|x---|----|x---|
    (3) hh-open	|--x-|--x-|x-x-|--x-|
    (5) low-tom	|----|---x|----|----|
    (12) mid-tom	|----|----|x---|----|
    (9) hi-tom	|----|----|-x--|----|
    """,
    """
    Saved with HW Version: 0.909
    Tempo: 240
    (0) SubKick	|----|----|----|----|
    (1) Kick	|x---|----|x---|----|
    (99) Maracas	|x-x-|x-x-|x-x-|x-x-|
    (255) Low Conga	|----|x---|----|x---|
    """,
    """
    Saved with HW Version: 0.708-alpha
    Tempo: 999
    (1) Kick	|x---|----|x---|----|
    (2) HiHat	|x-x-|x-x-|x-x-|x-x-|
    """
  ]

  test "decode all sample files" do
    for {output, i} <- Enum.with_index(@outputs) do
      file = "../drum-machine-go/fixtures/pattern_#{i+1}.splice"
      expected = String.strip(output)

      assert "#{Decoder.decode(file)}" == expected
    end
  end

end
