;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_lupattelli
;Author: nardinan
;Date  : 20 Dec 2016

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
(stagecrafter_play "birds_background")

;Collect environment
(define from_where        (collector_get "from_where"))
(define current_chapter   (collector_get "current_chapter"))
(define done_cabin_key    (collector_get "done_cabin_key"))

;Configure
(collector_set "from_where" "lupattelli")

;Setup characters
(puppeteer_show "technician" 3100)
(if (= done_cabin_key 1.0)
  (if (compare current_chapter "virus")
    (puppeteer_set "technician" "drunk_left")
    (puppeteer_stare "technician" "andrea")
    )
  (puppeteer_stare "technician" "andrea")
  )
(if (compare from_where "garibaldi")
  (puppeteer_show "andrea" 3600)
  (puppeteer_show "andrea" 2090)
  )
(if (compare current_chapter "quiet")
  (director_script "quiet_intro_lupattelli")
  (main_control "andrea")
  )
