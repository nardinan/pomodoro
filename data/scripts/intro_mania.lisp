;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_mania
;Author: nardinan
;Date  : 25 May 2017

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
(define from_where      (collector_get "from_where"))
(define current_chapter (collector_get "current_chapter"))

;Configure
(collector_set "from_where" "mania")

;Setup characters
(puppeteer_show "serena" 2280)
(if (compare current_chapter "epilogue")
  (puppeteer_set "serena" "front_loading")
  (puppeteer_set "serena" "still_left")
  )
(puppeteer_show "andrea" 590)
(puppeteer_set "andrea" "front")
(main_control "andrea")
