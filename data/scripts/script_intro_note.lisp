; Pomodoro
; Module: note_A_script
; Author: nardinan
; Date  : 8 Dec 2016

; Dialogs
(define language (collector_get "language"))
(define dialogs (list 
	(cons ;0 andrea
 	 "Oh, look!"
	 "Oh ma tu guarda!")
	(cons ;1 andrea
	 "Calculus 2"
	 "Analisi Matematica 2")
	(cons ;2 andrea
	 "These are the holy class notes from CUG"
	 "Questi sono i sacri appunti di CUG")
	(cons ;3 andrea
	 "Let me take them ..."
	 "Sara' il caso che io li prenda ...")
	(cons ;4 andrea
	 "Ehm . . ."
	 "Ehm . . .")
	(cons ;5 andrea
	 "Hello CUG, how are you?"
	 "Ciao CUG, come stai?")
	(cons ;6 andrea
	 "I woke up twenty minutes ago"
	 "Mi sono svegliato venti minuti fa")
	(cons ;7 luca
	 ". . . It is three o'clock"
	 ". . . Sono le tre di pomeriggio")
	(cons ;8 luca
	 "Biata a tte(TM)"
	 "Biata a tte(TM)")
	(cons ;9 luca
	 "Listen very carefull. Tomorrow we have to pay the electricity bill"
	 "Ascolta attentamente. Domani dobbiamo tassativamente pagare la bolletta della luce")
	(cons ;10 andrea
	 "Don't worry, even if we pay the bill after the expiration they will not tell us anything"
	 "Non ti preoccupare, anche se la paghiamo in ritardo non ci diranno nulla")
	(cons ;11 luca
	 "We are three monts late. Tomorrow I have to send them the receipt otherwise they will disconnect everything"
	 "Siamo in ritardo di tre mesi. Se domani non mando il bollettino staccano tutto")
	(cons ;12 andrea
	 "How much do I need to give you?"
	 "E io quanto devo pagare?")
	(cons ;13 luca
	 "120.97 euros"
	 "120.97 euri")
	(cons ;14 luca
	 "Before this evening, otherwise I will be pissed off"
	 "entro stasera, altrimenti mi incazzo")
	(cons ;15 andrea
	 "I hope you are aware about the fact that I have no idea where I could find 120.97 euros"
	 "Spero tu ti renda conto che non ho la minima idea di dove posso recuperare 120.97 euri")
	(cons ;16 luca
	 "I don't care"
	 "M'importa meno di un cane che orina nel deserto")
	(cons ;17 andrea
	 "OK. I will do it"
	 "OK. Lo faro'")
	(cons ;18 luca
	 "Good boy!"
	 "E bravo cagnolone!")
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

; Script
(puppeteer_disable_control)
(animation "andrea" "back")
(if (not (= note_A_taken 1.0))
	(begin
		(say "andrea" (get_dialog dialogs language 0))
		(say "andrea" (get_dialog dialogs language 1))
		(say "andrea" (get_dialog dialogs language 2))
		(say "andrea" (get_dialog dialogs language 3))
		(stagecrafter_set_item "notes_A" "none")
		(stagecrafter_enable_item "bed_B")
		(puppeteer_show "luca" 3500)
		(puppeteer_move "luca" 4500)
		(director_wait_movement "luca")
		(puppeteer_look "andrea" "luca")
		(puppeteer_look "luca" "andrea")
		(director_wait_time 2)
		(say "andrea" (get_dialog dialogs language 4))
		(say "andrea" (get_dialog dialogs language 5))
		(say "andrea" (get_dialog dialogs language 6))
		(director_wait_time 2)
		(say "luca" (get_dialog dialogs language 7))
		(director_wait_time 1)
		(say "luca" (get_dialog dialogs language 8))
		(say "luca" (get_dialog dialogs language 9))
		(say "andrea" (get_dialog dialogs language 10))
		(say "luca" (get_dialog dialogs language 11))
		(say "andrea" (get_dialog dialogs language 12))
		(say "luca" (get_dialog dialogs language 13))
		(say "luca" (get_dialog dialogs language 14))
		(director_wait_time 1)
		(say "andrea" (get_dialog dialogs language 15))
		(say "luca" (get_dialog dialogs language 16))
		(say "andrea" (get_dialog dialogs language 17))
		(say "luca" (get_dialog dialogs language 18))
		(animation "andrea" "front")
		(puppeteer_stare "luca" "andrea")
		(collector_set "note_A_taken" 1))
	nil
)
(main_control "andrea")