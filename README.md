# MyToolBox.jl
## News
Better ```CurrentTask()```.

Add macro ```@CurrentTask```.
## Introduction
Personal Toolbox.
## Functions
### SmallTools
* ```SignalCut(TargetSignal::AbstractVector, ReferenceSignal::AbstractVector{<:Real}, Window::AbstractVector{<:Real})```

  This function cut the ```TargetSignal``` based on the ```ReferenceSignal```, with Reference's value from the first element of ```Window``` to the second element of ```Window```.   This function returns the same type of ```TargetSignal```.
  ```
  julia> SignalCut(["a", "b", "c"], [1, 2, 3], [1.5, 2.5])
  1-element Vector{String}:
  "b"
  ```

* ```SignalNormalization(A::AbstractVector{<:Real}; TriangularSignal::Bool = false)```

  Normalize the real number vector ```A```. if ```TriangularSignal``` is ```true```, then the signal will be normalized based on its standard deviation.
  This function returns the same type of ```A```.
  ```
  julia> SignalNormalization(rand(5))
  5-element Vector{Float64}:
  0.20449276098988486
  0.42580079054186
  1.0
  0.0
  0.5777728018962027
  ```
 
* ```VectorSplit(TargetVector::AbstractVector, N::Int)```

  Similar function to ```numpy.array_split``` in 1 dim.
  This function returns ```Vector{Vector{<:Any}}```.
  ```
  julia> VectorSplit(rand(10), 3)
  3-element Vector{Vector{Float64}}:
  [0.7586332209712368, 0.08142437829248872, 0.269257485848563, 0.7962988776077914]
  [0.2285139025652192, 0.8083763585147616, 0.1026721069191413]
  [0.21644242937949254, 0.5055168332610793, 0.01393917657638355]
  ```

* ```CurrentTask(FuncName::Symbol)```

  Tracking the function being executed. Just need to insert ```CurrentTask(nameof(var"#self#"))``` at the place you want.
  ```
  julia> CurrentTask(:Hello)
  ----------------------------------------------Current Task: Hello
  ```

* ```CurrentTask()```
  
  Tracking the function being executed, use ```stacktrace()``` to get the function name before ```CurrentTask()``` is called.
  ```
  julia> CurrentTask()
  ----------------------------------------------Current Task: top-level scope
  ```
* ```@CurrentTask```

  A macro calls the function ```CurrentTask(FuncName::Symbol)``` with parameter ```CurrentTask(nameof(var"#self#"))```. Inspired from the issue https://github.com/JuliaLang/julia/issues/6733.
  ```
  julia> function A()
           @CurrentTask
       end
  A (generic function with 1 method)

  julia> A()
  ----------------------------------------------Current Task: A
  ```


### ChernNumber
* ```ChernNumber(HamiltonianModel, Paras::Tuple; HamiltonianDim::Int, KxLim::AbstractVector{<:Real}, KyLim::AbstractVector{<:Real}, Density::Int=21)```

  Calculate the Chern number for the given 2D model ```HamiltonianModel(kx, ky, Paras::Tuple)```. ```kx``` and ```ky``` are coordinates in the Brillouin zone. ```HamiltonianDim``` is the size of your Hamiltonian matrix, like 2x2 or 3x3. ```KxLim``` and ```KyLim``` are the boundaries of ```kx``` and ```ky```. ```Density``` is the mesh density of the calculation.

  This function based on the paper [arXiv:cond-mat/0503172](https://arxiv.org/abs/cond-mat/0503172) ([J. Phys. Soc. Jpn. 74, pp. 1674-1677 (2005)](https://doi.org/10.1143/JPSJ.74.1674)).

  This function returns ```ChernNumber::Vector{Float64}, LatticeField::Matrix{Float64}```. 
  
  The ```LatticeField``` is defined as follow (A is the berry connection, S is the area size inside the loop integral.)
  
  <p align="center">
  <img src = "https://latex.codecogs.com/svg.image?F&space;=&space;\frac{\oint&space;d\mathbf{k}&space;\mathbf{\mathcal{A}}_{\mathbf{k}}}{S}">
  </p>
* ```ChernNumberExample()``` 
  
  Simply a function which tests the function ```ChernNumber``` with Hamiltonian
  
  <p align="center">
  <img src = "https://latex.codecogs.com/svg.image?&space;\begin{pmatrix}&space;-2t&space;\cos(k_x)&space;-2t&space;\cos(k_y)&space;-&space;\mu&space;&&space;\Delta&space;(\sin(k_x)&space;-&space;i&space;\sin(k_y))&space;\\&space;\Delta&space;(\sin(k_x)&space;&plus;&space;i&space;\sin(k_y))&space;&&space;&plus;2t&space;\cos(k_x)&space;&plus;2t&space;\cos(k_y)&space;&plus;&space;\mu&space;\end{pmatrix}">
  </p>

  You can check out the source code ```ChernNumber.jl``` directly.
### PackageMaintain
* ```PrintInstalledPackages(;FileName::String = "JuliaDependencies.txt")```
  
  Print all installed package names into a file.

* ```RestorePackages(;FileName::String = "JuliaDependencies.txt")```

  Restore the packages based on the printed file.

### PackageUsing
* ```@IfNotUsedThenUsing(PackageName::String)```
  
  Check if a package is already used. If not then ```using``` it.