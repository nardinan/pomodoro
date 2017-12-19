;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : massimofuepilogu
;Location   : Unipg P1
;Author     : Nardinan
;Description: massimo is completely fucked

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 massimo
                    "Upload application SLAVE.bin from the remote central node - the unit is offline: please wait."
                    "Upload applicazione SLAVE.bin in corso dal nodo centrale - unita' offline: attendere prego.")
                  (cons ;2 andrea
                    "Good, load it!"
                    "Bravo, carica carica!")
                  (cons ;3 massimo
                    "Connection lost - the unit is offline"
                    "Connessione persa - unita' offline")
                  (cons ;4 andrea
                    "Cool"
                    "Cool")
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

;Collect environment
(define server_disconnected (collector_get "server_disconnected"))

;Action!
(puppeteer_look "andrea" "massimo")
(if (= server_disconnected 1.0)
  (begin
    (say "massimo" (get_dialog dialogs language 3) "massimofuepilogu_track3") ;preview: Connection lost - the unit is offline | looking at Andrea
    (say "andrea" (get_dialog dialogs language 4) "massimofuepilogu_track4")) ;preview: Cool | looking at massimo
  (begin
    (say "massimo" (get_dialog dialogs language 1) "massimofuepilogu_track1") ;preview: Upload 'slave.bin', please w... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 2) "massimofuepilogu_track2")) ;preview: Good, load it! | looking at massimo
  )

(main_control "andrea")
