;Pomodoro - I have no money and I must eat an ice cream
;Module: intro_lupattelli
;Author: nardinan
;Date  : 20 Dec 2016

;Draw interface
(director_script "items_interface")

;Play background
(stagecrafter_play "birds_background")

;Collect environment
(define from_where (collector_get "from_where"))
(define current_chapter (collector_get "current_chapter"))

;Configure
(collector_set "from_where" "lupattelli")

;Setup characters
(puppeteer_disable_control)
(if (compare from_where "garibaldi")
	(puppeteer_show "andrea" 3600)
	(puppeteer_show "andrea" 2090)
)

;Setup characters
(puppeteer_show   "technician" 3100)
(puppeteer_stare  "technician" "andrea")

(if (compare current_chapter "quiet")
  (director_script "quiet_intro_lupattelli")
  nil)
