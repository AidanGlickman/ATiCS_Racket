#lang racket

; 1. (Extremely Easy) Make a function, y-intercept that takes two arguments, m, and b, and determines the y-intercept of a line.
(define (y-intercept m b)
  b
  )
#| TEST CASES:
(y-intercept 0) : 0
|#

; 2. (Easy) Make a function, x-intercept, that takes two arguments, m, and b, and determines the x-intercept of a line.
(define (x-intercept m b)
  (/ (- 0 b) m)
  )
#| TEST CASES:
(x-intercept 1 1) : -1
(x-intercept 0 1) : Divide by Zero
|#

; 3. (Medium-Easy) Make a function, triangle-area, that takes two arguments, m, and b, and determines the area of the triangle defined by the y-axis, the x-axis, and the line formed by m and b.
(define (triangle-area m b)
  (/ (abs (* (x-intercept m b) (y-intercept m b))) 2)
  )
#| TEST CASES:
(triangle-area 1 1)  : 1/2
(triangle-area -1 1) : 1/2
(triangle-area 0 1)  : Divide by Zero
|#

; 4. (Medium) Consider the function: (define (modadd low high current addnum) This function will return the result of adding addnum to current within a modular circule from low to high. You may assume that current is within the bounds of low to high (inclusive).
(define (modadd low high current addnum)
  (+ (modulo (- (+ addnum current) low) (- high (- low 1))) low)
  )
#| TEST CASES:
(modadd 4 7 5 0)  :  5
(modadd 4 7 5 1)  :  6
(modadd 4 7 5 2)  :  7
(modadd 4 7 5 3)  :  4
(modadd -2 1 0 0) :  0
(modadd -2 1 0 1) :  1
(modadd -2 1 0 2) : -2
(modadd -2 1 0 3) : -1
|#

; 5. (Medium (possibly Medium-Hard)) Consider the function: (define (modsub low high current subnum) This function will return the result of subtracting subnum from current within a modular circule from low to high.  You may assume that current is within the bounds of low to high (inclusive).
(define (modsub low high current subnum)
  (+ (modulo (- (- current subnum) low) (- high (- low 1))) low)
  )
#| TEST CASES:
(modsub 4 7 5 0)  :  5
(modsub 4 7 5 1)  :  4
(modsub 4 7 5 2)  :  7
(modsub 4 7 5 3)  :  6
(modsub -2 1 0 0) :  0
(modsub -2 1 0 1) : -1
(modsub -2 1 0 2) : -2
(modsub -2 1 0 3) :  1
|#

; 6. (Hard) Make a function called addtime that takes a properly formatted hour and minute int (such as 130 or 1245) and a number of minutes to add.  It should return a properly formatted int with the new time returned.

(define (addtime time mins)
  (define (extract-hours time)
  	(quotient time 100)
  	)

  (define (extract-mins time)
  	(remainder time 100)
  	)

  (define (combine-time hours mins)
    (+ (* hours 100) mins)
    )

  (define (add-mins time mins)
  	(+ (extract-mins time) mins)
  	)
  (combine-time (modadd 1 12 (extract-hours time) (quotient (add-mins time mins) 60)) (remainder (add-mins time mins) 60))
  )
#| TEST CASES:
(addtime 1230 1)  : 1231
(addtime 1230 2)  : 1232
(addtime 1230 29) : 1259
(addtime 1230 30) : 100
(addtime 1230 91) : 201
(addtime 545 60)  : 645
(addtime 545 135) : 800

|#