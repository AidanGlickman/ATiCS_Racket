;#lang racket
(cons 1 null) ; cons takes 2 args, but if you want a length one list then you include a null
(cons 1 (cons 2 (cons 3 null))) ; This is the formulation for constructing a regular linked list
(cons 1 2) ; This is an incorrect cons formulation, as it is giving you a pair instead of a linked list

(list 1 2 3) ; This automatically makes a list of all elements included, to n length with implied null termination

(define (listsum x) ; recursive list sum
  (cond
    ((null? x) 0) ; if null return 0
    (else
      (+ (car x) (listsum (cdr x)))))) ; else add first half of list and run on back half

(define twisty '(("a" ("b" "c" "d") ("e" 743)) "g"))

(car twisty) ; returns all elements except "g", as they are all part of the first element of the cons
(cdr twisty) ; returns "g"
(car (car twisty)) ; returns a, as it is the first half of first half
(caar twisty) ; returns a, as it is 2 "car"s
