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

(define (next a)
    (if (= a 2) 3 (+ a 2))
)

(define (find-divisor n test-divisor)
    (cond
        ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))
    )
)

(define (smallest-divisor n)
    (find-divisor n 2)
)

(define (prime? n)
    (= n (smallest-divisor n))
)

(define (expmod base exp m)
    (cond
        ((= exp 0) 1)
        ((even? exp)
            (remainder (square (expmod base (/ exp 2) m)) m)
        )
        (else
            (remainder (* base (expmod base (- exp 1) m)) m)
        )
    )
)

(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a)
    )
    (try-it (+ 1 (random (- n 1))))
)

(define (fast-prime? n times)
    (cond
        ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)
    )
)

(define (report-prime n elapsed-time)
    (display n) 
    (display " *** ") 
    (display elapsed-time) 
    (newline) 
    #t
)

(define (start-prime-test n start-time)
    (if (fast-prime? n 10000)
        (report-prime n (- (runtime) start-time))
        #f
    )
)

(define (prime-test n)
    (start-prime-test n (runtime))
)

;;; (prime-test 1009)    ;;; time ~= 8
;;; (prime-test 1013)    ;;; time ~= 8
;;; (prime-test 1019)    ;;; time ~= 8
;;; (prime-test 10007)   ;;; time ~= 10
;;; (prime-test 10009)   ;;; time ~= 10
;;; (prime-test 10037)   ;;; time ~= 10
;;; (prime-test 100003)  ;;; time ~= 12
;;; (prime-test 100019)  ;;; time ~= 12
;;; (prime-test 100043)  ;;; time ~= 13
;;; (prime-test 1000003) ;;; time ~= 13
;;; (prime-test 1000037) ;;; time ~= 13


;;; Скорсоть растет по функции log(n)