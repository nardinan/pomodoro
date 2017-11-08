;Pomodoro - I have no money and I must eat an ice cream
;Module: change_scenario
;Author: nardinan
;Date  : 15 Dec 2016
;Disables the control to prevent the same script to start multiple time (fixes the double-click bug)
(puppeteer_disable_control)

;High level functions
;@brief: check_chapter <chapter_variable> <done_chapter_variable>
;@description: verifies if the chapter passed has parameter has to be shown or not. Returns 1.0 in case the chapter has to be presented.
(define check_chapter
  (lambda (sc dc)
    (begin
      (if (= (collector_get sc) 1.0)
        (if (= (collector_get dc) 1.0)
          0.0
          (begin
            (collector_set dc 1.0)
            1.0)
        )
        0.0
      )
    )
  )
)

;Retrieves from the collector the destination that we have to reach
(define destination_scenario (collector_get "destination_scenario"))

;Cleans out the scene with a movement outside
(director_camera_move 2000.0 8000.0)

;Retrieve information about change of chapter
(define show_chapter_one   (check_chapter "show_chapter_one"   "done_chapter_one"))
(define show_chapter_two   (check_chapter "show_chapter_two"   "done_chapter_two"))
(define show_chapter_three (check_chapter "show_chapter_three" "done_chapter_three"))
(define show_chapter_four  (check_chapter "show_chapter_four"  "done_chapter_four"))
(define show_chapter_five  (check_chapter "show_chapter_five"  "done_chapter_five"))

(define show_chapters (+ (+ (+ (+ show_chapter_one show_chapter_two) show_chapter_three) show_chapter_four) show_chapter_five))

;If we have to show a chapter entry title, is better to stop the music my dear
(if (> show_chapters 0.0)
  (begin
    (effecteer_stop  "stone_paradise")
    (director_script "hide_items_interface"))
  nil
)

;Wait to be completely out of the screen
(director_wait_time 3.0)

;Removes all the character (intro-script will take care of them)
(puppeteer_hide)
(stagecrafter_hide)

(if (> show_chapters 0.0)
  (begin
    ;For the scenario music to be completely disappeared
    (director_wait_time 2.0)

    (effecteer_play "chapter_screen_music" "chapter_intro_music" 1000 3000 20)
    (director_wait_time 3.0)
    (if (= show_chapter_one 1.0)
      (effecteer_add "chapter_screen_animation" "intro_chapter_one" 300 30 10 0 t nil)
      (if (= show_chapter_two 1.0)
        (effecteer_add "chapter_screen_animation" "intro_chapter_two" 300 30 10 0 t nil)
        (if (= show_chapter_three 1.0)
          (effecteer_add "chapter_screen_animation" "intro_chapter_three" 300 30 10 0 t nil)
          (if (= show_chapter_four 1.0)
            (effecteer_add "chapter_screen_animation" "intro_chapter_four" 300 30 10 0 t nil)
            (if (= show_chapter_five 1.0)
              (effecteer_add "chapter_screen_animation" "intro_chapter_five" 300 30 10 0 t nil)
              nil)
          )
        )
      )
    )

    ;Wait for the end of the animation and stop the effects
    (director_wait_time 3.0)
    (effecteer_stop   "chapter_screen_music")

    ;Wait for the end of the fade out and then removes the effects
    (director_wait_time 3.0)
    (effecteer_delete "chapter_screen_animation")
    (effecteer_delete "chapter_screen_music")

    ;And now, please, play the track
    (effecteer_play "stone_paradise" "stone_paradise" 2000 2000 16))
  nil
)

;Show the scenario
(director_camera_set 1000.0 -1000.0)
(stagecrafter_show destination_scenario)
