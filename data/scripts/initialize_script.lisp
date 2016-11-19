; Pomodoro
; this script handles some interesting game parts
(define say
	(lambda (c m)
		(begin
			(puppeteer_say c m 2)
			(director_wait 2)
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

(stagecrafter_show "cern")
