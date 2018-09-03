defmodule Link3 do
    import :timer, only: [ sleep: 1 ]

    def sad_funtion do
        sleep(500)
        exit(:boom)
    end

    def run do
        Process.flag(:trap_exit, true)
        IO.inspect self()
        IO.inspect spawn_link(Link3, :sad_funtion, [])
        receive do
            msg ->
                IO.puts "MESSAGE RECEIVED: #{inspect msg}"
            after 1000 ->
                IO.puts "Nothing happened as far as I am concerned"
        end
    end
end

Link3.run

