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

export ArrayNormalization
export SignalNormalization

end
