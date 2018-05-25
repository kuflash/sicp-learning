#lang racket/base

(require rackunit)

(define (gcd a b)
    (if (= b 0) a
        (gcd b (remainder a b))
    )
)

(define (make-rat n d)
    (let (
        (g (gcd (abs n) (abs d)))
        (normalize (cond
                ((< d 0) -1)
                ((> d 0) 1)
                (else 0)
            )
        )
    )
        (cons (* (/ n g) normalize) (* (/ d g) normalize))
    )
)
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (add-rat x y)
    (make-rat
        (+
            (* (numer x) (denom y))
            (* (numer y) (denom x))
        )
        (* (denom x) (denom y))
    )
)
(define (sub-rat x y)
    (make-rat
        (-
            (* (numer x) (denom y))
            (* (numer y) (denom x))
        )
        (* (denom x) (denom y))
    )
)
(define (mul-rat x y)
    (make-rat
        (* (numer x) (numer y))
        (* (denom x) (denom y))
    )
)
(define (div-rat x y)
    (make-rat
        (* (numer x) (denom y))
        (* (denom x) (numer y))
    )
)

(define (print-rat x)
  (display (numer x))
  (display "/")
  (display (denom x))
  (newline)
)

(check-equal? (make-rat 5 10) (cons 1 2))
(check-equal? (make-rat 5 -10) (cons -1 2))
(check-equal? (make-rat -5 -10) (cons 1 2))
(check-equal? (make-rat -5 10) (cons -1 2))
