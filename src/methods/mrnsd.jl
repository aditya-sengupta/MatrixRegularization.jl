"""
Modified Residual Norm Steepest Descent method
"""

struct MNRSD <: Method end

function initialize(m::MNRSD, A, b)
    r = b - A * x
    g = -A' * r
    xg = x .* g
    γ = g' * xg
    return NamedTuple{
        :r, :g, :xg, :γ,
    }(
        r, g, xg, γ
    )
end

function step!(m::MNRSD, x, A, b, r, g, xg, γ)
    u = -A * xg
    θ = γ ./ (u' ⋅ u)
    mask = xg .> 0
    α = min.(θ, min.(x[mask] ./ xg[mask]))
    if length(α) == 0
        α = θ 
    end

    x = x - α * xg
    r = r - α * u
    z = A' * u
    g = g + α * z
    xg = x .* g
    γ = g' * xg
end
