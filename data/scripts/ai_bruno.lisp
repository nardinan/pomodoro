;Pomodoro - I have no money and I must eat an ice cream
(define current_chapter (collector_get "current_chapter"))
(if (compare current_chapter "virus")
  (director_script "virus_ai_bruno")
  (if (compare current_chapter "epilogue")
    (director_script "epilogue_ai_bruno")
    nil
  )
)
