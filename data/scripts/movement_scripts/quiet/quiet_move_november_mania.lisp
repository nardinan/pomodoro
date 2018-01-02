;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : manclquiet
;Location   : Piazza IV Novembre
;Author     : Nardinan
;Description: Andrea tries to enter into Mania, but is closed

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 andrea
                    "Here you can go to Mania . . ."
                    "Di qui si va al Mania . . .")
                  (cons ;2 andrea
                    ". . . a bar, popular for his prices: 1 Europer shot."
                    ". . . locale famoso per i suoi shortini a 1 euro.")
                  (cons ;3 andrea
                    "Now it's 1 Euroand half per shot."
                    "Ora costano 1 Euro e cinquanta.")
                  (cons ;4 andrea
                    "Is closed right now."
                    "E' ancora chiuso.")
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

;Action!
(puppeteer_set "andrea" "front")
(say "andrea" (get_dialog dialogs language 1) "manclquiet_track1") ;preview: Here you can go to Mania . . . | animation front
(say "andrea" (get_dialog dialogs language 2) "manclquiet_track2") ;preview: . . . a bar, popular for his... | animation front
(puppeteer_set "andrea" "still_right")
(say "andrea" (get_dialog dialogs language 3) "manclquiet_track3") ;preview: Now it's 1 Euroand half per... | animation right
(puppeteer_set "andrea" "front")
(say "andrea" (get_dialog dialogs language 4) "manclquiet_track4") ;preview: Is closed right now. | animation front

;Return the control
(main_control "andrea")
