### A Pluto.jl notebook ###
# v0.20.21

#> [frontmatter]
#> title = "01: Intro"
#> description = "Notebook 1 in the AAS 247 JuliaAstro workshop series."

using Markdown
using InteractiveUtils

# ╔═╡ b34e164a-da63-4636-b2d3-1d9efc9ae8d6
using DrWatson

# ╔═╡ 040b953f-8873-441c-a97f-48c1cf45ef03
@quickactivate "AAS247Julia"

# ╔═╡ 7c4ebc32-9b8e-4b2a-8f39-f4c351283843
using Dates, PlutoUI

# ╔═╡ 38ead816-0375-4605-a833-6464485aa0d6
md"""
### Historical Context

Twenty-nine years ago at the Astronomical Data Analysis Software and Systems (ADASS) VI meeting (1996), Harrington and Barrett hosted a Birds-of-a-Feather session entitled [Interactive Data Analysis Environments](https://www.cv.nrao.edu/adass/adassVI/harringtonj.html). Based on their review of [21 interpreted programming languages](https://htmlpreview.github.io/?https://github.com/barrettp/AAS245Julia/blob/main/Interactive%20Data%20Analysis%20Environments.html) such as Glish, GUILE, IDL, IRAF, Matlab, Perl, Python, and Tcl; they recommended that Python be considered the primary language for astronomical data analysis. The primary reasons were that the language was simple to learn, yet powerful; well supported by the programming community; and had FORTRAN-like arrays. However, for good performance, the multi-dimensional arrays needed to be written in a compiled language, namely C. So Numerical Python suffered from the "two language problem".
"""

# ╔═╡ 95cfbabc-5e7c-481b-853c-6d06baa577b6
md"""
#### Why Julia?

In 2009, four faculty members[^1] at MIT, who were not satisfied with the state of scientific computing, decided to develop a general purpose, high performance, scientific programming language. After ten years of development, they release Julia Version 1.0 on August 8, 2018. Their aims were to create an open-source interpreted language that was concise, extensible, and high performance.

[^1]: [Alan Edelman](https://math.mit.edu/~edelman/), Professor of Applied Mathematics and Computer Science, MIT; [Viral B. Shah](https://en.wikipedia.org/wiki/Viral_B._Shah), Co-Founder, Chief Executive Officer (CEO), JuliaHub; [Jeff Bezanson](https://en.wikipedia.org/wiki/Jeff_Bezanson), Co-Founder, Chief Technology Officer (CTO), JuliaHub; [Stefen Karpinski](https://karpinski.org/), Co-Founder, Chief Product Officer (CPO), JuliaHub
"""

# ╔═╡ 8e597a38-6e41-499f-af06-f9223b8827de
md"""
#### What Differentiates Julia From Other Languages?

* Julia is **composable**.
* Julia is **concise**.
* Julia is **highly performant**.
* Julia is **productive**.
* Julia is **easy to maintain**.
* Julia is **free and open-source**.
"""

# ╔═╡ 1cc401a1-6d3a-40e5-a4fc-012caa913369
md"""
#### Why Have I migrated to Julia?

Although an early advocate and developer of Numerical Python (now NumPy), Matplotlib, and PyFits (now astropy.io.fits), I knew its limitations, namely, the two language problem. Therefore, once a better scientific programming language came along, I was prepared to migrate to that language. I believe that **Julia is that language.**
"""

# ╔═╡ b1ed2c4e-f5fa-4e5e-87d8-7af6f80a83ca
md"""
### Getting Started

---
"""

# ╔═╡ 7f3357bc-4103-4a35-af21-9c86f5a0ec2f
md"""
#### Starting Julia

Enter `julia` at the terminal prompt. Set the number of threads to `auto`. Threads will be discussed later in Parallel Computing.

```julia-repl
> julia --threads=auto
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.12.1 (2025-10-17)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org release
|__/                   |

julia>
```

!!! tip
    The command line option "`-q`" can be used to remove the start-up banner.

---
"""

# ╔═╡ 7475c896-d1b1-4429-9ba8-8e78de41e0b0
md"""
#### Stopping Julia

To exit Julia, enter `<Ctrl-D>` or `exit()`

```julia-repl
julia> <Ctrl-D>
```

!!! tip
    Don't do this now!

---
"""

# ╔═╡ 5df8264e-6e37-4674-abdf-2b05c530787f
md"""
#### The command line  or  REPL (Read-Eval-Print-Loop)
"""

# ╔═╡ f646ca14-c01e-47ee-8e2b-052d9db0985b
md"""
Our first command:

```julia
println("Hello World")
```
"""

# ╔═╡ 4a404280-2845-4deb-8eee-2dcdcb9aed27


# ╔═╡ 7813824a-cae9-4b97-ac90-e542fbd630d5
md"""
!!! note
    Unlike Jupyter and the REPL, Pluto prints the result above the line, not below.

Our first calculation

```julia
a = 4
```
"""

# ╔═╡ 6ac51e87-87a2-4ccc-9f08-0028700b3cda


# ╔═╡ 27208179-35c3-43c1-9548-3620c8aa7680
md"""```julia
b = 2
```"""

# ╔═╡ 40d8d18c-3713-4e77-812d-9d77a4e1ac50


# ╔═╡ aa3e9db7-49d1-40f8-b745-6c4faa2197e1
md"""```julia
a + b
```"""

# ╔═╡ 8eb9630a-44b2-4ac8-b243-0c2ce5b16f50


# ╔═╡ 419a6dec-1db0-477f-911f-049223b5674f
md"""
### Other REPL Modes

The Julia REPL supports several different modes, outlined below, accessible by a keystroke. Hit the `delete` or `backspace` key to return to the normal `julia>` REPL.

---
"""

# ╔═╡ 85f2bec3-0095-4bbc-93ef-48ab97094244
md"""
#### Help: `?`

For help mode:

```julia-repl
julia> ?

help?> println
search: println printstyled print sprint isprint

println([io::IO], xs...)

Print (using print) xs to io followed by a newline. If io is not supplied, prints to the default output stream stdout.

See also printstyled to add colors etc

Examples
≡≡≡≡≡≡≡≡≡≡

julia> println("Hello, world")
Hello, world

julia> io = IOBuffer();

julia> println(io, "Hello", ',', " world.")

julia> String(take!(io))
"Hello, world.\n"
```

!!! note
    Pluto has a **Live docs** tab in the lower right corner that will display the current Julia function or command. The **Help**, **Shell**, and **Package Manager** examples require the REPL, i.e., running Julia in a terminal.

---
"""

# ╔═╡ 8ee7f43d-bf75-4975-ac64-54c2d5a0174a
md"""
#### Shell: `;`

For shell mode:

```julia-repl
julia> ;

shell> pwd
/Users/myhomedir
```

---
"""

# ╔═╡ d1e9c51c-efb9-4dcb-9d28-8c54a235fbb4
md"""
#### Package Manager: `]`

For package mode:

```julia-repl
julia> ]

pkg>
```

For package manager help,

```julia-repl
pkg> ? `return`
```

returns a brief summary of package commands.

To add a package:

```julia-repl
pkg> add <package>

pkg> add <package1>, <package2>
```

When adding a package, the Julia online repository (aka the "registry") will be searched. The package and its dependencies will then be downloaded, compiled, and installed. This may take anywhere from a few seconds to a few minutes depending on the size of the package and its dependencies.

To use or load a package (after it has been added):

```julia-repl
julia> using <package>

julia> using <package1>, <package2>
```

A feature of the `using` command is that it will add the package, if it hasn't already been added.
"""

# ╔═╡ b27578b2-f5f5-4e46-82e6-0007be187ba6
md"""
To check the manifest:

```julia-repl
pkg> status
```
or
```julia-repl
pkg> st
```
"""

# ╔═╡ 065265a5-c9ad-4a39-b14d-f4e2e49d3f7a
md"""
To update a package in the manifest:

```julia-repl
pkg> update <package>
```

or

```julia-repl
pkg> up <package>
```

To update all packages in the manifest:

```julia-repl
pkg> up
```

To garbage collect packages not used for a significant time:

```julia-repl
pkg> gc
```
"""

# ╔═╡ 563f07ad-6aed-495e-85fb-bae4a1755ac2
md"""
### Some simple programming examples

---
"""

# ╔═╡ 0f94b21c-364f-488e-aff3-28c4b39a3844
md"""
#### Measurements and Unicode

The [Measurements.jl](https://juliaphysics.github.io/Measurements.jl/stable/) package enables variables to have both values and errors. Let's add Measurements using the `using` statement:

```julia
using Measurements
```
"""

# ╔═╡ 40abc83f-b4bd-479f-8671-189cc712d792


# ╔═╡ 297cd86c-5e9d-4f70-b11a-cbae8fa96d1e
md"""
Let's do some calculations.

```julia
m1 = measurement(4.5, 0.1)
```
"""

# ╔═╡ 8f016c75-7768-4418-8c57-100db3073c85


# ╔═╡ 094b6f30-cbd6-46b1-8e0c-3fdb1ef18261
md"""Typing `measurements` is rather awkward. There must be a better way. How about the following?

```julia
m2 = 15 ± 0.3
```

where the plus-minus character is entered using LaTeX syntax followed by tab, i.e., `\pm<tab>`.
"""


# ╔═╡ 7ba8dc19-e0ca-40de-a778-7583ca70978d


# ╔═╡ 668abc35-fdc3-430f-8c90-de3c2c2cd77b
md"""
One of the features of Julia is that it understands unicode. For example, expressions in a printed document that contain greek characters can be entered as greek characters in your code, e.g., `\alpha<tab>`. Let's calculate the following expression:

```julia
α = m1 + m2
```
"""

# ╔═╡ 0e42f7fd-955e-4679-8d90-0cb46c9a12dc


# ╔═╡ d2a2d0bc-e883-439f-8e34-166e2369caef
md"""
!!! note

    Notice that the error of the result `α` has been propogated correctly.

---
"""

# ╔═╡ 750acbf6-bc04-43ea-b123-14753cab597a
md"""
#### Units

Let's add another package called [Unitful.jl](https://juliaphysics.github.io/Unitful.jl/stable/), which enables attaching units to variables:

```julia
using Unitful
```
"""

# ╔═╡ 88ca2a73-6203-447c-afcc-9e370a82076b


# ╔═╡ c24f1ddd-5e31-4073-a627-86cedb1d44c2
md"""
Now let's create a velocity `m3` with attached units:

```julia
m3 = (32 ± 0.1)u"m/s"
```
"""

# ╔═╡ 63a4b27a-5361-4d95-8787-ae31ca7987fe


# ╔═╡ d65a2638-54c0-4eb5-a870-44d7ab35400c
md"""
Let's create a duration `m4` with attached units:

```julia
m4 = (9.8 ± 0.3)u"s"
```
"""

# ╔═╡ 15674bb0-2fe1-40b1-a6c0-3a5a64a6a5c3


# ╔═╡ c07f9493-b867-485b-87f2-50348bb9eaa6
md"""
Let's calculate `β` by multiplying `m3` and `m4`:

```julia
β = m3 * m4
```
"""

# ╔═╡ 70f08712-002c-4adc-84b1-73a8655d8a44


# ╔═╡ 6cc63679-6352-4ffa-ae6a-3066431cfd10
md"""

The variable β's value now has an associated error and unit.

!!! note
    Some care must be taken when using Greek characters to not override their predefined values. For example, π is the constant π, ie., 3.1415926... .

```julia
π
```
"""

# ╔═╡ d961b128-bd38-40dd-8942-da6b7c150c42
md"""
And 2π is the constant 2π:

```julia
2π
```
"""

# ╔═╡ 56f7266f-507f-403c-9875-4aa8f9bb04aa
md"""
!!! note
    As in the case of `2π`, the multiplication operator is inferred from the context and is not necessary. There cannot be a space between the number and variable.

---
"""

# ╔═╡ cf4a0e8f-9210-4f1e-84d4-ee7ff09aaf61
md"""
#### Arrays

Let's see if this works with one dimensional arrays or vectors:

```julia
γ = [10 ± 0.1, 20 ± 0.2, 30 ± 0.3]u"m/s" .* [15 ± 0.01, 25 ± 0.02, 25 ± 0.03]u"s"
```

Note the dot '`.`' before the multiplication character '`*`'.  This means element-wise multiplication, whereas the multiplication character '`*`' by itself means matrix multiplication. If you are coming from Python, this difference may take a little time to get used to.
"""

# ╔═╡ fdba7211-e480-4948-8435-76a7608e7e63


# ╔═╡ 1f90de4b-790b-41f8-9a7b-3a54e9fff472
md"""
See the [dot syntax](https://docs.julialang.org/en/v1/manual/functions/#man-vectorized) section of the Julia manual for more.

---
"""

# ╔═╡ 3e8ee79c-c315-4c19-88ad-9b58caa86c40
md"""
#### Symbolics

Julia can also do symbolic manipulation. We will need the [Symbolics.jl](https://docs.sciml.ai/Symbolics/stable/) package for this and [Latexify.jl](https://korsbo.github.io/Latexify.jl/stable) for optional pretty printing in the notebook:

```julia
using Symbolics, Latexify
```
"""

# ╔═╡ 94d323b9-554f-4620-8900-da7c89ad338d


# ╔═╡ 746e3dae-4bbb-410b-899f-ef95c8afb1b0
md"""
We will use rotation matrices as an example, where `Rx`, `Ry`, and `Rz` are rotations about the ``x``, ``y``, and ``z``-axes:

```julia
begin
    Rx(θ) = [1. 0. 0.; 0. cos(θ) sin(θ); 0. -sin(θ) cos(θ)]

    Ry(θ) = [cos(θ) 0. -sin(θ); 0. 1. 0.; sin(θ) 0. cos(θ)]

    Rz(θ) = [cos(θ) sin(θ) 0.; -sin(θ) cos(θ) 0.; 0. 0. 1.]
end
```
"""

# ╔═╡ d7169595-d401-4fab-8554-d25e3b367583


# ╔═╡ 80335b0c-de35-4133-a32d-c0ccb826a4b3
md"""
Now create symbolic variables for the three equatorial precession angles: `z`, `θ`, and `ζ` defined by *Lieske et al. (1977)*:

```julia
@variables z, θ, ζ
```
"""

# ╔═╡ 8f5f7d12-38eb-49c9-90c6-81d27eda13fe


# ╔═╡ 1b9553dd-149c-4e48-aacf-10d6ca4756c2
md"""
Let's see what the rotation matrix looks like for the three-angle formulation of the precession matrix:

```julia
Rz(-z)Ry(θ)Rz(-ζ)
```
"""

# ╔═╡ 856a6279-6354-48de-85ca-c5638be68c9e


# ╔═╡ 5767f17a-a101-4e02-b4f6-b11ee777882b
md"""
---
"""

# ╔═╡ f80f1bdd-5147-4a6c-8280-09329ed6dba1
md"""
#### GPU Programming

Depending on the GPU that your laptop has, you will need to load one of the following packages:

```julia
using CUDA                 # for NVIDIA
```

```julia
using oneAPI               # for Intel (linux only)
```

```julia
using AMDGPU               # for AMD
```

```julia
using Metal                # Apple Silicon, i.e., M1-4 Mac
```
"""

# ╔═╡ d308df6b-14ec-49ec-8270-a3b9efd88517


# ╔═╡ cfc57dc3-bb97-4bf2-99e8-241e3f552f1e
md"""
Create three large arrays.

```julia
begin
    xlarge = rand(2^20)
    ylarge = rand(2^20)
    outlarge = rand(2^20)
end
```

"""

# ╔═╡ d7ecfac4-8b9b-4b4b-b258-429f417380cc


# ╔═╡ b186c2fa-0ce2-4941-a9fa-a055de7f4ebf
md"""
Now let's load our array onto the GPU. For CUDA:
```julia
begin
    xlarge_gpu   = cu(xlarge)
    ylarge_gpu   = cu(ylarge)
    outlarge_gpu = cu(outlarge)
end
```

For other GPU providers replace `cu` with:
```julia
ROCArray(xlarge)              # AMD
```
```julia
oneArray(xlarge)              # Intel
```
```julia
MtlArray(xlarge)              # Apple Silicon
```
"""

# ╔═╡ ec8dbfe4-15f2-41f6-93be-48486c2bf8fb


# ╔═╡ da2c5d76-2dd3-4f1c-834e-11189793c56f
md"""
For more on GPU programming in Julia, see the [JuliaGPU website](https://juliagpu.org/).
"""

# ╔═╡ 8401d5df-ccb5-4c98-a952-6d71b7a74fa8
md"""
### Summary

!!! note

    What have we learned about the Julia command line and features?

    * Julia has four command line modes: **REPL**, **help**, **shell**, and **package manager**.

    * Julia understands **unicode**.

    * Julia packages are **composable**. It means that independent packages are compatible and work together without modification, as demonstrated by the `Measurements` and `Unitful` packages.

    * Julia can perform symbolic manipulation using the `Symbolics` package.

    * Julia can perform calculations on the GPU without resorting to compiled languages such as C/C++.
"""

# ╔═╡ 11645d9e-637b-47c4-b2e6-8c4a7d9747cb
md"""
### Notebook setup
"""

# ╔═╡ 68d34781-2f21-4356-996f-764ddf3acb4b
notebook_name = "1-1: Introduction"

# ╔═╡ 447f0993-ba7e-40f7-8955-5b5d77749770
timestamp = string("Last updated: ", Dates.format(today(), dateformat"d u Y"))

# ╔═╡ 6001288a-7a9d-4020-bf7d-02a0fa250c04
"""
!!! note "$(notebook_name)"
    **$(timestamp)**
""" |> Markdown.parse

# ╔═╡ b809bdb0-f042-4fd5-ace7-0cf51a587558
TableOfContents(; title = notebook_name, depth = 4)

# ╔═╡ Cell order:
# ╟─6001288a-7a9d-4020-bf7d-02a0fa250c04
# ╟─38ead816-0375-4605-a833-6464485aa0d6
# ╟─95cfbabc-5e7c-481b-853c-6d06baa577b6
# ╟─8e597a38-6e41-499f-af06-f9223b8827de
# ╟─1cc401a1-6d3a-40e5-a4fc-012caa913369
# ╟─b1ed2c4e-f5fa-4e5e-87d8-7af6f80a83ca
# ╟─7f3357bc-4103-4a35-af21-9c86f5a0ec2f
# ╟─7475c896-d1b1-4429-9ba8-8e78de41e0b0
# ╟─5df8264e-6e37-4674-abdf-2b05c530787f
# ╟─f646ca14-c01e-47ee-8e2b-052d9db0985b
# ╠═4a404280-2845-4deb-8eee-2dcdcb9aed27
# ╟─7813824a-cae9-4b97-ac90-e542fbd630d5
# ╠═6ac51e87-87a2-4ccc-9f08-0028700b3cda
# ╟─27208179-35c3-43c1-9548-3620c8aa7680
# ╠═40d8d18c-3713-4e77-812d-9d77a4e1ac50
# ╟─aa3e9db7-49d1-40f8-b745-6c4faa2197e1
# ╠═8eb9630a-44b2-4ac8-b243-0c2ce5b16f50
# ╟─419a6dec-1db0-477f-911f-049223b5674f
# ╟─85f2bec3-0095-4bbc-93ef-48ab97094244
# ╟─8ee7f43d-bf75-4975-ac64-54c2d5a0174a
# ╟─d1e9c51c-efb9-4dcb-9d28-8c54a235fbb4
# ╟─b27578b2-f5f5-4e46-82e6-0007be187ba6
# ╟─065265a5-c9ad-4a39-b14d-f4e2e49d3f7a
# ╟─563f07ad-6aed-495e-85fb-bae4a1755ac2
# ╟─0f94b21c-364f-488e-aff3-28c4b39a3844
# ╠═40abc83f-b4bd-479f-8671-189cc712d792
# ╟─297cd86c-5e9d-4f70-b11a-cbae8fa96d1e
# ╠═8f016c75-7768-4418-8c57-100db3073c85
# ╟─094b6f30-cbd6-46b1-8e0c-3fdb1ef18261
# ╠═7ba8dc19-e0ca-40de-a778-7583ca70978d
# ╟─668abc35-fdc3-430f-8c90-de3c2c2cd77b
# ╠═0e42f7fd-955e-4679-8d90-0cb46c9a12dc
# ╟─d2a2d0bc-e883-439f-8e34-166e2369caef
# ╟─750acbf6-bc04-43ea-b123-14753cab597a
# ╠═88ca2a73-6203-447c-afcc-9e370a82076b
# ╟─c24f1ddd-5e31-4073-a627-86cedb1d44c2
# ╠═63a4b27a-5361-4d95-8787-ae31ca7987fe
# ╟─d65a2638-54c0-4eb5-a870-44d7ab35400c
# ╠═15674bb0-2fe1-40b1-a6c0-3a5a64a6a5c3
# ╟─c07f9493-b867-485b-87f2-50348bb9eaa6
# ╠═70f08712-002c-4adc-84b1-73a8655d8a44
# ╟─6cc63679-6352-4ffa-ae6a-3066431cfd10
# ╟─d961b128-bd38-40dd-8942-da6b7c150c42
# ╟─56f7266f-507f-403c-9875-4aa8f9bb04aa
# ╟─cf4a0e8f-9210-4f1e-84d4-ee7ff09aaf61
# ╠═fdba7211-e480-4948-8435-76a7608e7e63
# ╟─1f90de4b-790b-41f8-9a7b-3a54e9fff472
# ╟─3e8ee79c-c315-4c19-88ad-9b58caa86c40
# ╠═94d323b9-554f-4620-8900-da7c89ad338d
# ╟─746e3dae-4bbb-410b-899f-ef95c8afb1b0
# ╠═d7169595-d401-4fab-8554-d25e3b367583
# ╟─80335b0c-de35-4133-a32d-c0ccb826a4b3
# ╠═8f5f7d12-38eb-49c9-90c6-81d27eda13fe
# ╟─1b9553dd-149c-4e48-aacf-10d6ca4756c2
# ╠═856a6279-6354-48de-85ca-c5638be68c9e
# ╟─5767f17a-a101-4e02-b4f6-b11ee777882b
# ╟─f80f1bdd-5147-4a6c-8280-09329ed6dba1
# ╠═d308df6b-14ec-49ec-8270-a3b9efd88517
# ╟─cfc57dc3-bb97-4bf2-99e8-241e3f552f1e
# ╠═d7ecfac4-8b9b-4b4b-b258-429f417380cc
# ╟─b186c2fa-0ce2-4941-a9fa-a055de7f4ebf
# ╠═ec8dbfe4-15f2-41f6-93be-48486c2bf8fb
# ╟─da2c5d76-2dd3-4f1c-834e-11189793c56f
# ╟─8401d5df-ccb5-4c98-a952-6d71b7a74fa8
# ╟─11645d9e-637b-47c4-b2e6-8c4a7d9747cb
# ╠═b34e164a-da63-4636-b2d3-1d9efc9ae8d6
# ╠═040b953f-8873-441c-a97f-48c1cf45ef03
# ╠═7c4ebc32-9b8e-4b2a-8f39-f4c351283843
# ╟─68d34781-2f21-4356-996f-764ddf3acb4b
# ╟─447f0993-ba7e-40f7-8955-5b5d77749770
# ╠═b809bdb0-f042-4fd5-ace7-0cf51a587558
