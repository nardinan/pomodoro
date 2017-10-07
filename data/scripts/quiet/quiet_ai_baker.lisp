;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : bkrquiet
;Location   : Garibaldi
;Author     : Nardinan
;Description: The baker already gave you 5 euros, you can't ask for more

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 baker
   "Are you still asking for money?"
   "Hai finito di chiedere soldi?")
  (cons ;2 baker
   "You should be ashamed of yourself!"
   "Dovresti vergognarti!")
  (cons ;3 baker
   "Leave me alone!"
   "Te ne vai?")
  (cons ;4 andrea
   "I am sorry, I clicked by mistake"
   "Scusa, ho cliccato per sbaglio")
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
(define got_five_euros (collector_get "got_five_euros"))
(define game_baker_dialog_quiet (collector_get "game_baker_dialog_quiet"))

;Environment configuration (music, effect, whatever)
(puppeteer_disable_control)

;Action!
(puppeteer_look "andrea" "baker")
(if (= game_baker_dialog_quiet 1.0)
  (if (= got_five_euros 1.0)
    (begin
      (say "baker" (get_dialog dialogs language 1) "bkrquiet_track1") ;preview: Are you still asking for mon... | looking at Andrea
      (say "baker" (get_dialog dialogs language 2) "bkrquiet_track2") ;preview: You should be ashamed of you... | looking at Andrea | animation pointing
      (say "andrea" (get_dialog dialogs language 4) "bkrquiet_track4")) ;preview: I am sorry, I clicked by mis... | looking at Baker
    (begin
      (say "baker" (get_dialog dialogs language 3) "bkrquiet_track3") ;preview: Leave me alone! | looking at Andrea
      (say "andrea" (get_dialog dialogs language 4) "bkrquiet_track4")) ;preview: I am sorry, I clicked by mis... | looking at Baker
  )
  (begin
    (director_dialog "game_baker_dialogue_quiet_0x0a")
    (director_wait_dialog)
    (collector_set "game_baker_dialog_quiet" 1.0)

    ;Refresh interface
    (director_script "items_interface"))
)

;Return the control
(main_control "andrea")
