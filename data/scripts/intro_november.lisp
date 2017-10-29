;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_november
;Author: nardinan
;Date  : 4 Feb 2017

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
(director_script "update_items_interface")

;Play background
(stagecrafter_play "people_background")

;Collect environment
(define from_where (collector_get "from_where"))
(define yuriy_quiet_dialog_garibaldi (collector_get "yuriy_quiet_dialog_garibaldi"))
(define yuriy_quiet_dialog_november (collector_get "yuriy_quiet_dialog_november"))
(define done_flowers (collector_get "done_flowers"))
(define request_flowers (collector_get "request_flowers"))

;Configure
(collector_set "from_where" "november")

;Setup characters
(puppeteer_disable_control)
(if (compare from_where "fortebraccio")
	(puppeteer_show "andrea" 980)
	(if (compare from_where "vannucci")
		(puppeteer_show "andrea" 7500)
		(puppeteer_show "andrea" 7900)
	)
)
(puppeteer_show "policeman" 3000)

;Setup characters
(animation "andrea" 		"front")
(animation "policeman" 	"front")
(if (= yuriy_quiet_dialog_garibaldi 1.0)
	(if (= yuriy_quiet_dialog_november 1.0)
		nil
		(begin
			(puppeteer_show "andrii" 6800)
			(puppeteer_show "yuriy"  6400)
			(animation "andrii" "still_left_radar_up")
			(animation "yuriy" "still_right"))
		)
		nil
)
(if (= request_flowers 1.0)
  (if (= done_flowers 1.0)
    nil
    (begin
      (puppeteer_show  "mustafa" 6000)
      (puppeteer_stare "mustafa" "andrea"))
  )
  nil
)

;Setup character
(main_control "andrea")
