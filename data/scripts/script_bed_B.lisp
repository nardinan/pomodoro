;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : bedquiet
;Location   : Canama
;Author     : Nardinan
;Description: Andrea is complaining about the fact that Luca makes his bed every day

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 andrea
   "Tsk"
   "Tsk")
  (cons ;2 andrea
   "Cug wastes his time making his bed every day . . ."
   "Cug perde il suo tempo a rifare il letto tutti i giorni . . .")
  (cons ;3 andrea
   "Where is the point?"
   "Ma a quale pro?")
  (cons ;4 andrea
   "In the end, we all die"
   "Alla fine moriamo tutti")
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
(animation "andrea" "back")
(say "andrea" (get_dialog dialogs language 1) "bedquiet_track1") ;preview: Tsk | animation back
(say "andrea" (get_dialog dialogs language 2) "bedquiet_track2") ;preview: Cug wastes his time making h... | animation back
(say "andrea" (get_dialog dialogs language 3) "bedquiet_track3") ;preview: Where is the point? | animation front
(animation "andrea" "front")
(say "andrea" (get_dialog dialogs language 4) "bedquiet_track4") ;preview: In the end, we all die | animation front

;Return the control
(main_control "andrea")
