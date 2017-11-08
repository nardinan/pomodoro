;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_panorama
;Author: nardinan
;Date  : 6 Sept 2017
;This module contains the intro of the Panorama scenario

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
(define from_where (collector_get "from_where"))
(define current_chapter (collector_get "current_chapter"))

;Configure
(collector_set "from_where" "panorama")

;Setup characters
(if (compare current_chapter "quiet")
  nil
  (begin
    (puppeteer_show "federico" 5750)
    (puppeteer_set "federico" "back"))
)
(puppeteer_show  "andrea" 280)
(puppeteer_set "andrea" "front")
(main_control "andrea")
