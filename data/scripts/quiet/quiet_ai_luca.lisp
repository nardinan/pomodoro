;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : cganquiet
;Location   : Canama
;Author     : Nardinan
;Description: Cug and Andrea want a pizza

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 luca
   "Do you need something?"
   "Hai bisogno di qualcosa?")
  (cons ;2 andrea
   "What do you want to eat for dinner?"
   "Cosa mangiamo stasera a cena?")
  (cons ;3 luca
   "Well, I was thinking about a . . ."
   "Pensavo a una . . .")
  (cons ;4 andrea
   "Uhm, what about a . . ."
   "Che ne dici di . . .")
  (cons ;5 andrea
   "Pizza?"
   "Pizza?")
  (cons ;6 luca
   "Pizza?"
   "Pizza?")
  (cons ;7 andrea
   "Can you tell me again where Luca Caprini is?"
   "Puoi dirmi di nuovo dove trovo Luca Caprini?")
  (cons ;8 luca
   "At 'Elfo' pub, in Priori street"
   "Al pub 'Elfo', in via dei Priori")
  (cons ;9 andrea
   "OK"
   "OK")
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
(puppeteer_look "andrea" "luca")
(say "luca" (get_dialog dialogs language 1) "cganquiet_track1") ;preview: Do you need something? | looking at Andrea
(say "andrea" (get_dialog dialogs language 2) "cganquiet_track2") ;preview: What do you want to eat for ... | looking at Luca
(say "luca" (get_dialog dialogs language 3) "cganquiet_track3") ;preview: Well, I was thinking about a... | looking at Andrea
(say "andrea" (get_dialog dialogs language 4) "cganquiet_track4") ;preview: Uhm, what about a . . . | looking at Luca
;Script suggestion: Allo stesso tempo
(say_and_go "andrea" (get_dialog dialogs language 5) "cganquiet_track5") ;preview: Pizza? | looking at Luca
(say_and_go "luca" (get_dialog dialogs language 6) "cganquiet_track6") ;preview: Pizza? | looking at Andrea
(director_wait_message "luca")
(director_wait_message "andrea")
(say "andrea" (get_dialog dialogs language 7) "cganquiet_track7") ;preview: Can you tell me again where ... | looking at Luca
(say "luca" (get_dialog dialogs language 8) "cganquiet_track8") ;preview: At 'Elfo' pub, in Priori str... | looking at Andrea | animation pointing
(say "andrea" (get_dialog dialogs language 9) "cganquiet_track9") ;preview: OK | looking at Luca

;Return the control
(main_control "andrea")
