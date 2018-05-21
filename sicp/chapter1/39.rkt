#lang racket/base

(require rackunit)

(define (cont-frac n d k)
    (define (calc-cont-frac result i)
        (if (> i k) result
            (/
                result
                (+ (d i) (calc-cont-frac (n i) (+ i 1)))
            )
        )
    )
    (calc-cont-frac (n 1) 1)
)

(define (tan-cf x k)
    (cont-frac
        (lambda (i)
            (if (= i 1) x (- (* x x)))
        )
        (lambda (i) (+ i (- i 1)))
        k
    )
)

;;; (tan-cf 1 10)