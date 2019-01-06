#lang racket

7
67
213456786543245675454765876985467588976857463536475898768574635253467868796857463524367869785746356758767463564758
964/3
(/ (+ 34 4) 2)
(/ 1 2)
(/ 1 2.0)
(sqrt 12) ; use fn+f1 to search manuals
"dog"
"dog cat frog"
(string-append "donkey " "dog cat frog") ; string append
(define monster (string-append "REEEEE donkey " "dog cat frog")) ; defines constant monster

monster ; executes monster

(define (++ f)
  (+ f 1)) ; defines a function '++' which returns the next number

(++ 7)

(define (ftoc n)
  (* (/ 5 9) (- n 32))) ; defines function ftoc and fahrenheit to celsius conversion using ints to guaruntee accuracy

(ftoc 100)

#|
BLOCK
COMMENT
|#

(require plot)
(plot3d (surface3d (lambda (x y) (* (tan x) (cos y)))
                     (- pi) pi (- pi) pi)
          #:title "Lennon J Okun vs Time vs Gravity"
          #:x-label "Lennon J Okun" #:y-label "Time" #:z-label "Gravity")
