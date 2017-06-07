; Pomodoro
; Module: intro_med
; Author: nardinan
; Date  : 9 May 2017

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
(collector_set "from_where" "med")

; Setup characters
(puppeteer_disable_control)
(puppeteer_show "andrea" 590)
(puppeteer_show "massimo" 2700)

; Setup characters
(animation "andrea" 	"front")
(animation "massimo"	"still_left")
(main_control "andrea")
