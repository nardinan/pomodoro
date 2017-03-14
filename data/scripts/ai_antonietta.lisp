; Pomodoro
; Module: ai_antonietta
; Author: nardinan
; Date  : 14 Mar 2017
; This module contains the artificial intelligence for Antonietta

; Dialogs
(define language (collector_get "language"))
(define dialogs (list 
	(cons ;0 antonietta
 	 "I am sorry, I am too busy to listen you"
	 "Mi dispiace ma sono troppo occupata per ascoltarti")
	(cons ;1 andrea
	 "Busy? Ma'am you are not doing anything!"
	 "Occupata? Ma lei non stai facendo niente!")
	(cons ;2 antonietta
	 "I am waiting . . ."
	 "Sto aspettando . . .")
	(cons ;3 antonietta
	 "Soon or later that fly will put its ass somewhere and then . . ."
	 "Prima o poi quella mosca si posera' da qualche parte e allora . . .")
	(cons ;4 antonietta
 	 "SBAM!"
	 "SBAM!")
))

(define say
	(lambda (c m)
		(begin
			(puppeteer_say c m (+ 1 (* (length m) 0.05)))
			(director_wait_message c)
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
(say "antonietta" (get_dialog dialogs language 0))
(say "andrea" (get_dialog dialogs language 1))
(say "antonietta" (get_dialog dialogs language 2))
(say "antonietta" (get_dialog dialogs language 3))
(say "antonietta" (get_dialog dialogs language 4))
(main_control "andrea")