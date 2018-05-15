#lang racket/base

(require rackunit)

(define (gcd a b)
    (if (= b 0) a
        (gcd b (remainder a b))
    )
)

;;; Нормальный порядок - вычисляется тело функции

;;; #1
;;; (gcd 206 40)

;;; #2
;;; (if (= 40 0) 206
;;;     (gcd 40 (remainder 206 40))
;;; )

;;; #3
;;; (gcd 40 (remainder 206 40))

;;; #4 ;;; 1
;;; (if (= (remainder 206 40) 0) 40
;;;     (gcd
;;;         (remainder 206 40)
;;;         (remainder 40 (remainder 206 40))
;;;     )
;;; )

;;; #5
;;; (if (= 6 0) 40
;;;     (gcd
;;;         (remainder 206 40)
;;;         (remainder 40 (remainder 206 40))
;;;     )
;;; )

;;; #6
;;; (gcd
;;;     (remainder 206 40)
;;;     (remainder 40 (remainder 206 40))
;;; )

;;; #7 ;;; 1
;;; (if (= (remainder 40 (remainder 206 40)) 0) (remainder 206 40)
;;;     (gcd
;;;         (remainder 40 (remainder 206 40))
;;;         (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;     )
;;; )

;;; #8 ;;; 1
;;; (if (= (remainder 40 6) 0) (remainder 206 40)
;;;     (gcd
;;;         (remainder 40 (remainder 206 40))
;;;         (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;     )
;;; )

;;; #9
;;; (if (= 4 0) (remainder 206 40)
;;;     (gcd
;;;         (remainder 40 (remainder 206 40))
;;;         (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;     )
;;; )

;;; #10
;;; (gcd
;;;     (remainder 40 (remainder 206 40))
;;;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;; )

;;; #11 ;;; 1
;;; (if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0) 
;;;     (remainder 40 (remainder 206 40))
;;;     (gcd
;;;         (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;     )
;;; )

;;; #12 ;;; 1
;;; (if (= (remainder (remainder 206 40) (remainder 40 6)) 0) 
;;;     (remainder 40 (remainder 206 40))
;;;     (gcd
;;;         (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;     )
;;; )

;;; #13 ;;; 1
;;; (if (= (remainder (remainder 206 40) 4) 0) 
;;;     (remainder 40 (remainder 206 40))
;;;     (gcd
;;;         (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;     )
;;; )

;;; #14 ;;; 1
;;; (if (= (remainder 6 4) 0) 
;;;     (remainder 40 (remainder 206 40))
;;;     (gcd
;;;         (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;     )
;;; )

;;; #15
;;; (if (= 2 0) 
;;;     (remainder 40 (remainder 206 40))
;;;     (gcd
;;;         (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;     )
;;; )

;;; #16
;;; (gcd
;;;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;     (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;; )

;;; #17 ;;; 1
;;; (if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0) 
;;;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;     (gcd
;;;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         (remainder
;;;             (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 
;;;             (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         )
;;;     )
;;; )

;;; #18 ;;; 1
;;; (if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 6))) 0) 
;;;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;     (gcd
;;;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         (remainder
;;;             (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 
;;;             (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         )
;;;     )
;;; )

;;; #19 ;;; 1
;;; (if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) 4)) 0) 
;;;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;     (gcd
;;;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         (remainder
;;;             (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 
;;;             (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         )
;;;     )
;;; )

;;; #20 ;;; 1
;;; (if (= (remainder (remainder 40 (remainder 206 40)) (remainder 6 4)) 0) 
;;;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;     (gcd
;;;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         (remainder
;;;             (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 
;;;             (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         )
;;;     )
;;; )

;;; #21 ;;; 1
;;; (if (= (remainder (remainder 40 (remainder 206 40)) 2) 0) 
;;;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;     (gcd
;;;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         (remainder
;;;             (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 
;;;             (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         )
;;;     )
;;; )

;;; #22 ;;; 1
;;; (if (= (remainder (remainder 40 6) 2) 0) 
;;;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;     (gcd
;;;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         (remainder
;;;             (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 
;;;             (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         )
;;;     )
;;; )

;;; #23 ;;; 1
;;; (if (= (remainder 4 2) 0) 
;;;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;     (gcd
;;;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         (remainder
;;;             (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 
;;;             (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         )
;;;     )
;;; )

;;; #24 ;;; 1
;;; (if (= 0 0) 
;;;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;;;     (gcd
;;;         (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         (remainder
;;;             (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 
;;;             (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;;;         )
;;;     )
;;; )

;;; #25 ;;; 1
;;; (remainder (remainder 206 40) (remainder 40 6))

;;; #26 ;;; 1
;;; (remainder (remainder 206 40) 4)

;;; #27 ;;; 1
;;; (remainder 6 4)

;;; Ответ: 18 раз будет вызван remainder













;;; Аппликативный порядок - вычисляются аргументы

;;; #1
;;; (gcd 206 40)

;;; #2
;;; (if (= 40 0) 206
;;;     (gcd 40 (remainder 206 40))
;;; )

;;; #3 ;;; 1
;;; (gcd 40 (remainder 206 40))

;;; #4
;;; (gcd 40 6)

;;; #5
;;; (if (= 6 0) 40
;;;     (gcd 6 (remainder 40 6))
;;; )

;;; #6 ;;; 1
;;; (gcd 6 (remainder 40 6))

;;; #7
;;; (gcd 6 4)

;;; #8
;;; (if (= 4 0) 6
;;;     (gcd 4 (remainder 6 4))
;;; )

;;; #9 ;;; 1
;;; (gcd 4 (remainder 6 4))

;;; #10
;;; (gcd 4 2)

;;; #11
;;; (if (= 2 0) 4
;;;     (gcd 2 (remainder 4 2))
;;; )

;;; #12 ;;; 1
;;; (gcd 2 (remainder 4 2))

;;; #13
;;; (gcd 2 0)

;;; #14
;;; (if (= 0 0) 2
;;;     (gcd 0 (remainder 2 0))
;;; )

;;; 2

;;; Ответ: 4 раза будет вызван remainder