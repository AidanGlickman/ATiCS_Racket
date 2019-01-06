; LISTS

(define (test func expect)
  (displayln (~a func " expects " expect)))

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

(test (get-element '(3 2 1) 0) 3)
(test (get-element '(3 2 1) 1) 2)
(test (get-element '(3 2 1) 2) 1)
(test (get-element '(3 2 1) 3) null)

;|#

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

(test (append-element '(4 3 2) 1) '(4 3 2 1))
(test (append-element '() 1) '(1))
(test (append-element '(1) '()) '(1 '()))

;|#

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

(test (append-list '(1 2 3 4) '(5 6 7 8)) '(1 2 3 4 5 6 7 8))
(test (append-list '() '(5 6 7 8)) '(5 6 7 8))
(test (append-list '(1 2 3 4) '()) '(1 2 3 4))

;|#

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

(test (backwards '(1 2 3 4)) '(4 3 2 1))
(test (backwards '(1)) '(1))
(test (backwards '()) '())

;|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CREDIT CARDS

; We need to first find the digits of a number. Define the functions (toDigits : integer -> list) (toDigitsRev : integer -> list)

(define (to-digits integer) 
  (define last-digit (remainder integer 10))
  (define other-digits (quotient integer 10))
  (cond
     ((not (exact-positive-integer? integer)) 
      '())
     (else 
       (append-element (to-digits other-digits) last-digit))))

(define (to-digits-rev integer)
  (backwards (to-digits integer)))

#| TEST CASES: 

(test (to-digits 1234) '(1 2 3 4))
(test (to-digits 0) '())
(test (to-digits -10) '())

;|#

; Once we have the digits in the proper order, we need to double every other one. Define a function (doubleEveryOther : list -> list) Remember that doubleEveryOther should double every other number beginning from the right, that is, the second-to-last, fourth-to-last,… etc. numbers are doubled.

(define (double-every-other list)
  (define (dub-2nd-last list)
    (* 2 (cadr list)))
  (define (create-list x y)
    (cons x (cons y null)))
  
  (define (double-backwards list)
    (cond
      ((null? list)
       null)
      ((null? (cdr list))
       list)
      ((null? (cddr list)) 
       (create-list (car list) (dub-2nd-last list)))
      (else
        (cons (car list) (cons (dub-2nd-last list) (double-backwards (cddr list)))))))
  (backwards (double-backwards (backwards list))))

#| TEST CASES:

(test (double-every-other '(1 2 3 4)) '(2 2 6 4))
(test (double-every-other '(1 2 3)) '(1 4 3))
(test (double-every-other '(1)) '(1))

;|#

; Define the function sumDigits : list -> integer to calculate the sum of all digits.

(define (sum-digits list)
  (define (sum-of-num x) 
    (define last-digit (modulo x 10))
    (if (= x 0) 0 (+ last-digit (sum-of-num (/ (- x last-digit) 10)))))
  (define (all-but-last list) (backwards (cdr (backwards list))))
  (define (last list) (car (backwards list)))
  (cond
    ((null? list)
     0)
    ((null? (cdr list))
     (car list))
    (else
      (sum-digits (append-element (all-but-last (cdr list)) (+ (last list) (sum-of-num (car list))))))))

#| TEST CASES:

(test (sum-digits '(1 2 3 4)) 10)
(test (sum-digits '(10 2 3 4)) 10)
(test (sum-digits '()) 0)

;|#

; Define the function validate : integer -> boolean that indicates whether an Integer could be a valid credit card number.

(define (validate integer)
  (cond
    ((zero? (modulo (sum-digits (double-every-other (to-digits integer))) 10))
     true)
    (else
      false)))

#| TEST CASES:

(test (validate 34) #t)
(test (validate 123456789) #f)
(test (validate 4012888888881881) #t)
(test (validate 4012888888881882) #f)
(test (validate 0) #t)

;|#