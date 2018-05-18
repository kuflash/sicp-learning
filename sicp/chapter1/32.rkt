#lang racket/base

(require rackunit)

(define (accumulate combiner null-value term a next b)
    (if (> a b) null-value
        (combiner
            (term a)
            (accumulate combiner null-value term (next a) next b)
        )
    )
)

(define (accumulate-iterate combiner null-value term a next b)
    (define (iterate a result)
        (if (> a b) result
            (iterate (next a) (combiner result (term a)))
        )
    )
    (iterate a null-value)
)

(define (product term a next b)
    (accumulate * 1 term a next b)
)

(define (product-iterate term a next b)
    (accumulate-iterate * 1 term a next b)
)

(define (sum term a next b)
    (accumulate + 0 term a next b)
)

(define (sum-iterate term a next b)
    (accumulate-iterate + 0 term a next b)
)

(define (factorial n)
    (define (inc a) (+ 1 a))
    (define (identity a) a)
    (product identity 1 inc n)
)

(define (factorial-iterate n)
    (define (inc a) (+ 1 a))
    (define (identity a) a)
    (product-iterate identity 1 inc n)
)

(define (sum-square n)
    (define (square x) (* x x))
    (define (inc x) (+ 1 x))
    (sum square 0 inc n)
)

(define (sum-square-iterate n)
    (define (square x) (* x x))
    (define (inc x) (+ 1 x))
    (sum-iterate square 1 inc n)
)

(check-equal? (factorial 1) 1)
(check-equal? (factorial 2) 2)
(check-equal? (factorial 3) 6)
(check-equal? (factorial 4) 24)
(check-equal? (factorial 5) 120)

(check-equal? (factorial-iterate 1) 1)
(check-equal? (factorial-iterate 2) 2)
(check-equal? (factorial-iterate 3) 6)
(check-equal? (factorial-iterate 4) 24)
(check-equal? (factorial-iterate 5) 120)

(check-equal? (sum-square 1) 1)
(check-equal? (sum-square 2) 5)
(check-equal? (sum-square 3) 14)

(check-equal? (sum-square-iterate 1) 1)
(check-equal? (sum-square-iterate 2) 5)
(check-equal? (sum-square-iterate 3) 14)