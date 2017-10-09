;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : tinspquiet
;Location   : Corso Vannucci
;Author     : Nardinan
;Description: After the dialogue, the ticket inspector asks Andrea to leave

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 ticket_inspector
   "I don't want any junkie in my bus!"
   "Non voglio drogati sul mio postale!")
  (cons ;2 ticket_inspector
   "I don't want my guests to be killed like the guy in Piazza Quattro Novembre!"
   "Non vorrei che i miei ospiti facessero la fine del poveretto a Piazza Quattro Novembre!")
  (cons ;3 andrea
   "Remarkable"
   "Ammirevole")
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
(define ticket_inspector_quiet_dialog (collector_get "ticket_inspector_quiet_dialog"))

;Environment configuration (music, effect, whatever)
(puppeteer_disable_control)

;Action!
(puppeteer_look "andrea" "ticket_inspector")
(if (= ticket_inspector_quiet_dialog 1.0)
  (begin
    (say "ticket_inspector" (get_dialog dialogs language 1) "tinspquiet_track1") ;preview: I don't want any junkie in m... | looking at Andrea
    (say "ticket_inspector" (get_dialog dialogs language 2) "tinspquiet_track2") ;preview: I don't want my guests to be... | looking at Andrea | animation pointing
    (say "andrea" (get_dialog dialogs language 3) "tinspquiet_track3")) ;preview: Remarkable | looking at Ticket_inspector
  (begin
    (director_dialog "game_ticket_inspector_dialogue_quiet_0x0a")
    (director_wait_dialog)

    ;And never again
    (collector_set "ticket_inspector_quiet_dialog" 1.0)

    ;Refresh interface
    (director_script "items_interface"))
)

;Return the control
(main_control "andrea")
