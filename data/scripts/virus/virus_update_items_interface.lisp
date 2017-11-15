;Pomodoro - I have no money and I must eat an ice cream
;Module: items (for quiet)
;Author: nardinan
;Date  : 4 Nov 2017

;Parameters configuration
(define got_note            (collector_get "got_note"))
(define got_tie             (collector_get "got_tie"))
(define got_shoe            (collector_get "got_shoe"))
(define got_lemon           (collector_get "got_lemon"))
(define got_battery         (collector_get "got_battery"))
(define got_glasses         (collector_get "got_glasses"))
(define got_screwdriver     (collector_get "got_screwdriver"))
(define got_glass           (collector_get "got_glass"))
(define got_sugar           (collector_get "got_sugar"))
(define got_cocktail        (collector_get "got_cocktail"))
(define got_pills           (collector_get "got_pills"))
(define got_drug_cocktail   (collector_get "got_drug_cocktail"))
(define got_cabin_key       (collector_get "got_cabin_key"))

(effecteer_delete "inventory_note")
(effecteer_delete "inventory_tie")
(effecteer_delete "inventory_shoe")
(effecteer_delete "inventory_lemon")
(effecteer_delete "inventory_battery")
(effecteer_delete "inventory_glasses")
(effecteer_delete "inventory_screwdriver")
(effecteer_delete "inventory_glass")
(effecteer_delete "inventory_sugar")
(effecteer_delete "inventory_cocktail")
(effecteer_delete "inventory_pills")
(effecteer_delete "inventory_drug_cocktail")
(effecteer_delete "inventory_cabin_key")

(define position_y 100.0) ; the Y is fixed with the bottom of the screen
(define position_x 100.0) ; initially, the X is 100 and increases step by step by an offset
(define offset_x   200.0) ; the offset

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

(if (= got_battery 1.0)
  (begin
    (effecteer_add "inventory_battery" "icon_battery" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )

(if (= got_glasses 1.0)
  (begin
    (effecteer_add "inventory_glasses" "icon_glasses" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )

(if (= got_screwdriver 1.0)
  (begin
    (effecteer_add "inventory_screwdriver" "icon_screwdriver" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )

(if (= got_glass 1.0)
  (begin
    (effecteer_add "inventory_glass" "icon_glass" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )

(if (= got_sugar 1.0)
  (begin
    (effecteer_add "inventory_sugar" "icon_sugar" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )

(if (= got_cocktail 1.0)
  (begin
    (effecteer_add "inventory_cocktail" "icon_cocktail" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )

(if (= got_pills 1.0)
  (begin
    (effecteer_add "inventory_pills" "icon_pills" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )

(if (= got_drug_cocktail 1.0)
  (begin
    (effecteer_add "inventory_drug_cocktail" "icon_drug_cocktail" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )

(if (= got_cabin_key 1.0)
  (begin
    (effecteer_add "inventory_cabin_key" "icon_cabin_key" position_x position_y 12.0 0.0 t nil)
    (define position_x (+ position_x offset_x)))
  nil
  )
