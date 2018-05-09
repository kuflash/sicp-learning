#lang racket/base

(require rackunit)

;;; все индексы считаются с 1

(define (pascal-element row cell)
    (cond
        ((or (< row 3) (= row cell) (= cell 1)) 1)
        (else
            (+
                (pascal-element (- row 1) (- cell 1))
                (pascal-element (- row 1) cell)
            )
        )
    )
)

(check-equal? (pascal-element 1 1) 1)
(check-equal? (pascal-element 2 1) 1)
(check-equal? (pascal-element 3 3) 1)
(check-equal? (pascal-element 3 1) 1)
(check-equal? (pascal-element 3 2) 2)
(check-equal? (pascal-element 4 2) 3)
(check-equal? (pascal-element 5 2) 4)
(check-equal? (pascal-element 5 3) 6)
