### A Pluto.jl notebook ###
# v0.20.20

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

# ╔═╡ dbb04803-2fc3-4455-99e6-ac78360a200f
using DrWatson

# ╔═╡ 533bf41f-0dc3-42e3-af5c-344163e950b1
@quickactivate "AAS247Julia"

# ╔═╡ e186986e-ae37-47ad-b44c-2d7d1078b3cd
using PlutoUI, HypertextLiteral, Revise

# ╔═╡ f7cd76de-4427-4dc3-9d12-9931b27a2956
md" [Julia Markdown Doc](https://docs.julialang.org/en/v1/stdlib/Markdown)"

# ╔═╡ e984391b-0c01-4dc8-85aa-3593027e8530
begin
	notebookName = "02-Arrays_1"
	"""
	!!! note "$notebookName"
		###### Origin Date: 29 October 2025
	""" |> Markdown.parse
end

# ╔═╡ 0fe8eafe-871b-40a2-ad45-3a27e0566533
TableOfContents(title = notebookName, depth = 6)

# ╔═╡ b3c88a20-d092-40e8-9e01-95f093048318
md"""
###### Cell width sliders
`cellWidth` $(@bind cellWidth Slider(500:25:1500, show_value=true, default=800))

`Left-Margin` $(@bind leftMargin Slider(-250:25:100, show_value=true, default=25))
"""

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

# ╔═╡ e133c0fe-39b7-400e-9e20-f7506603e17d
md" ##### Begin New Coding Here."

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

# ╔═╡ 974bb44d-420c-460d-b626-707909568554
md"""
!!! danger "Review: Six Problems"
	Solutions are hidden below each problem.
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

# ╔═╡ 7fee9cc1-ecd5-40d1-b9e5-7ca82ee3128e
begin
	# 1. Create the matrix
	M = reshape(1:9, 3, 3)
	# 3×3 Matrix{Int64}:
	#  1  4  7
	#  2  5  8
	#  3  6  9

	# 2. Print element at (1, 3)
	# println(M[1, 3])
	# Output: 7

	# 3. Print the 2nd column
	# println(M[:, 2])
	# Output: [4, 5, 6]

	# Note how M[1, 3] is 7, not 3, because the matrix filled by columns.

	md"""
	!!! tip "Solution 1 (with println commented out)"
	"""
end

# ╔═╡ ff17e921-4522-4ab3-8282-9d9aafecdbe9
md"""
### Problem 2: Broadcasting and Fusion
!!! warning ""
	1. Create a 1D vector x containing five evenly spaced points from 0 to $\pi$, inclusive.
	   - Hint: `pi` is a built-in constant. The `range()` function might be useful: `range(start, stop, length)`. Or just type it manually.
	1. Define a simple function `my_poly(x) = x^2 - 2*x + 1`.
	1. Using broadcasting, apply your function `my_poly` to every element in `x`. Store the result in `y`.
	1. Print both `x` and `y`.

"""

# ╔═╡ 86c3b5ee-7024-4614-a28e-4516e35adfb4
begin
	# 1. Create the vector x
	x = range(0, pi, length=5)
	# Output: [0.0, 0.785398, 1.5708, 2.35619, 3.14159]

	# 2. Define the function
	my_poly(x) = x^2 - 2*x + 1

	# 3. Apply the function using broadcasting
	y = my_poly.(x)

	# 4. Print
	# println("X values: ", x)
	# println("Y values: ", y)
	# Output:
	# X values: [0.0, 0.785398, 1.5708, 2.35619, 3.14159]
	# Y values: [1.0, 0.04603, 0.32288, 1.8396, 4.5869]

	# Note: You could also have written this using dot fusion directly
	# without defining a function, and it would be just as fast!
	# y = x.^2 .- 2 .* x .+ 1

	md"""
	!!! tip "Solution 2 (with println commented out)"
	"""
end

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


# ╔═╡ 3d50f1d3-066a-4ab0-8e6d-bb1041598057
let # to avoid multiple instances of variables
	# 1. Create A
	A = reshape(1:8, 4, 2)
	# 4×2 Matrix{Int64}:
	#  1  5
	#  2  6
	#  3  7
	#  4  8

	# 2. Create v (1D Vector)
	v = [10, 20, 30]
	# 3-element Vector{Int64}:
	#  10
	#  20
	#  30

	# 3. Create c (2D Column Matrix)
	c = [40; 50]
	# 2×1 Matrix{Int64}:
	#  40
	#  50

	# 4. Create B (a slice)
	B = A[3:4, :] # Read as: rows 3 through 4, all columns
	# 2×2 Matrix{Int64}:
	#  3  7
	#  4  8

	# Alternative for #4 using 'end'
	# B = A[end-1:end, :]


	md"""
	!!! tip "Solution 3"
	"""
end

# ╔═╡ e022f21e-7f18-4690-99d4-0141403b3b38
md"""
### Problem 4: Matrix Math vs. Element-wise Math
!!! warning ""
	1. Create two 2×2 matrices:
	   - `X = [1 2; 3 4]`
	   - `Y = [2 0; 0 2] # This is a scaling matrix.`
	2. Calculate the matrix multiplication `M = X * Y`.
	3. Calculate the element-wise multiplication `E = X .* Y`.
	4. Print both `M` and `E`. Look at `M[1, 1]` and `E[1, 1]`. Why are they different? (You just need to think about this, no need to write the answer).

"""

# ╔═╡ 34cd25cc-f017-4c24-8125-bd899945be62
let
	# 1. Create matrices
	X = [1 2; 3 4]
	Y = [2 0; 0 2]

	# 2. Matrix multiplication
	M = X * Y
	# 2×2 Matrix{Int64}:
	#  2  4
	#  6  8

	# 3. Element-wise multiplication
	E = X .* Y
	# 2×2 Matrix{Int64}:
	#  2  0
	#  0  8

	# 4. Print
	# println("Matrix Product M: \n", M)
	# println("Element-wise Product E: \n", E)

	# Why are they different?
	# M[1, 1] is (1*2 + 2*0) = 2
	# E[1, 1] is (1*2) = 2
	# (In this one case, they are the same! But look at M[2, 2] vs E[2, 2])
	# M[2, 2] is (3*0 + 4*2) = 8
	# E[2, 2] is (4*2) = 8
	# (Still the same! This is a special diagonal matrix.)
	# Let's look at M[2, 1] vs E[2, 1]
	# M[2, 1] is (3*2 + 4*0) = 6
	# E[2, 1] is (3*0) = 0
	# Ah, there's the difference! `*` does the full linear algebra dot product,
	# while `.*` just multiplies matching elements.

	# (Self-correction: The example with Y = [2 0; 0 2] accidentally had the same result for [2,2]. The [2,1] element clearly shows the difference.)

	md"""
	!!! tip "Solution 4 (with println commented out)"
	"""
end

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

# ╔═╡ 1ae90170-7388-4a6b-a134-508a94c0ba05
let
	# 1. Create vectors
	a = [1.0, 2.0, 3.0, 4.0]
	b = [0.1, 0.2, 0.3, 0.4]
	c = [10.0, 10.0, 10.0, 10.0]

	# 2. Calculate y using a fused expression
	y = (a.^2 .+ b) ./ c

	# 3. Print
	# println(y)
	# 4-element Vector{Float64}:
	#  0.11
	#  0.42
	#  0.93
	#  1.64

	# This single line (a.^2 .+ b) ./ c is as fast as writing a manual for loop, because Julia fuses all the "dotted" operations.

	md"""
	!!! tip "Solution 5 (with println commented out)"
	"""
end

# ╔═╡ cc640d51-f3d1-4d9e-bd6d-4fd7aa338f07
md"""
### Problem 6: Column-Major Thinking (A Thought Experiment)
!!! warning ""
	1. Imagine you have a 10,000 × 10,000 matrix called `DATA`.
	1. You need to write a for loop to calculate the sum of every element in the second column.
	1. Write this loop.
	   - Hint: You only need one loop. Which index (row or column) should be fixed? Which one should your loop iterate over? Will this loop be fast or slow according to Julia's memory layout?
"""

# ╔═╡ 9d3ace8b-55a4-45bf-8609-8eff2341aa82
let

	# This code is for demonstration; you only needed to write the loop.
	DATA = rand(10000, 10000); # A large matrix

	# The loop to sum the *second column*:
	total = 0.0
	for i in 1:size(DATA, 1) # Loop over all ROWS (i)
		total += DATA[i, 2]   # ...but keep the COLUMN (j) fixed at 2
	end

	# println("The total is: ", total)

	# Thought experiment answer:
	# This loop iterates from DATA[1, 2], DATA[2, 2], DATA[3, 2], ...
	# This is moving *down a column*.
	# Because Julia is COLUMN-MAJOR, these elements are all
	# right next to each other in memory.
	# Therefore, this loop will be **very fast**.

	md"""
	!!! tip "Solution 6 (with println commented out)"
	"""
end

# ╔═╡ Cell order:
# ╟─f7cd76de-4427-4dc3-9d12-9931b27a2956
# ╟─e984391b-0c01-4dc8-85aa-3593027e8530
# ╠═dbb04803-2fc3-4455-99e6-ac78360a200f
# ╠═533bf41f-0dc3-42e3-af5c-344163e950b1
# ╠═e186986e-ae37-47ad-b44c-2d7d1078b3cd
# ╠═0fe8eafe-871b-40a2-ad45-3a27e0566533
# ╟─650767d3-3e8e-4351-a249-8e11c1037385
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
# ╟─974bb44d-420c-460d-b626-707909568554
# ╟─e3b1c6c2-5631-42c0-9a1b-d5a5520466c8
# ╟─7fee9cc1-ecd5-40d1-b9e5-7ca82ee3128e
# ╟─ff17e921-4522-4ab3-8282-9d9aafecdbe9
# ╟─86c3b5ee-7024-4614-a28e-4516e35adfb4
# ╟─23069d06-9d74-4a39-912e-e6372ac03abb
# ╟─3d50f1d3-066a-4ab0-8e6d-bb1041598057
# ╟─e022f21e-7f18-4690-99d4-0141403b3b38
# ╟─34cd25cc-f017-4c24-8125-bd899945be62
# ╟─1416a80e-dbda-4185-8984-7f5de3c58f02
# ╟─1ae90170-7388-4a6b-a134-508a94c0ba05
# ╟─cc640d51-f3d1-4d9e-bd6d-4fd7aa338f07
# ╟─9d3ace8b-55a4-45bf-8609-8eff2341aa82
