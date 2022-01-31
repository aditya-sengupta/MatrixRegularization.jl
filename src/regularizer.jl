"""
Just an API for a regularizer
"""

abstract type Method end

function initialize(m::Method, A, b) end
function step!(m::Method, x, A, b, args...) end