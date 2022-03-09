# MyToolBox.jl
## Introduction
Personal Toolbox.
## Functions
* ```SignalCut(TargetSignal::Vector{<:Real}, ReferenceSignal::Vector{<:Real}, Window::Vector{<:Real})```

  This function cut the ```TargetSignal``` based on the ```ReferenceSignal```, with Reference's value from the first element of ```Window``` to the second element of ```Window```.   This function returns the same type of ```TargetSignal```.

* ```SignalNormalization(A::Vector{<:Real}; TriangularSignal::Bool = false)```

  Normalize the real number vector ```A```. if ```TriangularSignal``` is ```true```, then the signal will be normalized based on its standard deviation.
  This function returns the same type of ```A```.
 
* ```VectorSplit(TargetVector::Vector{<:Any}, N::Int64)```

  Similar function to ```numpy.array_split``` in 1 dim.
  This function returns ```Vector{Vector{<:Any}}```.

* ```CurrentTask(FuncName::Symbol)```

  Tracking the function being executed. Just need to insert ```CurrentTask(nameof(var"#self#"))``` at the place you want.

