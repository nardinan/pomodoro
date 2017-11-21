;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : <none>
;Location   : UnipgA
;Author     : Nardinan
;Description: Serena gives you the Mojito if you give her lemon, glass and brown sugar

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
(define dialog_done         (collector_get "serena_virus_dialog"))
(define request_cocktail    (collector_get "request_cocktail"))
(define request_lemon       (collector_get "request_lemon"))
(define request_glass       (collector_get "request_glass"))
(define request_sugar       (collector_get "request_sugar"))
(define got_lemon           (collector_get "got_lemon"))
(define got_glass           (collector_get "got_glass"))
(define got_sugar           (collector_get "got_sugar"))
(define done_cocktail       (collector_get "done_cocktail"))
(define request_components  (+ (+ request_lemon request_glass) request_sugar))
(define got_components      (+ (+ got_lemon got_glass) got_sugar))

;Action!
(puppeteer_look "andrea" "serena")
(puppeteer_look "serena" "andrea")
(if (= dialog_done 1.0)
  (director_dialog "game_serena_intro_after_0x0b")
  (begin
    (director_dialog "game_serena_intro_first_0x0b")

    ;And never again
    (collector_set "serena_virus_dialog" 1.0))
  )
(director_wait_dialog)
(if (= request_cocktail 1.0)
  (if (= done_cocktail 1.0)
    (director_dialog "game_serena_done_0x0b")
    (if (= got_components 3.0)
      (director_dialog "game_serena_requested_tool_0x0b")
      (if (= request_components 3.0)
        (director_dialog "game_serena_requested_no_tool_0x0b")
        (director_dialog "game_serena_activated_no_tool_0x0b")
        )
      )
    )
  (director_dialog "game_serena_no_request_0x0b")
  )
(director_wait_dialog)
(director_script "virus_ai_serena_shake_cocktail")
