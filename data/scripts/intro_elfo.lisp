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
(define current_chapter (collector_get "current_chapter"))
(define done_location (collector_get "done_location"))

;Configure
(collector_set "from_where" "elfo")

;Setup characters
(if (compare current_chapter "epilogue")
  (begin
    (puppeteer_show "caprini" 3000)
    (puppeteer_set "caprini" "drink_left")
    (puppeteer_show "yuriy" 2000)
    (puppeteer_set "yuriy" "drink_left")
    (puppeteer_show "andrii" 1000)
    (puppeteer_set "andrii" "drink_right"))
  (if (compare current_chapter "chaos")
    (if (= done_location 1.0)
      (begin
        (puppeteer_show "caprini" 3000)
        (puppeteer_set "caprini" "drink_left")
        (puppeteer_show "yuriy" 2600)
        (puppeteer_set "yuriy" "drink_left")
        (puppeteer_show "andrii" 2200)
        (puppeteer_set "andrii" "drink_right"))
      nil
      )
    (begin
      (puppeteer_show "caprini"  3000)
      (puppeteer_stare "caprini" "andrea"))
    )
  )
(puppeteer_show "andrea" 300)
(puppeteer_set "andrea" "front")
(main_control "andrea")
