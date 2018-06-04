#lang racket/base

(require rackunit)

(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (make-center-width c w)
    (make-interval (- c w) (+ c w))
)

(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2)
)
(define (width i)
    (/ (- (upper-bound i) (lower-bound i)) 2)
)

(define (percent i)
    (* (/ (width i) (center i)) 100)
)

(define (make-center-percent center percent)
    (make-center-width center (* center (/ percent 100)))
)

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

(check-equal? (make-center-percent 400 3) (make-interval 388 412))