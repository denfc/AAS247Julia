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

# ╔═╡ c4480e57-d479-403b-a841-50e0b6ee0b04
using DrWatson

# ╔═╡ 5bd8b585-ee1c-4ec7-bfb5-6e266824b3b4
@quickactivate "AAS247Julia"

# ╔═╡ 602c43c5-28de-487b-af91-bc6523b7d899
using PlutoUI, HypertextLiteral, Revise

# ╔═╡ afe988c7-c708-4fdb-bf82-54edeb9db708
begin
	notebookName = "04-Arrays"
	"""
	!!! note "$notebookName"
		###### Origin Date: 1 December 2025
	""" |> Markdown.parse
end

# ╔═╡ 83ab9733-5969-4d0c-a3c0-b8f4d2402fde
TableOfContents(title = notebookName, depth = 6)

# ╔═╡ 55f82e50-9a84-4c09-a15b-18fa9275726c
md"""
###### Cell width sliders
`cellWidth` $(@bind cellWidth Slider(500:25:1500, show_value=true, default=800))

`Left-Margin` $(@bind leftMargin Slider(-250:25:100, show_value=true, default=25))
"""

# ╔═╡ 3aa7166e-3e82-41c3-8618-859c1d8fbe5a
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

# ╔═╡ 65b843a0-24ad-4821-9097-088be8d4539f
md" ##### Begin New Coding Here."

# ╔═╡ 7d8410d2-7568-4dee-b812-9fa9f8acb33f
md"""
### 0. The Power of Functions in Julia
Introduction to the contruction of Julia functions and their implementation by Julia.

If you come from Python or Java, functions are attached to classes. In Julia, functions are standalone citizens, and they define the behavior of the language. We will cover the syntax, the argument system, and introduce Julia’s killer feature: Multiple Dispatch.

!!! note ""
	1. Defining functions
	1. Function arguments and keywords
	1. Multiple dispatch
"""

# ╔═╡ c78da21b-40ad-42d1-8516-b91d16982c77
md"""
### 1: Defining Functions

Julia offers three syntactic ways to define a function. They all compile down to the same thing, so choose because of context or preferred style.

1. The standard multiline looks similar to Python or MATLAB: we use the `function` keyword and close with `end`.

```julia
function hypotenuse(a, b)
	result = sqrt(a^2 + b^2)
	return result
end
```

Julia automatically returns the result of the last expression evaluated, but for clarity we have used it in the example above.

2. The single-line assignment form may be unique to Julia and is perfect for short operations. While functionally identical to the multiline version, it reduces visual clutter for simple logic.

```julia
hypotenuse(a, b) = sqrt(a^2 + b^2)
```

3. Anonymous Functions (Lambdas)

Used often in functional programming contexts such as `map`, `filter` or `findall`, an anonymous function uses the arrow syntax:  -> .

```julia
# Equivalent to Python's: lambda x: x^2 + 2x - 1
f = x -> x^2 + 2x - 1

# Usage in a map function
map(x -> x^2, [1, 2, 3]) 
```

"""

# ╔═╡ e1b0b588-eaee-47cd-9406-b3dfe38b2f19
md"""

### 2: Arguments, Types, and Keywords

Julia gives you granular control over arguments.

1. Type Annotations

In Python, you might use type hints for documentation. In Julia, type annotations change how the compiler generates code. You annotate with ::.


```julia
function describe(name::String, age::Int32)
    println("$name is $age years old.")
end
```

_Julian inference_: if you do not provide a type (e.g., just writing `name, age`), Julia defaults to type Any. However, when you call the function, Julia’s JIT (Just-In-Time) compiler infers the specific type at runtime and compiles a specialized version of that function for those specific types.

2. Positional vs. Keyword Arguments

A crucial syntax distinction: in a Julia function, a semicolon (;) strictly separates positional arguments from keyword arguments.

```julia
# a and b are positional
# scale and offset are keyword arguments
function transform(a, b; scale=1.0, offset=0.0)
    return (a + b) * scale + offset
end

# Usage
transform(10, 20; scale=2.0)
```

3. Default Values and Methods

You can provide default values for positional arguments. Interestingly, behind the scenes, Julia actually generates multiple methods.

```julia
# This defines a default for y
myfunc(x, y=10) = x * y
```

Julia sees this as two separate possibilities:
```julia
myfunc(x) # (which calls the internal version with 10)
myfunc(x, y)
```
"""

# ╔═╡ 022ce88c-cf02-11f0-ba74-39ac8b31fd57
md"""
### 3: Multiple Dispatch

!!! note "The most important part and a core reason for Julia's existence."

1. Single Dispatch (The Python/OO Way)

In Object-Oriented languages (Python, Java), methods belong to objects. When you call `obj.method(arg)`, the language decides which code to run based on the type of the first argument (`obj`) only, which creates the "Expression Problem."

Think about addition. If you write `a + b` in Python, it effectively calls `a.__add__(b)`.
If `a` doesn't know how to add `b`, Python tries `b.__radd__(a)` (reverse add).
You have to write specific logic inside the class of `a` to handle every possible `b`.

2. Multiple Dispatch (The Julia Way)

Julia is not Object-Oriented; it is Function-Oriented. When you call `f(arg1, arg2)`, Julia looks at the types of all arguments involved to decide which implementation to run. We call the abstract definition a Function (e.g., +), and the specific implementation for specific types a Method. Let's look at a concrete example using the + operator.

```julia
import Base.+ # You need to explicitly write import Base.+ before defining a new method for the + operator because of Julia's method extension rules.
# By writing import Base.+, you’re telling Julia: “I know + already exists in Base, and I want to add more methods to it,” which makes your code clearer to readers and avoids unintentional type piracy (changing behavior for types you don’t own).

# Define addition for two strings (concatenation)
+(a::String, b::String) = "$a $b"

# Define addition for a String and an Int
+(a::String, b::Int) = "$a: $b"

# Define addition for an Int and a String
+(a::Int, b::String) = "Number $a says $b"
```

Why is this powerful?

a) Symmetry: You don't need __radd__ because compared with +(a::Float, b::Int), +(a::Int, b::Float) is just a different method.

b) Extensibility: If you import a library that defines a `Planet` type, and another library that defines a `Satellite` type, you can define a `collide(p::Planet, s::Satellite)` function in your own code without modifying the source code of either library.

c) Note that Dispatch happens on positional arguments only. Keyword arguments do not participate in dispatch.

!!! note "Summary of Dispatch"
	  - Python: dog.bark(at_stranger) -> Logic lives in dog.\
	  - Julia: bark(dog, stranger) -> Logic lives in the bark function, selected specifically for the combination of Dog and Stranger.

"""

# ╔═╡ 09abe51d-ed7d-4f8a-b49c-193dbf188e02
md"""
!!! note ""
	Recap
	1. Definitions: You can use multiline blocks, one-liners, or lambdas.
	2. Arguments: Use :: for types and ; to separate keyword arguments.
	3. Multiple Dispatch: The compiler chooses the most specific method based on the types of all arguments, allowing for incredibly composable and high-performance code.

"""

# ╔═╡ f2c8a8af-6638-4fc3-88e7-88190bcea9b2
md"""
### Problems
!!! warning "7+ problems (~5 minutes each)"

* Define and use a multi-line function without keywords.
* Define and use a multi-line function with default values and without keywords.
* Define and use a multi-line function with default values and keywords.
* Define and use a single-line function without keywords.
* Define and use a single-line function with keywords.
* Define and use an anonymous function.
* Use an anonymous function with the `filter()` and `map()`.
* Define an `add()` with no argument types and use it with different argument types.
* Use `methods()` to show the `add()` methods.
* Define an `add()` with specified argument types and use it.
  * Note: Julia will use the specific version function before defaulting to the general version function.
"""

# ╔═╡ Cell order:
# ╟─afe988c7-c708-4fdb-bf82-54edeb9db708
# ╠═c4480e57-d479-403b-a841-50e0b6ee0b04
# ╠═5bd8b585-ee1c-4ec7-bfb5-6e266824b3b4
# ╠═602c43c5-28de-487b-af91-bc6523b7d899
# ╠═83ab9733-5969-4d0c-a3c0-b8f4d2402fde
# ╟─3aa7166e-3e82-41c3-8618-859c1d8fbe5a
# ╟─55f82e50-9a84-4c09-a15b-18fa9275726c
# ╟─65b843a0-24ad-4821-9097-088be8d4539f
# ╟─7d8410d2-7568-4dee-b812-9fa9f8acb33f
# ╟─c78da21b-40ad-42d1-8516-b91d16982c77
# ╟─e1b0b588-eaee-47cd-9406-b3dfe38b2f19
# ╟─022ce88c-cf02-11f0-ba74-39ac8b31fd57
# ╟─09abe51d-ed7d-4f8a-b49c-193dbf188e02
# ╟─f2c8a8af-6638-4fc3-88e7-88190bcea9b2
