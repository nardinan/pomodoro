; Pomodoro
; Module: intro_priori
; Author: nardinan
; Date  : 28 May 2017

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
(collector_set "from_where" "priori")

; Setup characters
(puppeteer_disable_control)
(if (compare from_where "vannucci")
	(puppeteer_show "andrea" 250)
	(if (compare from_where "elfo")
		(puppeteer_show "andrea" 5900)
		(puppeteer_show "andrea" 8750)
	)
)

; Setup characters
(animation "andrea" 	"front")
(main_control "andrea")
