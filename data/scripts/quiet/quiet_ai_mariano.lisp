;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : marquiet
;Location   : Corso Vannucci
;Author     : Madmoon
;Description: Andrea meets a person in Corso Vannucci and he tries to talk with him

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 mariano
			"Boy, don't you see I'm discussing with the future major of the great Perugia City?"    
			"Ragazzo, non vedi che sto amorevolmente parlando con il futuro sindaco di Perugia?")   
		(cons ;2 mariano
			"I will not give anything to buy the drug, go away!"    
			"Non te li do i soldi per comprarti la droga, pussa via!")   
		(cons ;3 mariano
			"Vote for Gianni!"    
			"Vota Gianni!")   
		(cons ;4 andrea
			"Maybe it's better not to push"    
			"Forse e' meglio non insistere")   
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

;Parameters configuration
(define mariano_quiet_dialog_vannucci (collector_get "mariano_quiet_dialog_vannucci"))
(collector_set "quiet_mariano_and_gianni_ongoing" 1.0)

;Action!
(if (= mariano_quiet_dialog_vannucci 1.0)
  (begin
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 4) "marquiet_track4")) ;preview: Maybe it's better not to push | looking at Main Camera
  (begin
    (puppeteer_look "mariano" "andrea")
    (puppeteer_look "andrea" "mariano")
    (say "mariano" (get_dialog dialogs language 1) "marquiet_track1") ;preview: Boy, don't you see I'm discu... | looking at Andrea
    (say "mariano" (get_dialog dialogs language 2) "marquiet_track2") ;preview: I will not give anything to ... | looking at Andrea
    (say "mariano" (get_dialog dialogs language 3) "marquiet_track3") ;preview: Vote for Gianni! | looking at Andrea | animation pointing

    ;And never again
    (collector_set "mariano_quiet_dialog_vannucci" 1.0))
  )

;Return the control
(collector_set "quiet_mariano_and_gianni_ongoing" 0.0)
(main_control "andrea")
