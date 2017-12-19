;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_temple
;Author: nardinan
;Date  : 5 Oct 2017

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
(stagecrafter_play "disturbing_background")

;Collect environment
(define from_where (collector_get "from_where"))

;Configure
(collector_set "from_where" "temple")

;Setup characters
(puppeteer_show "luna"  4000)
(puppeteer_set  "luna" "hung_front")
(puppeteer_show "luca"  4400)
(puppeteer_set  "luca" "hung_front")
(puppeteer_show "bruno"  4000)
(puppeteer_set  "bruno" "still_left")
(puppeteer_show "valerio" 3430)
(puppeteer_set "valerio" "none")
(puppeteer_show "andrea" 1300)
(puppeteer_set "andrea" "front")
(main_control "andrea")

(director_script "epilogue_intro_temple")
