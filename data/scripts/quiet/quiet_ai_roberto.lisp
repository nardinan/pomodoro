;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : robquiet
;Location   : Piazza S. Francesco
;Author     : Madmoon
;Description: Andrea meet for the first time Roberto in front of the Saint Francis Church

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 roberto
   "Enough is enough! "
   "Non se ne puo' piu! ")
  (cons ;2 andrea
   "What are you talking about? "
   "Di che parli?")
  (cons ;3 andrea
   "He is Roberto"
   "Lui e' Roberto")
  (cons ;4 andrea
   "He is a friend of mine"
   "Un mio amico")
  (cons ;5 andrea
   "And one of the Psycho Games illustrators, back in 2012"
   "E uno degli illustratori della della Psycho Games nel 2012")
  (cons ;6 roberto
   "Please, I have urgent things to do here!"
   "Lascia stare, ho da fare qui")
  (cons ;7 andrea
   "As you wish"
   "Come vuoi tu")
  (cons ;8 roberto
   "I'll just tell you a single word"
   "Ti dico solo una parola")
  (cons ;9 roberto
   "SCIENTOLOGY"
   "SCIENTOLOGY")
  (cons ;10 andrea
   "I am not sure I'd get that . . ."
   "Non credo d'aver capito . . .")
  (cons ;11 roberto
   "They are everywhere!"
   "Sono ovunque!")
  (cons ;12 roberto
   "Everywhere!"
   "Ovunque!")
  (cons ;13 andrea
   "Here we go . . ."
   "Ambe . . .")
  (cons ;14 roberto
   "Indeed! "
   "Appunto! ")
  (cons ;15 roberto
   "I prefer to talk with someone who can understand"
   "Preferisco parlarne con qualcuno che ci capisce! ")
  (cons ;16 andrea
   "Sure, I guess with the priest! "
   "Certo, magari con il prete! ")
  (cons ;17 roberto
   "Of course!"
   "Certo!")
  (cons ;18 roberto
   "I'm waiting for the end of the mass"
   "Sto aspettando che finisca la messa infatti")
  (cons ;19 andrea
   "We go from bad to worse"
   "Di bene in meglio")
  (cons ;20 roberto
   "Leave me alone now! I need to think"
   "Su, lasciami stare che devo pensare ad un piano")
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
(define roberto_quiet_dialog (collector_get "roberto_quiet_dialog"))

;Environment configuration (music, effect, whatever)
(puppeteer_disable_control)

;Action!
(if (= roberto_quiet_dialog 1.0)
  (begin
    (puppeteer_look "andrea"  "roberto")
    (say "roberto" (get_dialog dialogs language 20) "robquiet_track20"))
  (begin
    (puppeteer_move "andrea" 4700)
    (director_wait_movement "andrea")

    (puppeteer_stare "roberto" "#null")

    (animation "andrea"  "still_right")
    (animation "roberto" "still_left")

    (say "roberto" (get_dialog dialogs language 1) "robquiet_track1") ;preview: Enough is enough!  | looking at Andrea
    (animation "andrea" "scratch_right")
    (say "andrea" (get_dialog dialogs language 2) "robquiet_track2") ;preview: What are you talking about?  | looking at Roberto | animation scratching his head
    (animation "andrea" "front")
    (say "andrea" (get_dialog dialogs language 3) "robquiet_track3") ;preview: He is Roberto | looking at Main Camera
    (say "andrea" (get_dialog dialogs language 4) "robquiet_track4") ;preview: He is a friend of mine | looking at Main Camera
    (say "andrea" (get_dialog dialogs language 5) "robquiet_track5") ;preview: And one of the Psycho Games ... | looking at Main Camera
    (animation "andrea"  "still_right")
    (say "roberto" (get_dialog dialogs language 6) "robquiet_track6") ;preview: Please, I have urgent things... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 7) "robquiet_track7") ;preview: As you wish | looking at Roberto
    (say "roberto" (get_dialog dialogs language 8) "robquiet_track8") ;preview: I'll just tell you a single ... | looking at Andrea
    (animation "roberto" "point_left")
    (say "roberto" (get_dialog dialogs language 9) "robquiet_track9") ;preview: SCIENTOLOGY | looking at Andrea | animation pointing
    (animation "roberto" "still_left")
    ;Script suggestion: Pausa
    (director_wait_time 2)
    (say "andrea" (get_dialog dialogs language 10) "robquiet_track10") ;preview: I am not sure I'd get that .... | looking at Roberto
    (animation "roberto" "point_left")
    (say "roberto" (get_dialog dialogs language 11) "robquiet_track11") ;preview: They are everywhere! | looking at Andrea | animation pointing
    (animation "roberto" "still_left")
    (say "roberto" (get_dialog dialogs language 12) "robquiet_track12") ;preview: Everywhere! | looking at Andrea
    (animation "andrea" "scratch_right")
    (say "andrea" (get_dialog dialogs language 13) "robquiet_track13") ;preview: Here we go . . . | looking at Roberto | animation scratching his head
    (say "roberto" (get_dialog dialogs language 14) "robquiet_track14") ;preview: Indeed!  | looking at Andrea
    (say "roberto" (get_dialog dialogs language 15) "robquiet_track15") ;preview: I prefer to talk with someon... | looking at Andrea
    (animation "andrea" "point_right")
    (say "andrea" (get_dialog dialogs language 16) "robquiet_track16") ;preview: Sure, I guess with the pries... | looking at Roberto | animation pointing
    (animation "andrea" "still_right")
    (say "roberto" (get_dialog dialogs language 17) "robquiet_track17") ;preview: Of course! | looking at Andrea
    (say "roberto" (get_dialog dialogs language 18) "robquiet_track18") ;preview:  I'm waiting for the end of ... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 19) "robquiet_track19") ;preview: We go from bad to worse | looking at Roberto
    (say "roberto" (get_dialog dialogs language 20) "robquiet_track20") ;preview: Leave me alone now! I need t... | looking at Andrea

    ;And never again
    (puppeteer_stare "roberto" "andrea")
    (collector_set "roberto_quiet_dialog" 1.0))
)

;Return the control
(main_control "andrea")
