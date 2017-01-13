; Pomodoro
; Module: change_scenario
; Author: nardinan
; Date  : 15 Dec 2016

(define destination_scenario (collector_get "destination_scenario"))

; Clear out the scene with a movement outside
(director_camera_move 2000.0 4000.0)
(director_wait_time 3)

; Remove all the character (intro-script will take care of them)
(puppeteer_hide) 
(stagecrafter_hide)

; Show the scenario
(director_camera_set 1000.0 -1000.0)
(stagecrafter_show destination_scenario)
