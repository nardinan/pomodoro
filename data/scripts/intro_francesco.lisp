; Pomodoro
; Module: intro_francesco
; Author: nardinan
; Date  : 12 June 2017
; This module contains the intro of the Francesco scenario

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
; Play background
(stagecrafter_play "nature_background")

; Collect environment
(define from_where (collector_get "from_where"))

; Configure
(collector_set "from_where" "francesco")

; Setup characters
(puppeteer_disable_control)
(if (compare from_where "innamorati")
	(puppeteer_show "andrea" 8700)
	(puppeteer_show "andrea" 300)
)

(puppeteer_show "roberto" 5000)
(puppeteer_stare "roberto" "andrea")

; Setup characters
(animation "andrea" 	"front")
(animation "roberto"	"front")
(main_control "andrea")
