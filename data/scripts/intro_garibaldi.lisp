; Pomodoro
; Module: intro_garibaldi
; Author: nardinan
; Date  : 2 Jan 2017
; This module contains the intro of the Garibaldi scenario

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
(collector_set "from_where" "garibaldi")

; Setup characters
(puppeteer_disable_control)
(if (compare from_where "lupattelli")
	(puppeteer_show "andrea" 6900)
	(puppeteer_show "andrea" 1100)
)

; Setup characters
(puppeteer_show 	"baker" 	3500)
(puppeteer_show 	"maria" 	-200)
(animation 			  "andrea" 	"front")
(animation 			  "baker" 	"still_right")
(puppeteer_stare 	"baker"		"andrea")
(if (collector_get "yuriy_quiet_dialog_garibaldi")
	nil
	(begin
		(puppeteer_show "andrii"	1500)
		(puppeteer_show "yuriy"		2000)
		(animation "andrii" "still_right_radar_up")
		(animation "yuriy"	"still_left")
	)
)

;Return the control
(main_control "andrea")
