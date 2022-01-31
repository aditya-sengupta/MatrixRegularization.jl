module MatrixRegularization

# A pedagogical tool for myself, assessing different matrix regularization techniques

"""
algebraic reconstruction (Kaczmarz's method)
conjugate gradient implicitly to normal equations
projected-restarted iteration method with constraints
conjugate gradient + low-dim subspace with desired features
first-order FISTA optimiser, solves Tikhonov problem with box/energy constraints
restarted iteration with heuristic TV penalty
hybrid GMRES with 2-norm penalty term (dispatch on penalty/loss I think)
hybrid LSQR with 2-norm penalty term
iteratively reweighted norm for 1-norm penalised solution
CGLS
range restricted GMRES
simultaneous iterative reconstruction
"""

using LinearAlgebra: ⋅, norm

include("utils.jl")
# include("methods/fista.jl")
# include("methods/kaczmarz.jl")
include("methods/mrnsd.jl")
# include("methods/sirt.jl")
include("constraint.jl")
include("initial_x.jl")
include("stopping.jl")

function solve(A, b, stop::Union{Stop,Nothing}=nothing, method::Union{Method,Nothing}=nothing)
    A \ b
end

"""
Iteratively solves the matrix equation Ax = b with the given stop condition and method.
"""
function solve(A, b, stop::Stop, method::Method)
    x, args = initialize(method, A, b) # TODO update this with conditions
    while !stop(x, A, b, args...)
        step!(method, x, A, b, args...)
    end
    x # TODO return more stuff
end

end # module
