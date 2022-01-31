abstract type Constraint end

struct tv <: Constraint end
struct nn <: Constraint end
struct sp <: Constraint end
struct tvnn <: Constraint end
struct spnn <: Constraint end

struct Box{T} <: constraint
    xmin::T
    xmax::T
end

struct Energy{T} <: constraint
    xenergy::T
end

struct Project{T} <: constraint
    xmin::T
    xmax::T
    xenergy::T
end
