### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ b4228b44-cd1f-4664-a102-65c0b22a757c
using DrWatson

# ╔═╡ d07e2d0b-9d94-4cd4-ac26-5494d555bd1b
@quickactivate "AAS247Julia"

# ╔═╡ 04cc37cd-ecf9-4dd5-b14d-4d4fe1f0992d
using Dates, PlutoUI

# ╔═╡ 9119b6aa-10f1-41a8-b236-e407312cb219
using Markdown

# ╔═╡ a450e173-a833-4bbd-be59-be42fc9c2247
using InteractiveUtils

# ╔═╡ 2614efc4-c4a5-11f0-b6f8-5fb2b6ceb0de
md"""

### Let Julia write and compile the code

Let's assume that we have to write a function `myfunc` to do some data analysis. The function has one argument `a`. It has the same implementation for all floating point data types.

* For statically compiled languages such as C, each argument type must have its own version of the function, i.e., `myfunc(a::Float32)`, `myfunc(a::Float64)`, etc.

* For Julia, only one version of the function is needed, assuming the argument type is an `AbstractFloat`, i.e., `myfunc(a::AbstractFloat)`

`AbstractFloat` tells Julia to only allow floating point types for the argument. Integers are not allowed. A new version of the function is compiled for each new data type. Thus, the user only needs to write on version of the function.
"""

# ╔═╡ dbf2d122-5751-447e-9a6b-6997fe9a07fc
md"""
### Constructor functions

Functions can be constructors for composite types. Assume a composit type `MyType` has two fields `a` and `b`:

```julia
struct MyType
    a::Integer
    b::Integer
end
```

Julia automatically creates a default constructor function:

```julia
function MyType(a::Integer, b::Integer)
    new(a, b)
end
```

Now assume the second argument `b` is often `0`, then we can define a function of the same name with the second argument having a default value of `0`.

```julia
function MyType(a::Integer, b::Integer=0)
    MyType(a, b)
end
```

with usage of:

```julia
MyType(1)
```
"""

# ╔═╡ bcc0cb23-ea14-477c-8e3c-2c04d7fd00d8
md"""
### Object-oriented behaviour

Object-oriented languages tightly couple the class (or composite type) and the method (or function). This is achieved via single dispatch.

* For Python, the method may look like the following, where `self` is the class (composite type):
  ```python
  def mymethod(self, a, b):
  ```
  The method is usually invoked using the dot notation:
  ```python
  self.mymethod(a, b)
  ```

Julia loosely couples composite types (classes) and functions (methods) because of multiple dispatah. Therefore, Julia is not an object-oriented language.

* For Julia, the function may look like the following, where `mytype` is the composite type (class):

  ```julia
  mymethod(mytype, a, b)
  ```
"""

# ╔═╡ 74314d5e-64d6-46a1-88ee-cd5fc84972e3
md"""
### Functors

Functors are nameless functions. They are defined by their argument type, usually a composite type. A good example of this behaviour is the polynomial.

* Construct the polynomial type:

  ```julia
  struct Polynomial{R}
      coef::Vector{R}
  end
  ```

* Construct the function to evaluate the polynomial:

  ```julia
  function (p::Polynomial)(x)
      ...
  end
  ```

* Create the polynomial:

  ```julia
  p = Polynomial([1, 2, 3])
  ```

* Evaluate the polynomial

  ```julia
  p(3)
  ```
"""

# ╔═╡ 0c5d2b23-fb2b-4ce0-a7fc-e706eafd7751
md"""
!!! note "Summary"
    * Abstract types allow you to write functions for specific set of types.
    * Julia create a new version of the function based on the argument types.
    * Functions can be used to simplify composite type constructors.
    * Julia is not an object-oriented language, but is behaves like one.
    * Functors are nameless functions that use the composite type for dispatch.
"""

# ╔═╡ 2d156a39-9fa7-4c16-9fcb-beccfd318c03
md"""
### Problem 1: A function with one abstract type
!!! warning ""
    * Create a function having one argument being an abstract float type.
    * Use the function with a `Float64` (double precision) type, e.g., `1.0`
    * Use the function with a `Float32` (single precision) type, e.g., `1.0f0`.
      * Note: the `f` means Float32, whereas `e` means Float64.
    * How many methods does it have?
      * Hint: use the `methods()` function, e.g., `methods(myfunc)`.
    * Use the function with a `BigFloat` type
    * How many methods are there now?
"""

# ╔═╡ 660de134-abd4-4fd5-af7f-0f78f1e23727


# ╔═╡ c43d1c95-e003-4580-9057-ac59970f17c2
md"""
### Problem 2: A function with two abstract types
!!! warning ""
    * Create a `add` function having two arguments, the first being an abstract float and the second an abstract integer.
    * Use the function with float and integer arguments.
    * Use the function with integer and float arguments. What happens?
"""

# ╔═╡ d9c9c0c8-6484-4c95-9949-656a5de83762


# ╔═╡ 5588e7ba-1f51-441b-bdc2-fe63023e42e6
md"""
### Problem 3: A constructor function
!!! warning ""
    * Create a composite type with two fields.
    * Instantiate the type.
    * Create a function of the same name having a default second argument.
    * Use the function with one and two arguments.
"""

# ╔═╡ 94952bbc-8e78-4daa-9186-b4d87ffb1697


# ╔═╡ 092154d4-5072-4855-bba6-69500c2dcf31
md"""
### Problem 4: Object-oriented behaviour
!!! warning ""
    * `import Base.*`
    * Create a 2D point type
      * Hint: `struct Point{R} x::R, y::R end`
    * Create a variable using the Point type
    * Create add function for the Point type
      * Hint: `function +(a, b)`
    * Add the two points together
    * Create a norm function for the Point type
    * Evaluate the norm for a point
"""

# ╔═╡ f9a1fece-bec7-4dbb-ad0a-4ff1d29c2f08


# ╔═╡ 36360e9c-a3fa-463d-b3ed-fef4f4851007
md"""
### Problem 5: Functors
!!! warning ""
    * Create a polynomial type
    * Create a function to evaluate the polynomial at a value x
      * Hint: use the `sum()` function and an array comprehension
    * Create the polynomial
    * Evaluate the polynomial
"""

# ╔═╡ 8c258f48-bd25-4998-9699-b4f415d76b8a


# ╔═╡ 5c195e5e-3929-4448-9b6e-f3b989f2e297
md"""
----
"""

# ╔═╡ e7ae5a6e-1bf4-442b-9c03-75343c07f999
md"""
### Notebook setup
"""

# ╔═╡ 2af773a0-1138-4918-8224-aabbd046261e
notebook_name = "1-6: Functions and Types"

# ╔═╡ 8bc5134f-d7e8-438a-9d68-fbf14951a66f
TableOfContents(; title = notebook_name, depth = 4)

# ╔═╡ 0df0caf9-e2df-4713-a9d1-fdb724882a0a
timestamp = Dates.format(today(), dateformat"d u Y")

# ╔═╡ 70c42e39-490a-4fc2-acfc-c4c0553a4e1e
"""
!!! note "$(notebook_name)"
    **Last Updated: $(timestamp)**
""" |> Markdown.parse

# ╔═╡ Cell order:
# ╟─70c42e39-490a-4fc2-acfc-c4c0553a4e1e
# ╟─2614efc4-c4a5-11f0-b6f8-5fb2b6ceb0de
# ╟─dbf2d122-5751-447e-9a6b-6997fe9a07fc
# ╟─bcc0cb23-ea14-477c-8e3c-2c04d7fd00d8
# ╟─74314d5e-64d6-46a1-88ee-cd5fc84972e3
# ╟─0c5d2b23-fb2b-4ce0-a7fc-e706eafd7751
# ╟─2d156a39-9fa7-4c16-9fcb-beccfd318c03
# ╠═660de134-abd4-4fd5-af7f-0f78f1e23727
# ╟─c43d1c95-e003-4580-9057-ac59970f17c2
# ╠═d9c9c0c8-6484-4c95-9949-656a5de83762
# ╟─5588e7ba-1f51-441b-bdc2-fe63023e42e6
# ╠═94952bbc-8e78-4daa-9186-b4d87ffb1697
# ╟─092154d4-5072-4855-bba6-69500c2dcf31
# ╠═f9a1fece-bec7-4dbb-ad0a-4ff1d29c2f08
# ╟─36360e9c-a3fa-463d-b3ed-fef4f4851007
# ╠═8c258f48-bd25-4998-9699-b4f415d76b8a
# ╟─5c195e5e-3929-4448-9b6e-f3b989f2e297
# ╟─e7ae5a6e-1bf4-442b-9c03-75343c07f999
# ╠═b4228b44-cd1f-4664-a102-65c0b22a757c
# ╠═d07e2d0b-9d94-4cd4-ac26-5494d555bd1b
# ╠═04cc37cd-ecf9-4dd5-b14d-4d4fe1f0992d
# ╠═8bc5134f-d7e8-438a-9d68-fbf14951a66f
# ╟─2af773a0-1138-4918-8224-aabbd046261e
# ╟─0df0caf9-e2df-4713-a9d1-fdb724882a0a
# ╟─9119b6aa-10f1-41a8-b236-e407312cb219
# ╟─a450e173-a833-4bbd-be59-be42fc9c2247
