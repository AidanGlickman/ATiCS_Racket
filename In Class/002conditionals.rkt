;#lang racket
(define x 7)

(cond
  ((integer? x)
   (displayln "This number is an integer!")
   (display x)
   (+ x 7)
   (displayln (+ x 19)) ; display displays a value, even if it is not the final expression on a variable.
   (+ x 34)) ; Generally, only the final value (This expression) is displayed.
  ((real? x) (display "This number is at least real."))
  (#t
    (display "This is neither real nor an integer."))
  )

(or #t #f)
(implies #t #f)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(cons 1 2)

(cons (cons 1 2) 3)

(define foo (cons 1 2))
foo
(car foo)
(cdr foo)