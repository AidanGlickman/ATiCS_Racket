; LISTS

; Make (get-element list n) which takes a list and returns the nth element.  (Just like arrays, we will start counting from zero).  This is mimicking the list-ref function.

(define (get-element list n)
  (cond
    ((null? list)
     null)
    ((zero? n)
     (car list))
    (else
      (get-element (cdr list) (- n 1)))))

#| TEST CASES:

(get-element '(3 2 1) 0) : 3
(get-element '(3 2 1) 1) : 2
(get-element '(3 2 1) 2) : 1

|#

; Make (append-element list y) which takes a list x and an element, y, and returns list with y added to the end.  This is mimicking the append function.
; LIST FUNCTIONS
(define (append-element list y)
  (cond
    ((null? list)
     (cons y null))
    ((null? (cdr list))
        (cons (car list) (cons y null)))
    (else
    	(cons (car list) (append-element (cdr list) y)))))

#| TEST CASES:

(append-element '(4 3 2) 1) : '(4 3 2 1)

|#

; Make (append-list first second) which takes a list first and a list second, and returns a combined list. This is mimicking the append function.

(define (append-list first second)
  (cond
    ((null? second)
     first)
    ((null? (cdr second))
     (append-element first (car second)))
    (else
      (append-list (append-element first (car second)) (cdr second)))))

#| TEST CASES:

(append-list '(1 2 3 4) '(5 6 7 8)) : '(1 2 3 4 5 6 7 8)

|#

; Make (backwards list) which takes a list, and returns a reversed list. This is mimicking the reverse function.

(define (backwards list)
  (cond
    ((null? list)
     null)
    ((null? (cdr list))
      list)
  (else
    (append-element (backwards (cdr list)) (car list)))))

#| TEST CASES:

(backwards '(1 2 3 4)) : '(4 3 2 1)

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CREDIT CARDS

; We need to first find the digits of a number. Define the functions (toDigits : integer -> list) (toDigitsRev : integer -> list)

(define (to-digits integer) 
  (cond
     ((not (exact-positive-integer? integer)) 
      `())
     (else 
       (append-list (to-digits (quotient integer 10)) (list (remainder integer 10))))))

(define (to-digits-rev integer)
  (backwards (to-digits integer)))

#| TEST CASES: 

(to-digits 1234) : '(1 2 3 4)
(to-digits 0)    : '()
(to-digits -12)  : '()

(to-digits-rev 1234) : '(4 3 2 1)

|#

; Once we have the digits in the proper order, we need to double every other one. Define a function (doubleEveryOther : list -> list) Remember that doubleEveryOther should double every other number beginning from the right, that is, the second-to-last, fourth-to-last,… etc. numbers are doubled.

(define (double-every-other list)
  (define (create-list x y)
    (cons x (cons y null)))
  
  (define (double-backwards list)
    (cond
      ((null? list)
       null)
      ((null? (cdr list))
       list)
      ((null? (cddr list)) 
       (create-list (car list) (* 2 (cadr list))))
      (else
        (cons (car list) (cons (* 2 (cadr list)) (double-backwards (cddr list)))))))
  (backwards (double-backwards (backwards list))))

#| TEST CASES:

(double-every-other '(1 2 3 4)) : '(2 2 6 4)

|#

; Define the function sumDigits : list -> integer to calculate the sum of all digits.

(define (sum-digits list)
  (define (sum-of-num x) (if (= x 0) 0 (+ (modulo x 10) (sum-of-num (/ (- x (modulo x 10)) 10)))))
  (define (all-but-last list) (backwards (cdr (backwards list))))
  (define (last list) (car (backwards list)))
  (cond
    ((null? list)
     null)
    ((null? (cdr list))
     (car list))
    (else
      (sum-digits (append-element (all-but-last (cdr list)) (+ (last list) (sum-of-num (car list))))))))

; NOTE: I know this function isn't perfect (if the last element is double digits it returns the wrong answer) BUT, due to the nature of the broader problem this edge case can literally never occur (the last element is never doubled, as it is every other from the right)

#| TEST CASES:

(sum-digits '(1 2 3 4)) : 10
(sum-digits '(10 2 3 4)) : 10

|#

; Define the function validate : integer -> boolean that indicates whether an Integer could be a valid credit card number.

(define (validate integer)
  (cond
    ((zero? (modulo (sum-digits (double-every-other (to-digits integer))) 10))
     true)
    (else
      false)))

#|

TEST CASES:

(validate 34) : #t
(validate 123456789) : #f
(validate 4012888888881881) : #t
(validate 4012888888881882) : #f

|#