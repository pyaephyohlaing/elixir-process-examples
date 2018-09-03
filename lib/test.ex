defmodule Test do
    def counter(pid) do
        IO.inspect "GG"
        IO.inspect pid
    end

    def call(_,send)do
        spawn(Test, :counter, [send])
    end
end