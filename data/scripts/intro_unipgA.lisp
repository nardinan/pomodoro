;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_unipgA
;Author: nardinan
;Date  : 15 July 2017

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
  nil
  (stagecrafter_play "people_background")
  )

;Collect environment
(define from_where          (collector_get "from_where"))
(define server_disconnected (collector_get "server_disconnected"))
(define current_chapter     (collector_get "current_chapter"))

;Configure
(collector_set "from_where" "unipgA")

;Setup character
(puppeteer_show "nerd" 7040)
(if (compare current_chapter "epilogue")
  (puppeteer_set "nerd" "front_loading")
  (begin
    (puppeteer_set "nerd" "back_code")
    (stagecrafter_set_item "computer_A" "coding_A"))
  )
(if (= server_disconnected 1)
  (stagecrafter_set_item "rack_A" "still_A")
  nil
  )
(if (compare current_chapter "virus")
  (begin
    (puppeteer_show "bruno" 5800)
    (puppeteer_stare "bruno" "andrea"))
  (if (compare current_chapter "chaos")
    (begin
      (puppeteer_show "roberto" 3000)
      (puppeteer_stare "roberto" "andrea"))
    (if (compare current_chapter "epilogue")
      (begin
        (puppeteer_show "roberto" 3000)
        (puppeteer_stare "roberto" "#null")
        (puppeteer_set "roberto" "front_loading"))
      nil
      )
    )
  )
(if (compare from_where "innamorati")
  (puppeteer_show "andrea" 4530)
  (puppeteer_show "andrea" 1400)
  )
(puppeteer_set "andrea" "front")
(main_control "andrea")
