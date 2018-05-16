#lang racket/base

(require rackunit)

(define (runtime) (current-milliseconds))

(define (square x) (* x x))

(define (even? a)
    (= (remainder a 2) 0)
)

(define (divides? a b)
    (= (remainder b a) 0)
)

(define (find-divisor n test-divisor)
    (cond
        ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))
    )
)

(define (smallest-divisor n)
    (find-divisor n 2)
)

(define (prime? n)
    (= n (smallest-divisor n))
)

(define (report-prime n elapsed-time)
    (display n) 
    (display " *** ") 
    (display elapsed-time) 
    (newline) 
    #t
)

(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime n (- (runtime) start-time))
        #f
    )
)

(define (search-for-primes start count)
    (when (> count 0)
        (if (even? start)
            (search-for-primes (+ start 1) count)
            (if (start-prime-test start (runtime))
                (search-for-primes (+ start 1) (- count 1))
                (search-for-primes (+ start 1) count)
            )
        )
    )
)

;;; (search-for-primes 1000000000000 3) time ~= 15
;;; (search-for-primes 10000000000000 3) time ~= 53
;;; (search-for-primes 100000000000000 3) time ~= 150

;;; (sqrt 10) === 3.16
;;; 53 / 15 ~= (sqrt 10)
;;; 150 / 53 ~= (sqrt 10)