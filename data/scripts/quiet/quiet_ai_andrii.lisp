;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : andriiquiet
;Location   : Piazza IV Novembre
;Author     : Nardinan
;Description: Andrii tells Andrea that he does not want to talk with him

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 andrii
   "I can't be talking to you!"
   "Io e te non possiamo parlare!")
  (cons ;2 andrea
   "Excuse me?"
   "Come, scusa?")
  (cons ;3 andrii
   "We'll meet in the future and I don't want to generate any paradox."
   "Ci conosceremo in futuro, e non voglio generare un paradosso.")
  (cons ;4 andrea
   "Makes sense."
   "Ha senso.")
  (cons ;5 andrea
    "I should not push . . ."
    "Meglio non insistere . . .")
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
(define andrii_quiet_dialog (collector_get "andrii_quiet_dialog"))

;Action!
(if (= andrii_quiet_dialog 1.0)
  (begin
    (animation "andrea" "front")
    (say "andrea" (get_dialog dialogs language 5) "andriiquiet_track5")) ;preview: I should not push . . . | looking Front
  (begin
    (puppeteer_look "andrea" "andrii")
    (say "andrii" (get_dialog dialogs language 1) "andriiquiet_track1") ;preview: I can't be talking to you!
    (say "andrea" (get_dialog dialogs language 2) "andriiquiet_track2") ;preview: Excuse me? | looking at Andrii
    (say "andrii" (get_dialog dialogs language 3) "andriiquiet_track3") ;preview: We'll meet in the future and...
    (animation "andrea" "front")
    (say "andrea" (get_dialog dialogs language 4) "andriiquiet_track4") ;preview: Makes sense. | looking at Andrii

    ;And never again
    (collector_set "andrii_quiet_dialog" 1.0))
)
;Return the control
(main_control "andrea")
