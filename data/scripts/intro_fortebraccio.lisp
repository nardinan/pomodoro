; Pomodoro
; Module: intro_fortebraccio
; Author: nardinan
; Date  : 21 Jan 2017

(define animation
	(lambda (c m)
		(begin
			(puppeteer_set c m)
		)
	)
)

(define get_dialog
	(lambda (d lang n)
		(begin
			(if (= n 0)
				(if (= lang 0)
					(car (car d))
					(cdr (car d))
				)
				(get_dialog (cdr d) lang (- n 1))
			)
		)
	)
)

; Collect environment 
(define from_where (collector_get "from_where"))

; Configure
(collector_set "from_where" "fortebraccio")

; Setup characters
(puppeteer_disable_control)
(if (compare from_where "garibaldi")
	(puppeteer_show "andrea" 4980)
	(puppeteer_show "andrea" 1000)
)

; Setup characters
(animation "andrea" 	"front")
(main_control "andrea")
