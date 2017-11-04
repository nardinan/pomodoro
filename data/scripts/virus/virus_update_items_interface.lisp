;Pomodoro - I have no money and I must eat an ice cream
;Module: items (for quiet)
;Author: nardinan
;Date  : 4 Nov 2017

;Parameters configuration
(define got_note        (collector_get "got_note"))
(define got_shoe        (collector_get "got_shoe"))
(define got_lemon       (collector_get "got_lemon"))

(effecteer_delete "inventory_note")
(effecteer_delete "inventory_shoe")
(effecteer_delete "inventory_lemon")

(define position_y 100.0) ; the Y is fixed with the bottom of the screen
(define position_x 100.0) ; initially, the X is 100 and increases step by step by an offset
(define offset_x   200.0) ; the offset

(if (= got_note 1.0)
  (begin
    (effecteer_add "inventory_note" "icon_note" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= got_shoe 1.0)
  (begin
    (effecteer_add "inventory_shoe" "icon_shoe" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= got_lemon 1.0)
  (begin
    (effecteer_add "inventory_lemon" "icon_lemon" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)
