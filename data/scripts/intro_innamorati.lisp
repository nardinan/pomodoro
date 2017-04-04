; Pomodoro
; Module: intro_garibaldi
; Author: nardinan
; Date  : 31 March 2017
; This module contains the intro of the Innamorati scenario

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
(stagecrafter_play "traffic_background")

; Collect environment 
(define from_where (collector_get "from_where"))

; Configure
(collector_set "from_where" "innamorati")

; Setup characters
(puppeteer_disable_control)
(if (compare from_where "unipgp1")
	(puppeteer_show "andrea" 9000)
	(puppeteer_show "andrea" 1000)
)

; Setup characters
(animation 			"andrea" 	"front")

(main_control "andrea")
