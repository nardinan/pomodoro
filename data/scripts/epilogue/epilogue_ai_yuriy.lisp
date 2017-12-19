;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : yuriyfuepilogu
;Location   : Unipg P1
;Author     : Nardinan
;Description: yuriy is completely fucked

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 andrea
                    "Ehy, what are you doing?"
                    "Ehy, che state facendo?")
                  (cons ;2 yuriy
                    "I am drinshking to the enshd of the woooooooorld."
                    "Io festesshio la fine del mooooooondo.")
                  (cons ;3 andrea
                    "You're drinking a lot, aren't you?"
                    "Si beve eh?")
                  (cons ;4 yuriy
                    "I shamh!"
                    "Shi!")
                  (cons ;5 andrea
                    "Good job!"
                    "Ma che bravi!")
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

;Parameters configuration
(define andrea_position (puppeteer_get_position "andrea"))
(define yuriy_position  (puppeteer_get_position "yuriy"))

;Action!
(puppeteer_look "andrea" "yuriy")
(if (< andrea_position yuriy_position)
  (puppeteer_set "yuriy" "drink_left")
  (puppeteer_set "yuriy" "drink_right")
  )

(collector_set "epilogue_yuriy_ongoing" 1.0)
(say "andrea" (get_dialog dialogs language 1) "drunkepilogue_track34") ;preview: Ehy, what are you doing?
(say "yuriy" (get_dialog dialogs language 2) "drunkepilogue_track42") ;preview: I am drinshking to the enshd...
(say "andrea" (get_dialog dialogs language 3) "drunkepilogue_track43") ;preview: You're drinking a lot, aren'...
(say "yuriy" (get_dialog dialogs language 4) "drunkepilogue_track44") ;preview: I shamh!
(say "andrea" (get_dialog dialogs language 5) "drunkepilogue_track45") ;preview: Good job!
(collector_set "epilogue_yuriy_ongoing" 0.0)

(main_control "andrea")
