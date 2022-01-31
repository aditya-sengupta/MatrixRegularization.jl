get_initial_x(n::Int, x0=nothing) = isnothing(x0) ? zeros(n) : x0

function get_initial_x(n::Int, con::box, x0=nothing)
    x0 = get_initial_x(n, x0)
    max.(min.(x0, con.xmax), con.xmin)
end

function get_initial_x(n::Int, con::energy, x0=nothing)
    x0 = get_initial_x(n, x0)
    max.(x0, 0)
end

function get_initial_x(n::Int, con::project, x0=nothing)
    x0 = get_initial_x(n, x0)
    con.xmin = 0
    max.(x0, 0)
end

