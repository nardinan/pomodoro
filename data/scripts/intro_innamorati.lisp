;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_innamorati
;Author: nardinan
;Date  : 31 March 2017

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
(stagecrafter_play "traffic_background")

;Collect environment
(define from_where (collector_get "from_where"))
(define marta_quiet_dialog (collector_get "marta_quiet_dialog"))

;Configure
(collector_set "from_where" "innamorati")

;Setup characters
(puppeteer_disable_control)
(if (compare from_where "unipgA")
	(puppeteer_show "andrea" 13600)
	(if (compare from_where "francesco")
		(puppeteer_show "andrea" 11270)
		(puppeteer_show "andrea" 900)
	)
)

;Setup characters
(puppeteer_show "writer" 8900)
(animation "andrea" "front")
(animation "writer" "back_writer")
(if (= marta_quiet_dialog 1.0)
	nil
	(begin
		(puppeteer_show "marta"  12300)
		(puppeteer_show "bruno"  12600)
		(animation "marta" "still_right")
		(animation "bruno" "still_left"))
)

;Return the control
(main_control "andrea")
