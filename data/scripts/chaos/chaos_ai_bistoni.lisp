;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : <none>
;Location   : UnipgA
;Author     : Nardinan
;Description: Bistoni tells you where to ask for the password

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 bistoni
			"*beep*"    
			"*beep*")   
		(cons ;2 andrea
			"Unrecoverable."    
			"Irrecuperabile.")   
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
(define dialog_intro_done         (collector_get "bistoni_intro_chaos_dialog"))
(define dialog_done_done          (collector_get "bistoni_done_chaos_dialog"))
(define request_authorization     (collector_get "request_authorization"))
(define request_location          (collector_get "request_location"))
(define request_password          (collector_get "request_password"))
(define done_location             (collector_get "done_location"))
(define done_computer             (collector_get "done_computer"))

;Action!
(collector_set "chaos_bistoni_and_policeman_ongoing" 1.0)
(puppeteer_look "andrea" "bistoni")
(puppeteer_look "bistoni" "andrea")
(if (= done_location 1.0)
  (begin
    (say "bistoni" (get_dialog dialogs language 1) "bistdonchaos_track1") ;preview: *beep* | looking at andrea
    (puppeteer_set "andrea" "front")
    (say "andrea"  (get_dialog dialogs language 2) "bistdonchaos_track2")) ;preview: Unrecoverable | animation front
  (begin
    (if (= request_password 1.0)
      (begin
        (if (= dialog_done_done 1.0)
          (director_dialog "game_bistoni_done_after_0x0c")
          (begin
            (director_dialog "game_bistoni_done_first_0x0c")

            ;And never again
            (collector_set "bistoni_done_chaos_dialog" 1.0))
          )
        (director_wait_dialog)
        )
      (begin
        (if (= dialog_intro_done 1.0)
          (director_dialog "game_bistoni_intro_after_0x0c")
          (begin
            (director_dialog "game_bistoni_intro_first_0x0c")

            ;And never again
            (collector_set "bistoni_intro_chaos_dialog" 1.0))
          )

        (director_wait_dialog)
        (if (= request_authorization 1.0)
          (if (= request_location 1.0)
            (director_dialog "game_bistoni_requested_no_tool_0x0c")
            (director_dialog "game_bistoni_activated_no_tool_0x0c")
            )
          (director_dialog "game_bistoni_no_request_0x0c")
          )
        (director_wait_dialog))
      ))
  )
(collector_set "chaos_bistoni_and_policeman_ongoing" 0.0)

;Return the control
(main_control "andrea")
