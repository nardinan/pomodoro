;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : antquiet
;Location   : Gallenga
;Author     : Nardinan
;Description: Antonietta is extremely relaxed and she doesn't want to do anything

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 antonietta
   "I am sorry, I am too busy to listen you!"
   "Mi dispiace, sono troppo occupata per ascoltarti")
  (cons ;2 andrea
   "Hello Antonietta!"
   "Ciao Antonietta!")
  (cons ;3 antonietta
   "Hello Antonietta' my ass!"
   "Ciao Antonietta' un paglio di coglioni!")
  (cons ;4 andrea
   "Excuse me?"
   "Come, scusa?")
  (cons ;5 antonietta
   "Hello MADAME Antonietta!"
   "Ciao SIGNORA Antonietta!")
  (cons ;6 andrea
   "Uhm . . ."
   "Uhm . . .")
  (cons ;7 andrea
   "This 2012 smells like 1992"
   "Questo 2012 mi puzza di 1992 . . .")
  (cons ;8 andrea
   "What are you doing?"
   "Cos'hai da fare?")
  (cons ;9 antonietta
   "I am waiting . . ."
   "Sto aspettando . . .")
  (cons ;10 antonietta
   "Soon or later that fly will put its ass somewhere, and then . . ."
   "Prima o poi quella mosca di posera' da qualche parte e allora . . .")
  (cons ;11 antonietta
   "SBAM!"
   "SBAM!")
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

;Action!
(animation "andrea" "still_left")
(animation "antonietta" "still_right")
(if (collector_get "antonietta_quiet_dialog")
  (begin
    (say "antonietta" (get_dialog dialogs language 10) "antquiet_track10") ;preview: Soon or later that fly will ... | looking at Andrea
    (say "antonietta" (get_dialog dialogs language 11) "antquiet_track11")) ;preview: SBAM! | looking at Andrea
  (begin
    (say "antonietta" (get_dialog dialogs language 1) "antquiet_track1") ;preview: I am sorry, I am too busy to... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 2) "antquiet_track2") ;preview: Hello Antonietta! | looking at Antonietta
    (say "antonietta" (get_dialog dialogs language 3) "antquiet_track3") ;preview: Hello Antonietta' my ass! | looking at Andrea
    (say "andrea" (get_dialog dialogs language 4) "antquiet_track4") ;preview: Excuse me? | looking at Antonietta
    (say "antonietta" (get_dialog dialogs language 5) "antquiet_track5") ;preview: Hello MADAME Antonietta! | looking at Andrea
    (say "andrea" (get_dialog dialogs language 6) "antquiet_track6") ;preview: Uhm . . . | looking at Antonietta
    (animation "andrea" "scratch_left")
    (say "andrea" (get_dialog dialogs language 7) "antquiet_track7") ;preview: This 2012 smells like 1992 | looking at Antonietta | animation scratching his head
    (say "andrea" (get_dialog dialogs language 8) "antquiet_track8") ;preview: What are you doing? | looking at Antonietta
    (say "antonietta" (get_dialog dialogs language 9) "antquiet_track9") ;preview: I am waiting . . . | looking at Andrea
    (say "antonietta" (get_dialog dialogs language 10) "antquiet_track10") ;preview: Soon or later that fly will ... | looking at Andrea
    (say "antonietta" (get_dialog dialogs language 11) "antquiet_track11") ;preview: SBAM! | looking at Andrea

    ;And never again
		(collector_set "antonietta_quiet_dialog" 1.0))
)

;Return the control
(main_control "andrea")
