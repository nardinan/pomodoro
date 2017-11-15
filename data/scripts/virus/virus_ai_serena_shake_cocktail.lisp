;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : sermojivirus
;Location   : Mania
;Author     : Nardinan
;Description: Serena asks Andrea to stop asking stuff for free

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 serena
                    "Here, your Mojito."
                    "Ecco il tuo Mojito.")
                  (cons ;2 serena
                    "It's a little bit diluted . . ."
                    "Un po' annacquato forse . . .")
                  (cons ;3 serena
                    ". . . but Kerosene free!"
                    ". . . ma senza Kerosene!")
                  (cons ;4 serena
                    "Kerosene is for those who pay!"
                    "Il Kerosene e' per chi paga!")
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
(define animation_done      (collector_get "serena_virus_animation"))
(define done_cocktail       (collector_get "done_cocktail"))

;Action!
(if (= animation_done 1.0)
  nil
  (if (= done_cocktail 1.0)
    (begin
      (puppeteer_set "serena" "shake_left")
      (director_wait_time 4)
      (puppeteer_set "serena" "still_left")
      (say "serena" (get_dialog dialogs language 1) "sermojivirus_track1") ;preview: Here, your Mojito. | looking at Andrea

      ;Refresh interface
      (director_script "update_items_interface")

      (say "serena" (get_dialog dialogs language 2) "sermojivirus_track2") ;preview: It's a little bit diluted . ... | looking at Andrea
      (say "serena" (get_dialog dialogs language 3) "sermojivirus_track3") ;preview: . . . but Kerosene free! | looking at Andrea
      (puppeteer_set "serena" "point_left")
      (say "serena" (get_dialog dialogs language 4) "sermojivirus_track4") ;preview: Kerosene is for those who pay! | looking at Andrea | animation pointing
      (puppeteer_set "serena" "still_left")

      ;And never again
      (collector_set "serena_virus_animation" 1.0))
    nil
    )
  )

;Refresh interface
(director_script "update_items_interface")

;Return the control
(main_control "andrea")

;Prepare drug cocktail (if possible)
(director_script "virus_ai_andrea_drug_cocktail")
