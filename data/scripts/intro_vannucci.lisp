; Pomodoro
; Module: intro_vannucci
; Author: nardinan
; Date  : 22 April 2017

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
(stagecrafter_play "people_background")

; Collect environment
(define from_where (collector_get "from_where"))

; Configure
(collector_set "from_where" "vannucci")

; Setup characters
(puppeteer_disable_control)
(if (compare from_where "november")
	(puppeteer_show "andrea" 240)
	(if (compare from_where "priori")
		(puppeteer_show "andrea" 3400)
		(if (compare from_where "panoramica")
			(puppeteer_show "andrea" 11800)
			(puppeteer_show "andrea" 12000)
		)
	)
)

; Setup characters
(animation "andrea" 	"front")
(main_control "andrea")
