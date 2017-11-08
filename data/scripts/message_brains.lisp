;Pomodoro - I have no money and I must eat an ice cream
;Module: message_brains
;Author: nardinan
;Date  : 8 Dec 2016

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
	(cons ;0
		""
		"")
	(cons ;1 andrea
	 "'Call me! 456456'"
	 "'Chiamami! 456456'")
	(cons ;2 andrea
 	 "It says:"
	 "Dice:")
	(cons ;3 andrea
	 "'Do you want to increase your intelligence?'"
	 "'Vuoi incrementare la tua intelligenza?'")
	(cons ;4 andrea
	 "'Do you want to learn how to cook?'"
	 "'Vuoi imparare a cucinare?'")
	(cons ;5 andrea
	 "'Do you want to learn how to read correctly?'"
	 "'Vuoi imparare a leggere correttamente?'")
	(cons ;6 andrea
	 "'Do you want to learn how to be cool with girls?'"
	 "'Vuoi imparare ad essere cool con le ragazze?'")
  (cons ;7 andrea
	 "'Do you want to learn how to eat like a duke?'"
	 "'Vuoi imparare a mangiare come un signorotto?'")
	nil
))

;High level functions
;@brief: say <character> <message>
;@description: character <character> says <message> and the system waits for the bubble to disappear
(define say
  (lambda (c m)
    (begin
      (puppeteer_say c m (+ 1 (* (length m) 0.05)))
      (director_wait_message c)
      )
    )
  )

;@brief: talk <character> <message> <track>
;@description: similar to 'say', but is it possible to associate an audio track to the dialog
(define talk
  (lambda (c m track)
    (begin
      (puppeteer_say c m track)
      (director_wait_message c)
      )
    )
  )

;@brief: say_and_go <character> <message>
;@description: similar to 'say', but the control is returned immediately to the program before the end of the message
(define say_and_go
  (lambda (c m)
    (begin
      (puppeteer_say c m (+ 1 (* (length m) 0.05)))
      )
    )
  )

;@brief: talk_and_go <character> <message> <track>
;@description: similar to 'talk', but the control is returned immediately to the program before the end of the audio track
(define talk_and_go
  (lambda (c m track)
    (begin
      (puppeteer_say c m track)
      )
    )
  )

;@brief: main_control <character>
;@description: gives the main control of the game to the character <character>
(define main_control
  (lambda (c)
    (begin
      (director_camera_follow c -100.0 1.0)
      (puppeteer_enable_control c)
      )
    )
  )

;@brief: get_dialog <dialog list> <language> <number>
;@description: returns the message number <number> stored in the <dialog list> list in the <language> language
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

;Action!
(puppeteer_disable_control)
(puppeteer_set "andrea" "back")
(say "andrea" (get_dialog dialogs language 2))
(if (compare (collector_get "from_where") "canama")
	(say "andrea" (get_dialog dialogs language 3))
	(if (compare (collector_get "from_where") "lupattelli")
		(say "andrea" (get_dialog dialogs language 4))
		(if (compare (collector_get "from_where") "garibaldi")
			(say "andrea" (get_dialog dialogs language 5))
			(if (compare (collector_get "from_where") "fortebraccio")
				(say "andrea" (get_dialog dialogs language 6))
				(if (compare (collector_get "from_where") "vannucci")
					(say "andrea" (get_dialog dialogs language 7))
					nil
				)
			)
		)
	)
)
(say "andrea" (get_dialog dialogs language 1))

;Return the control
(main_control "andrea")
