; Pomodoro
; Module: intro_cern
; Author: nardinan
; Date  : 20 Nov 2016
; This module contains the intro of the CERN scenario (which actually is the intro of the game itself)

; Dialogs
(define language (collector_get "language"))
(define dialogs (list 
	(cons ;0 andrii
 	 "Dilution magnets are now operative and ready to prevent a catastophic scenario"
	 "I magneti di diluizione sono operativi e pronti a prevenire una possibile catastrofe")
	(cons ;1 yuriy
	 "That's great"
	 "Fantastico")
	(cons ;2 yuriy
	 "Dr. Tykhonov, could you please disable security grids?"
	 "Dr. Tykhonov, puo' cortesemente disabilitare le griglie di sicurezza?")
	(cons ;3 andrii
	 "Dr. Tykhonov?"
	 "Dr. Tykhonov?")
	(cons ;4 andrii
	 "Sounds too much formal, don't you think?"
	 "Suona un po' troppo formale, non credi?")
	(cons ;5 yuriy
	 "In 'Angel & Deamons' CERN they are referring each other in this way!"
	 "Al CERN di 'Angeli & Demoni' si chiamano tra di loro in questo modo!")
	(cons ;6 andrii
	 "By the way ..."
	 "Comunque ...")
	(cons ;7 andrii
	 "I don't think we should disable the security grids, Yuriy"
	 "Non credo sia saggio disabilitare le griglie di sicurezza, Yuriy")
	(cons ;8 andrii
	 "Is too risky"
	 "E' troppo pericoloso")
	(cons ;9 yuriy
	 "Oh, please ..."
	 "Oh, per favore ...")
	(cons ;10 andrii
	 "Fine"
	 "Va bene")
	(cons ;11 andrii
	 "Security grids have been disabled, Dr. Ilchenko"
	 "Le griglie di sicurezza sono state disabilitate, Dr. Ilchenko")
	(cons ;12 yuriy
	 "Great"
	 "Fantastico")
	(cons ;13 yuriy
	 "Dan Brown would be proud of you!"
	 "Dan Brown sarebbe orgoglioso di te!")
	(cons ;14 andrii
	 "Dan Brown is an asshole"
	 "Dan Brown e' un disagiato")
	(cons ;15 yuriy
	 "Uhm"
	 "Uhm")
	(cons ;16 yuriy
	 "LHC is smoking. Is it normal?"
	 "Del fumo esce dall'LHC. E' normale?")
	(cons ;17 andrii
	 "No Yuriy, obviously, is not normal."
	 "No Yuriy, ovviamente non e' normale.")
	(cons ;18 yuriy
	 "Is called 'sarcasm'. Even Dan Brown would be able to understand that a smoking LHC is not normal"
	 "Si chiama 'sarcasmo'. Anche Dan Brown sarebbe capace di capire che lo LHC che fuma non e' normale")
	(cons ;19 andrii
	 "Probably we should shut it off right now before it gets worse"
	 "Forse e' il caso di spegnerlo subito prima che la situazione peggiori")
	(cons ;20 yuriy
	 "Uh?"
	 "Uh?")
	(cons ;21 yuriy
	 "Worse?"
	 "Peggiorare?")
	(cons ;22 yuriy
	 "It's smoking! How could it be worse?"
	 "Sta uscendo del fumo! Come puo' peggiore la situazione?")
	(cons ;23 yuriy
	 "Oh, I see ..."
	 "Ah, capisco ...")
	(cons ;24 andrii
	 "Fuck"
	 "Cazzo")
	(cons ;25 andrii
	 "Shit"
	 "Merda")
	(cons ;26 andrii
	 "Diomatonne(TM)"
	 "Diomatonne(TM)")
	(cons ;27 andrii
	 "We are polluting the space-time continuum"
	 "Stiamo seriamente danneggiando il continuo spazio-temporale")
	(cons ;28 yuriy
	 "What?"
	 "Cosa?")
	(cons ;29 yuriy
	 "Space-time continuum?"
	 "Il continuo spazio-temporale?")
	(cons ;30 yuriy
	 "Are you high?"
	 "Ti sei drogato?")
	(cons ;31 andrii
	 "Shut the fuck up!"
	 "Stai zitto, cazzo!")
	(cons ;32 andrii
	 "Jesus Christ, shut the fucking crap up!"
	 "Gesu' Cristo, smettila di parlare!")
	(cons ;33 yuriy
	 "Phew"
	 "Phew")
	(cons ;34 yuriy
	 "Looks better now!"
	 "Ce l'hai fatta!")
	(cons ;35 andrii
	 "Well, yes but ..."
	 "Beh, si ma ...")
	(cons ;36 yuriy
	 "'But' what?"
	 "'Ma' cosa?")
	(cons ;37 andrii
	 "Probably the energy peak that we saw wasn't casual"
	 "Probabilmente il picco d'energia che abbiamo visto non era casuale")
	(cons ;38 yuriy
	 "So?"
	 "Quindi?")
	(cons ;39 andrii
	 "I think we have changed something, somewhere in the past"
	 "Penso che abbiamo cambiato qualcosa, da qualche parte nel passato")
	(cons ;40 andrii
	 "We have changed the history"
	 "Abbiamo cambiato la storia")
	(cons ;41 yuriy
	 "Shit, I have no umbrella!"
	 "Merda, non ho l'ombrello!")
	(cons ;42 yuriy
	 "Anyway we are still here!"
	 "Comunque siamo ancora qui!")
	(cons ;43 yuriy
	 "Whatever we have changed, probably was not that important"
	 "Qualsiasi cosa abbiamo cambiato, probabilmente non era cosi' importante")
	(cons ;44 andrii
	 "Yep probably you are right. Maybe was not important ..."
	 "Si, probabilmente hai ragione. Magari non era nulla di importante ...")
	(cons ;45 yuriy
	 "Vodka party?"
	 "Vodka party?")
	(cons ;46 andrii
	 "Yeah!"
	 "Yeah!")
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

; Intro dialogs
(puppeteer_disable_control)
(puppeteer_show "yuriy" 	1750)
(puppeteer_show "andrii" 	2510)
(effecteer_add "intro1" "CERN_intro_layer" 1800 1900 1 0 nil nil)
(stagecrafter_play "cern_track_A")
(director_camera_set 2200 2200)
(director_wait_time 2)
(director_camera_move 2200 800)
(animation "yuriy" 			"back_code")
(animation "andrii" 		"back_code")
(stagecrafter_set_item "computer_A" "coding")
(stagecrafter_set_item "computer_C" "coding")
(director_wait_time 2)
(effecteer_delete 	"intro1")
(director_wait_time 2)
(say "andrii"	(get_dialog dialogs language 0))
(say "yuriy"	(get_dialog dialogs language 1))
(director_wait_time 1)
(animation "yuriy" 	"still_right")
(stagecrafter_set_item "computer_A" "still")
(say "yuriy"	(get_dialog dialogs language 2))
(animation "andrii" "back")
(stagecrafter_set_item "computer_C" "still")
(director_wait_time 1)
(animation "andrii" "still_left")
(say "andrii"	(get_dialog dialogs language 3))
(say "andrii"	(get_dialog dialogs language 4))
(say "yuriy"  	(get_dialog dialogs language 5))
(director_wait_time 1)
(say "andrii" 	(get_dialog dialogs language 6))
(say "andrii" 	(get_dialog dialogs language 7))
(say "andrii" 	(get_dialog dialogs language 8))
(say "yuriy" 	(get_dialog dialogs language 9))
(director_wait_time 1)
(animation "andrii" "back_code")
(stagecrafter_set_item "computer_C" "coding")
(say "andrii" 	(get_dialog dialogs language 10))
(director_wait_time 1)
(say "andrii" 	(get_dialog dialogs language 11))
(animation "yuriy" 	"back_code")
(stagecrafter_set_item "computer_A" "coding")
(say "yuriy" 	(get_dialog dialogs language 12))
(say "yuriy" 	(get_dialog dialogs language 13))
(say "andrii" 	(get_dialog dialogs language 14))
(effecteer_add "smoke1" "smoke_spot_particle" 2250 700 4 0 nil nil)
(director_wait_time 1)
(animation "andrii" "back")
(animation "yuriy"  "back")
(stagecrafter_set_item "computer_A" "still")
(stagecrafter_set_item "computer_C" "still")
(director_wait_time 1)
(say "yuriy"  	(get_dialog dialogs language 15))
(animation "yuriy" 	"still_right")
(say "yuriy"  	(get_dialog dialogs language 16))
(animation "andrii"	"still_left")
(say "andrii"  	(get_dialog dialogs language 17))
(animation "yuriy"	"still_right")
(say "yuriy"  	(get_dialog dialogs language 18))
(director_wait_time 1)
(animation "andrii"	"back_code")
(stagecrafter_set_item "computer_C" "coding")
(say "andrii" 	(get_dialog dialogs language 19))
(animation "yuriy" 	"back")
(say "yuriy"  	(get_dialog dialogs language 20))
(say "yuriy"  	(get_dialog dialogs language 21))
(say "yuriy"  	(get_dialog dialogs language 22))
(stagecrafter_set_item "lhc_segment_B" "move_silence")
(stagecrafter_set_item "lhc_segment_D" "move_silence")
(stagecrafter_set_item "lhc_segment_A" "move_silence")
(stagecrafter_set_item "lhc_segment_C" "move_audio")
(stagecrafter_set_item "lhc_segment_E" "move_silence")
(effecteer_add "fire1" "fire_spot_particle" 2250 700 2 0 nil nil)
(director_wait_time 1)
(effecteer_add "redalarm1" "red_alarm_animation" 0 0 4 0 t nil)
(animation "andrii" "back")
(stagecrafter_set_item "computer_C" "still")
(director_wait_time 2)
(say "yuriy" 	(get_dialog dialogs language 23))
(director_wait_time 2)
(puppeteer_move "andrii" 2140)
(say_and_go "andrii" 	(get_dialog dialogs language 24))
(say_and_go "andrii" 	(get_dialog dialogs language 25))
(say_and_go "andrii" 	(get_dialog dialogs language 26))
(director_wait_movement "andrii")
(animation "andrii" "back_code")
(stagecrafter_set_item "computer_B" "coding")
(say "andrii" 	(get_dialog dialogs language 27))
(animation "yuriy" 	"still_right")
(say "yuriy"  	(get_dialog dialogs language 28))
(say "yuriy"  	(get_dialog dialogs language 29))
(say "yuriy"  	(get_dialog dialogs language 30))
(say "andrii" 	(get_dialog dialogs language 31))
(say "andrii" 	(get_dialog dialogs language 32))
(stagecrafter_set_item "lhc_segment_A" "still")
(stagecrafter_set_item "lhc_segment_B" "still")
(stagecrafter_set_item "lhc_segment_C" "still")
(stagecrafter_set_item "lhc_segment_D" "still")
(stagecrafter_set_item "lhc_segment_E" "still")
(effecteer_delete 	"redalarm1")
(effecteer_stop 	"fire1")
(director_wait_time 1)
(animation "yuriy"  "back")
(animation "andrii" "back")
(stagecrafter_set_item "computer_B" "still")
(director_wait_time 1)
(say "yuriy"	(get_dialog dialogs language 33))
(say "yuriy"  	(get_dialog dialogs language 34))
(effecteer_stop 	"smoke1")
(say "andrii" 	(get_dialog dialogs language 35))
(animation "yuriy" 	"still_right")
(say "yuriy" 	(get_dialog dialogs language 36))
(animation "andrii"	"still_left")
(say "andrii"	(get_dialog dialogs language 37))
(say "yuriy"	(get_dialog dialogs language 38))
(animation "andrii"	"back")
(say "andrii"	(get_dialog dialogs language 39))
(say "andrii"	(get_dialog dialogs language 40))
(effecteer_add "flash1" "thunder_flash"  0 0 3 0 t nil)
(stagecrafter_set_item "thunder_strike" "strike")
(director_wait_time 3)
(animation "yuriy"	"still_left")
(say "yuriy"	(get_dialog dialogs language 41))
(director_wait_time 1)
(animation "yuriy" "back")
(say "yuriy"	(get_dialog dialogs language 42))
(say "yuriy"	(get_dialog dialogs language 43))
(say "andrii"	(get_dialog dialogs language 44))
(director_wait_time 2)
(animation "yuriy" 	"still_right")
(say "yuriy"	(get_dialog dialogs language 45))
(animation "andrii" "still_left")
(say "andrii"	(get_dialog dialogs language 46))
(director_camera_move 2000 -1500)
(director_wait_time 2)

; cleanup
(effecteer_delete 	"fire1")
(effecteer_delete 	"smoke1")
(puppeteer_hide)
(stagecrafter_hide)

; and never again
(collector_set "intro_ran" 1.0)
