;Pomodoro - I have no money and I must eat an ice cream
(define current_chapter (collector_get "current_chapter"))
(if (compare current_chapter "quiet")
  (director_script "quiet_move_priori_elfo")
  (begin
    (collector_set "destination_scenario" "elfo")
    (director_script "change_scenario"))
  )
