;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_priori
;Author: nardinan
;Date  : 28 May 2017

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
(define from_where (collector_get "from_where"))
(define current_chapter (collector_get "current_chapter"))

;Configure
(collector_set "from_where" "priori")

;Setup characters
(puppeteer_show "cristiano" 5500)
(puppeteer_set "cristiano" "front")
(if (compare current_chapter "chaos")
  (begin
    (puppeteer_show "private_chris"  5100)
    (puppeteer_look "private_chris" "cristiano"))
  nil
  )
(if (compare from_where "vannucci")
  (puppeteer_show "andrea" 250)
  (if (compare from_where "elfo")
    (puppeteer_show "andrea" 5900)
    (puppeteer_show "andrea" 8700)
    )
  )
(puppeteer_set "andrea" "front")
(main_control "andrea")
