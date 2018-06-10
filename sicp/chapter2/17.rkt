#lang racket/base

(require rackunit)

(define (last-pair list)
    (if (null? (cdr list))
        (car list)
        (last-pair (cdr list))
    )
)

(check-equal? (last-pair (list 1 2 3 4)) 4)
(check-equal? (last-pair (list 4 3 2 1)) 1)