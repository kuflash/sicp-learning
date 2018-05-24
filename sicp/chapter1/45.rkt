#lang racket/base

(require rackunit)

(define (power a b) 
    (exp (* b (log a)))
)

(define (log2 x) 
    (/ (log x) (log 2))
)

(define (average x y)
    (/ (+ x y) 2)
)

(define (average-damp f)
    (lambda (x) (average x (f x)))
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

(define (fixed-point f first-guess)
    (define tolerance 0.00001)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next)
            )
        )
    )
    (try first-guess)
)

(define (calc-root pow x)
    (define (f y) (/ x (power y (- pow 1))))
    (define count-damp (log2 pow))
    (fixed-point ((repeated average-damp count-damp) f) 1.0)
)