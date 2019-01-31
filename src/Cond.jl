module Cond

export @cond

function translate(ex, i, s)
    i > s && return :(error("cond found no matching branch"))
    e = ex.args[i]
    e isa LineNumberNode && return translate(ex, i + 1, s)

    if i == s
        return e isa Expr && e.head == :call && e.args[1] == Symbol("=>") ?
            :($(esc(e.args[2])) ? $(esc(e.args[3])) : $(translate(ex, i + 1, s))) :
            e
    end

    @assert e.head == :call
    @assert e.args[1] == Symbol("=>")
    :($(esc(e.args[2])) ? $(esc(e.args[3])) : $(translate(ex, i + 1, s)))
end

function cond(ex)
    @assert ex.head == :block
    translate(ex, 1, length(ex.args))
end

macro cond(ex)
    cond(ex)
end

end # module
