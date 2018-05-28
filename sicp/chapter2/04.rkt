#lang racket/base

(require rackunit)

(define (cons x y)
    (lambda (m) (m x y))
)

(define (car z)
    (z (lambda (p q) p))
)

(define (cdr z)
    (z (lambda (p q) q))
)

;;; (car (cons 1 2))
;;; ((cons 1 2) (lambda (p q) p))
;;; ((lambda (m) (m x y)) (lambda (p q) p))
;;; ((lambda (p q) p) x y)
;;; ((lambda (x y) x))
;;; x

(check-equal? (car (cons 1 2)) 1)
(check-equal? (cdr (cons 1 2)) 2)
