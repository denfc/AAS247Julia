### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ 189ec852-bf0b-11f0-a069-2def1b4d4791
using DrWatson

# ╔═╡ 169ccf8b-5f34-4e1c-9596-a50c6153b9f1
@quickactivate "AAS247Julia"

# ╔═╡ d5c060c2-f0eb-4829-baa2-abf595983adf
using Markdown

# ╔═╡ d1a478f0-5282-4a8c-b44f-d3297748e9c3
using PlutoUI, HypertextLiteral

# ╔═╡ c8a117d7-790b-433f-9993-9e2f09357b25
md"""
## Type declarations
"""

# ╔═╡ 33a3c28c-7b98-4fa9-8603-d9f8848a523b
md"""
## Type hierarchy
"""

# ╔═╡ fd423ae4-fd20-46dd-9a92-369d69242dde


# ╔═╡ 444a233a-6815-43ce-a9f9-340ccbc7cb65
md"""
# Problems
"""

# ╔═╡ 6d5283e1-cbc8-49c2-a8ff-79e0df888483
md"""
Show the subtype graph for the Integer abstract type, e.g., `subtypes(Integer)`.
"""

# ╔═╡ 9d6a9d57-3d37-40ae-83e1-5630fac51cfb
md"""
Show the subtype graph for the `AbstractFloat` abstract type.
"""

# ╔═╡ eb9f19b4-518f-43bd-9491-fd8bd7727222
md"""
Show the subtype graph for the `Real` abstract type.
"""

# ╔═╡ 5866c023-3dec-4d4c-926d-cc046de788b5
md"""
Show the supertype for `Real`.
"""

# ╔═╡ 4c14ad18-f8ac-4822-b666-87d06f9b6a57
md"""
Show the supertype for `Number`.
"""

# ╔═╡ b4cbf4b0-c118-46f0-9429-94d94f9620d1
md"""
Show the supertype for `Any`.
"""

# ╔═╡ 90f106a9-ae69-446c-982f-1c1637ca157f
md"""
Where is `Any` in the type graph?
"""

# ╔═╡ 2283876d-1b7b-44c5-ab80-cab5853d8b94
md"""
Create a 1D array or vector and show its type, i.e., `typeof(vector)`. Note: What kind of type is it?
"""

# ╔═╡ 623072a7-79af-48f0-a9e0-31345d589e94
md"""
Create a composite type, e.g., `struct AType a::Integer b::String end`, and instantiate it, i.e., `AType(2, "abc")`.
"""

# ╔═╡ e3d0f321-ded7-4355-abdb-d58fbc008cd1
md"""
# Notebook setup
"""

# ╔═╡ 488e18dd-a795-457f-a78c-36090a63d1a1
notebookName = "Types";

# ╔═╡ 520278e3-1521-438a-bdbd-088956a4cc42
"# $notebookName" |> Markdown.parse

# ╔═╡ 56d5d99d-88a6-4e35-92da-3a7a8ba3a0a6
TableOfContents(title = notebookName)

# ╔═╡ Cell order:
# ╟─520278e3-1521-438a-bdbd-088956a4cc42
# ╟─c8a117d7-790b-433f-9993-9e2f09357b25
# ╟─33a3c28c-7b98-4fa9-8603-d9f8848a523b
# ╠═fd423ae4-fd20-46dd-9a92-369d69242dde
# ╟─444a233a-6815-43ce-a9f9-340ccbc7cb65
# ╟─6d5283e1-cbc8-49c2-a8ff-79e0df888483
# ╟─9d6a9d57-3d37-40ae-83e1-5630fac51cfb
# ╟─eb9f19b4-518f-43bd-9491-fd8bd7727222
# ╟─5866c023-3dec-4d4c-926d-cc046de788b5
# ╟─4c14ad18-f8ac-4822-b666-87d06f9b6a57
# ╟─b4cbf4b0-c118-46f0-9429-94d94f9620d1
# ╟─90f106a9-ae69-446c-982f-1c1637ca157f
# ╟─2283876d-1b7b-44c5-ab80-cab5853d8b94
# ╟─623072a7-79af-48f0-a9e0-31345d589e94
# ╟─e3d0f321-ded7-4355-abdb-d58fbc008cd1
# ╠═189ec852-bf0b-11f0-a069-2def1b4d4791
# ╠═169ccf8b-5f34-4e1c-9596-a50c6153b9f1
# ╠═d5c060c2-f0eb-4829-baa2-abf595983adf
# ╠═d1a478f0-5282-4a8c-b44f-d3297748e9c3
# ╠═488e18dd-a795-457f-a78c-36090a63d1a1
# ╠═56d5d99d-88a6-4e35-92da-3a7a8ba3a0a6
