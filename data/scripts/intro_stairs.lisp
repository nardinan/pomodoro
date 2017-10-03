;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_stairs
;Author: nardinan
;Date  : 14 Dec 2016

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

;Collect environment
(define from_where (collector_get "from_where"))

;Configure
(collector_set "from_where" "stairs")

;Setup characters
(puppeteer_disable_control)
(if (compare from_where "canama")
	(puppeteer_show "andrea" 1000)
	(if (compare from_where "palegi")
		(puppeteer_show "andrea" 2000)
		(if (compare from_where "lupattelli")
			(puppeteer_show "andrea" 250)
			(puppeteer_show "andrea" 1000)
		)
	)
)

;Setup characters
(animation "andrea" 	"front")
(main_control "andrea")
