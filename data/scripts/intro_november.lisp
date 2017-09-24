; Pomodoro
; Module: intro_november
; Author: nardinan
; Date  : 4 Feb 2017

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
(define intro_chronos (collector_get "intro_chronos"))
(define outro_chronos (collector_get "outro_chronos"))

; Configure
(collector_set "from_where" "november")

; Setup characters
(puppeteer_disable_control)
(if (compare from_where "fortebraccio")
	(puppeteer_show "andrea" 980)
	(if (compare from_where "vannucci")
		(puppeteer_show "andrea" 7500)
		(puppeteer_show "andrea" 7900)
	)
)
(puppeteer_show "policeman" 3000)
(puppeteer_show "jamal" 5000)
(puppeteer_show "gianni" 5300)
(if (= intro_chronos 1.0)
	(if (= outro_chronos 1.0)
		nil
		(begin
			(puppeteer_show "andrii" 6800)
			(puppeteer_show "yuriy"  6400)
			(animation "andrii" "still_left_radar_up")
			(animation "yuriy" "still_right"))
		)
		nil
)

; Setup characters
(animation "andrea" "front")
(animation "policeman" "front")
(animation "jamal" "still_right")
(animation "gianni" "drink_left")
(main_control "andrea")
