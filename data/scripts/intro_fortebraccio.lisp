; Pomodoro
; Module: intro_fortebraccio
; Author: nardinan
; Date  : 21 Jan 2017

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

; Collect environment 
(define from_where (collector_get "from_where"))

; Configure
(collector_set "from_where" "fortebraccio")

; Setup characters
(puppeteer_disable_control)
(if (compare from_where "garibaldi")
	(puppeteer_show "andrea" 4980)
	(puppeteer_show "andrea" 1000)
)

; Setup characters
(animation "andrea" 	"front")
(main_control "andrea")
