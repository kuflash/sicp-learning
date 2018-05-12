#lang racket/base

(require rackunit)

(define (even? n)
    (= (remainder n 2) 0)
)

(define (double x) (* x 2))
(define (halve x) (/ x 2))

(define (mult x y)
    (cond
        ((= y 0) 0)
        ((= x 1) y)
        ((even? y) (double (mult x (halve y))))
        (else (+ x (mult x (- y 1))))
    )
)

(check-equal? (mult 2 6) 12)
(check-equal? (mult 6 6) 36)
(check-equal? (mult 10 10) 100)