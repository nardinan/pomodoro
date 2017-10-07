;Pomodoro - I have no money and I must eat an ice cream
;Module: items
;Author: nardinan
;Date  : 7 Oct 2017

;Parameters configuration
(define five_euros  (collector_get "got_five_euros"))
(define three_euros (collector_get "got_three_euros"))

(effecteer_delete "five_euros")
(effecteer_delete "three_euros")

(define position_y 100.0) ; the Y is fixed with the bottom of the screen
(define position_x 100.0) ; initially, the X is 100 and increases step by step by an offset
(define offset_x   200.0) ; the offset

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
