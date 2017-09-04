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
	 "These are the holy notes from Cug"
	 "Questi sono i sacri appunti di Cug")
	(cons ;3 andrea
	 "Let me take them . . ."
	 "Sara' il caso che io li prenda . . .")
	(cons ;4 andrea
	 "Ehm . . ."
	 "Ehm . . .")
	(cons ;5 andrea
	 "Hello Cug, how are you?"
	 "Ciao Cug, come stai?")
    (cons ;6 andrea
     "He is Cug"
     "Lui e' Cug")
	(cons ;7 andrea
	 "I woke up twenty minutes ago and I am ready for this amazing day"
	 "Mi sono svegliato venti minuti fa e sono pronto per questa meravigliosa giornata")
	(cons ;8 luca
	 "I am not here tu judge you"
	 "Io non sono qui per giudicarti")
	(cons ;9 luca
	 "But I want you to know that it is three in the evening"
	 "Voglio solo che tu sappia che sono le tre di pomeriggio")
    (cons ;10 andrea
     "Ah"
     "Ah")
	(cons ;11 luca
	 "Listen very carefull now. The electricity bill is arrived and we have to pay it as soon as possible"
	 "Ascolta attentamente ora. E' arrivata la bolletta della luce e dobbiamo pagarla al piu' presto")
	(cons ;12 andrea
	 "We have time"
	 "Abbiamo tempo")
    (cons ;13 luca
	 "No, idiot. Tomorrow I have to send them the receipt, otherwise . . ."
	 "No, idiota. Domani devo mandare il bollettino, altrimenti . . .")
	(cons ;14 luca
	 "THEY WILL CUT US OUT"
	 "CI TAGLIERANNO LA CORRENTE")
	(cons ;15 andrea
	 "Wow! How did you do that?"
	 "Wow! Ma come hai fatto a farlo?")
	(cons ;16 luca
	 "Do what?"
	 "Fare cosa?")
    (cons ;17 andrea
     "That thing with thunderbolt"
     "Quella cosa del fulmine")
    (cons ;18 luca
     "What thunderbolt thing?"
     "Quale cosa del fulmine?")
	(cons ;19 andrea
     "It is fine. Listen, how much do I have to give you?"
     "Fa niente. Ascolta, quanto ti devo dare?")
	(cons ;20 luca
	 "One hundred twenty euros and ninenty five cents"
	 "Centoventi euro e novantasette centesimi")
    (cons ;21 luca
     "Cash"
     "In contanti")
	(cons ;22 luca
	 "Before this evening, otherwise I will be pissed off"
	 "Entro stasera, altrimenti mi incazzo")
    (cons ;23 andrea
     "I . . ."
     "Io . . .")
	(cons ;24 andrea
	 "I hope you are aware about the fact that I have no idea where I could find those money"
	 "Io spero tu ti renda conto che non ho la minima idea di dove recuperare tutti quei soldi")
	(cons ;25 luca
	 "I care less than a dog that pees in the desert"
	 "Mi interessa meno di un cane che orina nel deserto")
    (cons ;26 andrea
     "We'd better get a move on"
     "Sara' il caso di darsi da fare")
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
        (animation "andrea" "scratch_left")
		(say "andrea" (get_dialog dialogs language 5))
        (animation "andrea" "front")
		(say "andrea" (get_dialog dialogs language 6))
        (puppeteer_look "andrea" "luca")
        (say "andrea" (get_dialog dialogs language 7))
		(director_wait_time 2)
		(say "luca" (get_dialog dialogs language 8))
		(say "luca" (get_dialog dialogs language 9))
        (director_wait_time 2)
        (say "andrea" (get_dialog dialogs language 10))
        (director_wait_time 1)
		(say "luca" (get_dialog dialogs language 11))
		(say "andrea" (get_dialog dialogs language 12))
        (animation "luca" "point_right")
		(say "luca" (get_dialog dialogs language 13))
        (puppeteer_look "luca" "andrea")
		(say "luca" (get_dialog dialogs language 14))
		(effecteer_add "flash2" "thunder_flash"  0 0 4 0 t nil)
		(stagecrafter_set_item "thunder_strike" "strike")
		(director_wait_time 3)
		(say "andrea" (get_dialog dialogs language 15))
		(say "luca" (get_dialog dialogs language 16))
        (animation "andrea" "point_left")
        (say "andrea" (get_dialog dialogs language 17))
        (puppeteer_look "andrea" "luca")
		(say "luca" (get_dialog dialogs language 18))
		(say "andrea" (get_dialog dialogs language 19))
		(say "luca" (get_dialog dialogs language 20))
		(director_wait_time 2)
		(say "luca" (get_dialog dialogs language 21))
        (director_wait_time 2)
		(say "luca" (get_dialog dialogs language 22))
        (director_wait_time 2)
		(say "andrea" (get_dialog dialogs language 23))
        (director_wait_time 1)
		(say "andrea" (get_dialog dialogs language 24))
		(say "luca" (get_dialog dialogs language 25))
		(animation "andrea" "front")
		(say "andrea" (get_dialog dialogs language 26))
		(puppeteer_stare "luca" "andrea")

		; cleanup
		(effecteer_delete "flash2")

		; and never again
		(collector_set "note_A_taken" 1)

		; and now, please, play the track
		(effecteer_play "stone_paradise" "stone_paradise" 2000 2000 16))
	nil
)
(main_control "andrea")
