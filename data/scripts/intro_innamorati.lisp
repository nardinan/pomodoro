;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_innamorati
;Author: nardinan
;Date  : 31 March 2017

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
(stagecrafter_play "traffic_background")

;Collect environment
(define from_where (collector_get "from_where"))
(define marta_quiet_dialog (collector_get "marta_quiet_dialog"))

;Configure
(collector_set "from_where" "innamorati")

;Setup characters
(puppeteer_disable_control)
(if (compare from_where "unipgA")
	(puppeteer_show "andrea" 13600)
	(if (compare from_where "francesco")
		(puppeteer_show "andrea" 11270)
		(puppeteer_show "andrea" 900)
	)
)

;Setup characters
(puppeteer_show "writer" 8900)
(animation "andrea" "front")
(animation "writer" "back_writer")
(if (= marta_quiet_dialog 1.0)
	nil
	(begin
		(puppeteer_show "marta"  12300)
		(puppeteer_show "bruno"  12600)
		(animation "marta" "still_right")
		(animation "bruno" "still_left"))
)

;Return the control
(main_control "andrea")
