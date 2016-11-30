; Pomodoro
; 	item: sink_A
;	author: Andrea Nardinocchi
;	date: 15/11/2016
(define say
	(lambda (c m)
		(begin
			(puppeteer_say c m  (+ 1 (* (length m) 0.05)))
			(director_wait_message c)
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
(puppeteer_disable_control)
(animation "andrea" "back")
(say "andrea" "yeah, you know ... I don't really want to clean this mess ...")
(animation "andrea" "front")
(main_control "andrea")