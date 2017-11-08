;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_cabin
;Author: nardinan
;Date  : 3 Nov 2017

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

;Environment configuration (music, effect, whatever)
(puppeteer_disable_control)

;Draw interface
(director_script "update_items_interface")

;Play background
(stagecrafter_play "cave_background")

;Collect environment
(define from_where (collector_get "from_where"))

;Configure
(collector_set "from_where" "cabin")

;Setup characters
(puppeteer_show "andrea" 590)
(puppeteer_set "andrea" "front")
(main_control "andrea")
