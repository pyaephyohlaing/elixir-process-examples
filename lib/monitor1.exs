defmodule Monitor1 do
    import :timer, only: [ sleep: 1 ]

    def sad_function do
        sleep 500
        exit(:boom)
    end

    def run do
        IO.inspect self()
        IO.inspect spawn_monitor(Monitor1, :sad_function, [])
        receive do
            msg ->
                IO.puts "MESSAGE RECEIVED: #{inspect msg}"
            after 1000 ->
                IO.puts "Nothing happened as far as I'm concerned"
        end
    end
end

Monitor1.run