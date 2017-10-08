;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_vannucci
;Author: nardinan
;Date  : 22 April 2017

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

;Draw interface
(director_script "items_interface")

;Play background
(stagecrafter_play "people_background")

;Collect environment
(define from_where (collector_get "from_where"))

;Configure
(collector_set "from_where" "vannucci")

;Setup characters
(puppeteer_disable_control)
(if (compare from_where "november")
	(puppeteer_show "andrea" 320)
	(if (compare from_where "priori")
		(puppeteer_show "andrea" 3400)
		(if (compare from_where "med")
			(puppeteer_show "andrea" 7300)
			(puppeteer_show "andrea" 11700)
		)
	)
)
(puppeteer_show  "ticket_inspector" 9800)
(puppeteer_show  "jamal" 		        6900)
(puppeteer_show  "gianni"           4500)
(puppeteer_show  "mariano"          4200)
(puppeteer_stare "ticket_inspector" "andrea")
(animation       "jamal"            "back")
(animation       "gianni"           "still_left")
(animation       "mariano"          "still_right")

;Setup characters
(puppeteer_stare "ticket_controller" "andrea")
(animation "andrea" "front")
(main_control "andrea")
