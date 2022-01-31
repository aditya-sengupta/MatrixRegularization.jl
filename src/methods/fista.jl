function fista_iterate(x, A, b, t, y, xₗ, ω, C)
    tₙ = (1/2) * (1 + sqrt(1 + 4 * t^2)) # n for "next"
    y = x + (t - 1) / (tₙ) * (x - xₗ)
    project(y + ω * A' * (b - A * y), C)
end