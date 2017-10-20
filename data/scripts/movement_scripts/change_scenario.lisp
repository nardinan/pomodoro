;Pomodoro - I have no money and I must eat an ice cream
;Module: change_scenario
;Author: nardinan
;Date  : 15 Dec 2016
;Disables the control to prevent the same script to start multiple time (fixes the double-click bug)
(puppeteer_disable_control "andrea")

;Retrieves from the collector the destination that we have to reach
(define destination_scenario (collector_get "destination_scenario"))

;Cleans out the scene with a movement outside
(director_camera_move 2000.0 8000.0)
(director_wait_time 3)

;Removes all the character (intro-script will take care of them)
(puppeteer_hide)
(stagecrafter_hide)

;Show the scenario
(director_camera_set 1000.0 -1000.0)
(stagecrafter_show destination_scenario)
