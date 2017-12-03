;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : priunipg
;Location   : Unipg P1
;Author     : Nardinan
;Description: The printer at uniPG

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 andrea
                    "A printer . . ."
                    "Una stampante . . .")
                  (cons ;2 andrea
                    "The old kind of printer that works with a kind of toner that if is removed from the printer without taking the necessary precautions . . ."
                    "Vecchio modello, di quelle che se il toner dovessere essere rimosso senza le dovute precauzioni . . .")
                  (cons ;3 andrea
                    ". . . it will be easier to destroy the building and rebuild it up from scratch than clean it."
                    ". . . si fa prima a far saltare in aria l'edificio e a ricostruirlo da zero piuttosto che a pulirlo.")
                  (cons ;4 andrea
                    "Uhm . . ."
                    "Uhm . . .")
                  (cons ;5 andrea
                    "I could use it to print the authorization from the Magnifico Rettore's computer!"
                    "Potrei usarla per stampare l'autorizzazione dal computer del magnifico rettore!")
                  (cons ;6 andrea
                    "Eheheh . . ."
                    "Eheheh . . .")
                  (cons ;7 andrea
                    "I'm a genius!"
                    "Sono un genio!")
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
(define got_computer (collector_get "got_computer"))
(define done_authorization (collector_get "done_authorization"))

;Action!
(puppeteer_set "andrea" "back")
(if (= (+ got_computer done_authorization) 1.0)
  (begin
    (say "andrea" (get_dialog dialogs language 4) "priunipg_track4") ;preview: Uhm . . . | animation back
    (say "andrea" (get_dialog dialogs language 5) "priunipg_track5") ;preview: I could use it to print the ... | animation back
    (puppeteer_set "andrea" "back_code")
    (director_wait_time 1.0)
    (puppeteer_set "andrea" "back")
    (effecteer_play "printer_noise" "printer_noise" 0 1000 15 nil)
    (director_wait_time 8.0)
    (effecteer_stop "printer_noise")
    (say "andrea" (get_dialog dialogs language 6) "priunipg_track6") ;preview: Eheheh . . . | animation back
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 7) "priunipg_track7") ;preview: I'm a genius! | animation front
    (effecteer_delete "printer_noise")

    ;And never again
    (collector_set "got_authorization" 1.0)
    (collector_set "done_authorization" 1.0))
  (begin
    (say "andrea" (get_dialog dialogs language 1) "priunipg_track1") ;preview: A printer . . . | animation back
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 2) "priunipg_track2") ;preview: The old kind of printer that... | animation front
    (say "andrea" (get_dialog dialogs language 3) "priunipg_track3")) ;preview: . . . it will be easier to d... | animation front
  )
;Refresh interface
(director_script "update_items_interface")

;Return the control
(main_control "andrea")
