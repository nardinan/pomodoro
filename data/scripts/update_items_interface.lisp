;Pomodoro - I have no money and I must eat an ice cream
(define current_chapter (collector_get "current_chapter"))
(if (compare current_chapter "quiet")
  (director_script "quiet_update_items_interface")
  (if (compare current_chapter "virus")
    (director_script "virus_update_items_interface")
    (if (compare current_chapter "chaos")
      (director_script "chaos_update_items_interface")
      nil
      )
    )
  )
