; Pomodoro
; this script handles some interesting game parts
(define say
	(lambda (c m)
		(begin
			(puppeteer_say c m 1)
			(director_wait 1)
		)
	)
)

(define animation
	(lambda (c m)
		(begin
			(puppeteer_set c m)
		)
	)
)

(define main_control
	(lambda (c)
		(begin
			(director_camera_follow c -100.0 1.0)
			(puppeteer_enable_control c)
		)
	)
)
(stagecrafter_show "canama")
(puppeteer_show "andrea" 200)
(puppeteer_show "andrii" 800)
(puppeteer_disable_control)
(say "andrea" "Hello guys!")
(say "andrii" "Hello!")
(animation "andrea" "still_right")
(say "andrea" "What do you think about my script system, Andrii?")
(animation "andrii" "still_left")
(effecteer_add "expl1" "smoke_spot_particle" 400 450)
(director_wait 1)
(effecteer_add "expl2" "fire_spot_particle" 600 450 1 0 nil t)
(say "andrii" "Well . . . it works at least!")
(animation "andrii" "back_code")

(main_control "andrea")

(director_wait 1)

(effecteer_stop "expl1")
(effecteer_stop "expl2")

(director_script "restore_environment")
(director_wait 10)
(stagecrafter_unlock_item "canama_wall_B")
(director_wait 10)
(stagecrafter_lock_item "canama_wall_B")