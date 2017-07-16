; Pomodoro
; Module: intro_unipgA
; Author: nardinan
; Date  : 15 July 2017

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
(collector_set "from_where" "unipgA")

; Setup characters
(puppeteer_disable_control)
(if (compare from_where "innamorati")
	(puppeteer_show "andrea" 4530)
	(puppeteer_show "andrea" 1200))
)

; Setup characters
(animation "andrea" 	"front")
(main_control "andrea")
