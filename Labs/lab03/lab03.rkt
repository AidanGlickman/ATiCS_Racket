;#lang racket

;;;;;;;;;;;;;;;;;;;;;;;
; WARM-UP

(define (test func expect)
  (displayln (~a func " expects " expect)))

#|
Create the following two functions:
func1(x) = x^2+2
func2 = λx→x^2+2
|#

(define (func-1 x)
  (+ (expt x 2) 2))

(define func-2 
  (λ (x) (+ (expt x 2) 2)))

; Create tests to show that your two functions are the same.

(define (first-part-test num-tests)
  (cond
    ((zero? num-tests)
     #t)
    (else
      (cond
        ((eq? (func-1 num-tests) (func-2 num-tests))
         (first-part-test (- num-tests 1)))
        (else
          #f)))))

#| TEST
  (displayln (~a "First Part Test: " (first-part-test 100)))
;|#

#|
Create:
dec = λx→x-1
|#

(define dec
  (λ (x) (- x 1)))

#| TEST
  (test (dec 2) 1)
  (test (dec 0) -1)
  (test (dec -1) -2)
;|#

;;;;;;;;;;;;;;;;;;;;;;;
; Consing a list of two

(define operate
  (λ (f)
    (λ (a b)
      (list (f a) (f b)))))

#| TEST
  (test ((operate (λ (x) (+ x x))) 3 4) '(6 8))
;|#

(define times3
  (operate (λ (x) (* x 3))))

#| TEST
  (test (times3 3 4) '(9 12))
;|#

;;;;;;;;;;;;;;;;;;;;;;;;;
; Maps

(define evens
  (λ (list)
    (map even? list)))

#| TEST
  (test (evens '(1 2 3 4 5 6)) '(#f #t #f #t #f #t))
;|#

(define list4times
  (λ (list)
    (map
      (λ (x) (* x 4)) list)))

#| TEST
  (test (list4times '(1 2 3 4 5 6)) '(4 8 12 16 20 24))
;|#

;;;;;;;;;;;;;;;;;;;;;;;;
; Infix

(define op
  (λ (f a b)
    (f a b)))

(define (prepend x ls)
  (append (list x) ls))

(define (rpn ls [stack '()])
  (cond
    ((null? ls)
      (car stack))
    ((number? (car ls))
     (rpn (cdr ls) (prepend (car ls) stack)))
    (else
      (rpn (cdr ls) (prepend (op (car ls) (cadr stack) (car stack)) (cddr stack))))))

#| TEST
  (test (rpn (list 3 4 5 + /)) 1/3)
  (test (rpn (list 2 5 *)) 10) 
;|#

(define (precedence op)
  (cond
    ((or (eq? op +) (eq? op -))
     0)
    ((or (eq? op *) (eq? op /))
     1)))

(define (operator? x)
  (cond
    ((or (eq? x +) (eq? x -) (eq? x *) (eq? x /))
     #t)
    (else
      #f)))
    
(define (eval-out operands operators)
  (cond
    ((null? operators)
     (reverse operands))
    (else (eval-out (prepend (car operators) operands) (cdr operators)))))

(define (evaluate ls [operands '()] [operators '()])
  (cond
    ((null? ls)
     (eval-out operands operators))
    ((number? (car ls))
     (evaluate (cdr ls) (prepend (car ls) operands) operators))
    ((operator? (car ls))
     (cond
       ((or (null? operators) (eq? "(" (car operators)) (> (precedence (car ls)) (precedence (car operators))))
          (evaluate (cdr ls) operands (prepend (car ls) operators)))
       (else
          (evaluate ls (prepend (car operators) operands) (cdr operators)))))
    ((eq? "(" (car ls))
     (evaluate (cdr ls) operands (prepend (car ls) operators)))
    ((eq? ")" (car ls))
     (cond
       ((eq? (car operators) "(")
        (evaluate (cdr ls) operands (cdr operators)))
       (else
         (evaluate ls (prepend (car operators) operands) (cdr operators)))))))

(define (infix ls)
  (rpn (evaluate ls)))

#| CITATIONS
Learned how to do default parameters from this stack overflow: https://stackoverflow.com/questions/7133401/setting-default-argument-value-in-racket
|#