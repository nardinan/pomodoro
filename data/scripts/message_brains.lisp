; Pomodoro
; Module: message_brains
; Author: nardinan
; Date  : 8 Dec 2016

; Dialogs
(define language (collector_get "language"))
(define dialogs (list 
	(cons ;0 andrea
 	 "It says:"
	 "Dice:")
	(cons ;1 andrea
	 "'Do you want to increase your intelligence?'"
	 "'Vuoi incrementare la tua intelligenza?'")
	(cons ;2 andrea
	 "'Call me! 456456'"
	 "'Chiamami! 456456'")
	(cons ;3 andrea
	 "'Do you want to learn how to cook?'"
	 "'Vuoi imparare a cucinare?'")
	(cons ;4 andrea
	 "'Do you want to learn how to read correctly?'"
	 "'Vuoi imparare a leggere correttamente?'")
	(cons ;5 andrea
	 "'Do you want to learn how to be cool with girls?'"
	 "'Vuoi imparare ad essere cool con le ragazze?'")
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
(if (compare (collector_get "from_where") "canama")
	(say "andrea" (get_dialog dialogs language 1))
	(if (compare (collector_get "from_where") "lupattelli")
		(say "andrea" (get_dialog dialogs language 3))
		(if (compare (collector_get "from_where") "garibaldi")
			(say "andrea" (get_dialog dialogs language 4))
			(if (compare (collector_get "from_where") "fortebraccio")
				(say "andrea" (get_dialog dialogs language 5))
				nil
			)
		)
	)
)
(say "andrea" (get_dialog dialogs language 2))
(main_control "andrea")