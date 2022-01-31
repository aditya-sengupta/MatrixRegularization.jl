function kaczmarz(A, b, λ=0; niter=1000)
    x = get_initial_x(size(A, 2))
    for i = 1:niter
        x = kaczmarz_iterate(x, A, b, i, λ)
    end
    x
end

function kaczmarz_iterate(x, A, b, i, λ)
    aᵢ = view(A, i, :)
    x + λ^i * ((b[i] - aᵢ ⋅ x) / (aᵢ ⋅ aᵢ)) * conj(aᵢ)
end