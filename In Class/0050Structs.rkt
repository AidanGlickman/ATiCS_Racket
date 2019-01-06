; Structs. Structs work like they do in c.

(define-struct frog (species size)) ; This defines a struct called frog that has attributes species and weight. Also implicitly creates function (make-frog) that creates frogs and functions that return a frogs attributes and frog? that checks if something is a frog
(define kermit (make-frog "street" 3040)) ; Defines a frog called kermit of species "street" and size 3040
(define small-buddy (make-frog "tree" 39)) ; Defines a called small-buddy frog of species "tree" and size 39

(define/contract (fits-in-display-case? my-frog case-size) ; Defines a function called fits-in-display-case? that will check if a frog my-frog can fit in a display case that can hold size case-size 
    (-> frog? integer? boolean?) ; sets contract expecting a frog, an int, and promising to return a boolean
	(>= case-size (frog-size my-frog))) ; returns boolean for if frog can fit in case.

#| TEST CASES:
(fits-in-display-case? kermit 300) ; checks if kermit can fit in a display case of size 300, expected value false

(fits-in-display-case? small-buddy 39) ; expected value true

(fits-in-display-case? small-buddy 50) ; expected value true

(fits-in-display-case? null 40) ; runs function with null as my-frog, expects contract violation
|#

#| 
Create a struct for a point. 
Create a function called "area" that takes 3 points and returns the area of the triangle specified.

Area should use Heron's formula:
Area = sqrt(s * (s-a) * (s-b) * (s-c))
where s = 1/2(a + b + c)
and where a, b, and c are side lengths
|#

(define-struct point (x y))

(define/contract (area point-a point-b point-c)
   (-> point? point? point? real?)
   (define (get-side-length point-a point-b)
     (sqrt (+ (expt (abs (- (point-x point-a) (point-x point-b))) 2) (expt (abs (- (point-y point-a) (point-y point-b))) 2))))
     
   (define side-a (get-side-length point-a point-b))
   (define side-b (get-side-length point-a point-c))
   (define side-c (get-side-length point-b point-c))
   
   (define (semi-perimeter side-a side-b side-c)
     (/ (+ side-a side-b side-c) 2))
   
   (define semi-s (semi-perimeter side-a side-b side-c))
   (sqrt (* semi-s (- semi-s side-a) (- semi-s side-b) (- semi-s side-c)))
   )

#| TEST CASES:
(area (make-point 2 2) (make-point 3 2) (make-point 2 3)): 0.5
|#
