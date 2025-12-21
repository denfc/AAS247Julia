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

<<<<<<< Updated upstream
=======
# ╔═╡ dbb04803-2fc3-4455-99e6-ac78360a200f
using DrWatson

>>>>>>> Stashed changes
# ╔═╡ e186986e-ae37-47ad-b44c-2d7d1078b3cd
using PlutoUI, HypertextLiteral, Revise

# ╔═╡ 624bd571-c51e-4f52-848b-7cdefebbd42a
using Dates

# ╔═╡ e133c0fe-39b7-400e-9e20-f7506603e17d
md" ##### Begin New Coding Here"

# ╔═╡ b28ecc8b-c27f-4446-961d-a187f28cf97a
md"""
### 0. Array Topics
!!! note ""
	Julia is built for high-performance scientific computing, and at the heart of that is its array implementation. Understanding how Julia thinks about arrays will make your code simpler, more readable, and fast.

	We'll cover six key topics:

	1. Multidimensional Arrays.

	1. Julia's "Mathematics Protocol": 1-Indexing and Column-Major Order.

	1. Array Creation with "," and ";".

	1. Broadcasting with the . (dot) operator.

	1. Array Fusion and its performance (especially vs. Python).

	1. Matrix Multiplication with the * operator.

!!! warning ""
	If you want to go straight to the problems based on these topics, go [here.](#Problem-1:-Creation-and-Indexing-(Column-Major))
"""

# ╔═╡ 2675d602-810c-4320-971c-902c3327a5cb
md"""
### 1. Multidimensional Arrays
In Julia, an array is a collection of objects stored in a multi-dimensional grid.

1. A 1D array is a Vector, i.e., as a single list or column of numbers.

2. A 2D array is a Matrix, i.e., rows and columns.

3. A 3D array is a cube of numbers, but of course one can keep going to 4D, 5D, or any number of dimensions.

We interact with these using square brackets `[]` for indexing, e.g., `A[2]` gets the second element of a vector. `M[2, 3]` gets the element at the second row, third column of a matrix.
"""

# ╔═╡ 346cb64d-3c89-44d1-9edb-06354152243a
md"""
### 2. The Julia "Mathematics Protocol"

Julia's arrays behave differently from arrays in languages like Python, C, or Java. Julia's design follows the conventions of mathematics and linear algebra, which has two major consequences.

1. 1-Based Indexing

   The first element of an array is at index 1.

   1. `my_vector[1]` is the first element.

   2. `my_matrix[1, 1]` is the top-left element.

   Python and C use 0-based indexing (where `my_array[0]` is the first element). This 1-based system may be more intuitive for mathematicians and scientists who are used to notation such as ``A_{ij}``, where $i$ and $j$ start at 1.

2. Column-Major Order

   This is one secret to Julia's performance. It describes how arrays are physically laid out in your computer's memory.

   1. Row-major order (used by Python's NumPy, C): Elements of a row are grouped together in memory. The computer stores [row1, row2, row3].

   2. Column-major order (used by Julia, MATLAB, Fortran): Elements of a column are grouped together. The computer stores [col1, col2, col3].

Why does this matter? Accessing memory that is close together is typically much faster (due to CPU caching) than accessing memory that is spread out.

In Julia, this means that looping down a column, i.e., through the rows, is fast.
"""

# ╔═╡ 977537f7-3358-4598-afb8-3d421c12f565
md"""
``` julia
# Accessing memory sequentially is better, e.g.,
for j in 1:numCols
	for i in 1:numRows
		A[i, j] ...
	end
end
```
"""

# ╔═╡ 11832b60-4906-4d22-960b-0b16b6634011
md"""
### 3. Array Creation
1. You can create arrays with functions like `zeros(2, 3)` or `rand(3, 3)`. But for literal arrays, we use `[]` with two simple rules:

   1. Commas (`,`) separate elements in a 1D Vector.
   2. Spaces separate elements in a row (i.e., new columns).

2. Semicolons (`;`) separate rows.

The four following examples show array creation.
!!! note ""
	`[1, 2, 3]`, with commas, gives a 1D Vector, while `[1; 2; 3]`, with semicolons, gives a 2D, 3×1 Matrix. The 1D Vector is "dimensionless" and often acts like a column vector in math operations, which is very convenient.
"""

# ╔═╡ b6f5c9c6-669e-4a67-b429-cf8e85d00c08
md"1: A 1D Vector (using commas) produces a 3-element Vector{Int64}, `v = [1, 2, 3]`, yields"

# ╔═╡ 5a1ad46c-d500-4762-920f-812ebff350e4
begin
	v = [1, 2, 3]
	display(v)
	println()
	println("typeof(v) = $(typeof(v)))")
end

# ╔═╡ f542c713-f23d-4d9d-a271-e54d77c600d3
md"2: A 2D Matrix (using spaces for columns and semicolons for rows) produces a 2×3 Matrix{Int64}: `m = [1 2 3; 4 5 6]` yields "

# ╔═╡ 40481932-af01-4981-8911-e6e35121ff9e
begin
	m = [1 2 3; 4 5 6]
	display(m)
	println()
	println("typeof(m) =  $(typeof(m))")
end

# ╔═╡ 35a57b0a-87c6-448a-a3a9-5a8abca24bfd
md"3: A 1x3 Row Vector (Matrix) produces a 1×3 Matrix{Int64}: `row_vec = [1 2 3]` yields"

# ╔═╡ 8e2946d7-bdd1-4c87-9831-2b4bf2d53a0f
begin
	row_vec = [1 2 3]
	display(row_vec)
	println()
	println("typeof(row_vec) = ", typeof(row_vec))
end

# ╔═╡ 1d9f1425-ea25-4392-b681-9660217d25d2
md"4: A 3x1 Column Vector (Matrix) produces a 3×1 Matrix{Int64}: `col_vec = [1; 2; 3]` yields"

# ╔═╡ 3230a371-8901-41a0-8bd8-36965851eaca
begin
	col_vec = [1; 2; 3]
	display(col_vec)
	println()
	println("typeof(col_vec) = ", typeof(col_vec))
end

# ╔═╡ d5268417-62f9-4fa8-beac-c4d4b9007223
md"""
### 4. Array Broadcasting (The Dot: "`.`")
This is arguably the most important feature for clean, fast array code.

What if you have a vector `A = [1, 2, 3]` and you want to add 1 to every element? Or what if you want to multiply every element in an array by its corresponding element in another array?

The dot (`.`) operator tells Julia: "Apply this operation to _every single element_ of the array." We call using the dot operator "broadcasting".

 1. `A .+ 1` means `[A[1]+1, A[2]+1, A[3]+1]` $\rightarrow$ `[2, 3, 4]`
 2. `A .* B` means element-by-element multiplication.

You can "dot" any function, including your own: `my_function.(my_array)`.
"""

# ╔═╡ 8a5d4ccf-a3b2-4373-822d-dbf5254bf4b0
md"""

### 5. Array Fusion (Performance vs. Python)
This is where the magic happens. What happens if you chain multiple "dotted" operations?

```julia
A = rand(1000)
B = rand(1000)
C = rand(1000)
D = A .* B .+ C
```
Let's compare how Python (with NumPy) and Julia handle this.

In Python (NumPy): `D = A * B + C`

1. Python first calculates `T = A * B`. It creates a new temporary array `T` in memory to store this result.
2. Then, it calculates `D = T + C`. It creates the final array `D`.
3. This took two passes over the data and allocated a temporary array `T` of 1000 elements, which is then thrown away. This is slow and memory-intensive.

In Julia: `D = A .* B .+ C`

1. Julia sees the "chain of dots" and performs loop fusion.
2. It knows you want to do `D[i] = A[i] * B[i] + C[i]` for every element.
3. It compiles this down to a single, efficient for-loop:

```julia
# This is what Julia effectively runs:
D = similar(A) # Allocate D *once*
for i in 1:length(A)
	D[i] = A[i] * B[i] + C[i]
end
```
"""

# ╔═╡ 65151aba-d946-401d-8cca-1874f38146f2
md"""
### 6. Matrix Multiplication (`*`)
We just learned that `A .* B` is the element-wise product.

So, how do we do standard, linear algebra matrix multiplication?

We use the asterisk (`*`) operator without the dot.
"""

# ╔═╡ d46a4d5c-4324-48c8-9851-d486495ec5dc
begin
	A = [1 2; 3 4]
	B = [5 6; 7 8]

	# Element-wise product
	C = A .* B
end

# ╔═╡ 9ff79fb3-7415-44db-9427-853296f9fb6e
# Matrix multiplication
D = A * B

# ╔═╡ 29e28885-d969-4e27-b5d3-866eb25302ab
md"""
!!! note "Summary"
	a) `.*` (dot): Broadcasting, i.e., use for element-wide operations.

	b) `*` (no dot): use for Linear Algebra / Matrix Multiplication.

	c) (But also use `*` to join strings.)
"""

# ╔═╡ f4c82ed6-bfb7-4600-b9c6-b29627de74f4
md"""
## Problems
"""

# ╔═╡ 974bb44d-420c-460d-b626-707909568554
md"""
!!! danger "Review: Six Problems"
	Remember that you can always get to help by typing `?` in the REPL and typing the command name for which you desire assistance.
"""

# ╔═╡ e3b1c6c2-5631-42c0-9a1b-d5a5520466c8
md"""
### Problem 1: Creation and Indexing (Column-Major)
!!! warning ""
	1. Create a 3×3 matrix named `M` containing the numbers 1 through 9. Important: The numbers should fill the matrix column-by-column (i.e., 1, 2, 3 should be in the first column).
	   - Hint: The function `reshape(A, rows, cols)` is your friend here. Try `reshape(1:9, 3, 3)`.
	2. Print the element at the 1st row, 3rd column. (What do you expect it to be?)
	3. Print the entire 2nd column of `M`.
	   - Hint: The `:` operator means "all". `M[row_index, col_index]`.
"""

# ╔═╡ ff17e921-4522-4ab3-8282-9d9aafecdbe9
md"""
### Problem 2: Broadcasting and Fusion
!!! warning ""
	1. Create a 1D vector `x` containing five evenly spaced points from 0 to $\pi$, inclusive.
	   - Hint: `pi` is a built-in constant. The `range()` function might be useful: `range(start, stop, length)`. Or just type it manually.
	1. Define a simple function `my_poly(x) = x^2 - 2*x + 1`.
	1. Using broadcasting, apply your function `my_poly` to every element in `x`. Store the result in `y`.
	1. Print both `x` and `y`.

"""

# ╔═╡ 23069d06-9d74-4a39-912e-e6372ac03abb
md"""
### Problem 3: Array Creation and Slicing
!!! warning ""
	1. Create a 4×2 matrix named `A` containing the numbers 1-8, filling by columns. (Again, `reshape` is great for this).
	1. Create a 1D Vector named `v` containing the elements 10, 20, 30 using comma (`,`) syntax.
	1. Create a 2×1 Matrix (a column matrix) named `c` containing the elements 40 and 50 using semicolon (`;`) syntax.
	1. Create a new matrix `B` that consists of the last two rows of `A`.
	   - Hint: You can use the `end` keyword for indexing, like `A[end-1, :]`.
"""


# ╔═╡ e022f21e-7f18-4690-99d4-0141403b3b38
md"""
### Problem 4: Matrix Math vs. Element-wise Math
!!! warning ""
	1. Create two 2×2 matrices:
	   - `X = [1 2; 3 4]`
	   - `Y = [2 0; 0 2] # This is a scaling matrix.`
	2. Calculate the matrix multiplication `M = X * Y`.
	3. Calculate the element-wise multiplication `E = X .* Y`.
	4. Print both `M` and `E`. Look at `M[1, 1]` and `E[1, 1]`. Why are they different? (You just need to think about this; you don't need to write the answer).

"""

# ╔═╡ 1416a80e-dbda-4185-8984-7f5de3c58f02
md"""
### Problem 5: Broadcasting and Fusion
!!! warning ""
	1. Create three 1D vectors, `a`, `b`, and `c`, each of length 4.
	   - `a = [1.0, 2.0, 3.0, 4.0]`
	   - `b = [0.1, 0.2, 0.3, 0.4]`
	   - `c = [10.0, 10.0, 10.0, 10.0]`
	2. Using a single, "fused" broadcast expression, calculate the value y for each element according to the formula: $y = {(a^2 + b)}/{c}$
	3. Print the resulting vector `y`.
	   - Hint: Remember to "dot" (`.`) every operation (`^`, `+`, `/`) to apply it element-wise.
"""

# ╔═╡ cc640d51-f3d1-4d9e-bd6d-4fd7aa338f07
md"""
### Problem 6: Column-Major Thinking (A Thought Experiment)
!!! warning ""
	1. Imagine you have a 10,000 × 10,000 matrix called `DATA`.
	1. You need to write a for loop to calculate the sum of every element in the second column. (One might use the `size` command.)
	1. Write this loop.
	   - Hint: You only need one loop. Which index (row or column) should be fixed? Which one should your loop iterate over? Will this loop be fast or slow according to Julia's memory layout?
"""

# ╔═╡ 75a587fc-cd2d-4205-bd2e-8fc770a63dcf
md"""
## Notebook setup
"""

<<<<<<< Updated upstream
# ╔═╡ dbb04803-2fc3-4455-99e6-ac78360a200f
# using DrWatson

# ╔═╡ 533bf41f-0dc3-42e3-af5c-344163e950b1
# @quickactivate "AAS247Julia" # When running a script in the REPL, this command activates the project environment so that all pre-loaded packages are available.  Despire the help file's saying, "Pluto.jl understands the @quickactivate macro and will switch to using the standard Julia package manager once it encounters it (or quickactivate)," it seems to be preventing the automatic downloading of packages that Pluto effects.  Perhaps it has not caught up to the most recent Julia update(s) and so for now (19 Dec), at least, both it and DrWatson (cell above) have been commented out.
=======
# ╔═╡ 533bf41f-0dc3-42e3-af5c-344163e950b1
# ╠═╡ disabled = true
#=╠═╡
@quickactivate "AAS247Julia"
  ╠═╡ =#
>>>>>>> Stashed changes

# ╔═╡ 84ecbeb2-f601-4945-8ed0-6dcf103d97da
notebookName = "1-2: Arrays 1"

# ╔═╡ f124d454-a47e-446a-95f4-6793e9fd5b13
timestamp = Dates.format(today(), dateformat"d u Y")

# ╔═╡ e984391b-0c01-4dc8-85aa-3593027e8530
"""
!!! note "$notebookName"
    **Last Updated: $(timestamp)**
""" |> Markdown.parse

# ╔═╡ 0fe8eafe-871b-40a2-ad45-3a27e0566533
TableOfContents(title = notebookName, depth = 4)

# ╔═╡ 650767d3-3e8e-4351-a249-8e11c1037385
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

<<<<<<< Updated upstream
# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Revise = "295af30f-e4ad-537b-8983-00126c2a3abe"

[compat]
HypertextLiteral = "~0.9.5"
PlutoUI = "~0.7.76"
Revise = "~3.12.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.3"
manifest_format = "2.0"
project_hash = "dc752d4ce103266d28456068d6fde0a1741adaa5"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "b7231a755812695b8046e8471ddc34c8268cbad5"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "3.0.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.Compiler]]
git-tree-sha1 = "382d79bfe72a406294faca39ef0c3cef6e6ce1f1"
uuid = "807dbc54-b67e-4c79-8afb-eafe4df6f2e1"
version = "0.1.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "0ee181ec08df7d7c911901ea38baf16f755114dc"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "1.0.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "80580012d4ed5a3e8b18c7cd86cebe4b816d17a6"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.10.9"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.15.0+0"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "OpenSSL_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.3+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoweredCodeUtils]]
deps = ["CodeTracking", "Compiler", "JuliaInterpreter"]
git-tree-sha1 = "65ae3db6ab0e5b1b5f217043c558d9d1d33cc88d"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.5.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.5.20"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.4+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "05868e21324cede2207c6f0f466b4bfef6d5e7ee"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.12.1"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "0d751d4ceb9dbd402646886332c2f99169dc1cfd"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.76"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.REPL]]
deps = ["InteractiveUtils", "JuliaSyntaxHighlighting", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.Revise]]
deps = ["CodeTracking", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "ff0bd131abc4ebd9b66d2033144bed6d011d5074"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.12.3"

    [deps.Revise.extensions]
    DistributedExt = "Distributed"

    [deps.Revise.weakdeps]
    Distributed = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "311349fd1c93a31f783f977a71e8b062a57d4101"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.13"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.1+2"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.7.0+0"
=======
# ╔═╡ 3c71a06d-924a-4403-98df-4bf167ee8520
md"""
Widening sliders
"""

# ╔═╡ cd7d2daf-d625-4c76-a27d-3153721b339a
cellWidthSlider = @bind cellWidth Slider(500:25:1500, show_value=true, default=800);

# ╔═╡ 0c30be39-0c5b-44cf-9a64-518080da07a7
leftMarginSlider = @bind leftMargin Slider(-250:25:100, show_value=true, default=0);

# ╔═╡ b3c88a20-d092-40e8-9e01-95f093048318
md"""
###### Cell width sliders
- cell width: $cellWidthSlider
- left margin: $leftMarginSlider
>>>>>>> Stashed changes
"""

# ╔═╡ Cell order:
# ╟─e984391b-0c01-4dc8-85aa-3593027e8530
# ╟─b3c88a20-d092-40e8-9e01-95f093048318
# ╟─e133c0fe-39b7-400e-9e20-f7506603e17d
# ╟─b28ecc8b-c27f-4446-961d-a187f28cf97a
# ╟─2675d602-810c-4320-971c-902c3327a5cb
# ╟─346cb64d-3c89-44d1-9edb-06354152243a
# ╟─977537f7-3358-4598-afb8-3d421c12f565
# ╟─11832b60-4906-4d22-960b-0b16b6634011
# ╟─b6f5c9c6-669e-4a67-b429-cf8e85d00c08
# ╟─5a1ad46c-d500-4762-920f-812ebff350e4
# ╟─f542c713-f23d-4d9d-a271-e54d77c600d3
# ╟─40481932-af01-4981-8911-e6e35121ff9e
# ╟─35a57b0a-87c6-448a-a3a9-5a8abca24bfd
# ╟─8e2946d7-bdd1-4c87-9831-2b4bf2d53a0f
# ╟─1d9f1425-ea25-4392-b681-9660217d25d2
# ╟─3230a371-8901-41a0-8bd8-36965851eaca
# ╟─d5268417-62f9-4fa8-beac-c4d4b9007223
# ╟─8a5d4ccf-a3b2-4373-822d-dbf5254bf4b0
# ╟─65151aba-d946-401d-8cca-1874f38146f2
# ╠═d46a4d5c-4324-48c8-9851-d486495ec5dc
# ╠═9ff79fb3-7415-44db-9427-853296f9fb6e
# ╟─29e28885-d969-4e27-b5d3-866eb25302ab
# ╟─f4c82ed6-bfb7-4600-b9c6-b29627de74f4
# ╟─974bb44d-420c-460d-b626-707909568554
# ╟─e3b1c6c2-5631-42c0-9a1b-d5a5520466c8
# ╟─ff17e921-4522-4ab3-8282-9d9aafecdbe9
# ╟─23069d06-9d74-4a39-912e-e6372ac03abb
# ╟─e022f21e-7f18-4690-99d4-0141403b3b38
# ╟─1416a80e-dbda-4185-8984-7f5de3c58f02
# ╟─cc640d51-f3d1-4d9e-bd6d-4fd7aa338f07
# ╟─75a587fc-cd2d-4205-bd2e-8fc770a63dcf
# ╠═dbb04803-2fc3-4455-99e6-ac78360a200f
# ╠═533bf41f-0dc3-42e3-af5c-344163e950b1
# ╠═624bd571-c51e-4f52-848b-7cdefebbd42a
# ╠═e186986e-ae37-47ad-b44c-2d7d1078b3cd
# ╠═84ecbeb2-f601-4945-8ed0-6dcf103d97da
# ╟─f124d454-a47e-446a-95f4-6793e9fd5b13
# ╠═0fe8eafe-871b-40a2-ad45-3a27e0566533
# ╟─650767d3-3e8e-4351-a249-8e11c1037385
# ╟─3c71a06d-924a-4403-98df-4bf167ee8520
# ╠═cd7d2daf-d625-4c76-a27d-3153721b339a
# ╠═0c30be39-0c5b-44cf-9a64-518080da07a7
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
