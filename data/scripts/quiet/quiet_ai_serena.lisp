;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : serenrequiet
;Location   : Mania
;Author     : Nardinan
;Description: Serena from Mania does not want religious people to mess with her

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 serena
   "With no religions, the future would be already here!"
   "Se non fosse per la religione, saremmo gia' nel futuro.")
  (cons ;2 andrea
   "What is it to do with me?"
   "E io che c'entro?")
  (cons ;3 serena
   "The poor guy that has been killed is a clear example of war between religions!"
   "Il poveretto che hanno ammazzato e' un chiaro esempio di guerra tra religioni!")
  (cons ;4 andrea
   "I . . ."
   "Io . . .")
  (cons ;5 andrea
   "I will have a look around, thanks."
   "Io do un occhiata in giro, grazie.")
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

;Parameters configuration
(define serena_quiet_dialog (collector_get "serena_quiet_dialog"))
(define got_five_euros (collector_get "got_five_euros"))
(define got_three_euros (collector_get "got_three_euros"))

;Environment configuration (music, effect, whatever)
(puppeteer_disable_control)

;Action!
(puppeteer_look "andrea" "serena")
(if (= serena_quiet_dialog 1.0)
  (begin
    (animation "serena" "point_left")
    (say "serena" (get_dialog dialogs language 1) "serenrequiet_track1") ;preview: With no religions, the futur... | looking at Andrea | animation pointing
    (animation "serena" "still_left")
    (say "andrea" (get_dialog dialogs language 2) "serenrequiet_track2") ;preview: What is it to do with me? | looking at Serena
    (animation "serena" "point_left")
    (say "serena" (get_dialog dialogs language 3) "serenrequiet_track3") ;preview: The poor guy that has been k... | looking at Andrea | animation pointing
    (animation "serena" "still_left")
    (animation "andrea" "scratch_right")
    (say "andrea" (get_dialog dialogs language 4) "serenrequiet_track4") ;preview: I . . . | looking at Serena | animation scratching his head
    ;Script suggestion: Pausa
    (director_wait_time 2.0)
    (say "andrea" (get_dialog dialogs language 5) "serenrequiet_track5")) ;preview: I will have a look around, t... | looking at Serena
  (begin
    (if (> (+ got_five_euros got_three_euros) 0.0)
      (director_dialog "game_serena_dialogue_quiet_money_0x0a")
      (director_dialog "game_serena_dialogue_quiet_nomoney_0x0a")
    )
    (director_wait_dialog)

    ;And never again
    (collector_set "serena_quiet_dialog" 1.0)

    ;Refresh interface
    (director_script "items_interface_quiet_serena"))
)

;Return the control
(main_control "andrea")
