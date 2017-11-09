;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_fortebraccio
;Author: nardinan
;Date  : 21 Jan 2017

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
(stagecrafter_play "traffic_background")

;Collect environment
(define from_where (collector_get "from_where"))

;Configure
(collector_set "from_where" "fortebraccio")

;Setup characters
(if (compare from_where "garibaldi")
  (puppeteer_show "andrea" 4980)
  (if (compare from_where "gallenga")
    (puppeteer_show "andrea" 3360)
    (if (compare from_where "november")
      (puppeteer_show "andrea" 1000)
      (puppeteer_show "andrea" 1300))
    )
  )
(puppeteer_set "andrea" "front")
(main_control "andrea")
