;Pomodoro - I have no money and I must eat an ice cream
;Module: items
;Author: nardinan
;Date  : 7 Oct 2017

;Parameters configuration
(define got_euros       (collector_get "got_five_euros"))
(define got_note        (collector_get "got_note"))
(define got_tie         (collector_get "got_tie"))
(define got_disk        (collector_get "got_disk"))
(define got_movie       (collector_get "got_movie"))
(define got_internet    (collector_get "got_internet"))
(define got_phone       (collector_get "got_phone"))
(define got_flowers     (collector_get "got_flowers"))
(define got_cigarette   (collector_get "got_cigarette"))

(effecteer_delete "inventory_five_euros")
(effecteer_delete "inventory_note")
(effecteer_delete "inventory_tie")
(effecteer_delete "inventory_disk")
(effecteer_delete "inventory_movie")
(effecteer_delete "inventory_internet")
(effecteer_delete "inventory_phone")
(effecteer_delete "inventory_flowers")
(effecteer_delete "inventory_cigarette")

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

(if (= got_disk 1.0)
  (begin
    (effecteer_add "inventory_disk" "icon_disk" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= got_movie 1.0)
  (begin
    (effecteer_add "inventory_movie" "icon_movie" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= got_internet 1.0)
  (begin
    (effecteer_add "inventory_internet" "icon_internet" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= got_phone 1.0)
  (begin
    (effecteer_add "inventory_phone" "icon_phone" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= got_flowers 1.0)
  (begin
    (effecteer_add "inventory_flowers" "icon_flowers" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)

(if (= got_cigarette 1.0)
  (begin
    (effecteer_add "inventory_cigarette" "icon_cigarette" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
)
