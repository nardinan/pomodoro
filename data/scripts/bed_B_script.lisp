; Pomodoro
; Module: bed_B_script
; Author: nardinan
; Date  : 8 Dec 2016

; Dialogs
(define language (collector_get "language"))
(define dialogs (list 
	(cons ;0 andrea
     "Tsk"
     "Tsk")
	(cons ;1 andrea
	 "Cug wastes his time making his bed every day..."
	 "Cug perde tempo a rifare il letto tutti i giorni ...")
	(cons ;2 andrea
	 "Where is the point?"
	 "Ma a quale pro?")
	(cons ;3 andrea
	 "In the end, we all die."
	 "Alla fine moriamo tutti.")
	nil
))

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

; Script
(puppeteer_disable_control)
(animation "andrea" "back")
(say "andrea" (get_dialog dialogs language 0))
(say "andrea" (get_dialog dialogs language 1))
(say "andrea" (get_dialog dialogs language 2))
(animation "andrea" "front")
(say "andrea" (get_dialog dialogs language 3))
(main_control "andrea")