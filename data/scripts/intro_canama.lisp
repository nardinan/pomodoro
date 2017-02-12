; Pomodoro
; Module: intro_canama
; Author: nardinan
; Date  : 20 Nov 2016

; Dialogs
(define language (collector_get "language"))
(define dialogs (nil))

(define say
	(lambda (c m)
		(begin
			(puppeteer_say c m (+ 1 (* (length m) 0.05)))
			(director_wait_time (+ 1 (* (length m) 0.05)))
		)
	)
)

(define animation
	(lambda (c m)
		(begin
			(puppeteer_set c m)
		)
	)
)

(define main_control
	(lambda (c)
		(begin
			(director_camera_follow c -100.0 1.0)
			(puppeteer_enable_control c)
		)
	)
)

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

; Collect environment 
(define note_A_taken (collector_get "note_A_taken"))

; Configure
(collector_set "from_where" "canama")
(if (= note_A_taken 1.0)
	(begin
		(stagecrafter_set_item "notes_A" "none")
		(stagecrafter_enable_item "bed_B"))
	nil)

; Setup characters
(puppeteer_disable_control)
(puppeteer_show "andrea" 	450)
(puppeteer_show "luca" 		810)
(puppeteer_show "luna"		1100)
(animation "andrea" 	"front")
(animation "luca" 		"front")
(animation "luna"		"front")
(main_control "andrea")