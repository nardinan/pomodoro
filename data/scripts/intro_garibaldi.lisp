;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_garibaldi
;Author: nardinan
;Date  : 2 Jan 2017

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
(collector_set "from_where" "garibaldi")

;Setup characters
(puppeteer_show "maria" -200)
(puppeteer_show "baker" 3500)
(puppeteer_stare "baker" "andrea")
(if (collector_get "yuriy_quiet_dialog_garibaldi")
  nil
  (begin
    (puppeteer_show "andrii" 1500)
    (puppeteer_set "andrii" "still_right_radar_up")
    (puppeteer_show "yuriy"	2000)
    (puppeteer_set "yuriy" "still_left")
    )
  )
(if (compare from_where "lupattelli")
  (puppeteer_show "andrea" 6900)
  (puppeteer_show "andrea" 1100)
  )
(puppeteer_set "andrea" "front")
(main_control "andrea")
