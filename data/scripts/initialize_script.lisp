; Pomodoro
; Module: intro_cern
; Author: nardinan
; Date  : 20 Nov 2016

; Preamble. Here we should check for other things: loaded informations and stored informations.
(if (= (collector_get "current_chapter") nil)
  (collector_set "current_chapter" "quiet")
  nil)

(director_camera_set 1000.0 -1000.0) ; far far away ...
(if (collector_get "intro_cern")
    (begin
        (if (collector_get "destination_scenario")
          (stagecrafter_show (collector_get "destination_scenario"))
          (stagecrafter_show "canama")
        )
        (if (= (collector_get "note_A_taken") 1.0)
        	(effecteer_play "stone_paradise" "stone_paradise" 2000 2000 16)
        	nil
        )
    )
	(stagecrafter_show "cern")
)
