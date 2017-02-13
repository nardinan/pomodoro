; Pomodoro
; Module: ai_yuriy
; Author: nardinan
; Date  : 13 Feb 2017
; This module contains the artificial intelligence for Yuriy

; Dialogs
(define language (collector_get "language"))
(define dialogs (list 
	(cons ;0 yuriy
 	 "Looks like there is a degradation in the fabric of space-time"
	 "Sembra ci sia un disturbo nel tessuto spazio-temporale")
	(cons ;1 andrii
	 "So, if you say that it's fine but if I say that Iam an idiot, correct?"
	 "Oh certo, quando lo dico io sono scemo, ma quando lo dici tu va bene")
	(cons ;2 yuriy
	 "You've said something totally different"
	 "Tu avevi detto una cosa completamente diversa")
	(cons ;3 andrii
	 "Pff"
	 "Pff")
	(cons ;4 yuriy
	 "The lady with the green shirt is following the same path since this morning"
	 "La signora vestita di Verde sta facendo lo stesso percorso da stamattina")
	(cons ;5 yuriy
	 "We think she's stuck in a time loop"
	 "Crediamo sia bloccata in un loop temporale")
	(cons ;6 andrea
	 "Sorry, do you have some money?"
	 "Scusate, non e' che avete qualche euro?")
	(cons ;7 andrii
 	 "Yuriy! The disturbance in the Chronons particles is moving!"
	 "Yuriy! Il disturbo nelle particelle Chronon si sta spostando")
	(cons ;8 yuriy
	 "Let's go!"
	 "Andiamo!")
	(cons ;9 andrea
	 "Even 2 Euros are perfectly fine ..."
	 "Anche 2 Euro vanno bene ...")
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
(puppeteer_look "yuriy" "andrea")
(puppeteer_look "andrea" "yuriy")
(say 		"yuriy"		(get_dialog dialogs language 0))
(animation 	"andrii" "still_right_radar_down")
(say_and_go "andrii"	(get_dialog dialogs language 1))
(puppeteer_look "yuriy" "andrii")
(director_wait_message "andrii")
(say 		"yuriy"		(get_dialog dialogs language 2))
(say_and_go "andrii"	(get_dialog dialogs language 3))
(animation 	"andrii" "still_right_radar_up")
(puppeteer_look "yuriy" "andrea")
(say 		"yuriy"		(get_dialog dialogs language 4))
(say 		"yuriy"		(get_dialog dialogs language 5))
(say 		"andrea"	(get_dialog dialogs language 6))
(say_and_go "andrii"	(get_dialog dialogs language 7))
(puppeteer_look "yuriy" "andrii")
(director_wait_message "andrii")
(say 		"yuriy"		(get_dialog dialogs language 8))
(puppeteer_move "andrii" -200)
(puppeteer_move "yuriy"  -200)
(director_wait_time 3)
(say 		"andrea"	(get_dialog dialogs language 9))
(director_wait_movement "andrii")
(director_wait_movement "yuriy")
(main_control "andrea")

; and never again
(collector_set "intro_chronos" 1.0)