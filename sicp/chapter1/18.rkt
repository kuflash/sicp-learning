#lang racket/base

(require rackunit)

(define (even? n)
    (= (remainder n 2) 0)
)

(define (double x) (* x 2))
(define (halve x) (/ x 2))

(define (mult-iter a x y)
    (cond
        ((= y 0) a)
        ((even? y) (mult-iter a (double x) (halve y)))
        (else (mult-iter (+ a x) x (- y 1)))
    )
)

(define (mult x y)
    (mult-iter 0 x y)
)

(check-equal? (mult 2 6) 12)
(check-equal? (mult 6 6) 36)
(check-equal? (mult 10 10) 100)