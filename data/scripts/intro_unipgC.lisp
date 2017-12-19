;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_unipgC
;Author: nardinan
;Date  : 4 Oct 2017

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
(define from_where (collector_get "from_where"))

;Configure
(collector_set "from_where" "unipgC")

;Setup characters
(if (compare from_where "unipgB")
  (puppeteer_show "andrea" 900)
  (puppeteer_show "andrea" 4200)
  )
(puppeteer_set "andrea" "front")
(main_control "andrea")
