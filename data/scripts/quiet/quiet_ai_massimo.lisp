;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : masjuquiet
;Location   : Med Store
;Author     : Nardinan
;Description: Massimo complains about the criminality that is investing the city

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 massimo
   "People like you should be locked up in a Community Center!"
   "Gente come te, dovrebbe essere rinchiusa in un centro sociale!")
  (cons ;2 andrea
   "I am just slightly addicted to pizza . . ."
   "Ho solo una lieve dipendenza da pizza . . .")
  (cons ;3 andrea
   "But I am working on it!"
   "Ma ci sto lavorando!")
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
(define massimo_quiet_dialog (collector_get "massimo_quiet_dialog"))

;Environment configuration (music, effect, whatever)
(puppeteer_disable_control)

;Action!
(puppeteer_look "andrea" "massimo")
(if (= massimo_quiet_dialog 1.0)
  (begin
    (animation "massimo" "point_left")
    (say "massimo" (get_dialog dialogs language 1) "masjuquiet_track1") ;preview: People like you should be lo... | looking at Andrea | animation pointing
    (animation "massimo" "still_left")
    (say "andrea" (get_dialog dialogs language 2) "masjuquiet_track2") ;preview: I am just slightly addicted ... | looking at Massimo
    (animation "andrea" "scratch_right")
    (say "andrea" (get_dialog dialogs language 3) "masjuquiet_track3")) ;preview: But I am working on it! | looking at Massimo | animation scratching his head
  (begin
    (director_dialog "game_massimo_dialogue_quiet_0x0a")
    (director_wait_dialog)

    ;And never again
    (collector_set "massimo_quiet_dialog" 1.0))
)

;Return the control
(main_control "andrea")
