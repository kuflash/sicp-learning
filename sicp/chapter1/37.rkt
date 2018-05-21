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

(define (cont-frac-iterate n d k)
    (define (iter result i)
        (if (= i 0) result
            (iter
                (/ (n i) (+ (d i) result))
                (- i 1)
            )
        )
    )
    (iter (n 1) k)
)


(cont-frac
    (lambda (i) 1.0)
    (lambda (i) 1.0)
    10
)
(cont-frac-iterate
    (lambda (i) 1.0)
    (lambda (i) 1.0)
    10
)

;;; Необходимо 10 итераций чтобы получить φ с точностью до 4х знаков после запятой

;;; (check-equal? (φ) 1.6180327895683542)