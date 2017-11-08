;Pomodoro - I have no money and I must eat an ice cream
(define current_chapter (collector_get "current_chapter"))
(if (compare current_chapter "quiet")
  (director_script "quiet_move_innamorati_cabin")
  (if (compare current_chapter "virus")
    (director_script "virus_move_innamorati_cabin")
    (begin
      (collector_set "destination_scenario" "cabin")
      (director_script "change_scenario"))
  )
)
