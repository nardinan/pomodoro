;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_gallenga
;Author: nardinan
;Date  : 27 Feb 2017

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
;Play background
(stagecrafter_play "people_background")

;Collect environment
(define from_where (collector_get "from_where"))

;Configure
(collector_set "from_where" "gallenga")

;Setup characters
(puppeteer_disable_control)
(puppeteer_show "andrea" 1950)
(puppeteer_show "antonietta" 100)
(puppeteer_show "luna" 2900)

;Setup characters
(animation "andrea" 		"front")
(animation "antonietta"	"still_right")
(puppeteer_stare "luna" "andrea")
(main_control "andrea")
