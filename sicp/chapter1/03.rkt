#lang racket/base

(require rackunit)

(define (square x) 
  (* x x)
)

(define (sum-squares-of-max-values a b c)
  (cond 
    ((and (< a b) (< a c))
      (+ (square b) (square c)))
    ((and (< b c) (< b a))
      (+ (square a) (square c)))
    (else
      (+ (square a) (square b)))
  )
)

(check-equal? (sum-squares-of-max-values 1 2 3) 13)
(check-equal? (sum-squares-of-max-values 1 3 2) 13)
(check-equal? (sum-squares-of-max-values 2 3 1) 13)
(check-equal? (sum-squares-of-max-values 2 1 3) 13)
(check-equal? (sum-squares-of-max-values 3 2 1) 13)
(check-equal? (sum-squares-of-max-values 3 1 2) 13)
