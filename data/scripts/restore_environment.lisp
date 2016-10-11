; Pomodoro
; this script restores the environment after an action
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

(animation "andrii" "front")
