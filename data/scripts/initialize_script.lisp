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
(puppeteer_show "andrea" 200)
(puppeteer_show "andrii" 800)
(puppeteer_disable_control)
(say "andrea" "Hello guys!")
(say "andrii" "Hello!")
(animation "andrea" "still_right")
(say "andrea" "What do you think about my script system, Andrii?")
(animation "andrii" "still_left")
(effecteer_add "expl1" "fire_spot_particle" 400 450)
(director_wait 2)
(effecteer_add "expl2" "fire_spot_particle" 600 450 1 0 nil t)
(director_wait 2)
(say "andrii" ". . .")
(say "andrii" "Well . . . it works at least!")
(say "andrea" "You hate it!")
(say "andrii" "No, you hate it!")
(animation "andrii" "back_code")
(puppeteer_enable_control "andrii")

(director_wait 10)

(effecteer_stop "expl1")
(effecteer_stop "expl2")

(director_script "restore_environment")