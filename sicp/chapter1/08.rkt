#lang racket/base

(require rackunit)

(define (sqrt-iter guess prev-guess x)
    (if (good-enough? (- prev-guess guess) guess) guess
        (sqrt-iter (improve guess x) guess x)
    )
)

(define (good-enough? diff guess)
    (< (/ (abs diff) guess) 0.0000000000001)
)

(define (square x)
    (* x x)
)

(define (improve guess x)
    (/ (+ (/ x (square guess)) (* 2 guess)) 3)
)

(define (proportion x y)
    (/ x y)
)

(define (cubic-sqrt x)
  (sqrt-iter 1.0 0 x)
)

(check-equal? (cubic-sqrt 27) 3.0)
(check-equal? (cubic-sqrt 64) 4.0)
(check-equal? (cubic-sqrt 1000) 10.0)