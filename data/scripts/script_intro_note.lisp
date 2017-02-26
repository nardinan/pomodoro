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
	 "I'm not here tu judge you"
	 "Non sono qui per giudicarti")
	(cons ;8 luca
	 "I just want you to know that it's three in the evening"
	 "Voglio solo che tu sappia che sono le tre di pomeriggio")
	(cons ;9 luca
	 "Listen very carefull now. Tomorrow we have to pay the electricity bill"
	 "Ascolta attentamente ora. Domani dobbiamo pagare la bolletta della luce")
	(cons ;10 andrea
	 "We have time"
	 "Abbiamo tempo")
	(cons ;11 luca
	 "No, idiot. Tomorrow I have to send them the receipt otherwise . . ."
	 "No, idiota. Domani devo mandare il bollettino altrimenti . . .")
	(cons ;12 luca
	 "THEY WILL CUT US OUT"
	 "CI TAGLIERANNO LA CORRENTE")
	(cons ;13 andrea
	 "Wow! How you were able to do it?"
	 "Wow! Ma come hai fatto a farlo?")
	(cons ;14 luca
	 "Do what?"
	 "Fare cosa?")
	(cons ;15 andrea
	 "How much do I need to give you?"
	 "Quanti soldi devo darti?")
	(cons ;16 luca
	 "One hundred twenty euros and ninenty five cents"
	 "Centoventi euro e novantasette centesimi")
	(cons ;17 luca
	 "Before this evening, otherwise I will be pissed off"
	 "Entro stasera, altrimenti mi incazzo")
	(cons ;18 andrea
	 "I hope you are aware about the fact that I have no idea where I could find all those money"
	 "Spero tu ti renda conto che non ho la minima idea di dove recuperare tutti quei soldi")
	(cons ;19 luca
	 "I care less than a dog that pees in the desert"
	 "M'importa meno di un cane che orina nel deserto")
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
		(say "luca" (get_dialog dialogs language 8))
		(say "luca" (get_dialog dialogs language 9))
		(say "andrea" (get_dialog dialogs language 10))
		(say "luca" (get_dialog dialogs language 11))
		(say "luca" (get_dialog dialogs language 12))
		(effecteer_add "flash2" "thunder_flash"  0 0 4 0 t nil)
		(stagecrafter_set_item "thunder_strike" "strike")
		(director_wait_time 3)
		(say "andrea" (get_dialog dialogs language 13))
		(say "luca" (get_dialog dialogs language 14))
		(director_wait_time 2)
		(say "andrea" (get_dialog dialogs language 15))
		(say "luca" (get_dialog dialogs language 16))
		(director_wait_time 1)
		(say "luca" (get_dialog dialogs language 17))
		(director_wait_time 1)
		(say "andrea" (get_dialog dialogs language 18))
		(say "luca" (get_dialog dialogs language 19))
		(animation "andrea" "front")
		(puppeteer_stare "luca" "andrea")

		; cleanup
		(effecteer_delete "flash2")

		; and never again
		(collector_set "note_A_taken" 1))
	nil
)
(main_control "andrea")