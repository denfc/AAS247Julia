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

# ╔═╡ c47564b1-751b-46e0-883f-86fc11f6abb8
notebookName = "Arrays 2";

# ╔═╡ 56274a04-6ace-477a-a4f4-3acad1a85809
TableOfContents(title = notebookName)

# ╔═╡ 2788d2f9-a6b9-4169-85c9-014e5dd565bc
md"""
## Array and tuple comprehensions
"""

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

# ╔═╡ f8998c4d-d9ca-40bb-8185-8338faa3803f
[x^2 for x in 1:1000 if x % 2 == 0]

# ╔═╡ 7f84fd65-2483-4a20-85aa-0461603459ff
[x^2 for x in 1:1000 if isodd(x)]

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

# ╔═╡ 1282f0b4-41a9-46d1-adb2-68638c76da87
md"""
## Loading arrays from files
"""

# ╔═╡ Cell order:
# ╠═606d3a60-b987-11f0-b09c-ab2e3fa2835d
# ╠═3e21eeef-836b-468e-b058-9c26d8f75f01
# ╟─157fdc89-ff6f-4e6c-99b0-fc952daa24ef
# ╟─c47564b1-751b-46e0-883f-86fc11f6abb8
# ╠═56274a04-6ace-477a-a4f4-3acad1a85809
# ╟─2788d2f9-a6b9-4169-85c9-014e5dd565bc
# ╠═21318464-61e9-4f5c-a07c-b333bd422771
# ╠═64aa1b05-5dfd-4ecc-acec-d7b3af221192
# ╠═8e7a3b6e-f6b1-4d5f-a44d-5ba7c0d6655c
# ╟─7a634fe5-2a4e-4abd-90c8-5a4da31bba1e
# ╠═f8998c4d-d9ca-40bb-8185-8338faa3803f
# ╠═7f84fd65-2483-4a20-85aa-0461603459ff
# ╟─bfa7975e-f206-4179-93eb-e0236855c981
# ╟─d1e8e027-ce75-4cee-bbbd-f977e7c4d442
# ╠═ff5ae511-b9ee-46fa-8838-39e44d9fd7f3
# ╠═7635517f-4d73-45ff-89a4-c9bfd6f949e1
# ╠═3d8f63d0-47d8-41bd-9115-0bd67a739fb2
# ╠═84bc669b-bfbb-4880-bbcd-3712b1e3f94e
# ╠═fdd2befd-4317-4710-b7a2-da5c9260cc40
# ╟─1282f0b4-41a9-46d1-adb2-68638c76da87
