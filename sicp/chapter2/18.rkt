#lang racket/base

(require rackunit)

(define (reverse l)
    (if (null? (cdr l)) l
        (append
            (reverse (cdr l))
            (list (car l))
        )
    )
)

(reverse (list 1 2 3 4))

(check-equal? (reverse (list 1 2 3 4)) (list 4 3 2 1))
(check-equal? (reverse (list 4 3 2 1)) (list 1 2 3 4))