defmodule Pmap do
    def pmap(collection, fun) do
        me = self()
        IO.inspect "me"
        IO.inspect self()
        collection
        |> Enum.map(fn (elem) ->
                IO.inspect spawn_link fn -> (send me, { self(), fun.(elem) })end
           end)
        |> Enum.map(fn (pid) ->
                receive do { ^pid, result } -> result end
           end)
    end
end

