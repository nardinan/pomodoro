; Pomodoro
; Module: move_francesco_priori
; Author: nardinan
; Date  : 12 June 2017

; Collect environment
(define fologna_enabled (collector_get "fologna_enabled"))
(if (= fologna_enabled 1.0)
    (collector_set "destination_scenario" "fologna")
    (collector_set "destination_scenario" "priori"))
(director_script "change_scenario")
