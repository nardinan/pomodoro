;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_gallenga
;Author: nardinan
;Date  : 27 Feb 2017

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
(collector_set "from_where" "gallenga")

;Setup characters
(puppeteer_show "antonietta" 100)
(puppeteer_set "antonietta"	"still_right")
(if (compare current_chapter "chaos")
  nil
  (if (compare current_chapter "epilogue")
    nil
    (begin
      (puppeteer_show "luna" 2900)
      (if (compare current_chapter "virus")
        (begin
          (puppeteer_show "valerio" 2600)
          (puppeteer_look "valerio" "luna")
          (puppeteer_look "luna" "valerio"))
        (puppeteer_stare "luna" "andrea")
        ))
    )
  )
(puppeteer_show "andrea" 1950)
(puppeteer_set "andrea" "front")
(main_control "andrea")
