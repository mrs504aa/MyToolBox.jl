# MyToolBox.jl
## Introduction
Personal Toolbox.
## Functions
* ```SignalCut(TargetSignal::Vector{<:Real}, ReferenceSignal::Vector{<:Real}, Window::Vector{<:Real})```

  This function cut the TargetSignal based on the ReferenceSignal, with Reference's value from the first element of Window the the second element of Window.

* ```SignalNormalization(A::Vector{<:Real}; TriangularSignal::Bool = false)```

  Normalize the real number vector A. if TriangularSignal is true, then the signal will be normalized based on its standard deviation.
