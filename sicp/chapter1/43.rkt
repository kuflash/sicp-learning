#lang racket/base

(require rackunit)

(define (square x) (* x x))

(define (compose f g)
    (lambda (x) (f (g x)))
)

(define (repeated f n)
    (define (id x) x)
    (define (repeater g i)
        (if (> i n) g
            (repeater (compose f g) (+ i 1))
        )
    )
    (repeater id 1)
)

(check-equal? ((repeated square 2) 5) 625)