;Pomodoro - I have no money and I must eat an ice cream
;Module: items
;Author: nardinan
;Date  : 7 Oct 2017

;Parameters configuration
(define got_euros  (collector_get "got_five_euros"))
(define got_note   (collector_get "got_note"))
(define got_tie    (collector_get "got_tie"))

(effecteer_delete "inventory_five_euros")
(effecteer_delete "inventory_note")
(effecteer_delete "inventory_tie")

(define position_y 100.0) ; the Y is fixed with the bottom of the screen
(define position_x 100.0) ; initially, the X is 100 and increases step by step by an offset
(define offset_x   200.0) ; the offset

(if (= got_euros 1.0)
  (begin
    (effecteer_add "inventory_five_euros" "icon_five_euros" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= got_note 1.0)
  (begin
    (effecteer_add "inventory_note" "icon_note" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= got_tie 1.0)
  (begin
    (effecteer_add "inventory_tie" "icon_tie" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)
