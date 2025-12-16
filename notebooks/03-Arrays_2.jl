### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 606d3a60-b987-11f0-b09c-ab2e3fa2835d
using DrWatson

# ╔═╡ 3e21eeef-836b-468e-b058-9c26d8f75f01
@quickactivate "AAS247Julia"

# ╔═╡ 34562085-6ce2-44d6-84e6-056e9586117c
using CSV

# ╔═╡ 056a608f-18cf-4bcb-8f7e-e0c7a42692f4
using Downloads

# ╔═╡ 218c497d-d81a-40fe-b47a-5c59dbab2f09
using Markdown

# ╔═╡ 157fdc89-ff6f-4e6c-99b0-fc952daa24ef
using Dates, PlutoUI, HypertextLiteral

# ╔═╡ 1282f0b4-41a9-46d1-adb2-68638c76da87
md"""
### Loading arrays from files
"""

# ╔═╡ 75bc0795-bb17-48ed-92a8-98fed069ae4e
md"""
Scientific data is stored in a variety of formats, fixed-width, CSV, and FITS among them. Let's take a look at how to read a fixed-width file using Julia.

First, we'll use DrWatson.jl's `datadir()` function to get the path to our data file.

```julia
datafilepath = datadir("mpcorb.dat")
```
"""

# ╔═╡ 23fe0075-8eb4-4a0c-8711-7fa9a4bf3d20


# ╔═╡ 2aa6465f-7e79-4060-9d6b-d8ab1a792c64
md"""
Now, we can use the built-in DelimitedFiles package and its `readdlm()` function to read in the data.
```julia
using DelimitedFiles
DelimitedFiles.readdlm(datadir("mpcorb.dat"))
```
"""

# ╔═╡ 6f4eb353-2426-4a7c-b9e0-431727016bc2


# ╔═╡ 87c9962d-0a48-4772-ae15-7cd5bf9b21f4


# ╔═╡ 9e24d1be-7c2d-478c-b2b7-b112d15915e7
md"""
We can see that the first row is just headers, so we can select everything from the second row onwards and put it in a variable
```julia
mat = DelimitedFiles.readdlm(datadir("mpcorb.dat"))[2:end]
```
"""

# ╔═╡ 2f06b1c3-3ba6-4abf-aa72-9a8a8baf1556


# ╔═╡ 79669758-04c2-4617-bdcf-f3d031c9b226
md"""
Most recent EISN data
"""

# ╔═╡ 99893407-4326-43e5-9d90-fb969a6d815e
url = "https://www.sidc.be/SILSO/DATA/EISN/EISN_current.csv"

# ╔═╡ 2854a8cd-4b8a-4fdb-9f92-0a6ddfcf45fa
local_filename = Downloads.download(url)

# ╔═╡ ac4cca94-a416-44bf-8c62-35384adf98f6
csv_tuple = CSV.read(local_filename, Tuple, header=false)

# ╔═╡ 717ec41c-f524-4556-b316-32aa804f0c88
reduce(hcat, csv_tuple[1:end-1])

# ╔═╡ 2788d2f9-a6b9-4169-85c9-014e5dd565bc
md"""
### Array and tuple comprehensions
"""

# ╔═╡ a42c9932-65e5-4d7b-946e-4e1f81a364db
md"""
In Julia, much like in Python, you can use "comprehensions" to create arrays. The syntax is borrowed from set-builder notation in mathematics, where you can define new sets from existing ones like so:
```math
E = \{2n \mid n ∈ \mathbb{Z} \}
```
where ``\mathbb{Z}`` is the set of all integers, and so ``E`` is the set of all even numbers.
"""

# ╔═╡ e6af4614-6b62-44ba-a5ef-daccd6f8c9a8
md"""
In Julia, the comprehension syntax is also quite like Python's
```julia
[func(x) for x in x_arr]
```
where `x_arr` doesn't necessarily have to be an array itself, it can be any iterable object.
"""

# ╔═╡ 90e715fb-eeca-4275-87dd-8c70234acea2
[x^2 for x in 1:10]

# ╔═╡ 21318464-61e9-4f5c-a07c-b333bd422771
[-sinpi(x) for x in rand(44)]

# ╔═╡ 64aa1b05-5dfd-4ecc-acec-d7b3af221192
(-sinpi(x) for x in rand(44))

# ╔═╡ 8e7a3b6e-f6b1-4d5f-a44d-5ba7c0d6655c
Tuple(-sinpi(x) for x in rand(44))

# ╔═╡ 7a634fe5-2a4e-4abd-90c8-5a4da31bba1e
md"""
### Array comprehensions with "if statement"
"""

# ╔═╡ f13e35cf-d75f-4d56-82d6-1e1d52934512
md"""
We can also filter out elements by using a conditional after the `for ... in ...` part. The following two examples gets all of the squares of the even and odd numbers respectively from 1 to 1000.
"""

# ╔═╡ f8998c4d-d9ca-40bb-8185-8338faa3803f
[x^2 for x in 1:1000 if x % 2 == 0]

# ╔═╡ 7f84fd65-2483-4a20-85aa-0461603459ff
[x^2 for x in 1:1000 if isodd(x)]

# ╔═╡ 07be6f13-de1f-495e-b369-a28ec20de28e
md"""
Another option to pick out only certain elements of an array is to use the built-in `filter()` function.
"""

# ╔═╡ 631fed46-0bb2-44d8-bfc9-6d9929c17ab9


# ╔═╡ bfa7975e-f206-4179-93eb-e0236855c981
md"""
### Array slicing & indexing
"""

# ╔═╡ d1e8e027-ce75-4cee-bbbd-f977e7c4d442
md"""
### Array slicing with boolean array (masking)
"""

# ╔═╡ ff5ae511-b9ee-46fa-8838-39e44d9fd7f3
rolls = rand(1:20, 100)

# ╔═╡ 7635517f-4d73-45ff-89a4-c9bfd6f949e1
mask = rolls .< 5

# ╔═╡ 3d8f63d0-47d8-41bd-9115-0bd67a739fb2
damages = rand(1:100, 100)

# ╔═╡ 84bc669b-bfbb-4880-bbcd-3712b1e3f94e
rolls[mask]

# ╔═╡ fdd2befd-4317-4710-b7a2-da5c9260cc40
damages[mask]

# ╔═╡ c5e7ec5b-fc9b-46fb-8708-4cf9d80387e3
md"""
## Problems
"""

# ╔═╡ cee1d2fd-cea3-4fbf-bdd6-1d0286f84f69
md"""
### Problem 1: Cartesian indexing
"""

# ╔═╡ 59e1b957-ec35-48ba-8349-216750ead10f
md"""
### Problem 2: Identity matrix
"""

# ╔═╡ 90b215d2-733e-4a7c-a9f6-f2d3c6ef3cd5
md"""
### Problem 3: Using LinearAlgebra.jl
"""

# ╔═╡ 9f6c71ca-6de0-453d-9ad3-4996e2a2001b
md"""
## Notebook setup
"""

# ╔═╡ c47564b1-751b-46e0-883f-86fc11f6abb8
notebookName = "1-3: Arrays 2"

# ╔═╡ c4e5e3b5-7b0a-4b27-8781-6e12e11c5f4e
timestamp = Dates.format(today(), dateformat"d u Y")

# ╔═╡ d046592d-9786-4675-b8bd-26848fcb6a50
"""
!!! note "$notebookName"
    **Last Updated: $(timestamp)**
""" |> Markdown.parse

# ╔═╡ 56274a04-6ace-477a-a4f4-3acad1a85809
TableOfContents(title = notebookName, depth = 4)

# ╔═╡ 462886b6-2317-4e94-804c-483251ece497
md"""
Widening sliders
"""

# ╔═╡ ed2f25e4-ffcf-4e6e-bf18-046906f05a84
cellWidthSlider = @bind cellWidth Slider(500:25:1500, show_value=true, default=800);

# ╔═╡ a2dfca01-81f6-45e4-aa5e-da24c8ae5871
leftMarginSlider = @bind leftMargin Slider(-250:25:100, show_value=true, default=0);

# ╔═╡ 6dab8c14-64c1-4518-aea4-c3502787851e
md"""
###### Cell width sliders
- cell width: $cellWidthSlider
- left margin: $leftMarginSlider
"""

# ╔═╡ 62d434d4-93bb-49f1-a6ee-a7499b58aa92
@htl("""
<style>
pluto-notebook {
    margin-left: $(leftMargin)px;
    # margin: auto;
    width: $(cellWidth)px;
}
</style>
Widening cell
""")

# ╔═╡ Cell order:
# ╟─d046592d-9786-4675-b8bd-26848fcb6a50
# ╟─6dab8c14-64c1-4518-aea4-c3502787851e
# ╟─1282f0b4-41a9-46d1-adb2-68638c76da87
# ╟─75bc0795-bb17-48ed-92a8-98fed069ae4e
# ╠═23fe0075-8eb4-4a0c-8711-7fa9a4bf3d20
# ╟─2aa6465f-7e79-4060-9d6b-d8ab1a792c64
# ╠═6f4eb353-2426-4a7c-b9e0-431727016bc2
# ╠═87c9962d-0a48-4772-ae15-7cd5bf9b21f4
# ╟─9e24d1be-7c2d-478c-b2b7-b112d15915e7
# ╠═2f06b1c3-3ba6-4abf-aa72-9a8a8baf1556
# ╟─79669758-04c2-4617-bdcf-f3d031c9b226
# ╠═34562085-6ce2-44d6-84e6-056e9586117c
# ╠═056a608f-18cf-4bcb-8f7e-e0c7a42692f4
# ╠═99893407-4326-43e5-9d90-fb969a6d815e
# ╠═2854a8cd-4b8a-4fdb-9f92-0a6ddfcf45fa
# ╠═ac4cca94-a416-44bf-8c62-35384adf98f6
# ╠═717ec41c-f524-4556-b316-32aa804f0c88
# ╟─2788d2f9-a6b9-4169-85c9-014e5dd565bc
# ╟─a42c9932-65e5-4d7b-946e-4e1f81a364db
# ╟─e6af4614-6b62-44ba-a5ef-daccd6f8c9a8
# ╠═90e715fb-eeca-4275-87dd-8c70234acea2
# ╠═21318464-61e9-4f5c-a07c-b333bd422771
# ╠═64aa1b05-5dfd-4ecc-acec-d7b3af221192
# ╠═8e7a3b6e-f6b1-4d5f-a44d-5ba7c0d6655c
# ╟─7a634fe5-2a4e-4abd-90c8-5a4da31bba1e
# ╟─f13e35cf-d75f-4d56-82d6-1e1d52934512
# ╠═f8998c4d-d9ca-40bb-8185-8338faa3803f
# ╠═7f84fd65-2483-4a20-85aa-0461603459ff
# ╟─07be6f13-de1f-495e-b369-a28ec20de28e
# ╠═631fed46-0bb2-44d8-bfc9-6d9929c17ab9
# ╟─bfa7975e-f206-4179-93eb-e0236855c981
# ╟─d1e8e027-ce75-4cee-bbbd-f977e7c4d442
# ╠═ff5ae511-b9ee-46fa-8838-39e44d9fd7f3
# ╠═7635517f-4d73-45ff-89a4-c9bfd6f949e1
# ╠═3d8f63d0-47d8-41bd-9115-0bd67a739fb2
# ╠═84bc669b-bfbb-4880-bbcd-3712b1e3f94e
# ╠═fdd2befd-4317-4710-b7a2-da5c9260cc40
# ╟─c5e7ec5b-fc9b-46fb-8708-4cf9d80387e3
# ╟─cee1d2fd-cea3-4fbf-bdd6-1d0286f84f69
# ╟─59e1b957-ec35-48ba-8349-216750ead10f
# ╟─90b215d2-733e-4a7c-a9f6-f2d3c6ef3cd5
# ╟─9f6c71ca-6de0-453d-9ad3-4996e2a2001b
# ╠═606d3a60-b987-11f0-b09c-ab2e3fa2835d
# ╠═3e21eeef-836b-468e-b058-9c26d8f75f01
# ╠═218c497d-d81a-40fe-b47a-5c59dbab2f09
# ╠═157fdc89-ff6f-4e6c-99b0-fc952daa24ef
# ╟─c47564b1-751b-46e0-883f-86fc11f6abb8
# ╟─c4e5e3b5-7b0a-4b27-8781-6e12e11c5f4e
# ╠═56274a04-6ace-477a-a4f4-3acad1a85809
# ╟─62d434d4-93bb-49f1-a6ee-a7499b58aa92
# ╟─462886b6-2317-4e94-804c-483251ece497
# ╠═ed2f25e4-ffcf-4e6e-bf18-046906f05a84
# ╠═a2dfca01-81f6-45e4-aa5e-da24c8ae5871
