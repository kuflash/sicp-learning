#lang racket/base

(require rackunit)

(define (product term a next b)
    (if (> a b) 1
        (* (term a) (product term (next a) next b))
    )
)

(define (product-iterate term a next b)
    (define (iterate a result)
        (if (> a b) result
            (iterate (next a) (* result (term a)))
        )
    )
    (iterate a 1)
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

(define (pi-approximate n)
    (define (even? a)
        (= (remainder a 2) 0)
    )
    (define (inc a) (+ 1 a))
    (define (numerator x)
        (cond
            ((= x 1) 2)
            ((even? x) (+ x 2))
            (else (+ (remainder x 2) x))
        )
    )
    (define (denominator x)
        (if (even? x) (+ x 1) (+ x 2))
    )
    (/
        (product numerator 1 inc n)
        (product denominator 1 inc n)
    )
)

(define (pi-approximate-iterate n)
    (define (even? a)
        (= (remainder a 2) 0)
    )
    (define (inc a) (+ 1 a))
    (define (numerator x)
        (cond
            ((= x 1) 2)
            ((even? x) (+ x 2))
            (else (+ (remainder x 2) x))
        )
    )
    (define (denominator x)
        (if (even? x) (+ x 1) (+ x 2))
    )
    (/
        (product-iterate numerator 1 inc n)
        (product-iterate denominator 1 inc n)
    )
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

(check-equal? (pi-approximate 1) 2/3)
(check-equal? (pi-approximate 2) 8/9)
(check-equal? (pi-approximate 3) 32/45)

(check-equal? (pi-approximate-iterate 1) 2/3)
(check-equal? (pi-approximate-iterate 2) 8/9)
(check-equal? (pi-approximate-iterate 3) 32/45)