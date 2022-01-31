using MatrixRegularization
using Distributions: Normal
using LinearAlgebra: norm
# using Test

function test_problem(n, cond=1e6)
    M = rand(n, n)
    logcond = log10(cond)
    λ = 10 .^ (LinRange(-logcond/2, logcond/2, n))
    M * diagm(λ) * M', rand(n)
end

function test_inversion(A, b, σ, method=nothing, stop=nothing)
    x = solve(A, b + rand(Normal(0, σ), size(b)), method, stop)
    norm(b - A * x)
end

function test_inversion(n, cond=1e6, σ, method=nothing, stop=nothing)
    A, b = test_problem(n, cond)
    test_inversion(A, b, σ, method, stop)
end