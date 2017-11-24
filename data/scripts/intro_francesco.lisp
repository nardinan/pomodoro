;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_francesco
;Author: nardinan
;Date  : 12 June 2017

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
(stagecrafter_play "nature_background")

;Collect environment
(define from_where (collector_get "from_where"))
(define current_chapter (collector_get "current_chapter"))

;Configure
(collector_set "from_where" "francesco")

;Setup characters
(if (compare current_chapter "chaos")
  (begin
    (puppeteer_show "private_enrico" 4000)
    (puppeteer_look "private_enrico" "private_richard")
    (puppeteer_show "private_richard" 4500)
    (puppeteer_look "private_richard" "private_enrico"))
  (begin
    (puppeteer_show "roberto" 5000)
    (puppeteer_stare "roberto" "andrea"))
  )
(if (compare from_where "innamorati")
  (puppeteer_show "andrea" 8700)
  (puppeteer_show "andrea" 300)
  )
(puppeteer_set "andrea" "front")
(main_control "andrea")
