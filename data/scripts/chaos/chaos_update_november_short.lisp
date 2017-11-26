;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : bistpolchaos
;Location   : Piazza IV Novembre
;Author     : Nardinan
;Description: Bistoni asking for help of police

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 bistoni
                    "Please, officer."
                    "Per favore, agente.")
                  (cons ;2 bistoni
                    "Are you listening me?"
                    "Mi sta ascoltando?")
                  (cons ;3 bistoni
                    "I need your help!"
                    "Ho bisogno di aiuto!")
                  (cons ;4 bistoni
                    "Police is never helping here!"
                    "Possibile che non si riesca a farsi aiutare dalla polizia qui?")
                  (cons ;5 bistoni
                    "We cannot let them get away with this . . ."
                    "Non possono passarla liscia cosi' . . .")
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
(define chaos_bistoni_and_policeman_line      (collector_get "chaos_bistoni_and_policeman_line"))
(define chaos_bistoni_and_policeman_ongoing   (collector_get "chaos_bistoni_and_policeman_ongoing"))

;Action!
(if (= chaos_bistoni_and_policeman_ongoing 1.0)
  nil
  (begin
    (puppeteer_look "policeman" "bistoni")
    (puppeteer_look "bistoni" "policeman")
    (if (= chaos_bistoni_and_policeman_line 0.0)
      (say "bistoni" (get_dialog dialogs language 1) "bistpolchaos_track1") ;preview: Please, officer. | looking at Policeman
      (if (= chaos_bistoni_and_policeman_line 1.0)
        (say "bistoni" (get_dialog dialogs language 2) "bistpolchaos_track2") ;preview: Are you listening me? | looking at Policeman
        (if (= chaos_bistoni_and_policeman_line 2.0)
          (say "bistoni" (get_dialog dialogs language 3) "bistpolchaos_track3") ;preview: I need your help! | looking at Policeman
          (if (= chaos_bistoni_and_policeman_line 3.0)
            (say "bistoni" (get_dialog dialogs language 4) "bistpolchaos_track4") ;preview: Police is never helping here! | looking at Policeman
            (if (= chaos_bistoni_and_policeman_line 4.0)
              (say "bistoni" (get_dialog dialogs language 5) "bistpolchaos_track5") ;preview: We cannot let them get away ... | looking at Policeman
              nil
              )
            )
          )
        )
      )
    )
  )

;Configure environment for the next hop
(define chaos_bistoni_and_policeman_next_line (+ chaos_bistoni_and_policeman_line 1.0))
(if (> chaos_bistoni_and_policeman_next_line 4.0)
  (collector_set "chaos_bistoni_and_policeman_line" 0.0)
  (collector_set "chaos_bistoni_and_policeman_line" chaos_bistoni_and_policeman_next_line)
  )
