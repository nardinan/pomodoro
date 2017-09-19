; Pomodoro
; Module: intro_fologna
; Author: nardinan
; Date  : 18 Sept 2017

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
(stagecrafter_play "engine_background")

; Configure
(collector_set "from_where" "fologna")

; Stop the background music
(effecteer_stop "stone_paradise")

; Setup characters
(puppeteer_show "andrea" 250)
(puppeteer_show "chaos" 2900)
(animation "andrea" "front")
(puppeteer_stare 	"chaos" "andrea")
(main_control "andrea")

; And never again
(collector_set "fologna_enabled" 2)
