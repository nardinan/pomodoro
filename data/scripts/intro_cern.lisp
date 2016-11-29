; Pomodoro
; Module: intro_cern
; Author: nardinan
; Date  : 20 Nov 2016
; This module contains the intro of the CERN scenario (which actually is the intro of the game itself)

; Dialogs
(define language 0) ; temporary
(define dialogs (list 
	(cons ;0 andrii
 	 "Dilution magnets are now operative and ready to prevent a catastophic scenario"
	 "I magneti di diluizione sono operativi e pronti a prevenire una possibile catastrofe")
	(cons ;1 yuriy
	 "That's great"
	 "Fantastico")
	(cons ;2 yuriy
	 "Dr. Tykhonov, could you please disable the secutiry grids?"
	 "Dr. Tykhonov, puo' cortesemente disabilitare le griglie di sicurezza?")
	(cons ;3 andrii
	 "Dr. Tykhonov?"
	 "Dr. Tykhonov?")
	(cons ;4 andrii
	 "Why Dr. Tykhonov?"
	 "Perche' Dr. Tykhonov?")
	(cons ;5 yuriy
	 "Uhm, I'm bored"
	 "Uhm, Cosi'")
	(cons ;6 andrii
	 "By the way ..."
	 "Comunque ...")
	(cons ;7 andrii
	 "I don't think we should disable the security grids, Yuriy"
	 "Non credo sia saggio disabilitare le griglie di sicurezza, Yuriy")
	(cons ;8 andrii
	 "Is too risky ..."
	 "E' troppo pericoloso ...")
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
	 "Dr. Ilchenko sounds great by the way!"
	 "Comunque Dr. Ilchenko suona bene!")
	(cons ;14 andrii
	 "Yes, but 'Yuriy' is easier"
	 "Si ma 'Yuriy' e' piu' semplice")
	(cons ;15 yuriy
	 "Uhm"
	 "Uhm")
	(cons ;16 yuriy
	 "LHC is smoking. Is it normal?"
	 "Del fumo esce dall'LHC. E' normale?")
	(cons ;17 andrii
	 "Ehm ... probably we should shut it off right now before it gets worse"
	 "Ehm ... forse e' il caso di spegnerlo subito prima che la situazione peggiori")
	(cons ;18 yuriy
	 "Uh?"
	 "Uh?")
	(cons ;19 yuriy
	 "Worse?"
	 "Peggiorare?")
	(cons ;20 yuriy
	 "It's smoking! How could it be worse?"
	 "Sta fumando! Come puo' peggiore la situazione?")
	(cons ;21 yuriy
	 "Oh, I see ..."
	 "Ah ...")
	(cons ;22 andrii
	 "Fuck"
	 "Cazzo")
	(cons ;23 andrii
	 "Shit"
	 "Merda")
	(cons ;24 andrii
	 "Crap"
	 "Diomatonne(TM)")
	(cons ;25 andrii
	 "We are polluting the space-time continuum"
	 "Stiamo seriamente danneggiando il continuo spazio-temporale")
	(cons ;26 yuriy
	 "What?"
	 "Cosa?")
	(cons ;27 yuriy
	 "Space-time continuum?"
	 "Il continuo spazio-temporale?")
	(cons ;28 yuriy
	 "Are you high?"
	 "Ti sei drogato?")
	(cons ;29 andrii
	 "Shut the fuck up!"
	 "Stai zitto, cazzo!")
	(cons ;30 andrii
	 "Jesus Christ, shut the fucking crap up!"
	 "Gesu' Cristo, smettila di parlare!")
	(cons ;31 yuriy
	 "Phew"
	 "Phew")
	(cons ;32 yuriy
	 "Looks better now!"
	 "Ce l'hai fatta!")
	(cons ;33 andrii
	 "Well ... Yes but ..."
	 "Beh ... Si ma ...")
	(cons ;34 yuriy
	 "'But' what?"
	 "'Ma' cosa?")
	(cons ;35 andrii
	 "Probably the energy peak that we saw wasn't casual"
	 "Probabilmente il picco d'energia che abbiamo visto non era casuale")
	(cons ;36 yuriy
	 "So?"
	 "Quindi?")
	(cons ;37 andrii
	 "I think we have changed something, somewhere in the past"
	 "Penso che abbiamo cambiato qualcosa, da qualche parte nel passato")
	(cons ;38 andrii
	 "We have changed the history"
	 "Abbiamo cambiato la storia")
	(cons ;39 yuriy
	 "Yes, but we are still here!"
	 "Si, ma siamo ancora qui!")
	(cons ;40 yuriy
	 "Whatever we have changed, probably was not important"
	 "Qualsiasi cosa abbiamo cambiato, probabilmente non era importante")
	(cons ;41 andrii
	 "Yep probably you are right. Maybe was not important ..."
	 "Si, probabilmente hai ragione. Magari non era nulla di importante ...")
	(cons ;42 yuriy
	 "Vodka party?"
	 "Vodka party?")
	(cons ;43 andrii
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
(puppeteer_show "yuriy" 	1350)
(puppeteer_show "andrii" 	2510)
(effecteer_add "intro1" "CERN_intro_layer" 1550 1900 1 0 nil nil)
(stagecrafter_play "cern_track_A")
(director_camera_set 2000 2200)
(director_wait_time 2)
(director_camera_move 2000 500)
(animation "yuriy" 			"back_code")
(animation "andrii" 		"back_code")
(stagecrafter_set_item "computer_A" "coding")
(stagecrafter_set_item "computer_C" "coding")
(director_wait_time 2)
(effecteer_delete 	"intro1")
(director_wait_time 1)
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
(effecteer_add "smoke1" "smoke_spot_particle" 2050 400 3 0 nil nil)
(director_wait_time 1)
(animation "andrii" "back")
(animation "yuriy"  "back")
(stagecrafter_set_item "computer_A" "still")
(stagecrafter_set_item "computer_C" "still")
(director_wait_time 1)
(say "yuriy"  	(get_dialog dialogs language 15))
(animation "yuriy" 	"still_right")
(say "yuriy"  	(get_dialog dialogs language 16))
(director_wait_time 1)
(animation "andrii"	"back_code")
(stagecrafter_set_item "computer_C" "coding")
(say "andrii" 	(get_dialog dialogs language 17))
(animation "yuriy" 	"back")
(say "yuriy"  	(get_dialog dialogs language 18))
(say "yuriy"  	(get_dialog dialogs language 19))
(say "yuriy"  	(get_dialog dialogs language 20))
(stagecrafter_set_item "lhc_segment_B" "move_silence")
(stagecrafter_set_item "lhc_segment_D" "move_silence")
(stagecrafter_set_item "lhc_segment_A" "move_silence")
(stagecrafter_set_item "lhc_segment_C" "move_audio")
(stagecrafter_set_item "lhc_segment_E" "move_silence")
(effecteer_add "fire1" "fire_spot_particle" 2050 400 2 0 nil nil)
(director_wait_time 1)
(effecteer_add "redalarm1" "red_alarm_animation" 0 0 3 0 t nil)
(animation "andrii" "back")
(stagecrafter_set_item "computer_C" "still")
(director_wait_time 2)
(say "yuriy" 	(get_dialog dialogs language 21))
(director_wait_time 2)
(puppeteer_move "andrii" 1940)
(say_and_go "andrii" 	(get_dialog dialogs language 22))
(say_and_go "andrii" 	(get_dialog dialogs language 23))
(say_and_go "andrii" 	(get_dialog dialogs language 24))
(director_wait_movement "andrii")
(animation "andrii" "back_code")
(stagecrafter_set_item "computer_B" "coding")
(say "andrii" 	(get_dialog dialogs language 25))
(animation "yuriy" 	"still_right")
(say "yuriy"  	(get_dialog dialogs language 26))
(say "yuriy"  	(get_dialog dialogs language 27))
(say "yuriy"  	(get_dialog dialogs language 28))
(say "andrii" 	(get_dialog dialogs language 29))
(say "andrii" 	(get_dialog dialogs language 30))
(stagecrafter_set_item "lhc_segment_A" "still")
(stagecrafter_set_item "lhc_segment_B" "still")
(stagecrafter_set_item "lhc_segment_C" "still")
(stagecrafter_set_item "lhc_segment_D" "still")
(stagecrafter_set_item "lhc_segment_E" "still")
(effecteer_stop 	"fire1")
(director_wait_time 1)
(effecteer_delete 	"redalarm1")
(director_wait_time 1)
(animation "yuriy"  "back")
(animation "andrii" "back")
(stagecrafter_set_item "computer_B" "still")
(director_wait_time 1)
(say "yuriy"	(get_dialog dialogs language 31))
(say "yuriy"  	(get_dialog dialogs language 32))
(effecteer_stop 	"smoke1")
(say "andrii" 	(get_dialog dialogs language 33))
(animation "yuriy" 	"still_right")
(say "yuriy" 	(get_dialog dialogs language 34))
(animation "andrii"	"still_left")
(say "andrii"	(get_dialog dialogs language 35))
(say "yuriy"	(get_dialog dialogs language 36))
(animation "andrii"	"back")
(say "andrii"	(get_dialog dialogs language 37))
(say "andrii"	(get_dialog dialogs language 38))
(animation "yuriy"	"back")
(director_wait_time 1)
(say "yuriy"	(get_dialog dialogs language 39))
(say "yuriy"	(get_dialog dialogs language 40))
(say "andrii"	(get_dialog dialogs language 41))
(director_wait_time 2)
(animation "yuriy" 	"still_right")
(say "yuriy"	(get_dialog dialogs language 42))
(animation "andrii" "still_left")
(say "andrii"	(get_dialog dialogs language 43))
(director_camera_move 2000 -1500)

; cleanup
(effecteer_delete 	"fire1")
(effecteer_delete 	"smoke1")
(puppeteer_hide)
(stagecrafter_hide)

; never again
(collector_set "intro_ran" 1.0)
