defmodule FakeLC do
  use Application

  def start(_type, _args) do
    IO.puts "Staring the app!!!!"
    import Supervisor.Spec, warn: false

    children = [
      worker(FakeLC.LogGenerator, [])
    ]

    opts = [strategy: :simple_one_for_one, name: FakeLC.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_new_job(process_list, data) do
    {:ok, pid} = GenServer.start(FakeLC.LogGenerator, data)
    [pid | process_list]
  end
end

# How to use
# process_list = []
# process_list = process_list
#  |> FakeLC.start_new_job(%{data: &FakeLC.Data.checkin_ok/1, interval: 100, num_loops: 10, day: 29})
