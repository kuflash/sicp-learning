#lang racket/base

(require rackunit)

(define (square a) (* a a))
(define (cube a) (* a a a))
(define (inc a) (+ a 1))

(define (sum term a next b)
    (if (> a b) 0
        (+ 
            (term a)
            (sum term (next a) next b)
        )
    )
)

(define (sum-iter term a next b)
    (define (iter a result)
        (if (> a b) result
            (iter (next a) (+ (term a) result))
        )
    )
    (iter a 0)
)

(check-equal? (sum-iter cube 1 inc 3) (sum cube 1 inc 3))
(check-equal? (sum-iter square 1 inc 5) (sum square 1 inc 5))

