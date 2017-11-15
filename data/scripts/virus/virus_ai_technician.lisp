;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : techdrivirus
;Location   : Lupattelli
;Author     : Nardinan
;Description: The guy drinks the altered cocktail and gives you the key

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 technician
                    "Oh god . . ."
                    "Oddio . . .")
                  (cons ;2 technician
                    ". . . what did you put inside that . . ."
                    ". . . ma che c'era in quel . . .")
                  (cons ;3 technician
                    ". . . COCKTAIL."
                    ". . . COCKTAIL.")
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
(define dialog_done         (collector_get "technician_virus_dialog"))
(define request_cocktail    (collector_get "request_cocktail"))
(define request_pills       (collector_get "request_pills"))
(define got_cocktail        (collector_get "got_cocktail"))
(define got_pills           (collector_get "got_pills"))
(define got_drug_cocktail   (collector_get "got_drug_cocktail"))
(define done_cabin_key      (collector_get "done_cabin_key"))
(define andrea_position     (puppeteer_get_position "andrea"))
(define technician_position (puppeteer_get_position "technician"))

;Calculate position of the technician in respect of andrea
(define drink_side "drink_left")
(define drunk_side "drunk_left")
(if (> andrea_position technician_position)
  (begin
    (set drink_side "drink_right")
    (set drunk_side "drunk_right"))
  nil
  )

;Action!
(puppeteer_look "andrea" "technician")
(if (= done_cabin_key 1.0)
  (begin
    (puppeteer_set "technician" drunk_side)
    (say "technician" (get_dialog dialogs language 1) "techdrivirus_track1") ;preview: Oh god . . . | looking at Andrea
    (say "technician" (get_dialog dialogs language 2) "techdrivirus_track2") ;preview: . . . what did you put insid... | looking at Andrea
    (say "technician" (get_dialog dialogs language 3) "techdrivirus_track3") ;preview: . . . COCKTAIL. | looking at Andrea

    ;Return the control
    (main_control "andrea"))
  (begin
    (if (= dialog_done 1.0)
      (director_dialog "game_technician_intro_after_0x0b")
      (begin
        (director_dialog "game_technician_intro_first_0x0b")

        ;And never again
        (collector_set "technician_virus_dialog" 1.0))
      )
    (director_wait_dialog)
    (if (= got_cocktail 1.0)
      (director_dialog "game_technician_requested_half_tool_cocktail_0x0b")
      (if (= got_pills 1.0)
        (director_dialog "game_technician_requested_half_tool_pills_0x0b")
        (if (= got_drug_cocktail 1.0)
          (director_dialog "game_technician_requested_tool_0x0b")
          (if (>= (+ request_cocktail request_pills) 1.0)
            (director_dialog "game_technician_requested_no_tool_0x0b")
            (director_dialog "game_technician_activated_no_tool_0x0b")
            )
          )
        )
      )
    (director_wait_dialog)
    (if (>= (+ got_cocktail got_pills) 1.0)
      (director_script "virus_ai_technician_explain_plan")
      (director_script "virus_ai_technician_being_drunk")
      ))
  )
