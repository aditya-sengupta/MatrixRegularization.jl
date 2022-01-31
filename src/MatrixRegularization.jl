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

using LinearAlgebra: ⋅

project(vector, subspace) = subspace' * subspace * vector

function kaczmarz_iterate(x, A, b, i, λ)
    aᵢ = view(A, i, :)
    x + λ^i * ((b[i] - aᵢ ⋅ x) / (aᵢ ⋅ aᵢ)) * conj(aᵢ)
end

function sirt_iterate(x, A, b, ω, D₁, D₂, C)
    project(x + ω * D₁ * A' * D₂ * (b - A * x), C)
end

function fista_iterate(x, A, b, t, y, xₗ, ω, C)
    tₙ = (1/2) * (1 + sqrt(1 + 4 * t^2)) # n for "next"
    y = x + (t - 1) / (tₙ) * (x - xₗ)
    project(y + ω * A' * (b - A * y), C)
end

"""
Single iteration for the modified residual norm steepest descent method.
"""
function mrnsd_iterate(x, A, b, ω)
    x + ω * diag(x) * A' * (b - A * x)
end

function mrnsd(A, b; niter=100)
    r = b - A * x
    g = -A' * r
    xg = x .* g
    gamma = g' * xg
    # progressbar stuff
    for k = 1:niter
        s = -copy(xg)
        u = A * s
        theta = gamma / (u' ⋅ u)
        neg_ind = s .< 0
        alpha = min.(theta, min.(-x[neg_ind] ./ s[neg_ind]))
        if length(alpha) == 0
            alpha = theta
        end

        x = x + alpha * s
        r = r - alpha * u
        z = A' * u
        g = g + alpha * z
        xg = x .* g
        gamma = g' * xg
    end
end

function kaczmarz(A, b, λ=0; niter=1000)
    x = get_initial_x(size(A, 2))
    for i = 1:niter
        x = kaczmarz_iterate(x, A, b, i, λ)
    end
    x
end



end # module
