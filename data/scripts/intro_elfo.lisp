;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_elfo
;Author: nardinan
;Date  : 5 June 2017

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

;Collect environment
(define from_where (collector_get "from_where"))

;Configure
(collector_set "from_where" "elfo")

;Setup characters
(puppeteer_show "caprini"  3000)
(puppeteer_stare "caprini" "andrea")
(puppeteer_show "andrea" 300)
(puppeteer_set "andrea" "front")
(main_control "andrea")
