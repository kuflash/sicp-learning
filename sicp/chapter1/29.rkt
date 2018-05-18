#lang racket/base

(require rackunit)

(define (cube a) (* a a a))

(define (sum term a next b)
    (if (> a b) 0
        (+ 
            (term a)
            (sum term (next a) next b)
        )
    )
)

(define (integral f a b dx)
    (define (add-dx x) (+ x dx))
    (*
        (sum f (+ a (/ dx 2)) add-dx b)
        dx
    )
)

(define (simpson-itegral f a b n)
    (define (even? x)
        (= (remainder x 2) 0)
    )
    (define h (/ (- b a) n))
    (define (y-factor x)
        (cond 
            ((or (= x n) (= x 0)) 1)
            ((even? x) 2)
            (else 4)
        )
    )
    (define (y k)
        (*
            (y-factor k)
            (f (+ a (* k h)))
        )
    )
    (define (inc k) (+ k 1)) 
    (*
        (/ h 3)
        (sum y 0 inc n)
    )
)
;;; (integral cube 0 1 0.01)
;;; (simpson-itegral cube 0 1 100)

;;; (integral cube 0 1 0.001)
;;; (simpson-itegral cube 0 1 1000)

(check-equal? (integral cube 0 1 0.01) 0.24998750000000042)
(check-equal? (integral cube 0 1 0.001) 0.249999875000001)
(check-equal? (simpson-itegral cube 0 1 1000) 1/4)
(check-equal? (simpson-itegral cube 0 1 1000) 1/4)