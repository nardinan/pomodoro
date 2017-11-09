;Pomodoro - I have no money and I must eat an ice cream
(define current_chapter (collector_get "current_chapter"))
(define from_where (collector_get "from_where"))
(if (compare current_chapter "quiet")
  (begin
    (if (compare from_where "garibaldi")
      (director_script "quiet_ai_yuriy_garibaldi")
      (director_script "quiet_ai_yuriy_november")
      ))
  nil
  )
