; Pomodoro
; Module: intro_cern
; Author: nardinan
; Date  : 20 Nov 2016

; Preamble. Here we should check for other things: loaded informations and stored informations.
(director_camera_set 1000.0 -1000.0) ; far far away ...
(if (collector_get "intro_ran")
	(stagecrafter_show "garibaldi")
	(stagecrafter_show "cern")
)
