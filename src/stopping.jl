abstract type Stop end
# abstract type Conv <: Stop end

# Tol is a bit redundant
# but I think it's faster than 
# dynamically computing 0 * norm 
# in the case of abstol

struct Tol{T} <: Stop
    abstol::T
    reltol::T
end

struct AbsTol{T} <: Stop
    tol::T
end

struct RelTol{T} <: Stop
    tol::T
end

struct Iter <: Stop
    maxiter::Int
end

go(s::Stop, x, A, b, itr) = !s(x, A, b, itr)

function (s::Stop)(x, A, b, niter)::Bool
    false
end

function (s::AbsTol)(x, A, b, niter)::Bool
    norm(b - A * x) <= s.tol
end

function (s::RelTol)(x, A, b, niter)::Bool
    norm(b - A * x) <= s.tol * norm(x)
end

function (s::Tol)(x, A, b, niter)::Bool
    norm(b - A * x) <= (s.abstol + s.reltol * norm(x))
end

function (s::Iter)(x, A, b, niter)::Bool
    niter > s.maxiter
end
