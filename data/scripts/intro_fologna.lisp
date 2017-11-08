;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_fologna
;Author: nardinan
;Date  : 18 Sept 2017

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
(stagecrafter_play "engine_background")

;Configure
(collector_set "from_where" "fologna")

;Stop the background music
(effecteer_stop "stone_paradise")

;Setup characters
(puppeteer_show "chaos" 2900)
(puppeteer_stare "chaos" "andrea")
(puppeteer_show "andrea" 250)
(puppeteer_set "andrea" "front")
(main_control "andrea")

;And never again
(collector_set "fologna_enabled" 2)
