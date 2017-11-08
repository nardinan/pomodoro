;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : bkrquiet
;Location   : Garibaldi
;Author     : Nardinan
;Description: The baker is there to give you a cigarette

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
(define dialog_done         (collector_get "baker_quiet_dialog"))
(define request_cigarette   (collector_get "request_cigarette"))
(define done_cigarette      (collector_get "done_cigarette"))

;Action!
(puppeteer_look "andrea" "baker")
(if (= dialog_done 1.0)
  (director_dialog "game_baker_intro_after_0x0a")
  (begin
    (director_dialog "game_baker_intro_first_0x0a")

    ;And never again
    (collector_set "baker_quiet_dialog" 1.0))
)
(director_wait_dialog)
(if (= request_cigarette 1.0)
  (if (= done_cigarette 1.0)
    (director_dialog "game_baker_done_0x0a")
    (director_dialog "game_baker_requested_tool_0x0a")
  )
  (director_dialog "game_baker_no_request_0x0a")
)
(director_wait_dialog)

;Refresh interface
(director_script "update_items_interface")
(director_script "quiet_ai_baker_run_away")
