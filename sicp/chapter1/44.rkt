#lang racket/base

(require rackunit)

(define (square x) (* x x))

(define (average x y z)
    (/ (+ x y z) 3)
)

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

(define (smooth f dx)
    (lambda (x)
        (average (f (- x dx)) (f x) (f (+ x dx)))
    )
)

(define (n-smoothed f dx n)
    ((repeated (lambda (g) (smooth g dx)) n) f)
)

;;; (check-equal? ((repeated square 2) 5) 625)