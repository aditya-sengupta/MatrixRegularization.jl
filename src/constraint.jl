abstract type constraint end

struct tv <: constraint end
struct nn <: constraint end
struct sp <: constraint end
struct tvnn <: constraint end
struct spnn <: constraint end

struct box{T} <: constraint
    xmin::T
    xmax::T
end

struct energy{T} <: constraint
    xenergy::T
end

struct project{T} <: constraint
    xmin::T
    xmax::T
    xenergy::T
end
