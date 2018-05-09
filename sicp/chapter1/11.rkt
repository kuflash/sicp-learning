#lang racket/base

(require rackunit)

(define (f-recurse n)
    (if (< n 3) n
        (+
            (f-recurse (- n 1))
            (f-recurse (- n 2)) 
            (f-recurse (- n 3))
        )
    )
)

(check-equal? (f-recurse 0) 0)
(check-equal? (f-recurse 1) 1)
(check-equal? (f-recurse 2) 2)
(check-equal? (f-recurse 3) 3)
(check-equal? (f-recurse 4) 6)
(check-equal? (f-recurse 5) 11)

(define (iterate a b c counter)
    (if (= counter 0) c
        (iterate (+ a b c) a b (- counter 1))
    )
)

(define (f-iterate n)
    (iterate 2 1 0 n)
)

(check-equal? (f-iterate 0) 0)
(check-equal? (f-iterate 1) 1)
(check-equal? (f-iterate 2) 2)
(check-equal? (f-iterate 3) 3)
(check-equal? (f-iterate 4) 6)
(check-equal? (f-iterate 5) 11)
