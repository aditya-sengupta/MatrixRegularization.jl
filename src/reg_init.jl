"""
Setting the initial regularization matrix.
"""

function get_initial_regularization(initial_x, con::Union{tv,tvnn})
    temp_x = dx * initial_x # what operation is this in matlab
    temp_y = dy * initial_x
    diagW = temp_x .^ 2 + temp_y .^ 2
    diagW = max.(diagW, thr0)
    if sum(diagW) <= n * thr0
        L = "identity"
    else
        Wd = diagm(diagW .^ (-1/4))
        W = kron(I(2), Wd)
        L = W .* D
    end
    L
end

function get_initial_regularization(initial_x, con::spnn)
    dp = max.(initial_x, thr0) .^ (-1/2)
    L = diagm(dp)
    
end