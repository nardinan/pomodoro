; Pomodoro
; Module: ai_baker
; Author: nardinan
; Date  : 29 Jan 2017
; This module contains the artificial intelligence for Baker

; Dialogs
(define language (collector_get "language"))
(define say
	(lambda (c m)
		(begin
			(puppeteer_say c m (+ 1 (* (length m) 0.05)))
			(director_wait_message c)
		)
	)
)

(define say_and_go
	(lambda (c m)
		(begin
			(puppeteer_say c m (+ 1 (* (length m) 0.05)))
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

(puppeteer_disable_control)
(puppeteer_look "baker" "andrea")
(puppeteer_look "andrea" "baker")
(director_dialog "dialog_mimmo_de_bacheri")
(director_wait_dialog)
(main_control "andrea")