; Pomodoro
; Module: intro_mania
; Author: nardinan
; Date  : 25 May 2017

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
(collector_set "from_where" "mania")

; Setup characters
(puppeteer_disable_control)
(puppeteer_show "andrea" 590)

; Setup characters
(animation "andrea" 	"front")
(main_control "andrea")
