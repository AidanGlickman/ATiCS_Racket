# Lambda Calculus

```Racket
(define (do mystery)
	(mystery 17 5))
```
1. Refer to the slide: what would (do +) do?
	* It is a wrapper for adding.
	* (do takes an operator, and performs the operation passed with the args (operator 17 5))
2. Calculus is defined as 
	>a particular system of calculation or reasoning

3. Here are two functions:
	```
	f(x) = x + 2
	g(y) = y + 2
	```
	These two functions are the same!

	Here are three functions:
	```
	f(x) = x^2 + y
	g(y) = x^2 + y
	h(x,y) = x^2 + y
	```
	These functions are all completely different!

	**All of these functions have different inputs, so their mappings are completely different**

## Explicit vs Implicit
	x = 3 V x = 2 
is explicit

	x^2 - 5x + 6 = 0 
is implicit

Explification is making an implicit explicit, Implification is the opposite

	f(x) = x^2 - 5x + 6
f is the function name, the rule is 
	
	x -> x^2 - 5x + 6

Alonso Church invented Lambda calculus in the 1930s. He wanted to describe whether 
	
	x^2 + y

was a function of x or y, and he wanted to use a caret for this purpose but his typewriter didn't have one so he used a lambda.

	f(x) = x^2 + 2
is implicit,
The explicit is

	f = \x -> x^2 + 2
or more formally:

	f = \x.x^2 + 2

in Racket this can be
```(define (f x) [+ (* x x) 2])``` or ```(define f (lambda (x) [+ (* x x) 2]))```

There are no parentheses on the f in the second, as it is simply a variable.

```((lambda (x) (+ x x)) 3)```
Simply plugs 3 in to the function 

In lambda, elements feed in from the right.

```(([lambda (f) (lambda (x) (f x x))] +) 3)```

You feed from in to out, so, this is
	
	(+ 3 3) = 6

```(([\ (f) (\ (x) (f x x))] +) 3)```
=
```((\ (x) (+ x x)) 3) ```
=
```(+ 3 3)```
= 6

Make a function that takes a function and then an operand and applies the function to the operand twice

```(define two-time [\ (f) (\ (x) (f (f x)))])```

now feed it a function that multiplies a number by 2

```(define quad (two-time (\ (n) (* 2 n))))```

Make a function that takes an operand and then a function and applies the function to the operand twice

```(define two-time [\ (x) (\ (f) (f (f x)))])```


## map

map takes a function and a list and generates a new function by applying the function repeatedly:

ex. ```(map number? '("d" 5 12.5))```

make a (non-lambda) function that sums the first three elements of a list

```(define (sum-three list) (+ (car list) (cadr list) (caddr list)))```

make a (non-lambda) function that multiplies the first three elements of a list

```(define (prod-three list) (* (car list) (cadr list) (caddr list)))```

```(define first-three (\ (f) (\ (list) (f (car list) (cadr list) (caddr list)))))```

make a non-lambda recursive factorial

```
(define (factorial x)
	(cond
		((zero? x)
			1)
		(else
			(* x (factorial (- x 1))))))
```

make a non-lambda sum values in list

(define (sum-list list)
	(cond
		(null? (cdr list)
			(car list))
		(else
			(+ (car list)(sum-list (cdr list))))))
