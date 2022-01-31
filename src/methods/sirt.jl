function sirt_iterate(x, A, b, ω, D₁, D₂, C)
    project(x + ω * D₁ * A' * D₂ * (b - A * x), C)
end
