; Pomodoro
; Module: ai_luca
; Author: nardinan
; Date  : 2 Dec 2016
; This module contains the artificial intelligence for Luca

; Dialogs
(define language (collector_get "language"))
(define dialogs (list
	(cons ;0 luca
 	 "Do you need something?"
	 "Hai bisogno di qualcosa?")
	(cons ;1 andrea
	 "What do you want to eat for dinner?"
	 "Cosa mangiamo stasera a cena?")
	(cons ;2 luca
	 "Uhm, what about a ..."
	 "Uhm, che ne dici di una ...")
	(cons ;3 andrea
	 "Well, I was thinking about a ..."
	 "Beh, io pensavo a una ...")
	(cons ;4 andrea & luca
 	 "Pizza?"
	 "Pizza?")
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

(puppeteer_disable_control)
(puppeteer_look "andrea" "luca")
(say "luca"	(get_dialog dialogs language 0))
(say "andrea"	(get_dialog dialogs language 1))
(say "luca"	(get_dialog dialogs language 2))
(say "andrea"	(get_dialog dialogs language 3))
(say_and_go "luca" (get_dialog dialogs language 4))
(say_and_go "andrea" (get_dialog dialogs language 4))
(director_wait_message "luca")
(director_wait_message "andrea")

;Return the control
(main_control "andrea")
