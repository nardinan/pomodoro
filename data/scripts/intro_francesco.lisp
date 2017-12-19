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
(define fologna_step_mac (collector_get "fologna_step_mac"))
(define fologna_step_blackout (collector_get "fologna_step_blackout"))
(define fologna_step_bus (collector_get "fologna_step_bus"))
(define fologna_step_enel (collector_get "fologna_step_enel"))

;Configure
(collector_set "from_where" "francesco")

;Setup characters
(if (compare current_chapter "epilogue")
  nil
  (if (compare current_chapter "chaos")
    (begin
      ;Check fologna
      (if (= (+ (+ fologna_step_mac fologna_step_blackout) (+ fologna_step_bus fologna_step_enel)) 4.0)
        (begin
          (collector_set "fologna_enabled"        1.0)
          (collector_set "fologna_step_mac"       0.0)
          (collector_set "fologna_step_blackout"  0.0)
          (collector_set "fologna_step_bus"       0.0)
          (collector_set "fologna_step_enel"      0.0))
        nil
        )
      (puppeteer_show "private_kennedy" 4000)
      (puppeteer_show "private_richard" 4500)
      (puppeteer_look "private_kennedy" "private_richard")
      (puppeteer_look "private_richard" "private_kennedy"))
    (begin
      (puppeteer_show "roberto" 5000)
      (puppeteer_stare "roberto" "andrea"))
    )
  )
(if (compare from_where "innamorati")
  (puppeteer_show "andrea" 8700)
  (puppeteer_show "andrea" 300)
  )
(puppeteer_set "andrea" "front")
(main_control "andrea")
