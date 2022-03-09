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

* ```ChernNumber(HamiltonianModel, Paras::Tuple; HamiltonianDim::Int64,KxLim::Vector{<:Real}, KyLim::Vector{<:Real},Density::Int64 = 21)```

  Calculate the Chern number for the given 2D model ```HamiltonianModel(kx, ky, Paras::Tuple)```. ```kx``` and ```ky``` are coordinates in the Brillouin zone. ```HamiltonianDim``` is the size of your Hamiltonian matrix, like 2x2 or 3x3. ```KxLim``` and ```KyLim``` are the boundaries of ```kx``` and ```ky```. ```Density``` is the mesh density of the calculation.

  This function based on the paper [arXiv:cond-mat/0503172](https://arxiv.org/abs/cond-mat/0503172) ([J. Phys. Soc. Jpn. 74, pp. 1674-1677 (2005)](https://doi.org/10.1143/JPSJ.74.1674)).

  This function returns ```ChernNumber::Vector{Float64}, LatticeField::Matrix{Float64}```. The ```LatticeField``` is defined in the paper mentioned above.

* ```ChernNumberExample()``` 
  
  Simply a function which tests the function ```ChernNumber``` with Hamiltonian
  $$
  \begin{pmatrix}
  -2t \cos(k_x) -2t \cos(k_y) - \mu & \Delta (\sin(k_x) - i \sin(k_y)) \\
  \Delta (\sin(k_x) + i \sin(k_y)) & +2t \cos(k_x) +2t \cos(k_y) + \mu
  \end{pmatrix}.
  $$

  You can check out the source code ```ChernNumber.jl``` directly.

