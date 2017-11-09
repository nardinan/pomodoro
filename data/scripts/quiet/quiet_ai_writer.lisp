;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : writquiet
;Location   : Innamorati
;Author     : Nardinan
;Description: The writer stands there, in fron of the wall, thinking how to create a piece of art

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 writer
                    "Leave me alone!"
                    "Lasciami in pace!")
                  (cons ;2 writer
                    "I am not a junkie!"
                    "Non sono un drogato!")
                  (cons ;3 writer
                    "I'm just trying to create something."
                    "Sto solo cercando di creare qualcosa.")
                  (cons ;4 andrea
                    "Everyone is so touchy in this city . . ."
                    "Tutti permalosi . . .")
                  (cons ;5 andrea
                    "Who knows what piece of art he will draw here!"
                    "Chissa' che capolavoro tirera' fuori!")
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
(define writer_quiet_dialog (collector_get "writer_quiet_dialog"))

;Action!
(if (= writer_quiet_dialog 1.0)
  (begin
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 5) "writquiet_track5")) ;preview: Who knows what piece of art ... | looking at Main Camera
  (begin
    (puppeteer_look "andrea" "writer")
    (say "writer" (get_dialog dialogs language 1) "writquiet_track1") ;preview: Leave me alone! | animation back
    (say "writer" (get_dialog dialogs language 2) "writquiet_track2") ;preview: I am not a junkie! | animation back
    (say "writer" (get_dialog dialogs language 3) "writquiet_track3") ;preview: I'm just trying to create so... | animation back
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 4) "writquiet_track4") ;preview: Everyone is so touchy in thi... | looking at Main Camera

    ;And never again
    (collector_set "writer_quiet_dialog" 1.0))
  )

;Return the control
(main_control "andrea")
