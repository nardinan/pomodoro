;Pomodoro - I have no money and I must eat an ice cream
;Module: items
;Author: nardinan
;Date  : 7 Oct 2017

;Parameters configuration
(define note_calculus  (collector_get "got_note"))
(define five_euros     (collector_get "got_five_euros"))
(define three_euros    (collector_get "got_three_euros"))
(define one_euro       (collector_get "got_one_euro"))
(define beer_bottle    (collector_get "got_beer"))
(define coke_bottle    (collector_get "got_coke"))
(define glass_water    (collector_get "got_glass_water"))
(define bus_ticket     (collector_get "got_bus_ticket"))

(effecteer_delete "note_calculus")
(effecteer_delete "five_euros")
(effecteer_delete "three_euros")
(effecteer_delete "one_euro")
(effecteer_delete "beer_bottle")
(effecteer_delete "coke_bottle")
(effecteer_delete "glass_water")
(effecteer_delete "bus_ticket")

(define position_y 100.0) ; the Y is fixed with the bottom of the screen
(define position_x 100.0) ; initially, the X is 100 and increases step by step by an offset
(define offset_x   200.0) ; the offset

(if (= note_calculus 1.0)
  (begin
    (effecteer_add "note_calculus" "icon_note" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= five_euros 1.0)
  (begin
    (effecteer_add "five_euros" "icon_five_euros" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= three_euros 1.0)
  (begin
    (effecteer_add "three_euros" "icon_three_euros" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= one_euro 1.0)
  (begin
    (effecteer_add "one_euro" "icon_one_euro" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= beer_bottle 1.0)
  (begin
    (effecteer_add "beer_bottle" "icon_beer" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= coke_bottle 1.0)
  (begin
    (effecteer_add "coke_bottle" "icon_coke" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= glass_water 1.0)
  (begin
    (effecteer_add "glass_water" "icon_glass_water" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= bus_ticket 1.0)
  (begin
    (effecteer_add "bus_ticket" "icon_bus_ticket" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)
