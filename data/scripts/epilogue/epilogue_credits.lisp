;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Stop everything
(effecteer_add "clear_out" "fade_out" (+ 480 450) (+ 360 180) 4 0 t t)
(director_wait_time 3)

;Removes all the character (intro-script will take care of them)
(director_script "hide_items_interface")
(puppeteer_hide)
(stagecrafter_hide)

;Slide number one
(effecteer_add "slide0A" "credits" 500 0 1.0 0 t t)
(director_wait_time 31)
(effecteer_delete "slide0A")
(effecteer_delete "clear_out")
