;Pomodoro - I have no money and I must eat an ice cream
;Module: quiet_update_garibaldi
;Author: nardinan
;Date  : 12 Feb 2017

;Move maria outside, on the right
(puppeteer_move "maria" 7800)
(director_wait_movement "maria")

;And then back, on the left
(puppeteer_move "maria" 80)
(director_wait_movement "maria")
