#lang racket/base

(require rackunit)

(define (x-point point) (car point))
(define (y-point point) (cdr point))
(define (make-point x y)
    (cons x y)
)

(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))
(define (make-segment start end)
    (cons start end)
)

(define (get-width rect)
    (-
        (x-point (end-segment (car rect)))
        (x-point (start-segment (car rect)))
    )
)
(define (get-height rect)
    (-
        (y-point (end-segment (cdr rect)))
        (y-point (start-segment (cdr rect)))
    )
)
(define (perimetr rect)
    (* (+ (get-width rect) (get-height rect)) 2)
)
(define (area rect)
    (* (get-width rect) (get-height rect))
)
(define (make-rect x y w h)
    (cons
        (make-segment
            (make-point x y)
            (make-point (+ x w) y)
        )
        (make-segment
            (make-point x y)
            (make-point x (+ y h))
        )
    )
)

(define (make-alter-rect top-left-point bottom-right-point)
    (cons
        (make-segment
            top-left-point
            (make-point
                (+ (x-point top-left-point) (x-point bottom-right-point))
                (y-point top-left-point)
            )
        )
        (make-segment
            top-left-point
            (make-point
                (x-point top-left-point)
                (+ (y-point top-left-point) (y-point bottom-right-point))
            )
        )
    )
)

(check-equal? (perimetr
    (make-rect 0 0 4 4)
) 16)
(check-equal? (area
    (make-rect 0 0 4 4)
) 16)

(check-equal? (perimetr
    (make-rect 0 0 4 6)
) 20)
(check-equal? (area
    (make-rect 0 0 4 6)
) 24)



(check-equal? (perimetr
    (make-alter-rect
        (make-point 0 0)
        (make-point 4 4)
    )
) 16)
(check-equal? (area
    (make-alter-rect
        (make-point 0 0)
        (make-point 4 4)
    )
) 16)

(check-equal? (perimetr
    (make-alter-rect
        (make-point 0 0)
        (make-point 4 6)
    )
) 20)
(check-equal? (area
    (make-alter-rect
        (make-point 0 0)
        (make-point 4 6)
    )
) 24)













;;; (define (print-point p)
;;;     (newline)
;;;     (display "(")
;;;     (display (x-point p))
;;;     (display ",")
;;;     (display (y-point p))
;;;     (display ")")
;;; )

;;; (check-equal? (midpoint-segment
;;;     (make-segment
;;;         (make-point 1 1)
;;;         (make-point 6 6)
;;;     )
;;; ) (cons 7/2 7/2))

;;; (check-equal? (midpoint-segment
;;;     (make-segment
;;;         (make-point 0 0)
;;;         (make-point 1 1)
;;;     )
;;; ) (cons 1/2 1/2))

;;; (check-equal? (midpoint-segment
;;;     (make-segment
;;;         (make-point 1 1)
;;;         (make-point 5 5)
;;;     )
;;; ) (cons 3 3))
