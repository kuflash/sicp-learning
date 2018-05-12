#lang racket/base

(require rackunit)

(define (even? n)
    (= (remainder n 2) 0)
)

(define (double x) (* x 2))

(define (square x)
    (* x x)
)

(define (fib n)
    (fib-iter 1 0 0 1 n)
)
(define (fib-iter a b p q count) 
    (cond
        ((= count 0) b)
        ((even? count)
            (fib-iter
                a
                b
                (+ (square p) (square q))
                (+ (* 2 p q) (square q))
                (/ count 2)
            )
        )
        (else
            (fib-iter
                (+ (* b q) (* a q) (* a p))
                (+ (* b p) (* a q))
                p
                q
                (- count 1)
            )
        )
    )
)

(check-equal? (fib 0) 0)
(check-equal? (fib 1) 1)
(check-equal? (fib 2) 1)
(check-equal? (fib 3) 2)
(check-equal? (fib 4) 3)
(check-equal? (fib 5) 5)