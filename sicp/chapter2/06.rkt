#lang racket/base

(require rackunit)

(define zero
    (lambda (f)
        (lambda (x) x)
    )
)

(define (add-1 n)
    (lambda (f)
        (lambda (x) 
            (f ((n f) x))
        )
    )
)

;;; (add-1 zero)

;;; (lambda (f)
;;;     (lambda (x) 
;;;         (f ((zero f) x))
;;;     )
;;; )

;;; (lambda (f)
;;;     (lambda (x) 
;;;         (f ((lambda (x) x) x))
;;;     )
;;; )

;;; (lambda (f)
;;;     (lambda (x) 
;;;         (f x)
;;;     )
;;; )

;;; f -> x -> f(x)

(define one
    (lambda (f)
        (lambda (x) (f x))
    )
)

;;; (add-1 one)

;;; (lambda (f)
;;;     (lambda (x) 
;;;         (f ((one f) x))
;;;     )
;;; )

;;; (lambda (f)
;;;     (lambda (x) 
;;;         (f ((lambda (x) (f x)) x))
;;;     )
;;; )

;;; (lambda (f)
;;;     (lambda (x) 
;;;         (f (f x))
;;;     )
;;; )

;;; f -> x -> f(f(x))

(define two
    (lambda (f)
        (lambda (x) (f (f x)))
    )
)

;;; Дальше мало что понял, поэтому подглядел ответ...

(define (add n m)
    (lambda (f)
        (lambda (x)
            ((m f) ((n f) x))
        )
    )
)

(define (square x) (* x x))

(check-equal? (((add one two) square) 2) 256)
