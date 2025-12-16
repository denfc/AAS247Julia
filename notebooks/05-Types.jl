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

# ╔═╡ 189ec852-bf0b-11f0-a069-2def1b4d4791
using DrWatson

# ╔═╡ 169ccf8b-5f34-4e1c-9596-a50c6153b9f1
@quickactivate "AAS247Julia"

# ╔═╡ d5c060c2-f0eb-4829-baa2-abf595983adf
using Markdown

# ╔═╡ d1a478f0-5282-4a8c-b44f-d3297748e9c3
using Dates, PlutoUI, HypertextLiteral

# ╔═╡ 6714345c-947e-45c7-a4ed-bd7b668ac4ef
md" ##### Begin New Coding Here"

# ╔═╡ c8a117d7-790b-433f-9993-9e2f09357b25
md"""
### Type declarations
"""

# ╔═╡ 33a3c28c-7b98-4fa9-8603-d9f8848a523b
md"""
### Type hierarchy
"""

# ╔═╡ fd423ae4-fd20-46dd-9a92-369d69242dde


# ╔═╡ 444a233a-6815-43ce-a9f9-340ccbc7cb65
md"""
## Problems
"""

# ╔═╡ 0090a6e4-75d8-400f-82ce-bdd541d5f320
md"""
### Problem 1: Subtypes
"""

# ╔═╡ 6d5283e1-cbc8-49c2-a8ff-79e0df888483
md"""
!!! warning ""
    - Show the subtype graph for the Integer abstract type, e.g., `subtypes(Integer)`.
    - Show the subtype graph for the `AbstractFloat` abstract type.
    - Show the subtype graph for the `Real` abstract type.
"""

# ╔═╡ 9d6a9d57-3d37-40ae-83e1-5630fac51cfb


# ╔═╡ 56f44662-79fd-459c-b258-240dd2f33727
md"""
### Problem 2: Supertypes
"""

# ╔═╡ 5866c023-3dec-4d4c-926d-cc046de788b5
md"""
!!! warning ""
    - Show the supertype for `Real`.
    - Show the supertype for `Number`.
    - Show *all* the supertypes of `Float32`.
    - Show the supertype for `Any`.
"""

# ╔═╡ b4cbf4b0-c118-46f0-9429-94d94f9620d1


# ╔═╡ 90f106a9-ae69-446c-982f-1c1637ca157f
md"""
!!! warning ""
    Where is `Any` in the type graph?
"""

# ╔═╡ 83634592-4da6-41ca-ae82-f28f68a5c5bb
md"""
### Problem 3: Composite types
"""

# ╔═╡ 2283876d-1b7b-44c5-ab80-cab5853d8b94
md"""
!!! warning ""
    Create a 1D array or vector and show its type, i.e., `typeof(vector)`. Note: What kind of type is it?
"""

# ╔═╡ eca426ef-e2f3-449f-867f-3951b3373174


# ╔═╡ 623072a7-79af-48f0-a9e0-31345d589e94
md"""
!!! warning ""
    Create a composite type, e.g., `struct AType a::Integer b::String end`, and instantiate it, i.e., `AType(2, "abc")`.
"""

# ╔═╡ bce6847a-0d49-455d-b606-0c52c65e3d6d
md"""
----
"""

# ╔═╡ e3d0f321-ded7-4355-abdb-d58fbc008cd1
md"""
## Notebook setup
"""

# ╔═╡ 488e18dd-a795-457f-a78c-36090a63d1a1
notebookName = "1-5: Types"

# ╔═╡ d8f48cb6-9278-4b42-aa99-ad093e49e263
timestamp = Dates.format(today(), dateformat"d u Y")

# ╔═╡ 520278e3-1521-438a-bdbd-088956a4cc42
"""
!!! note "$notebookName"
    **Last Updated: $(timestamp)**
""" |> Markdown.parse

# ╔═╡ 56d5d99d-88a6-4e35-92da-3a7a8ba3a0a6
TableOfContents(title = notebookName; depth = 4)

# ╔═╡ c8f4b433-f298-4f8d-8f36-814f62fbb905
md"""
Widening sliders
"""

# ╔═╡ 03432019-214a-43ac-990a-63bf3ddc1ae2
cellWidthSlider = @bind cellWidth Slider(500:25:1500, show_value=true, default=800);

# ╔═╡ 7ab9c901-080f-4179-a552-6dfdd6e6e699
leftMarginSlider = @bind leftMargin Slider(-250:25:100, show_value=true, default=0);

# ╔═╡ a4f60d04-459d-4dc8-ab38-1a6195b846d3
md"""
###### Cell width sliders
- cell width: $cellWidthSlider
- left margin: $leftMarginSlider
"""

# ╔═╡ 39ad66e4-7474-47e9-b7e9-026c888c5434
begin
    @bind screenWidth @htl("""
    <div>
        <script>
            var div = currentScript.parentElement
            div.value = screen.width
        </script>
    </div>
    """)
    # cellWidth = min(1000, screenWidth * 0.50)
    @htl("""
    <style>
    pluto-notebook {
        margin-left: $(leftMargin)px;
        # margin: auto;
        width: $(cellWidth)px;
    }
    </style>
    Widening cell.
    """)
end

# ╔═╡ Cell order:
# ╟─520278e3-1521-438a-bdbd-088956a4cc42
# ╟─a4f60d04-459d-4dc8-ab38-1a6195b846d3
# ╟─6714345c-947e-45c7-a4ed-bd7b668ac4ef
# ╟─c8a117d7-790b-433f-9993-9e2f09357b25
# ╟─33a3c28c-7b98-4fa9-8603-d9f8848a523b
# ╠═fd423ae4-fd20-46dd-9a92-369d69242dde
# ╟─444a233a-6815-43ce-a9f9-340ccbc7cb65
# ╟─0090a6e4-75d8-400f-82ce-bdd541d5f320
# ╟─6d5283e1-cbc8-49c2-a8ff-79e0df888483
# ╠═9d6a9d57-3d37-40ae-83e1-5630fac51cfb
# ╟─56f44662-79fd-459c-b258-240dd2f33727
# ╟─5866c023-3dec-4d4c-926d-cc046de788b5
# ╠═b4cbf4b0-c118-46f0-9429-94d94f9620d1
# ╟─90f106a9-ae69-446c-982f-1c1637ca157f
# ╟─83634592-4da6-41ca-ae82-f28f68a5c5bb
# ╟─2283876d-1b7b-44c5-ab80-cab5853d8b94
# ╠═eca426ef-e2f3-449f-867f-3951b3373174
# ╟─623072a7-79af-48f0-a9e0-31345d589e94
# ╟─bce6847a-0d49-455d-b606-0c52c65e3d6d
# ╟─e3d0f321-ded7-4355-abdb-d58fbc008cd1
# ╠═189ec852-bf0b-11f0-a069-2def1b4d4791
# ╠═169ccf8b-5f34-4e1c-9596-a50c6153b9f1
# ╠═d5c060c2-f0eb-4829-baa2-abf595983adf
# ╠═d1a478f0-5282-4a8c-b44f-d3297748e9c3
# ╟─488e18dd-a795-457f-a78c-36090a63d1a1
# ╟─d8f48cb6-9278-4b42-aa99-ad093e49e263
# ╠═56d5d99d-88a6-4e35-92da-3a7a8ba3a0a6
# ╟─39ad66e4-7474-47e9-b7e9-026c888c5434
# ╟─c8f4b433-f298-4f8d-8f36-814f62fbb905
# ╠═03432019-214a-43ac-990a-63bf3ddc1ae2
# ╠═7ab9c901-080f-4179-a552-6dfdd6e6e699
