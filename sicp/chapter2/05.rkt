#lang racket/base

(require rackunit)

(define (pow base exp)
    (define (power-iter result counter)
        (if (= counter 0) result
            (power-iter (* result base) (- counter 1))
        )
    )
    (power-iter 1 exp)
)

(define (factor base source)
    (define (factor-iter value counter)
        (if (= (remainder value base) 0)
            (factor-iter (/ value base) (+ counter 1))
            counter
        )
    )
    (factor-iter source 0)
)

(define (cons a b)
    (* (pow 2 a) (pow 3 b))
)

(define (car couple)
    (factor 2 couple)
)

(define (cdr couple)
    (factor 3 couple)
)

(check-equal? (car (cons 10 2)) 10)
(check-equal? (cdr (cons 10 2)) 2)