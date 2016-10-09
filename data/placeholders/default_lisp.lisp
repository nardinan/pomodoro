(define game_title "pomodoro")
(define tatto_name "andrea")
(define tatto_surname "nardinocchi")
(define tatto_age 29)
(define tatta_name "luna")
(define tatta_surname "paciucci")
(define tatta_age (- tatto_age 3))

(define tatto 
  (cons 
    (cons tatto_name 
      tatto_surname) 
    tatto_age))

(define tatta 
  (cons 
    (cons tatta_name 
      tatta_surname) 
    tatta_age))

(define get_name 
  (lambda (x) (car (car x))))
(define get_surname
  (lambda (x) (cdr (car x))))
(define get_age
  (lambda (x) (cdr x)))
