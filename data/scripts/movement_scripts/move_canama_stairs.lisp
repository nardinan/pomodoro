; Pomodoro
; Module: move_canama_stairs
; Author: nardinan
; Date  : 15 Dec 2016

; Dialogs
(define language (collector_get "language"))
(define dialogs (list 
	(cons ;0 andrea
 	 "I need a good reason to leave the safety of my appartment"
	 "Ho bisogno della giusta motivazione per lasciare il mio appartamento")
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

(define animation
	(lambda (c m)
		(begin
			(puppeteer_set c m)
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
(define note_A_taken (collector_get "note_A_taken"))

(if (not (= note_A_taken 1.0))
	(begin
		(animation "andrea" "front")
		(say "andrea" (get_dialog dialogs language 0)))
	(begin
		(collector_set "destination_scenario" "stairs")
		(director_script "change_scenario"))
)
