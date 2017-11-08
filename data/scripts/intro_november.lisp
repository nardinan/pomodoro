;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_november
;Author: nardinan
;Date  : 4 Feb 2017

;High level functions
;@brief: main_control <character>
;@description: gives the main control of the game to the character <character>
(define main_control
  (lambda (c)
    (begin
      (director_camera_follow c -100.0 1.0)
      (puppeteer_enable_control c)
      )
    )
  )

;Draw interface
(director_script "update_items_interface")

;Play background
(stagecrafter_play "people_background")

;Collect environment
(define from_where (collector_get "from_where"))
(define yuriy_quiet_dialog_garibaldi (collector_get "yuriy_quiet_dialog_garibaldi"))
(define yuriy_quiet_dialog_november (collector_get "yuriy_quiet_dialog_november"))
(define done_flowers (collector_get "done_flowers"))
(define request_flowers (collector_get "request_flowers"))

;Configure
(collector_set "from_where" "november")

;Setup characters
(puppeteer_show "policeman" 3000)
(puppeteer_set "policeman" 	"front")
(if (= yuriy_quiet_dialog_garibaldi 1.0)
	(if (= yuriy_quiet_dialog_november 1.0)
		nil
		(begin
			(puppeteer_show "andrii" 6800)
			(puppeteer_show "yuriy"  6400)
			(puppeteer_set "andrii" "still_left_radar_up")
			(puppeteer_set "yuriy" "still_right"))
		)
		nil
)
(if (= request_flowers 1.0)
  (if (= done_flowers 1.0)
    nil
    (begin
      (puppeteer_show  "mustafa" 6000)
      (puppeteer_stare "mustafa" "andrea"))
  )
  nil
)
(if (compare from_where "fortebraccio")
	(puppeteer_show "andrea" 980)
	(if (compare from_where "vannucci")
		(puppeteer_show "andrea" 7500)
		(puppeteer_show "andrea" 7900)
	)
)
(puppeteer_set "andrea" "front")
(main_control "andrea")
