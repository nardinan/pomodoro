;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : caprinifuepilogu
;Location   : Unipg P1
;Author     : Nardinan
;Description: caprini is completely fucked

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 andrea
			"Ehy, what are you doing?"    
			"Ehy, che state facendo?")   
		(cons ;2 caprini
			"I don't know."    
			"Guarda non lo so.")   
		(cons ;3 caprini
			"The tall guy is buying me a lots of drinks."    
			"Quello alto non ha smesso di offrire da bere da quando e' arrivato.")   
		(cons ;4 caprini
			"I am drinking."    
			"Io bevo.")   
		(cons ;5 andrea
			"Amazing!"    
			"Daje!")   
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

;@brief: animation <character> <animation>
;@description: changes the state/animation of <character> to <animation>
(define animation
  (lambda (c m)
    (begin
      (puppeteer_set c m)
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

;Parameters configuration
(define andrea_position    (puppeteer_get_position "andrea"))
(define caprini_position    (puppeteer_get_position "caprini"))

;Action!
(puppeteer_look "andrea" "caprini")
(if (< andrea_position caprini_position)
  (puppeteer_set "caprini" "drink_left")
  (puppeteer_set "caprini" "drink_right")
  )

(collector_set "epilogue_caprini_ongoing" 1.0)
(say "andrea" (get_dialog dialogs language 1) "drunkepilogue_track34") ;preview: Ehy, what are you doing?
(say "caprini" (get_dialog dialogs language 2) "drunkepilogue_track46") ;preview: I don't know.
(say "caprini" (get_dialog dialogs language 3) "drunkepilogue_track47") ;preview: The tall guy is buying me a ...
(say "caprini" (get_dialog dialogs language 4) "drunkepilogue_track48") ;preview: I am drinking.
(say "andrea" (get_dialog dialogs language 5) "drunkepilogue_track49") ;preview: Amazing!
(collector_set "epilogue_caprini_ongoing" 0.0)

(main_control "andrea")
