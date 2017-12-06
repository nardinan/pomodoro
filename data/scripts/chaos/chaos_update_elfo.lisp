;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : anyucachaos
;Location   : Elfo Pub
;Author     : Nardinan
;Description: Andrii, Yuriy and Caprini are drinking to the end of the world

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 caprini
                    "Nazdarovya!"
                    "Nazdarovya!")
                  (cons ;2 yuriy
                    "Nazdarovya!"
                    "Nazdarovya!")
                  (cons ;3 andrii
                    "A toss to the end of the world!"
                    "Alla fine del mondo!")
                  (cons ;4 andrii
                    "To an uncertain future!"
                    "Ad un futuro incerto!")
                  (cons ;5 andrii
                    "To a destiny that surely could have been avoided!"
                    "Ad un destino che poteva essere evitato!")
                  (cons ;6 andrii
                    "To a friend, 'il Profeta', that sacrificed himself for us!"
                    "Ad un amico, 'il profeta', che si e' sacrificato per aiutarci!")
                  (cons ;7 andrii
                    "To whatever is going on that will drive the humanity to the extinction!"
                    "A qualsiasi cosa stia succedendo che portera' all'estinzione la razza umana!")
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
(define done_computer                            (collector_get "done_computer"))
(define chaos_andrii_yuriy_and_caprini_line      (collector_get "chaos_andrii_yuriy_and_caprini_line"))
(define chaos_andrii_yuriy_and_caprini_next_line (+ chaos_andrii_yuriy_and_caprini_line 1.0))

;Action!
(if (= done_computer 1.0)
  (begin
    (puppeteer_set "andrii"  "drink_right")
    (puppeteer_set "yuriy"   "drink_left")
    (puppeteer_set "caprini" "drink_left")
    (if (= chaos_andrii_yuriy_and_caprini_line 0.0)
      (say "andrii" (get_dialog dialogs language 3) "anyucachaos_track63") ;preview: A toss to the end of the wor... | animation right
      (if (= chaos_andrii_yuriy_and_caprini_line 1.0)
        (say "andrii" (get_dialog dialogs language 4) "anyucachaos_track64") ;preview: To an uncertain future! | animation right
        (if (= chaos_andrii_yuriy_and_caprini_line 2.0)
          (say "andrii" (get_dialog dialogs language 5) "anyucachaos_track65") ;preview: To a destiny that surely cou... | animation right
          (if (= chaos_andrii_yuriy_and_caprini_line 3.0)
            (say "andrii" (get_dialog dialogs language 6) "anyucachaos_track66") ;preview: To a friend, 'il Profeta', t... | animation right
            (if (= chaos_andrii_yuriy_and_caprini_line 4.0)
              (say "andrii" (get_dialog dialogs language 7) "anyucachaos_track67") ;preview: To whatever is going on that... | animation right
              nil
              )
            )
          )
        )
      )
    (say_and_go "caprini" (get_dialog dialogs language 1) "anyucachaos_track3") ;preview: Nazdarovya! | looking at Andrii
    (say_and_go "yuriy" (get_dialog dialogs language 2) "anyucachaos_track4") ;preview: Nazdarovya! | looking at Andrii
    (director_wait_message "caprini")
    (director_wait_message "yuriy")

    ;Configure environment for the next hop
    (if (> chaos_andrii_yuriy_and_caprini_next_line 4.0)
      (collector_set "chaos_andrii_yuriy_and_caprini_line" 0.0)
      (collector_set "chaos_andrii_yuriy_and_caprini_line" chaos_andrii_yuriy_and_caprini_next_line)
      ))
  nil
  )
