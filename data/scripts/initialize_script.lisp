; Pomodoro
; Module: intro_cern
; Author: nardinan
; Date  : 20 Nov 2016

; Preamble. Here we should check for other things: loaded informations and stored informations.
(director_camera_set 1000.0 -1000.0) ; far far away ...
(if (collector_get "intro_ran")
    (begin
        (if (collector_get "destination_scenario")
          (stagecrafter_show (collector_get "destination_scenario"))
          (stagecrafter_show "canama")
        )
    )
	(stagecrafter_show "cern")
)
