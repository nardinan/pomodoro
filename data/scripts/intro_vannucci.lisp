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
(if (compare (collector_get "current_chapter") "epilogue")
  (stagecrafter_play "birds_background")
  (stagecrafter_play "people_background")
  )

;Collect environment
(define from_where      (collector_get "from_where"))
(define current_chapter (collector_get "current_chapter"))

;Configure
(collector_set "from_where" "vannucci")

;Setup characters
(puppeteer_show "ticket_inspector" 10100)
(if (compare current_chapter "epilogue")
  (begin
    (puppeteer_stare "ticket_inspector" "#null")
    (puppeteer_set "ticket_inspector" "front_loading"))
  (puppeteer_stare "ticket_inspector" "andrea")
  )
(if (compare current_chapter "quiet")
  (begin
    (puppeteer_show "gianni" 4500)
    (puppeteer_set "gianni" "still_left")
    (puppeteer_show "mariano" 4200)
    (puppeteer_set "mariano" "still_right")
    (puppeteer_show  "jamal" 6900)
    (puppeteer_set "jamal" "back"))
  (if (compare current_chapter "virus")
    (begin
      (puppeteer_show "gianni" 4500)
      (puppeteer_set "gianni" "still_left")
      (puppeteer_show "yuriy" 8400)
      (puppeteer_set  "yuriy" "still_left")
      (puppeteer_show "andrii" 8000)
      (puppeteer_set "andrii" "still_right"))
    (if (compare current_chapter "chaos")
      (begin
        (puppeteer_show "marta" 4600)
        (puppeteer_set "marta" "still_left")
        (puppeteer_show "private_albert" 6260)
        (puppeteer_set "private_albert" "back")
        (puppeteer_show "private_enrico" 9700)
        (puppeteer_look "private_enrico" "ticket_inspector")
        (puppeteer_show "private_richard" 4200)
        (puppeteer_look "private_richard" "marta"))
      nil
      )
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
