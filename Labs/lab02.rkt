;
(define (get-element list n)
  (cond
    ((zero? n)
     (car list))
    (else
      (get-element (cdr list) (- n 1)))))

(list 3 2 1)
(get-element (list 3 2 1) 0)