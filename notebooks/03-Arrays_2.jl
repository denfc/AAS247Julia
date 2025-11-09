### A Pluto.jl notebook ###
# v0.20.20

using Markdown
using InteractiveUtils

# ╔═╡ 606d3a60-b987-11f0-b09c-ab2e3fa2835d
using DrWatson

# ╔═╡ 3e21eeef-836b-468e-b058-9c26d8f75f01
@quickactivate "AAS247Julia"

# ╔═╡ 157fdc89-ff6f-4e6c-99b0-fc952daa24ef
using PlutoUI

# ╔═╡ 6f4eb353-2426-4a7c-b9e0-431727016bc2
using DelimitedFiles

# ╔═╡ 34562085-6ce2-44d6-84e6-056e9586117c
using CSV

# ╔═╡ 056a608f-18cf-4bcb-8f7e-e0c7a42692f4
using Downloads

# ╔═╡ c47564b1-751b-46e0-883f-86fc11f6abb8
notebookName = "Arrays 2";

# ╔═╡ 56274a04-6ace-477a-a4f4-3acad1a85809
TableOfContents(title = notebookName)

# ╔═╡ 1282f0b4-41a9-46d1-adb2-68638c76da87
md"""
## Loading arrays from files
"""

# ╔═╡ 87c9962d-0a48-4772-ae15-7cd5bf9b21f4
DelimitedFiles.readdlm(datadir("mpcorb.dat"))

# ╔═╡ 79669758-04c2-4617-bdcf-f3d031c9b226
md"""
Most recent EISN data
"""

# ╔═╡ 99893407-4326-43e5-9d90-fb969a6d815e
url = "https://www.sidc.be/SILSO/DATA/EISN/EISN_current.csv"

# ╔═╡ 2854a8cd-4b8a-4fdb-9f92-0a6ddfcf45fa
local_filename = Downloads.download(url)

# ╔═╡ ac4cca94-a416-44bf-8c62-35384adf98f6
CSV.read(local_filename, Tuple, header=false)

# ╔═╡ 2788d2f9-a6b9-4169-85c9-014e5dd565bc
md"""
## Array and tuple comprehensions
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
## Array comprehensions with "if statement"
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
## Array slicing & indexing
"""

# ╔═╡ d1e8e027-ce75-4cee-bbbd-f977e7c4d442
md"""
## Array slicing with boolean array (masking)
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

# ╔═╡ Cell order:
# ╠═606d3a60-b987-11f0-b09c-ab2e3fa2835d
# ╠═3e21eeef-836b-468e-b058-9c26d8f75f01
# ╟─157fdc89-ff6f-4e6c-99b0-fc952daa24ef
# ╟─c47564b1-751b-46e0-883f-86fc11f6abb8
# ╠═56274a04-6ace-477a-a4f4-3acad1a85809
# ╟─1282f0b4-41a9-46d1-adb2-68638c76da87
# ╠═6f4eb353-2426-4a7c-b9e0-431727016bc2
# ╠═87c9962d-0a48-4772-ae15-7cd5bf9b21f4
# ╟─79669758-04c2-4617-bdcf-f3d031c9b226
# ╠═34562085-6ce2-44d6-84e6-056e9586117c
# ╠═056a608f-18cf-4bcb-8f7e-e0c7a42692f4
# ╠═99893407-4326-43e5-9d90-fb969a6d815e
# ╠═2854a8cd-4b8a-4fdb-9f92-0a6ddfcf45fa
# ╠═ac4cca94-a416-44bf-8c62-35384adf98f6
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
# ╠═07be6f13-de1f-495e-b369-a28ec20de28e
# ╠═631fed46-0bb2-44d8-bfc9-6d9929c17ab9
# ╟─bfa7975e-f206-4179-93eb-e0236855c981
# ╟─d1e8e027-ce75-4cee-bbbd-f977e7c4d442
# ╠═ff5ae511-b9ee-46fa-8838-39e44d9fd7f3
# ╠═7635517f-4d73-45ff-89a4-c9bfd6f949e1
# ╠═3d8f63d0-47d8-41bd-9115-0bd67a739fb2
# ╠═84bc669b-bfbb-4880-bbcd-3712b1e3f94e
# ╠═fdd2befd-4317-4710-b7a2-da5c9260cc40
