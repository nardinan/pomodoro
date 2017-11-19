;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : cugniptcvirus
;Location   : Canama
;Author     : Madmoon
;Description: Cug is at home but there are a lot of blackouts

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 luca
                    "I can't take it anymore!"
                    "Non ce la faccio piu', diosanto!")
                  (cons ;2 andrea
                    "What is happening? "
                    "Che succede? ")
                  (cons ;3 luca
                    "Well, what is happening!"
                    "Eh, che succede!")
                  (cons ;4 andrea
                    "So? "
                    "Bhe? ")
                  (cons ;5 luca
                    "There's the fact that I want to finish this Nip&Tuck episode"
                    "C'e' che vorrei finire di guardare Nip&Tuck")
                  (cons ;6 luca
                    "But all these blackout . . ."
                    "Ma questi blackout continui blackout . . .")
                  (cons ;7 andrea
                    "See?"
                    "Vedi?")
                  (cons ;8 andrea
                    "Considering the so poor service, we shouldn't even pay the electric bill! "
                    "Considerando il servizio scadente che offrono, non dovremmo nemmeno pagare la bolletta!")
                  (cons ;9 luca
                    ". . ."
                    ". . .")
                  (cons ;10 luca
                    "Figure out a way to find the money, otherwise I'll break your legs!"
                    "Tu vedi di trovare i soldi altrimenti ti sego le gambe!")
                  (cons ;11 andrea
                    "Wait wait . . ."
                    "Aspetta aspetta . . .")
                  (cons ;12 andrea
                    "Are you watching Nip & Tuck without me? "
                    "Stai guardando Nip & Tuck senza di me?")
                  (cons ;13 luca
                    "Well only one episode . . ."
                    "Ma giusto una puntata . . .")
                  (cons ;14 luca
                    "And apparently neither that! "
                    "E a quanto pare nemmeno quella!")
                  (cons ;15 andrea
                    "You deserve it!"
                    "Ben ti sta!")
                  (cons ;16 andrea
                    "Watching Nip & Tuck without me . . . "
                    "Guardare Nip & Tuck senza di me . . . ")
                  (cons ;17 luca
                    "All these blackouts are making me so flippin' angry"
                    "Questi blackouts continui mi fanno girare le palle in un modo clamoroso!")
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
(define dialog_done         (collector_get "luca_virus_dialog"))
(define andrea_position     (puppeteer_get_position "andrea"))
(define luca_position       (puppeteer_get_position "luca"))

;Calculate position of luca in respect of andrea
(define luca_still_side     "still_left")
(define luca_point_side     "point_left")
(define andrea_still_side   "still_right")
(define andrea_scratch_side "scratch_right")
(if (> andrea_position luca_position)
  (begin
    (define luca_still_side     "still_right")
    (define luca_point_side     "point_right")
    (define andrea_still_side   "still_left")
    (define andrea_scratch_side "scratch_left"))
  nil
  )

;Action!
(puppeteer_stare "luca" "#null")
(puppeteer_look "andrea" "luca")
(if (= dialog_done 1.0)
  (begin
    (say "luca" (get_dialog dialogs language 17) "cugniptcvirus_track17") ;preview: All these blackouts are making... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 7) "cugniptcvirus_track7") ;preview: See? | looking at Luca
    (say "andrea" (get_dialog dialogs language 8) "cugniptcvirus_track8") ;preview: Considering the so poor serv... | looking at Luca
    (say "luca" (get_dialog dialogs language 9) "cugniptcvirus_track9") ;preview: . . . | looking at Andrea
    (puppeteer_set "luca" luca_point_side)
    (say "luca" (get_dialog dialogs language 10) "cugniptcvirus_track10") ;preview: Figure out a way to find the... | looking at Andrea | animation pointing
    (puppeteer_set "luca" luca_still_side))
  (begin
    (say "luca" (get_dialog dialogs language 1) "cugniptcvirus_track1") ;preview: I can't take it anymore! | looking at Andrea
    (say "andrea" (get_dialog dialogs language 2) "cugniptcvirus_track2") ;preview: What is happening?  | looking at Luca
    (say "luca" (get_dialog dialogs language 3) "cugniptcvirus_track3") ;preview: Well, what is happening! | looking at Andrea
    (puppeteer_set "andrea" andrea_scratch_side)
    (say "andrea" (get_dialog dialogs language 4) "cugniptcvirus_track4") ;preview: So?  | looking at Luca | animation scratching his head
    (say "luca" (get_dialog dialogs language 5) "cugniptcvirus_track5") ;preview: There's the fact that I want... | looking at Andrea
    (say "luca" (get_dialog dialogs language 6) "cugniptcvirus_track6") ;preview: But all these blackout . . . | looking at Andrea
    (say "andrea" (get_dialog dialogs language 7) "cugniptcvirus_track7") ;preview: See? | looking at Luca
    (say "andrea" (get_dialog dialogs language 8) "cugniptcvirus_track8") ;preview: Considering the so poor serv... | looking at Luca
    (say "luca" (get_dialog dialogs language 9) "cugniptcvirus_track9") ;preview: . . . | looking at Andrea
    (puppeteer_set "luca" luca_point_side)
    (say "luca" (get_dialog dialogs language 10) "cugniptcvirus_track10") ;preview: Figure out a way to find the... | looking at Andrea | animation pointing
    (puppeteer_set "luca" luca_still_side)
    (say "andrea" (get_dialog dialogs language 11) "cugniptcvirus_track11") ;preview: Wait wait . . . | looking at Luca
    (say "andrea" (get_dialog dialogs language 12) "cugniptcvirus_track12") ;preview: Are you watching Nip & Tuck ... | looking at Luca
    (say "luca" (get_dialog dialogs language 13) "cugniptcvirus_track13") ;preview: Well only one episode . . . | looking at Andrea
    (say "luca" (get_dialog dialogs language 14) "cugniptcvirus_track14") ;preview: And apparently neither that!  | looking at Andrea
    (say "andrea" (get_dialog dialogs language 15) "cugniptcvirus_track15") ;preview: You deserve it! | looking at Luca
    (say "andrea" (get_dialog dialogs language 16) "cugniptcvirus_track16") ;preview: Watching Nip & Tuck without ... | looking at Luca

    (collector_set "luca_virus_dialog" 1.0))
  )
(puppeteer_stare "luca" "andrea")

;Return the control
(main_control "andrea")
