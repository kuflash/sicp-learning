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

(check-equal? (cont-frac
    (lambda (i) 1.0)
    (lambda (i)
        (let ((k (- i 2)))
            (cond
                ((< k 0) 1)
                ((= k 0) 2)
                ((= (remainder k 3) 0) (+ 2 (* 2 (/ k 3))))
                (else 1)
            )
        )
    )
    10
) 0.7182823682498374)