;Pomodoro - I have no money and I must eat an ice cream
;Module: outro_fologna
;Author: nardinan
;Date  : 19 Sept 2017

;And now, please, play the track
(if (= (collector_get "temple_part_two") 1.0)
  (effecteer_play "the_duel" "the_duel" 2000 2000 16)
  (effecteer_play "stone_paradise" "stone_paradise" 2000 2000 16)
  )
