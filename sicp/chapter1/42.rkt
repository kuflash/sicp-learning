#lang racket/base

(require rackunit)

(define (inc x) (+ x 1))
(define (square x) (* x x))

(define (compose f g)
    (lambda (x) (f (g x)))
)

(check-equal? ((compose square inc) 6) 49)