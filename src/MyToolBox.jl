module MyToolBox

import Statistics

function SignalNormalization(A::Vector{<:Real}; TriangularSignal::Bool = false)
    if TriangularSignal == true 
        return (A .- Statistics.mean(A)) ./ (sqrt(2) * Statistics.std(A) * 2) .+ 0.5
    else
        return (A .- minimum(A)) ./ (maximum(A) - minimum(A))
    end
end

function SignalCut(TargetSignal::Vector{<:Real}, ReferenceSignal::Vector{<:Real}, Window::Vector{<:Real})
    length(Window) == 2 || throw(ArgumentError("Invalid length of (Window = $Window), should be 2."))
    length(TargetSignal) == length(ReferenceSignal) || throw(ArgumentError("Length of TargetSignal should be same as the length of ReferenceSignal."))
    S = Vector{Bool}(undef, length(ReferenceSignal))
    for i in 1:length(ReferenceSignal)
        S[i] = true * (ReferenceSignal[i] >= Window[1]) * (ReferenceSignal[i] <= Window[2])
    end
    return TargetSignal[S]
end

function VectorSplit(TargetVector::Vector{<:Any}, N::Int64)
    L1 = length(TargetVector)
    L2 = trunc(Int64, L1 / N)
    X = L1 - N * L2

    Result = Vector{Vector}(undef, N)
    CutStart = 1
    for i in 1:N
        Result[i] = TargetVector[CutStart:CutStart-1+L2+((i-1)<X)]
        CutStart += L2 + (i < X)
    end
    
    return Result
end

export SignalCut
export SignalNormalization
export VectorSplit

end
