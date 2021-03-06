;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : <none>
;Location   : UnipgA
;Author     : Nardinan
;Description: The nerd gives you the screwdriver if you give him his glasses

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

;Parameters configuration
(define animation_done      (collector_get "nerd_virus_animation"))
(define done_screwdriver    (collector_get "done_screwdriver"))

;Action!
(if (= animation_done 1.0)
  nil
  (if (= done_screwdriver 1.0)
    (begin
      (puppeteer_stare "andrea" "nerd")
      (director_camera_follow "nerd" -100.0 1.0)
      (puppeteer_move "nerd" 7740)
      (director_wait_movement "nerd")
      (puppeteer_set "nerd" "back_code")
      (director_wait_time 3)
      (puppeteer_set "nerd" "back")
      (director_wait_time 1)
      (puppeteer_move "nerd" 7040)
      (director_wait_movement "nerd")
      (puppeteer_stare "andrea" "#null")
      (puppeteer_look "nerd" "andrea")
      (director_wait_time 1)

      ;And never again
      (collector_set "nerd_virus_animation" 1.0))
    nil
    )
  )
(puppeteer_set "nerd" "back_code")
(stagecrafter_set_item "computer_A" "coding_A")

;Refresh interface
(director_script "update_items_interface")

;Return the control
(main_control "andrea")
