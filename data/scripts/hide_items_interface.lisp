;Pomodoro - I have no money and I must eat an ice cream
(define current_chapter (collector_get "current_chapter"))
(if (compare current_chapter "quiet")
  (director_script "quiet_delete_items_interface")
  (if (compare current_chapter "virus")
    (director_script "virus_delete_items_interface")
    (if (compare current_chapter "chaos")
      (director_script "chaos_delete_items_interface")
      (if (compare current_chapter "epilogue")
        (director_script "epilogue_delete_items_interface")
        nil
        )
      )
    )
  )
