#lang racket/base

(require rackunit)

(define (make-point x y)
    (cons x y)
)

(define (x-point point) (car point))
(define (y-point point) (cdr point))

(define (make-segment start end)
    (cons start end)
)
(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))

(define (midpoint-segment segment)
    (define (midcoord point-selector)
        (/
            (+
                (point-selector (start-segment segment))
                (point-selector (end-segment segment))
            )
            2
        )
    )
    (make-point
        (midcoord x-point)
        (midcoord y-point)
    )
)

(define (print-point p)
    (newline)
    (display "(")
    (display (x-point p))
    (display ",")
    (display (y-point p))
    (display ")")
)

(check-equal? (midpoint-segment
    (make-segment
        (make-point 1 1)
        (make-point 6 6)
    )
) (cons 7/2 7/2))

(check-equal? (midpoint-segment
    (make-segment
        (make-point 0 0)
        (make-point 1 1)
    )
) (cons 1/2 1/2))

(check-equal? (midpoint-segment
    (make-segment
        (make-point 1 1)
        (make-point 5 5)
    )
) (cons 3 3))
