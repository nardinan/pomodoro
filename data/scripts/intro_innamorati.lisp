;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_innamorati
;Author: nardinan
;Date  : 31 March 2017

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
(stagecrafter_play "traffic_background")

;Collect environment
(define from_where          (collector_get "from_where"))
(define marta_quiet_dialog  (collector_get "marta_quiet_dialog"))
(define current_chapter     (collector_get "current_chapter"))

;Configure
(collector_set "from_where" "innamorati")

;Setup characters
(if (compare current_chapter "quiet")
  (begin
    (puppeteer_show "writer" 9400)
    (puppeteer_set "writer" "back_writer"))
  (stagecrafter_set_item "coverture" "none")
  )
(if (= marta_quiet_dialog 1.0)
  nil
  (begin
    (puppeteer_show "bruno" 12600)
    (puppeteer_set "bruno" "still_left")
    (puppeteer_show "marta" 12300)
    (puppeteer_set "marta" "still_right"))
  )
(if (compare from_where "unipgA")
  (puppeteer_show "andrea" 13500)
  (if (compare from_where "francesco")
    (puppeteer_show "andrea" 11270)
    (if (compare from_where "cabin")
      (puppeteer_show "andrea" 8800)
      (puppeteer_show "andrea" 900)
      )
    )
  )
(puppeteer_set "andrea" "front")
(main_control "andrea")
