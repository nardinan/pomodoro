; Pomodoro
; Module: note_A_script
; Author: nardinan
; Date  : 8 Dec 2016

; Dialogs
(define language (collector_get "language"))
(define dialogs (list 
	(cons ;0 andrea
 	 "Oh, look!"
	 "Oh ma tu guarda!")
	(cons ;1 andrea
	 "Calculus 2"
	 "Analisi Matematica 2")
	(cons ;2 andrea
	 "These are the holy class notes from Cug"
	 "Questi sono i sacri appunti di Cug")
	(cons ;3 andrea
	 "Let me take them ..."
	 "Sara' il caso che io li prenda ...")
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

; Collect environment 
(define note_A_taken (collector_get "note_A_taken"))

; Script
(puppeteer_disable_control)
(animation "andrea" "back")
(if (not (= note_A_taken 1.0))
	(begin
		(say "andrea" (get_dialog dialogs language 0))
		(say "andrea" (get_dialog dialogs language 1))
		(say "andrea" (get_dialog dialogs language 2))
		(say "andrea" (get_dialog dialogs language 3))
		(stagecrafter_set_item "notes_A" "none")
		(stagecrafter_enable_item "bed_B")
		(collector_set "note_A_taken" 1)
	)
	nil
)
(main_control "andrea")