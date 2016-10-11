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
(say "andrii" "...")
(say "andrii" "Well .. it works at least!")
(animation "andrii" "back_code")
(puppeteer_enable_control "andrea")

(director_wait 5)

(director_script "restore_environment")