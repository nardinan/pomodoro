	; Pomodoro
; Module: intro_cern
; Author: nardinan
; Date  : 20 Nov 2016
; Initialization script. Called at the begin of the game

; Preamble. Here we should check for other things: loaded informations and stored informations.
(director_camera_set 6000 2000) ; far far away ...
(if (collector_get "intro_ran")
	(stagecrafter_show "lupattelli")
	(stagecrafter_show "cern")
)
