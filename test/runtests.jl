using Cond, Test

f(x) = @cond begin
    x > 5 => :bigger
    x == 5 => :equal
    x < 5 => :smaller
end

@test f(7) == :bigger
@test f(5) == :equal
@test f(3) == :smaller

g(x) = @cond begin
    x > 5 => :bigger
    x == 5 => :equal
    :smaller
end

@test g(7) == :bigger
@test g(5) == :equal
@test g(3) == :smaller

h(x) = @cond begin
    x > 5 => :bigger
    x == 5 => :equal
end

@test h(7) == :bigger
@test h(5) == :equal
@test_throws ErrorException h(3)
