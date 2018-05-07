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
    (average guess (/ x guess))
)

(define (average x y)
  (/ (+ x y) 2)
)

(define (proportion x y)
    (/ x y)
)

(define (sqrt x)
  (sqrt-iter 1.0 0 x)
)

(check-equal? (sqrt 4) 2.0)
(check-equal? (sqrt 9) 3.0)
(check-equal? (sqrt 10000) 100.0)