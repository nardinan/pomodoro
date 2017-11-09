;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : remassvirus
;Location   : Canama
;Author     : Nardinan
;Description: Andrea needs batteries from the remote control (shared between different chapters)

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 andrea
                    "The holy remote control . . ."
                    "Il sacro telecomando . . .")
                  (cons ;2 andrea
                    "Is still working, incredible!"
                    "Incredibile che funzioni ancora.")
                  (cons ;3 andrea
                    "Maybe I could take the batteries for Federico from this remote control . . ."
                    "Forse potrei prendere le batterie per Federico da questo telecomando . . .")
                  (cons ;4 andrea
                    ". . . but I need a screwdriver."
                    ". . . ma ho bisogno di un cacciavite.")
                  (cons ;5 andrea
                    "Cug has wisely decided to protect the batteries with a screw!"
                    "Cug ha saggiamente protetto le pile con una vite!")
                  (cons ;6 andrea
                    "Ah-ha!"
                    "Ah-ha!")
                  (cons ;7 andrea
                    "With two shots of screwdriver . . ."
                    "Con due semplici colpi di cacciavite . . .")
                  (cons ;8 andrea
                    "Maybe tree . . ."
                    "Forse tre . . .")
                  (cons ;9 andrea
                    "Or four . . ."
                    "Facciamo quattro . . .")
                  (cons ;10 andrea
                    "Here we go!"
                    "Ecco!")
                  (cons ;11 luca
                    "You stole the remote control batteries, didn't you?"
                    "Hai rubato le pile del telecomando?")
                  (cons ;12 andrea
                    ". . ."
                    ". . .")
                  (cons ;13 andrea
                    "No?"
                    "No?")
                  (cons ;14 luca
                    "You'd better not!"
                    "Lo spero per te!")
                  (cons ;15 andrea
                    "I should go before he sees that the batteries are not there anymore."
                    "Meglio andare via prima che se ne accorga.")
                  (cons ;16 andrea
                    "Is not working anymore, obviously."
                    "Senza pile, ovviamente.")
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
(define got_screwdriver     (collector_get "got_screwdriver"))
(define request_battery     (collector_get "request_battery"))
(define request_screwdriver (collector_get "request_screwdriver"))
(define done_battery        (collector_get "done_battery"))

;Action!
(puppeteer_move "andrea" 3830)
(director_wait_movement "andrea")
(puppeteer_set "andrea" "back")
(if (= request_battery 1.0)
  (if (= done_battery 1.0)
    (begin
      (say "andrea" (get_dialog dialogs language 1) "remassvirus_track1") ;preview: The holy remote control . . . | animation back
      (puppeteer_set "andrea" "front")
      (say "andrea" (get_dialog dialogs language 16) "remassvirus_track16")) ;preview: Is not working anymore, obvi... | animation front
    (if (= got_screwdriver 1.0)
      (begin
        (say "andrea" (get_dialog dialogs language 6) "remassvirus_track6") ;preview: Ah-ha! | animation back
        (puppeteer_set "andrea" "back_code")
        (say "andrea" (get_dialog dialogs language 7) "remassvirus_track7") ;preview: With two shots of screwdrive... | animation programming
        (say "andrea" (get_dialog dialogs language 8) "remassvirus_track8") ;preview: Maybe tree . . . | animation programming
        (say "andrea" (get_dialog dialogs language 9) "remassvirus_track9") ;preview: Or four . . . | animation programming
        (puppeteer_set "andrea" "back")
        (say "andrea" (get_dialog dialogs language 10) "remassvirus_track10") ;preview: Here we go! | animation back
        (director_camera_follow "luca" -100.0 1.0)
        (puppeteer_stare "luca" "#null")
        (say_and_go "luca" (get_dialog dialogs language 11) "remassvirus_track11") ;preview: You stole the remote control... | looking at Andrea
        (director_wait_time 1.0)
        (puppeteer_set "andrea" "still_right")
        (director_wait_message "luca")
        (say "andrea" (get_dialog dialogs language 12) "remassvirus_track12") ;preview: . . . | looking at Luca
        ;Script suggestion: Lunga pausa
        (director_wait_time 2.0)
        (say "andrea" (get_dialog dialogs language 13) "remassvirus_track13") ;preview: No? | looking at Luca
        (puppeteer_set "luca" "point_left")
        (say "luca" (get_dialog dialogs language 14) "remassvirus_track14") ;preview: You'd better not! | looking at Andrea | animation pointing
        (puppeteer_stare "luca" "andrea")
        (director_camera_follow "andrea" -100.0 1.0)
        (puppeteer_set "andrea" "front")  
        (say "andrea" (get_dialog dialogs language 15) "remassvirus_track15") ;preview: I should go before he sees t... | animation front
        (stagecrafter_set_item "remote_A" "still_B")

        (collector_set "got_screwdriver" 0.0)
        (collector_set "got_battery" 1.0)
        (collector_set "done_battery" 1.0)

        ;Refresh interface
        (director_script "update_items_interface"))
      (begin
        (say "andrea" (get_dialog dialogs language 3) "remassvirus_track3") ;preview: Maybe I could take the batte... | animation back
        (puppeteer_set "andrea" "front")
        (say "andrea" (get_dialog dialogs language 4) "remassvirus_track4") ;preview: . . . but I need a screwdriv... | animation front
        (puppeteer_set "andrea" "scratch_front")
        (say "andrea" (get_dialog dialogs language 5) "remassvirus_track5") ;preview: Cug has wisely decided to pr... | animation front

        (collector_set "request_screwdriver" 1.0))
      )
    )
  (begin
    (say "andrea" (get_dialog dialogs language 1) "remassvirus_track1") ;preview: The holy remote control . . . | animation back
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 2) "remassvirus_track2")) ;preview: Is still working, incredible! | animation front
  )

;Return the control
(main_control "andrea")
