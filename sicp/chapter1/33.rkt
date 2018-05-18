#lang racket/base

(require rackunit)

(define (filtered-accumulate combiner predicate null-value term a next b)
    (if (> a b) null-value
        (if (predicate a)
            (combiner
                (term a)
                (filtered-accumulate combiner predicate null-value term (next a) next b)
            )
            (filtered-accumulate combiner predicate null-value term (next a) next b)
        )
    )
)

(define (sum-square-primes-in-range a b)
    (define (square x) (* x x))
    (define (divides? a b)
        (= (remainder b a) 0)
    )
    (define (find-divisor n test-divisor)
        (cond
            ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor 1)))
        )
    )
    (define (smallest-divisor n)
        (find-divisor n 2)
    )
    (define (is-prime n)
        (= n (smallest-divisor n))
    )
    (define (inc a) (+ 1 a))
    (filtered-accumulate + is-prime 0 square a inc b)
)

(define (mult-primes-relative-n n)
    (define (gcd a b)
        (if (= b 0) a
            (gcd b (remainder a b))
        )
    )
    (define (is-valid a)
        (= (gcd n a) 1)
    )
    (define (inc a) (+ 1 a))
    (define (identity a) a)
    (filtered-accumulate * is-valid 1 identity 1 inc n)
)

(check-equal? (sum-square-primes-in-range 1 3) 14)
(check-equal? (sum-square-primes-in-range 1 6) 39)
(check-equal? (sum-square-primes-in-range 1 10) 88)

(check-equal? (mult-primes-relative-n 3) 2)
(check-equal? (mult-primes-relative-n 5) 24)