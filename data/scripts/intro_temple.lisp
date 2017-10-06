;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_temple
;Author: nardinan
;Date  : 5 Oct 2017

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
(stagecrafter_play "disturbing_background")

;Collect environment
(define from_where (collector_get "from_where"))

;Configure
(collector_set "from_where" "temple")

;Setup characters
(puppeteer_disable_control)
(puppeteer_show "andrea" 1300)

;Setup characters
(animation "andrea" 	"front")
(main_control "andrea")
