;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : intro
;Location   : Canama
;Author     : Nardinan
;Description: This short introduction is used to introduce Andrea to the player and Cug as well

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 andrea
                    "Hello, my name is Andrea and I am a student here, at the University of Perugia"
                    "Ciao! Io mi chiamo Andrea e sono uno studente dell'Unversita' degli studi di Perugia")
                  (cons ;2 andrea
                    "This is my apartment"
                    "Questo e' l'appartamento dove vivo")
                  (cons ;3 andrea
                    "I will get my master degree in Computer Science very soon!"
                    "Frequento il corso di informatica e sono prossimo alla mia laurea magistrale!")
                  (cons ;4 andrea
                    "I live here with my cousin, Luca"
                    "Vivo qui con mio cugino, Luca")
                  (cons ;5 andrea
                    "We call him 'Cug'"
                    "Lo chiamiamo 'Cug'")
                  (cons ;6 andrea
                    "Because he is my cousin, you know"
                    "Perche' e' mio cugino, sapete")
                  (cons ;7 andrea
                    "He is a student at UniPG's Department of Mathematics"
                    "E' uno studente del Dipartimento di Matematica dell'UniPG")
                  (cons ;8 andrea
                    "He is even one of the two reasons why I was able to survive so far"
                    "E' anche uno dei due motivi per cui sono sopravvissuto fino ad ora")
                  (cons ;9 andrea
                    "This is his room"
                    "Questa e' la sua stanza")
                  (cons ;10 andrea
                    "And you know what? It's clean."
                    "E sapete cosa? E' pulita.")
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

;Draw interface
(director_script "update_items_interface")

;Parameters configuration
(define got_note (collector_get "got_note"))
(define intro_canama (collector_get "intro_canama"))
(define done_battery (collector_get "done_battery"))
(define current_chapter (collector_get "current_chapter"))

(collector_set "from_where" "canama")
(if (= got_note 1.0)
  (begin
    (stagecrafter_set_item "notes_A" "none")
    (stagecrafter_enable_item "bed_B"))
  nil
  )
(if (= done_battery 1.0)
  (stagecrafter_set_item "remote_A" "still_B")
  nil
  )

;Action!
(puppeteer_show "andrea" 450)
(if (= intro_canama 1.0)
  (if (= got_note 1.0)
    (if (compare current_chapter "epilogue")
      nil
      (if (compare current_chapter "chaos")
        nil
        (begin
          (puppeteer_show "luca" 4500)
          (puppeteer_stare "luca" "andrea"))
        )
      )
    nil
    )
  (begin
    (director_camera_follow "andrea" -100.0 1.0)
    (puppeteer_set "andrea" "front")
    (director_wait_time 3)
    (say "andrea" (get_dialog dialogs language 1) "intro_track1") ;preview: Hello, my name is Andrea and... | looking at Main Camera
    (puppeteer_set "andrea" "scratch_front")
    (say "andrea" (get_dialog dialogs language 2) "intro_track2") ;preview: This is my apartment | animation scratching his ass
    ;Script suggestion: Inizia a camminare verso la camera di cug
    (puppeteer_move "andrea" 4500)
    (say "andrea" (get_dialog dialogs language 3) "intro_track3") ;preview: I am taking a Computer Scien...
    (say "andrea" (get_dialog dialogs language 4) "intro_track4") ;preview: I live here with my cousin, L...
    (say "andrea" (get_dialog dialogs language 5) "intro_track5") ;preview: We call him 'Cug'
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 6) "intro_track6") ;preview: Because he is my cousin, you... | looking at Main Camera
    ;Script suggestion: Riprende a camminare verso la camera di cug
    (puppeteer_move "andrea" 4500)
    (say "andrea" (get_dialog dialogs language 7) "intro_track7") ;preview: He is a student at UniPG's D...
    (say "andrea" (get_dialog dialogs language 8) "intro_track8") ;preview: He is even one of the two re...
    ;Script suggestion: Arriva nella stanza di cug
    (director_wait_movement "andrea")
    (puppeteer_set "andrea"	"point_right")
    (say "andrea" (get_dialog dialogs language 9) "intro_track9") ;preview: This is his room | animation pointing
    (puppeteer_set "andrea"	"front")
    (say "andrea" (get_dialog dialogs language 10) "intro_track10") ;preview: And you know what? It's clean. | looking at Main Camera

    ;And never again
    (collector_set "intro_canama" 1.0))
  )

;Return the control
(main_control "andrea")
