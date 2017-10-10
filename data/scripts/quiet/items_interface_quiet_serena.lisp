;Pomodoro - I have no money and I must eat an ice cream
;Parameters configuration
(define got_coke (collector_get "got_coke"))
(define got_beer (collector_get "got_beer"))
(define got_five_euros (collector_get "got_five_euros"))
(define got_three_euros (collector_get "got_three_euros"))
(if (> (+ got_coke got_beer) 0.0)
  (if (= got_three_euros 1.0)
    (begin
      (collector_set "got_three_euros" 0.0)
      (collector_set "got_one_euro"    1.0))
    (if (= got_five_euros 1.0)
      (begin
        (collector_set "got_five_euros" 0.0)
        (collector_set "got_three_euros" 1.0))
      nil
    )
  )
  nil
)

;Refresh interface
(director_script "items_interface")
