; Pomodoro
; Module: ai_baker
; Author: nardinan
; Date  : 29 Jan 2017
; This module contains the artificial intelligence for Baker

; Dialogs
(define language (collector_get "language"))
(define dialogs (list 
	(cons ;0 baker
 	 "So? Do you like my Pane Cafone?"
	 "Allora? Ti piace il mio Pane Cafone?")
	(cons ;1 andrea
	 "Sure. Do you like my shirt?"
	 "Certo. Ti piace la mia maglietta?")
	(cons ;2 baker
	 "Don't think so"
	 "No, direi di no")
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

; Collect environment 
(define have_leaf (collector_get "have_leaf"))

; Script
(puppeteer_disable_control)
(puppeteer_look "baker" "andrea")
(puppeteer_look "andrea" "baker")
(if (= have_leaf 1.0)
	(begin
		(say "baker" 	(get_dialog dialogs language 0))
		(say "andrea" 	(get_dialog dialogs language 1))
		(say "baker" 	(get_dialog dialogs language 2))
	)
	(begin
		(director_dialog "dialog_mimmo_de_bacheri")
		(director_wait_dialog)
	)
)
(main_control "andrea")
