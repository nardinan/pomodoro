;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : tinsinfvirus
;Location   : Corso Vannucci
;Author     : Nardinan
;Description: The ticket inspector is infected

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 ticket_inspector
                    "Ticket and arm, please."
                    "Biglietto e braccio, per favore.")
                  (cons ;2 andrea
                    "Again?"
                    "Ancora?")
                  (cons ;3 ticket_inspector
                    "Again?"
                    "Ancora?")
                  (cons ;4 andrea
                    "Again, what?"
                    "Ancora cosa?")
                  (cons ;5 ticket_inspector
                    "Ticket and arm, please."
                    "Biglietto e braccio, per favore.")
                  (cons ;6 ticket_inspector
                    "Ticket and ar - introduction.bin[26]: segfault at 82ff1a error 5"
                    "Biglietto e brac - introduction.bin[26]: segfault at 82ff1a error 5")
                  (cons ;7 andrea
                    "Oh no . . ."
                    "Oh no . . .")
                  (cons ;8 andrea
                    ". . . you're infected!"
                    ". . . sei infetto!")
                  (cons ;9 ticket_inspector
                    "Are you kidding?"
                    "Stai scherzando?")
                  (cons ;10 ticket_inspector
                    "I am not infected!"
                    "Non sono infetto!")
                  (cons ;11 ticket_inspector
                    "I am healthy."
                    "Sono perfettamente sano.")
                  (cons ;12 andrea
                    "Sure, sure."
                    "Certo, certo.")
                  (cons ;13 ticket_inspector
                    "<Giaffro.bin is not responding err 0x011c>"
                    "<Giaffro.bin is not responding err 0x011c>")
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
(define dialog_done (collector_get "ticket_inspector_virus_dialog"))

;Action!
(puppeteer_look "andrea" "ticket_inspector")
(if (= dialog_done 1.0)
  (say "ticket_inspector" (get_dialog dialogs language 13) "tinsinfvirus_track13") ;preview: <Giaffro.bin is not respondin... | looking at Andrea
  (begin
    (say "ticket_inspector" (get_dialog dialogs language 1) "tinsinfvirus_track1") ;preview: Ticket and arm, please. | looking at Andrea
    (say "andrea" (get_dialog dialogs language 2) "tinsinfvirus_track2") ;preview: Again? | looking at Ticket_inspector
    (say "ticket_inspector" (get_dialog dialogs language 3) "tinsinfvirus_track3") ;preview: Again? | looking at Andrea
    (say "andrea" (get_dialog dialogs language 4) "tinsinfvirus_track4") ;preview: Again, what? | looking at Ticket_inspector
    (say "ticket_inspector" (get_dialog dialogs language 5) "tinsinfvirus_track5") ;preview: Ticket and arm, please. | looking at Andrea
    (say "ticket_inspector" (get_dialog dialogs language 6) "tinsinfvirus_track6") ;preview: Ticket and ar - introduction... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 7) "tinsinfvirus_track7") ;preview: Oh no . . . | looking at Ticket_inspector
    (say "andrea" (get_dialog dialogs language 8) "tinsinfvirus_track8") ;preview: . . . you're infected! | looking at Ticket_inspector
    (say "ticket_inspector" (get_dialog dialogs language 9) "tinsinfvirus_track9") ;preview: Are you kidding? | looking at Andrea
    (say "ticket_inspector" (get_dialog dialogs language 10) "tinsinfvirus_track10") ;preview: I am not infected! | looking at Andrea
    (say "ticket_inspector" (get_dialog dialogs language 11) "tinsinfvirus_track11") ;preview: I am healthy. | looking at Andrea
    (say "andrea" (get_dialog dialogs language 12) "tinsinfvirus_track12") ;preview: Sure, sure. | looking at Ticket_inspector
    (say "ticket_inspector" (get_dialog dialogs language 13) "tinsinfvirus_track13") ;preview: <Centro.bin is not respondin... | looking at Andrea

    ;And never again
    (collector_set "ticket_inspector_virus_dialog" 1.0))
  )

;Return the control
(main_control "andrea")
