#lang racket/base

(require rackunit)

(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (add-interval x y)
    (make-interval
        (+ (lower-bound x) (lower-bound y))
        (+ (upper-bound x) (upper-bound y))
    )
)

(define (sub-interval x y)
    (make-interval
        (- (lower-bound x) (upper-bound y))
        (- (upper-bound x) (lower-bound y))
    )
)

(define (mul-interval x y)
    (let
        (
            (p1 (* (lower-bound x) (lower-bound y)))
            (p2 (* (lower-bound x) (upper-bound y)))
            (p3 (* (upper-bound x) (lower-bound y)))
            (p4 (* (upper-bound x) (upper-bound y)))
        )
        (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))
    )
)

(define (div-interval x y)
    (define valid?
        (> (* (lower-bound y) (upper-bound y)) 0)
    )
    (if valid?
        (mul-interval x
            (make-interval
                (/ 1.0 (upper-bound y))
                (/ 1.0 (lower-bound y))
            )
        )
        (error "Second interval shouldn't across zero value" y)
    )
)

(check-equal?
    (add-interval
        (make-interval 2 6)
        (make-interval 4 8)
    )
    (make-interval 6 14)
)

(check-equal?
    (sub-interval
        (make-interval 2 6)
        (make-interval 4 8)
    )
    (make-interval -6 2)
)

(check-equal?
    (mul-interval
        (make-interval 2 6)
        (make-interval 4 8)
    )
    (make-interval 8 48)
)

(check-equal?
    (div-interval
        (make-interval 2 6)
        (make-interval 4 8)
    )
    (make-interval 0.25 1.5)
)