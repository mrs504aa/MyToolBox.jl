include("../src/MyToolBox.jl")
using .MyToolBox

@show :Statistics in names(Main, imported = true)
@IfNotUsedThenUsing("Statistics")
@show :Statistics in names(Main, imported = true)