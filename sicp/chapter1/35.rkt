#lang racket/base

(require rackunit)

(define tolerance 0.00001)
(define (fixed-point f first-guess)
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
(define (φ)
    (fixed-point
        (lambda (x) (+ 1 (/ 1 x)))
        0.001
    )
)

;;; 1 + 1 / 1.61803398 = 1.61803278 ~= 1.61803398

(check-equal? (φ) 1.6180327895683542)