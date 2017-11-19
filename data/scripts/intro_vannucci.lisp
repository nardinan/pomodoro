;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_vannucci
;Author: nardinan
;Date  : 22 April 2017

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
(stagecrafter_play "people_background")

;Collect environment
(define from_where      (collector_get "from_where"))
(define current_chapter (collector_get "current_chapter"))

;Configure
(collector_set "from_where" "vannucci")

;Setup characters
(puppeteer_show "ticket_inspector" 10100)
(puppeteer_stare "ticket_inspector" "andrea")
(puppeteer_show "gianni" 4500)
(puppeteer_set "gianni" "still_left")
(if (compare current_chapter "quiet")
  (begin
    (puppeteer_show "mariano" 4200)
    (puppeteer_set "mariano" "still_right")
    (puppeteer_show  "jamal" 6900)
    (puppeteer_set "jamal" "back"))
  (if (compare current_chapter "virus")
    (begin
      (puppeteer_show "yuriy" 8400)
      (puppeteer_set  "yuriy" "still_left")
      (puppeteer_show "andrii" 8000)
      (puppeteer_set "andrii" "still_right"))
    nil
    )
  )
(if (compare from_where "november")
  (puppeteer_show "andrea" 320)
  (if (compare from_where "priori")
    (puppeteer_show "andrea" 3400)
    (if (compare from_where "med")
      (puppeteer_show "andrea" 7300)
      (puppeteer_show "andrea" 11700)
      )
    )
  )
(puppeteer_set "andrea" "front")
(main_control "andrea")
