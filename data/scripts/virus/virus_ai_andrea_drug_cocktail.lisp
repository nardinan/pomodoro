;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : mixcocvirus
;Location   : Undefined
;Author     : Nardinan
;Description: Andrea mixes the pills with the cocktail to create the drug_cocktail

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 andrea
			"Now that I've these pills and this Mojito, I can prepare my potion!"    
			"Ora che ho questo Mojito e le pillole, posso prepare la mia pozione!")   
		(cons ;2 andrea
			"AH AH AH!"    
			"AH AH AH!")   
		(cons ;3 andrea
			"It's ready!"    
			"Fatto!")   
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
(define got_cocktail  (collector_get "got_cocktail"))
(define got_pills     (collector_get "got_pills"))

;Action!
(if (= (+ got_cocktail got_pills) 2.0)
  (begin
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 1) "mixcocvirus_track1") ;preview: Now that I've these pills an... | animation front
    (say "andrea" (get_dialog dialogs language 2) "mixcocvirus_track2") ;preview: AH AH AH! | animation front
    (puppeteer_set "andrea" "back_code")
    (director_wait_time 2.0)

    (collector_set "got_cocktail"       0.0)
    (collector_set "got_pills"          0.0)
    (collector_set "got_drug_cocktail"  1.0)

    ;Refresh interface
    (director_script "update_items_interface")

    ;Script suggestion: Andrea Mischia pillole e mojito
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 3) "mixcocvirus_track3")) ;preview: It's ready! | animation front
  nil
  )

;Return the control
(main_control "andrea")
