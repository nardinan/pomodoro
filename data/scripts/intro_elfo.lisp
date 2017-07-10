; Pomodoro
; Module: intro_elfo
; Author: nardinan
; Date  : 5 June 2017

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
(collector_set "from_where" "elfo")

; Setup characters
(puppeteer_disable_control)
(puppeteer_show "andrea"  300)
(puppeteer_show "gianni"  3000)
(puppeteer_show "mariano" 2340)

; Setup characters
(animation "andrea" 	     "front")
(animation "gianni"        "drink_left")
(puppeteer_stare "mariano" "andrea")
(main_control "andrea")
