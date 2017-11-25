;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : pdlettrchaos
;Location   : Chabin ENEL
;Author     : Nardinan
;Description: Andrea finds out the letter that PD left in the cabin

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 andrea
                    "Uhm . . ."
                    "Uhm . . .")
                  (cons ;2 andrea
                    "It says:"
                    "Dice:")
                  (cons ;3 andrea
                    "'Dear Luca . . ."
                    "'Caro Luca . . .")
                  (cons ;4 andrea
                    ". . . I took your money."
                    ". . . ho preso i tuoi soldi.")
                  (cons ;5 andrea
                    "I am currently working on something . . ."
                    "Sto lavorando ad un progetto particolare . . .")
                  (cons ;6 andrea
                    ". . . and I needed founds."
                    ". . . e avevo urgente bisogno di fondi.")
                  (cons ;7 andrea
                    "Sorry."
                    "Scusami.")
                  (cons ;8 andrea
                    "Join me when you need it . . ."
                    "Vienimi pure a cercare quando li rivuoi . . .")
                  (cons ;9 andrea
                    ". . . I'll be more than happy to give you that money back.'"
                    ". . . saro' ben lieto di restituirteli.'")
                  (cons ;10 andrea
                    "The letter is signed by PD."
                    "La lettera e' firmata da PD.")
                  (cons ;11 andrea
                    "That tuna-face."
                    "Quel faccia di merda.")
                  (cons ;12 andrea
                    "Now I have to look for PD and I need to ask him Luca's money back  . . ."
                    "Ora devo trovare PD e chiedergli indietro i soldi di Luca . . .")
                  (cons ;13 andrea
                    ". . . then I have to bring Luca his money . . ."
                    ". . . poi li devo portare a Luca . . .")
                  (cons ;14 andrea
                    ". . . so he can lend me some money."
                    ". . . cosi' che lui possa prestarmeli da vero amico.")
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
(define got_note (collector_get "got_note"))
(define note_B_virus_animation (collector_get "note_B_virus_animation"))

;Action!
(puppeteer_set "andrea" "back")
(say "andrea" (get_dialog dialogs language 1) "pdlettrchaos_track1") ;preview: Uhm . . . | animation back
(say "andrea" (get_dialog dialogs language 2) "pdlettrchaos_track2") ;preview: It says: | animation back
(say "andrea" (get_dialog dialogs language 3) "pdlettrchaos_track3") ;preview: Dear Luca . . . | animation back
(say "andrea" (get_dialog dialogs language 4) "pdlettrchaos_track4") ;preview: . . . I am sorry but I had t... | animation back
(say "andrea" (get_dialog dialogs language 5) "pdlettrchaos_track5") ;preview: I am currently working on so... | animation back
(say "andrea" (get_dialog dialogs language 6) "pdlettrchaos_track6") ;preview: . . . and I needed founds. | animation back
(say "andrea" (get_dialog dialogs language 7) "pdlettrchaos_track7") ;preview: Sorry. | animation back
(say "andrea" (get_dialog dialogs language 8) "pdlettrchaos_track8") ;preview: Join me when you need those ... | animation back
(say "andrea" (get_dialog dialogs language 9) "pdlettrchaos_track9") ;preview: . . . I'll be more than happ... | animation back
(puppeteer_set "andrea" "front")
(say "andrea" (get_dialog dialogs language 10) "pdlettrchaos_track10") ;preview: The letter is signed by PD. | animation front
(say "andrea" (get_dialog dialogs language 11) "pdlettrchaos_track11") ;preview: That tuna-face. | animation front
(if (= note_B_virus_animation 1.0)
  nil
  (begin
    (say "andrea" (get_dialog dialogs language 12) "pdlettrchaos_track12") ;preview: Now I have to look for PD an... | animation front
    (say "andrea" (get_dialog dialogs language 13) "pdlettrchaos_track13") ;preview: . . . then I have to bring L... | animation front
    (say "andrea" (get_dialog dialogs language 14) "pdlettrchaos_track14") ;preview: . . . so he can lend me some... | animation front

    ;Advance to the next chapter
    (collector_set "current_chapter" "chaos")
    (collector_set "show_chapter_three" 1.0)

    ;And never again
    (collector_set "note_B_virus_animation" 1.0))
  )

;Return the control
(main_control "andrea")
