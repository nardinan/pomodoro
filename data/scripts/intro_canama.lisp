; Pomodoro
; Module: intro_canama
; Author: nardinan
; Date  : 20 Nov 2016

; Dialogs
(define language (collector_get "language"))
(define dialogs (list 
	(cons ;0 andrea
 	 "Hello, my name is Andrea and I am a student here, in the University of Perugia"
	 "Salve, io mi chiamo Andrea e sono uno studente nell'Universita' di Perugia")
	(cons ;1 andrea
	 "This is my appartment"
	 "Questo e' il mio appartamento")
	(cons ;2 andrea
	 "I live here with my cusin, Luca"
	 "Vivo qui con mio cugino, Luca")
	(cons ;3 andrea
     "We call him 'CUG'"
     "Lo chiamiamo 'CUG'")
	(cons ;4 andrea
	 "Because he is my cousin, you know"
	 "Perche' e' mio cugino, sapete")
	(cons ;5 andrea
	 "He is a student at UniPG's Department of Mathematics"
	 "E' uno studente del Dipartimento di Matematica dell'UniPG")
	(cons ;6 andrea
	 "He is even one of the two reasons why I was able to survive so far"
	 "E' anche uno dei due motivi per cui sono sopravvissuto fino ad ora")
	(cons ;7 andrea
	 "This is his room"
	 "Questa e' la sua stanza")
	nil
))

(define say
	(lambda (c m)
		(begin
			(puppeteer_say c m (+ 1 (* (length m) 0.05)))
			(director_wait_message c)
		)
	)
)

(define say_and_go
	(lambda (c m)
		(begin
			(puppeteer_say c m (+ 1 (* (length m) 0.05)))
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
(define note_A_taken (collector_get "note_A_taken"))
(define intro_canama (collector_get "intro_canama"))


; Configure
(collector_set "from_where" "canama")
(if (= note_A_taken 1.0)
	(begin
		(stagecrafter_set_item "notes_A" "none")
		(stagecrafter_enable_item "bed_B"))
	nil
)

; Setup characters
(puppeteer_disable_control)
(puppeteer_show "andrea" 450)

(director_camera_follow "andrea" -100.0 1.0)

(if (= intro_canama 1.0)
	(begin
		(puppeteer_show "luca" 4500)
		(puppeteer_stare "luca" "andrea"))
	(begin
		(animation "andrea" "front")
		(director_wait_time 3)
		(say "andrea" (get_dialog dialogs language 0))
		(puppeteer_move "andrea" 4500)
		(say "andrea" (get_dialog dialogs language 1))
		(say "andrea" (get_dialog dialogs language 2))
		(animation "andrea" "front")
		(say "andrea" (get_dialog dialogs language 3))
		(say "andrea" (get_dialog dialogs language 4))
		(puppeteer_move "andrea" 4500)
		(say "andrea" (get_dialog dialogs language 5))
		(say "andrea" (get_dialog dialogs language 6))
		(director_wait_movement "andrea")
		(animation "andrea"	"front")
		(say "andrea" (get_dialog dialogs language 7))
		(collector_set "intro_canama" 1))
)
(main_control "andrea")