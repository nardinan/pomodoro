;Pomodoro - I have no money and I must eat an ice cream
(define current_chapter (collector_get "current_chapter"))
(if (compare current_chapter "quiet")
  (director_script "quiet_ai_luna")
  (if (compare current_chapter "virus")
    (director_script "virus_ai_andrea_brown_sugar")
    nil
    )
  nil
  )
