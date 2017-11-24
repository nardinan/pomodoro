;Pomodoro - I have no money and I must eat an ice cream
;Module: chaos_update_fortebraccio
;Author: nardinan
;Date  : 24 Nov 2017

;Move privates outside, on the right
(puppeteer_run "private_barry" 7600)
(puppeteer_run "private_joseph" 7000)
(director_wait_movement "private_barry")
(director_wait_movement "private_joseph")

;And then back, on the left
(puppeteer_run "private_barry" -200)
(puppeteer_run "private_joseph" -600)
(director_wait_movement "private_barry")
(director_wait_movement "private_joseph")
