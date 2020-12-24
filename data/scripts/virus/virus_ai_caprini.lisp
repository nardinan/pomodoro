;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : caprianvirus
;Location   : Elfo Pub
;Author     : Nardinan
;Description: Caprini tells Andrea that he puts the money in the Enel cabin

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 andrea
			"Where are those money, by the way?"    
			"Dov'e' che avevi messo i soldi?")   
		(cons ;2 caprini
			"I put them into the ENEL's cabin in Viale Innamorati."    
			"Li ho nascosti dentro la cabina dell'ENEL in viale Innamorati.")   
		(cons ;3 caprini
			"It's a green door."    
			"E' una porta verde.")   
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

;Environment configuration (music, effect, whatever)
(puppeteer_disable_control)

;Action!
(say "andrea" (get_dialog dialogs language 1) "caprianvirus_track48") ;preview: Where are those money, by th... | looking at Caprini
(say "caprini" (get_dialog dialogs language 2) "caprianvirus_track49") ;preview: I put them into the ENEL's c... | looking at Andrea
(say "caprini" (get_dialog dialogs language 3) "caprianvirus_track50") ;preview: It's a green door. | looking at Andrea

;Return the control
(main_control "andrea")
