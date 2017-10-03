;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_panorama
;Author: nardinan
;Date  : 6 Sept 2017
;This module contains the intro of the Panorama scenario

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
(collector_set "from_where" "panorama")

;Setup characters
(puppeteer_show  "andrea"   280)
(puppeteer_show  "federico" 5750)
(puppeteer_stare "federico" "andrea")
(animation "andrea" 	"front")
(animation "federico" "back")
;Return the control
(main_control "andrea")
