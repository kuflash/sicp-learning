#lang racket/base

(require rackunit)

(define (even? n)
    (= (remainder n 2) 0)
)

(define (square x)
    (* x x)
)

(define (fast-expt-iter a b n)
    (cond
        ((= n 0) a)
        ((even? n) (fast-expt-iter a (square b) (/ n 2)))
        (else (fast-expt-iter (* a b) b (- n 1)))
    )
)

(define (fast-expt b n)
    (fast-expt-iter 1 b n)
)

(check-equal? (fast-expt 2 4) 16)
(check-equal? (fast-expt 2 5) 32)
(check-equal? (fast-expt 2 6) 64)

