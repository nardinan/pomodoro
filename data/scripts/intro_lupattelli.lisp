;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_lupattelli
;Author: nardinan
;Date  : 20 Dec 2016

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
(stagecrafter_play "birds_background")

;Collect environment
(define from_where (collector_get "from_where"))

;Configure
(collector_set "from_where" "lupattelli")

;Setup characters
(puppeteer_disable_control)
(if (compare from_where "stairs")
	(puppeteer_show "andrea" 2090)
	(puppeteer_show "andrea" 3600)
)

;Setup characters
(animation "andrea" 	"front")
(main_control "andrea")
