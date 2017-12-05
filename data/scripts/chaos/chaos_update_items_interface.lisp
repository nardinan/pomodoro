;Pomodoro - I have no money and I must eat an ice cream
;Module: items (for chaos)
;Author: nardinan
;Date  : 25 Nov 2017

;Parameters configuration
(define got_note            (collector_get "got_note"))
(define got_tie             (collector_get "got_tie"))
(define got_cabin_key       (collector_get "got_cabin_key"))
(define got_computer        (collector_get "got_computer"))
(define got_authorization   (collector_get "got_authorization"))
(define got_temple_key      (collector_get "got_temple_key"))

(effecteer_delete "inventory_note")
(effecteer_delete "inventory_tie")
(effecteer_delete "inventory_cabin_key")
(effecteer_delete "inventory_computer")
(effecteer_delete "inventory_authorization")
(effecteer_delete "inventory_temple_key")

(define position_y 100.0) ; the Y is fixed with the bottom of the screen
(define position_x 100.0) ; initially, the X is 100 and increases step by step by an offset
(define offset_x   150.0) ; the offset
(define offset_z   10.0)  ; the zoom

(if (= got_note 1.0)
  (begin
    (effecteer_add "inventory_note" "icon_note" position_x position_y offset_z 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )

(if (= got_tie 1.0)
  (begin
    (effecteer_add "inventory_tie" "icon_tie" position_x position_y offset_z 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )

(if (= got_cabin_key 1.0)
  (begin
    (effecteer_add "inventory_cabin_key" "icon_cabin_key" position_x position_y offset_z 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )

(if (= got_computer 1.0)
  (begin
    (effecteer_add "inventory_computer" "icon_computer" position_x position_y offset_z 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )

(if (= got_authorization 1.0)
  (begin
    (effecteer_add "inventory_authorization" "icon_authorization" position_x position_y offset_z 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )

(if (= got_temple_key 1.0)
  (begin
    (effecteer_add "inventory_temple_key" "icon_temple_key" position_x position_y offset_z 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )
