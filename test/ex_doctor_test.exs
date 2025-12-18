defmodule ExDoctorTest do
  use ExUnit.Case, async: true
  doctest ExDoctor

  require ExDoctor
  import ExDoctor, only: [to_map: 1, tr: 1]

  describe "to_map/1" do
    test "converts tr()" do
      pid = :erlang.list_to_pid(~c"<0.115.0>")

      trace =
        tr(
          index: 5,
          pid: pid,
          event: :call,
          mfa: {:lists, :keyfind, 3},
          data: [:syntax_colors, 1, []],
          ts: 1_766_078_114_348_924,
          info: :no_info
        )

      assert %{
               record: :tr,
               index: 5,
               pid: ^pid,
               event: :call,
               mfa: {:lists, :keyfind, 3},
               data: [:syntax_colors, 1, []],
               ts: 1_766_078_114_348_924,
               info: :no_info
             } = to_map(trace)
    end
  end
end
