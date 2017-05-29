defmodule FakeLC.LogGenerator do
  use GenServer

    def init(state = %{interval: interval, num_loops: num_loops}) do
    IO.inspect state, label: "init"
    num_loops = schedule_work(interval, num_loops)
    {:ok, Map.merge(state, %{num_loops: num_loops})}
  end

  def handle_info(:work, state =
    %{interval: interval, data: data, num_loops: num_loops, day: day}) do

    job(data, day)
    num_loops = schedule_work(interval, num_loops)
    {:noreply, Map.merge(state, %{num_loops: num_loops})}
  end

  defp job(data, day) do
    # Logger.error "HealthCheck fail"
    message = day
    |> mount_timestamp
    |> data.()
    |> Poison.encode!

    KafkaEx.produce("logging", 0, message)
  end

  defp schedule_work(interval, num_loops) when num_loops > 0 do
    Process.send_after(self(), :work, interval) # 1 minute
    num_loops - 1
  end

  defp schedule_work(_, _), do: 0

  defp mount_timestamp(day) do
    hour = Enum.random(6..23)
    minute = Enum.random(0..59)
    second = Enum.random(0..59)
    {:ok, time} = Time.new(hour, minute, second)

    "2017-05-#{day}T#{time}.000Z"
  end
end
