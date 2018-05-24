#lang racket/base

(require rackunit)

(define (iterative-improve close-enough? improve)
    (lambda (guess prev-guess)
        (if (close-enough? guess prev-guess) guess
            ((iterative-improve close-enough? improve) (improve guess) guess)
        )
    )
)

(define (fixed-point f first-guess)
    (define tolerance 0.00001)
    ((iterative-improve
        (lambda (x y)
            (< (abs (- x y)) tolerance)
        )
        f
    ) first-guess 0)
)

(define (newton-transform g)
    (define dx 0.00001)
    (define (deriv g)
        (lambda (x)
            (/ (- (g (+ x dx)) (g x)) dx)
        )
    )
    (lambda (x)
        (- x (/ (g x) ((deriv g) x)))
    )
)

(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess)
)

(define (cubic a b c)
    (lambda (x)
        (+
            (* x x x)
            (* a (* x x))
            (* b x)
            c
        )
    )
)

(define (sqrt x)
    (define (average x y)
       (/ (+ x y) 2)
    )
    ((iterative-improve
        (lambda (x y)
            (< (/ (abs (- y x)) x) 0.0000000000001)
        )
        (lambda (guess)
            (average guess (/ x guess))
        )
    ) 1.0 0)
)


(check-equal? (sqrt 4) 2.0)
(check-equal? (sqrt 16) 4.0)
(check-equal? (floor (newtons-method (cubic 0 0 -8) 1)) 2.0)