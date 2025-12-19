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
using Dates, PlutoUI, HypertextLiteral, Revise

# ╔═╡ 65b843a0-24ad-4821-9097-088be8d4539f
md" ##### Begin New Coding Here"

# ╔═╡ 7d8410d2-7568-4dee-b812-9fa9f8acb33f
md"""
### 0. The Power of Functions in Julia
Introduction to the contruction of Julia functions and their implementation by Julia.

If you come from Python or Java, functions are attached to classes. In Julia, functions are standalone citizens, and they define the behavior of the language. We will cover the syntax, the argument system, and introduce a key Julia feature: Multiple Dispatch.

!!! note ""
    1. Defining functions
    1. Function arguments and keywords
    1. Multiple dispatch
"""

# ╔═╡ c78da21b-40ad-42d1-8516-b91d16982c77
md"""
### 1: Defining Functions

Julia offers three syntactic ways to define a function. They all compile down to the same thing, so choose because of context or preferred style.
"""

# ╔═╡ c74cace1-0e96-48e7-82d3-12f3af3d8591
md"""
1.1 The standard multiline looks similar to Python or MATLAB: we use the `function` keyword and close with `end`.

```julia
function hypotenuse(a, b)
    result = sqrt(a^2 + b^2)
    return result
end
```

!!! note ""
    Two things to note here:

    A. The indentation helps for readability, of course, but Julia does not use indentation to define code blocks.\
    B. Julia automatically returns the result of the last expression evaluated, but for definitiveness and clarity we have used it in the example above.
"""

# ╔═╡ cd420030-32d1-4eef-9630-2d526566081c
md"""
1.2 The single-line assignment form may be unique to Julia and is perfect for short operations. While functionally identical to the multiline version, it reduces visual clutter for simple logic.

```julia
hypotenuse(a, b) = sqrt(a^2 + b^2)
```

!!! note
    The compiler will automatically inline functions to improve performance, i.e., unlike in C or Python, there is no function call performance hit.
"""

# ╔═╡ d87b2eed-922f-4c9b-8fcd-6a015d9d35d3
md"""
1.3 Anonymous Functions (Lambdas)

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
### 2: Arguments and Keywords (over which Julia gives you much control).
"""

# ╔═╡ 70b70576-0c49-4e5b-b7c1-dd400f3fbcca
md"""
2.1 Positional vs. Keyword Arguments

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
"""

# ╔═╡ f0714c6a-19e8-408e-ba1e-565ae9ef87fb
md"""
2.2 Default Values and Methods

You can provide default values for positional arguments. Interestingly, behind the scenes, Julia actually generates multiple methods.

```julia
# This function defines a default value for the y.
myfunc(x, y=10) = x * y
```

Julia sees this function as two separate possibilities and creates two different methods:
```julia
myfunc(x) # (which calls the internal version with 10)
myfunc(x, y)
```
"""

# ╔═╡ 022ce88c-cf02-11f0-ba74-39ac8b31fd57
md"""
### 3: Multiple Dispatch

!!! note "The most important part and a core reason for Julia's existence."
"""

# ╔═╡ 12928360-90aa-4409-860a-af7f5c781e98
md"""
3.1 Single Dispatch (The Python/OO Way)

In Object-Oriented languages such as Python or Java, functions or methods are tightly bound to classes. In non-OO languages, methods are loosely bound to classes.  When you call `obj.method(arg)` --- equivalent in Julia to `method(obj, arg)` --- the language decides which code to run based on the type of the first argument (`obj`) only, which creates the "Expression Problem."

Think about addition. If you write `a + b` in Python, it effectively calls `a.__add__(b)`.
If `a` doesn't know how to add `b`, Python tries `b.__radd__(a)` (reverse add).
You have to write specific logic inside the class of `a` to handle every possible `b`.
"""

# ╔═╡ 775644ed-bbd9-4017-a036-14d9b576873a
md"""
3.2 Multiple Dispatch (The Julia Way)

Julia is not Object-Oriented; it is Function-Oriented. When you call `f(arg1, arg2)`, Julia looks at the types of all arguments involved to decide which implementation to run. We call the abstract definition a Function and the specific implementation for specific types a Method. Let's look at a (perhaps silly) example of addition.

```julia
# Define additon for an integer and a float, and the other way around:
fAdd(a::Int, b::Float64) = a + b
fAdd(a::Float64, b::Int) = a + b
```

Why is this powerful?

a) Symmetry: You don't need __radd__ because compared with (a::Float, b::Int), (a::Int, b::Float) is just a different method.

b) Extensibility: If you import a library that defines a `Planet` type, and another library that defines a `Satellite` type, you can define a `collide(p::Planet, s::Satellite)` function in your own code without modifying the source code of either library.

c) Trying to add two integers or two floating points fails, e.g., "ERROR: MethodError: no method matching fAdd(::Float64, ::Float64)."  If you know, for example, that a particular function is only supposed to be called with an integer and a float, and you don't want to worry about the order, you now have a check on your code.

d) Note that Dispatch happens on positional arguments only. Keyword arguments do not participate in dispatch.
"""

# ╔═╡ d8ba51b9-2d28-4d97-8704-c56c44e04a62
md"""
!!! note "Summary of Dispatch"
    - Python: `dog.bark(at_stranger)` -> Logic lives in `dog`.\
    - Julia: `bark(dog, stranger)` -> Logic lives in the `bark` function, selected specifically for the combination of `Dog` and `Stranger`.
"""

# ╔═╡ 09abe51d-ed7d-4f8a-b49c-193dbf188e02
md"""
!!! note "Recap"
    1. Definitions: You can use multiline blocks, one-liners, or lambdas.
    2. Arguments: Use :: for types and ; to separate keyword arguments.
    3. Multiple Dispatch: The compiler chooses the most specific method based on the types of all arguments, allowing for incredibly composable and high-performance code.

"""

# ╔═╡ 334abd5f-8a2c-4e05-96cc-feb9dd8f30ae
md"""

### Problem 1: Function Syntax (Multi-line & Defaults)

!!! warning ""
	1. **Basic Multi-line:** Define a function `calculate_vol(l, w, h)` using the `function ... end` block. It should return the product of the three arguments.
	- Test: `calculate_vol(2, 3, 4)` should be 24.
	2. **Adding Defaults:** Redefine the function so `h` has a default value of `1`.
	- Code: `function calculate_vol(l, w, h=1) ... end`
	3. **Testing Defaults:** Call `calculate_vol(5, 5)`.
	- Note: You only provided 2 arguments, so Julia automatically supplies `1` for `h`.
"""

# ╔═╡ 0659caa1-1dfd-418a-80c8-3167ca30ade9
md"""

### Problem 2: Keywords & Single-liners

!!! warning ""
	1. **Keywords (`:` vs `;`):** Define a function `describe_data(data; label="Unknown")`.
	- Note the semicolon `;`! This separates positional arguments (`data`) from keyword arguments (`label`).
	- Make the function return a string: `"$label: $data"`.
	2. **Usage:**
	- Call it without the keyword: `describe_data([10, 20])`.
	- Call it *with* the keyword: `describe_data([10, 20], label="Temperature")`.
	3. **The One-Liner:** Redefine this function using the concise assignment syntax:
	- `describe_data(data; label="Unknown") = "$label: $data"`
"""

# ╔═╡ 50f84dd5-7585-482d-bd8e-96b6cabfdbc2
md"""

### Problem 3: Anonymous Functions (Map & Filter)

!!! warning ""
	1. **The Syntax:** An anonymous function (lambda) looks like `x -> x + 1`.
	2. **Map:** Use `map()` with an anonymous function to double every number in the list `[1, 2, 3, 4]`.
	- Structure: `map(func, collection)`.
	- Solution: `map(x -> x * 2, [1, 2, 3, 4])`.
	3. **Filter:** Use `filter()` with an anonymous function to extract numbers greater than 5 from the list `[3, 4, 5, 6, 7]`.
	- Solution: `filter(x -> x > 5, [3, 4, 5, 6, 7])`.
"""

# ╔═╡ a1ec03ac-f7b4-4499-92e2-c2a047ed3574
md"""

### Problem 4: The Generic `add()`

!!! warning ""
	1. **Generic Definition:** Define a function `my_add(a, b) = a + b`. Do not add any `::Type` annotations.
	2. **Duck Typing:**
	- Try `my_add(10, 20)` (Ints).
	- Try `my_add(3.14, 2.0)` (Floats).
	- Try `my_add("Hello ", "World")` (Strings).
	- *Observation:* It works for all of them because the underlying `+` is defined for all these types.
	3. **Introspection:** Run `methods(my_add)`.
	- You should see `# 1 method for generic function "my_add"`.
"""

# ╔═╡ 0eec43c3-6ca7-4d11-b21c-7d661ef0a3e7
md"""

### Problem 5: Specialization & Dispatch

!!! warning ""
	1. **Specific Definition:** Now, add a new method to the *same* function name `my_add`, but constrain the types to Strings only.
	- `my_add(a::String, b::String) = "$a ... $b"`
	2. **Check Methods:** Run `methods(my_add)` again. You should now see **2 methods**.
	3. **Dispatch in Action:**
	- Run `my_add(5, 5)`. (Julia chooses the generic version).
	- Run `my_add("A", "B")`. (Julia chooses the specific String version).
	4. **The Rule:** Julia always executes the **most specific** method that matches the arguments provided.
"""

# ╔═╡ 7c70658b-9913-42ee-913b-0c483d95aee9
md"""
## Notebook setup
"""

# ╔═╡ 601e5ecb-4829-432c-9315-6450cb22b05a
notebookName = "1-4: Functions"

# ╔═╡ ae271c82-969e-45e3-87b7-872e1cbf097b
timestamp = Dates.format(today(), dateformat"d u Y")

# ╔═╡ afe988c7-c708-4fdb-bf82-54edeb9db708
"""
!!! note "$notebookName"
    **Last Updated: $(timestamp)**
""" |> Markdown.parse

# ╔═╡ 83ab9733-5969-4d0c-a3c0-b8f4d2402fde
TableOfContents(title = notebookName, depth = 4)

# ╔═╡ 8e538add-e168-434f-b98c-721586a66167
md"""
Widening sliders
"""

# ╔═╡ 86b28341-38ec-4dfc-bad2-4a5c89d46cb9
cellWidthSlider = @bind cellWidth Slider(500:25:1500, show_value=true, default=800);

# ╔═╡ 25f04e9b-f087-49fb-b325-bd73c4260d58
leftMarginSlider = @bind leftMargin Slider(-250:25:100, show_value=true, default=0);

# ╔═╡ 55f82e50-9a84-4c09-a15b-18fa9275726c
md"""
###### Cell width sliders
- cell width: $cellWidthSlider
- left-margin: $leftMarginSlider
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

# ╔═╡ Cell order:
# ╟─afe988c7-c708-4fdb-bf82-54edeb9db708
# ╟─55f82e50-9a84-4c09-a15b-18fa9275726c
# ╟─65b843a0-24ad-4821-9097-088be8d4539f
# ╟─7d8410d2-7568-4dee-b812-9fa9f8acb33f
# ╟─c78da21b-40ad-42d1-8516-b91d16982c77
# ╟─c74cace1-0e96-48e7-82d3-12f3af3d8591
# ╟─cd420030-32d1-4eef-9630-2d526566081c
# ╟─d87b2eed-922f-4c9b-8fcd-6a015d9d35d3
# ╟─e1b0b588-eaee-47cd-9406-b3dfe38b2f19
# ╟─70b70576-0c49-4e5b-b7c1-dd400f3fbcca
# ╟─f0714c6a-19e8-408e-ba1e-565ae9ef87fb
# ╟─022ce88c-cf02-11f0-ba74-39ac8b31fd57
# ╟─12928360-90aa-4409-860a-af7f5c781e98
# ╟─775644ed-bbd9-4017-a036-14d9b576873a
# ╟─d8ba51b9-2d28-4d97-8704-c56c44e04a62
# ╟─09abe51d-ed7d-4f8a-b49c-193dbf188e02
# ╟─334abd5f-8a2c-4e05-96cc-feb9dd8f30ae
# ╟─0659caa1-1dfd-418a-80c8-3167ca30ade9
# ╟─50f84dd5-7585-482d-bd8e-96b6cabfdbc2
# ╟─a1ec03ac-f7b4-4499-92e2-c2a047ed3574
# ╟─0eec43c3-6ca7-4d11-b21c-7d661ef0a3e7
# ╟─7c70658b-9913-42ee-913b-0c483d95aee9
# ╠═c4480e57-d479-403b-a841-50e0b6ee0b04
# ╠═5bd8b585-ee1c-4ec7-bfb5-6e266824b3b4
# ╠═602c43c5-28de-487b-af91-bc6523b7d899
# ╟─601e5ecb-4829-432c-9315-6450cb22b05a
# ╟─ae271c82-969e-45e3-87b7-872e1cbf097b
# ╠═83ab9733-5969-4d0c-a3c0-b8f4d2402fde
# ╟─3aa7166e-3e82-41c3-8618-859c1d8fbe5a
# ╟─8e538add-e168-434f-b98c-721586a66167
# ╠═86b28341-38ec-4dfc-bad2-4a5c89d46cb9
# ╠═25f04e9b-f087-49fb-b325-bd73c4260d58
