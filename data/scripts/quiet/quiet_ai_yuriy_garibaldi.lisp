;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : sprqrk
;Location   : Garibaldi
;Author     : Nardinan
;Description: Andrii and Yuriy tell to Andrea about the problem with the time continuum

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 yuriy
   "There is something fishy going on in the fabric of space and time"
   "Sembra ci sia un disturbo nel tessuto spazio-tempo")
  (cons ;2 andrii
   "Really? I told you about the fabric of space and time and you told me I was a dork!"
   "Oh certo, se lo dico io sono scemo, ma quando lo dici tu va bene!")
  (cons ;3 yuriy
   "You said something completely different"
   "Tu avevi detto una cosa completamente diversa")
  (cons ;4 andrii
   "Came on!"
   "Ma va!")
  (cons ;5 yuriy
   "The lady in green is following the same path since this morning"
   "La signora vestita di verde sta facendo lo stesso percorso da stamattina")
  (cons ;6 yuriy
   "We suspect she got stuck in a time loop"
   "Crediamo sia bloccata in un loop temporale")
  (cons ;7 andrea
   "I . . ."
   "Io . . .")
  (cons ;8 andrea
   "I am not sure exactly what that means."
   "Io non credo di aver capito.")
  (cons ;9 andrea
   "Do you have some spare change, sir?"
   "Non e' che avete qualche euro?")
  (cons ;10 andrii
   "Yuriy"
   "Yuriy")
  (cons ;11 andrii
   "The disturbance in the Chronon particle is moving"
   "Il disturbo nelle particelle Chronon si sta spostando")
  (cons ;12 yuriy
   "Let's go then!"
   "Andiamo!")
  (cons ;13 andrea
   "Even two euros would be great . . ."
   "Anche due euro vanno bene . . .")
  (cons ;14 andrea
   "I have to pay the electric bill, you know . . ."
   "Sto cercando di pagare una bolletta, sapete . . .")
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
(define yuriy_quiet_dialog_garibaldi (collector_get "yuriy_quiet_dialog_garibaldi"))


;Environment configuration (music, effect, whatever)
(puppeteer_disable_control)

;Action!
(if (= yuriy_quiet_dialog_garibaldi 1.0)
  nil
  (begin
    (puppeteer_look  "yuriy" 	"andrea")
    (puppeteer_stare "andrea" "yuriy")

    ;Action!
    (say "yuriy" (get_dialog dialogs language 1) "sprqrk_track1") ;preview: There is something fishy goi... | looking at Andrea
    (animation 	"andrii" "still_right_radar_down")
    (say_and_go "andrii" (get_dialog dialogs language 2) "sprqrk_track2") ;preview: Really? I told you about the... | looking at Yuriy | animation pointing
    (animation "yuriy" "still_left")
    (director_wait_message "andrii")
    (say "yuriy" (get_dialog dialogs language 3) "sprqrk_track3") ;preview: You said something completel... | looking at Andrii
    (say_and_go "andrii" (get_dialog dialogs language 4) "sprqrk_track4") ;preview: Came on!
    (animation 	"andrii" "still_right_radar_up")
    (puppeteer_look "yuriy" "andrea")
    (say "yuriy" (get_dialog dialogs language 5) "sprqrk_track5") ;preview: The lady in green is followi... | looking at Andrea
    (say "yuriy" (get_dialog dialogs language 6) "sprqrk_track6") ;preview: We suspect she got stuck in ... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 7) "sprqrk_track7") ;preview: I ... | looking at Yuriy
    (say "andrea" (get_dialog dialogs language 8) "sprqrk_track8") ;preview: I am not sure exactly what t... | looking at Yuriy
    (say "andrea" (get_dialog dialogs language 9) "sprqrk_track9") ;preview: Do you have some spare chang... | looking at Yuriy
    (say_and_go "andrii" (get_dialog dialogs language 10) "sprqrk_track10") ;preview: Yuriy | looking at Yuriy
    (animation "yuriy" "still_left")
    (director_wait_message "andrii")
    (say "andrii" (get_dialog dialogs language 11) "sprqrk_track11") ;preview: The disturbance in the Chron... | looking at Yuriy
    (say "yuriy" (get_dialog dialogs language 12) "sprqrk_track12") ;preview: Let's go then! | looking at Andrii
    ;Script suggestion: Pausa
    ;Script suggestion: Andrii e Yuriy spariscono dalla scena
    (puppeteer_move "andrii" 0)
    (puppeteer_move "yuriy"  0)
    (director_wait_time 3)
    (say "andrea" (get_dialog dialogs language 13) "sprqrk_track13") ;preview: Even two euros would be grea...
    (director_wait_time 2)
    (say "andrea" (get_dialog dialogs language 14) "sprqrk_track14") ;preview: I have to pay the electric b...

    (director_wait_movement "andrii")
    (director_wait_movement "yuriy")
    (puppeteer_stare "andrea" "#null")
    (puppeteer_show "andrii" -200)
    (puppeteer_show "yuriy"  -200)

    ;And never again
    (collector_set "yuriy_quiet_dialog_garibaldi" 1.0))
)

;Return the control
(main_control "andrea")
