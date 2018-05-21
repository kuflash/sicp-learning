#lang racket/base

(require rackunit)

(define tolerance 0.00001)

(define (average x y)
    (/ (+ x y) 2)
)

(define (report a)
    (display a) 
    (newline) 
)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (report next)
            (if (close-enough? guess next)
                next
                (try next)
            )
        )
    )
    (try first-guess)
)

;;; (fixed-point
;;;     (lambda (x) (average x (/ (log 1000) (log x))))
;;;     2
;;; )

;;; 35 шагов

;;; (fixed-point
;;;     (lambda (x) (average x (/ (log 1000) (log x))))
;;;     2
;;; )

;;; 10 шагов

;;; (check-equal? (φ) 1.6180327895683542)