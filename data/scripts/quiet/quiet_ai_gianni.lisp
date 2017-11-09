;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : gianquiet
;Location   : Corso Vannucci
;Author     : Madmoon
;Description: Andrea meets a person in the street and he tries to ask information

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 gianni
                    "This year I will run for mayor"
                    "Quest'anno mi candido sindaco")
                  (cons ;2 gianni
                    "We need to clean the city from all these junkies"
                    "Bisogna ripulire la citta' da questa gentaccia!")
                  (cons ;3 gianni
                    "Vote for Gianni! "
                    "Vota Gianni!")
                  (cons ;4 andrea
                    "Who is Gianni?"
                    "E chi e' Gianni?")
                  (cons ;5 gianni
                    "I am Gianni!"
                    "Io sono Gianni!")
                  (cons ;6 andrea
                    "And is enough to write 'Gianni' on the voting card?"
                    "E basta scrivere 'Gianni' sulla scheda?")
                  (cons ;7 gianni
                    "Sure!"
                    "Certo!")
                  (cons ;8 gianni
                    "Everybody in town knows about me!"
                    "Tutti mi conoscono!")
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
(define gianni_quiet_dialog_vannucci (collector_get "gianni_quiet_dialog_vannucci"))
(collector_set "quiet_mariano_and_gianni_ongoing" 1.0)

;Action!
(puppeteer_look "gianni" "andrea")
(puppeteer_look "andrea" "gianni")
(say "gianni" (get_dialog dialogs language 1) "gianquiet_track1") ;preview: This year I will run for mayor | looking at Andrea
(say "gianni" (get_dialog dialogs language 2) "gianquiet_track2") ;preview: We need to clean the city fr... | looking at Andrea
(say "gianni" (get_dialog dialogs language 3) "gianquiet_track3") ;preview: Vote for Gianni!  | looking at Andrea
(if (= gianni_quiet_dialog_vannucci 1.0)
  nil
  (begin
    (say "andrea" (get_dialog dialogs language 4) "gianquiet_track4") ;preview: Who is Gianni? | looking at Gianni
    (say "gianni" (get_dialog dialogs language 5) "gianquiet_track5") ;preview: I am Gianni! | looking at Andrea
    (say "andrea" (get_dialog dialogs language 6) "gianquiet_track6") ;preview: And is enough to write 'Gian... | looking at Gianni
    (say "gianni" (get_dialog dialogs language 7) "gianquiet_track7") ;preview: Sure! | looking at Andrea
    (say "gianni" (get_dialog dialogs language 8) "gianquiet_track8") ;preview: Everybody in town knows abou... | looking at Andrea

    ;And never again
    (collector_set "gianni_quiet_dialog_vannucci" 1.0))
  )

;Return the control
(collector_set "quiet_mariano_and_gianni_ongoing" 0.0)
(main_control "andrea")
