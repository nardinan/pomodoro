;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : templockchaos
;Location   : Unipg P3
;Author     : Nardinan
;Description: Andrea is looking for PD, that is at the temple

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 andrea
                    "Uhm, the door is locked . . ."
                    "Uhm, la porta e' chiusa a chiave . . .")
                  (cons ;2 andrea
                    ". . . but seems that has been open recently."
                    ". . . ma sembra sia stata aperta di recente.")
                  (cons ;3 andrea
                    "Maybe PD is here!"
                    "Forse PD e' qui dentro!")
                  (cons ;4 andrea
                    "I think is better to look around for the key . . ."
                    "Forse e' il caso di cercare la chiave . . .")
                  (cons ;5 andrea
                    "Locked . . ."
                    "Chiusa . . .")
                  (cons ;6 andrea
                    ". . . but I suspect that PD is inside."
                    ". . . ma sospetto che PD sia qui dentro!")
                  (cons ;7  andrea
                    "Here, behind this door, there is the last chapter of the game."
                    "Qui, dietro questa porta, c'e' l'ultimo capitolo del gioco.")
                  (cons ;8 andrea
                    "You have the key, but Luna and Andrea are still working on it"
                    "Tu hai la chiave, ma Luna e Andrea stanno ancora lavorando all'implementazione")
                  (cons ;9 andrea
                    "Sorry."
                    "Scusa")
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

;Parameters configuration
(define request_temple_key      (collector_get "request_temple_key"))
(define got_temple_key          (collector_get "got_temple_key"))

;Action!
(if (= got_temple_key 1.0)
  (begin
    (collector_set "current_chapter" "epilogue")
    (collector_set "show_chapter_four" 1.0)

    (collector_set "destination_scenario" "temple")
    (director_script "change_scenario"))
  (begin
    (puppeteer_set "andrea" "front")
    (if (= request_temple_key 1.0)
      (begin
        (say "andrea" (get_dialog dialogs language 5) "templockchaos_track5") ;preview: Locked . . . | animation front
        (say "andrea" (get_dialog dialogs language 6) "templockchaos_track6")) ;preview: . . . but I suspect that PD ... | animation scratching his head
      (begin
        (say "andrea" (get_dialog dialogs language 1) "templockchaos_track1") ;preview: Uhm, the door is locked . . . | animation front
        (say "andrea" (get_dialog dialogs language 2) "templockchaos_track2") ;preview: . . . but seems that has bee... | animation front
        (say "andrea" (get_dialog dialogs language 3) "templockchaos_track3") ;preview: Maybe PD is here! | animation front
        (say "andrea" (get_dialog dialogs language 4) "templockchaos_track4") ;preview: I think is better to look ar... | animation front

        ;And never again
        (collector_set "request_temple_key" 1.0))
      ))
  )

;Return the control
(main_control "andrea")
