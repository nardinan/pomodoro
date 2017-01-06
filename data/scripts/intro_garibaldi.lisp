; Pomodoro
; Module: intro_garibaldi
; Author: nardinan
; Date  : 2 Jan 2017
; This module contains the intro of the Garibaldi scenario

; Dialogs
(define language 0) ; temporary
(define dialogs (nil))

(define say
	(lambda (c m)
		(begin
			(puppeteer_say c m (+ 1 (* (length m) 0.05)))
			(director_wait_time (+ 1 (* (length m) 0.05)))
		)
	)
)

(define animation
	(lambda (c m)
		(begin
			(puppeteer_set c m)
		)
	)
)

(define main_control
	(lambda (c)
		(begin
			(director_camera_follow c -100.0 1.0)
			(puppeteer_enable_control c)
		)
	)
)

(define get_dialog
	(lambda (d lang n)
		(begin
			(if (= n 0)
				(if (= lang 0)
					(car (car d))
					(cdr (car d))
				)
				(get_dialog (cdr d) lang (- n 1))
			)
		)
	)
)

; Collect environment 
(define from_where (collector_get "from_where"))

; Configure
(collector_set "from_where" "garibaldi")

; Setup characters
(puppeteer_disable_control)
(if (compare from_where "lupattelli")
	(puppeteer_show "andrea" 6900)
	(puppeteer_show "andrea" 1100)
)

; Setup characters
(animation "andrea" 	"front")
(main_control "andrea")