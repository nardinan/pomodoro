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
	 "I magneti di diluizione sono stati attivati e sono pronti a prevenire una possibile catastrofe")
	(cons ;1 yuriy
	 "That's great"
	 "Fantastico")
	(cons ;2 yuriy
	 "Dr. Tykhonov?"
	 "Dr. Tykhonov?")
	(cons ;3 andrii
	 "Mh?"
	 "Mh?")
	(cons ;4 yuriy
	 "Could you please disable the security grid?"
	 "Potrebbe cortesemente disabilitare la griglia di sicurezza?")
	(cons ;5 andrii
	 "Dr. Tykhonov?"
	 "Dr. Tykhonov?")
	(cons ;6 andrii
	 "Sounds too much formal, don't you think?"
	 "Suona leggermente troppo formale, non credi?")
	(cons ;7 yuriy
	 "In 'Angels & Daemons' CERN's people referring each other in this way"
	 "Ma su 'Angeli & Demoni' le persone al CERN usano questi appellativi!")
	(cons ;8 andrii
	 "By the way ..."
	 "Comunque ...")
	(cons ;9 andrii
	 "I don't think we should disable the security grids, Yuriy"
	 "Non credo che dovremmo disabilitare le griglie di sicurezza, Yuriy")
	(cons ;10 andrii
	 "Is too risky"
	 "E' troppo pericoloso")
	(cons ;11 yuriy
	 "Oh, please ..."
	 "Oh, eddai!")
	(cons ;12 andrii
	 "Nope"
	 "No")
	(cons ;13 yuriy
	 "Oh, please ..."
	 "Oh, essu!")
	(cons ;14 andrii
	 "Fine, asshole"
	 "E va bene, rompipalle!")
	(cons ;15 andrii
	 "Security grids have been disabled, Dr. Ilchenko"
	 "Le griglie di sicurezza sono state disabilitate, Dr. Ilchenko")
	(cons ;16 yuriy
	 "Great"
	 "Fantastico! Dan Brown sarebbe orgoglioso di te!")
	(cons ;17 andrii
	 "Dan Brown is an needy"
	 "Dan Brown e' un disagiato")
	(cons ;18 yuriy
	 "Uhm"
	 "Uhm")
	(cons ;19 yuriy
	 "LHC is smoking. Is it normal?"
	 "Andrii, del fumo esce dall'LHC! E' normale?")
	(cons ;20 andrii
	 "No Yuriy, obviously, it is not normal."
	 "No Yuriy, ovviamente non e' normale.")
	(cons ;21 yuriy
	 "Is called 'sarcasm'. Even Dan Brown would be able to recognize it"
	 "Si chiama 'sarcasmo' e anche Dan Brown sarebbe capace di riconoscerlo!")
	(cons ;22 andrii
	 "Probably we should shut it off right now before it gets worse"
	 "Credo sia il caso di spegnerlo prima che la situazione peggiori")
	(cons ;23 yuriy
	 "Uh?"
	 "Uh?")
	(cons ;24 yuriy
	 "Worse?"
	 "Peggiorare?")
	(cons ;25 yuriy
	 "It's smoking! How could it be worse?"
	 "Sta uscendo del fumo! Come puo' peggiorare la situazione?")
	(cons ;26 yuriy
	 "Oh, I see ..."
	 "Oh, capisco ora!")
	(cons ;27 andrii
	 "Fuck"
	 "Merda")
	(cons ;28 andrii
	 "Shit"
	 "Puttana Eva")
	(cons ;29 andrii
	 "Diomatonne(TM)"
	 "Diomatonne(TM)")
	(cons ;30 andrii
	 "We are polluting the fabric of space-time"
	 "Stiamo inquinando il tessuto spazio-tempo")
	(cons ;31 yuriy
	 "What?"
	 "Cosa?")
	(cons ;32 yuriy
	 "Fabric of space-time?"
	 "Il tessuto spazio-tempo?")
	(cons ;33 yuriy
	 "We are polluting your brain as well . . ."
	 "Ti sei laureato su Topolino?")
	(cons ;34 andrii
	 "Shut the fuck up!"
	 "Stai zitto!")
	(cons ;35 andrii
	 "Jesus Christ, shut the fucking crap up!"
	 "Gesu' Cristo, smettila di parlare!")
	(cons ;36 yuriy
	 "Phew"
	 "Phew, per un pelo")
	(cons ;37 andrii
	 "Uhm"
	 "Uhm")
	(cons ;38 yuriy
	 ""
	 "Cosa? Che c'e'?")
	(cons ;39 andrii
	 ""
	 "Yuriy io credo che il picco d'energia che abbiamo avuto non sia stato casuale")
	(cons ;40 yuriy
	 ""
	 "Spiegazione, prego")
	(cons ;41 andrii
	 ""
	 "Vedi, secondo il computer abbiamo avuto un blackout dei magneti di controllo")
	(cons ;42 andrii
	 ""
	 "Potremmo aver  cambiato qualcosa da qualche parte nel passato")
	(cons ;43 andrii
     ""
     "Potremmo aver cambiato . . .")
	(cons ;44 andrii
	 ""
	 "LA STORIA")
	(cons ;42 yuriy
	 ""
	 "Oh no, ho dimenticato l'ombrello a casa!")
	(cons ;43 yuriy
	 ""
	 "Comunque noi siamo ancora qui!")
	(cons ;44 yuriy
	 ""
	 "Probabilmente abbiamo cambiato la storia di qualche idiota . . .")
	(cons ;45 andrii
	 ""
	 "O magari di un gruppo di idioti!")
	(cons ;46 yurii
	 ""
	 "Magari in una citta' senza nome . . .")
	(cons ;47 andrii
	 ""
	 "La solita citta' che pur con una cartina davanti, nessuno saprebbe dove cercarla!")
	(cons ;48 yuriy
	 ""
	 "Magari in un passato non troppo lontano . . .")
	(cons ;49 andrii
	 ""
	 "Che dobbiamo raccontare come va a finire?")
	(cons ;50 yuriy
	 "Right, it's enough"
	 "Hai ragione, famo basta")
	(cons ;51 yuriy
	 "Vodka party?"
	 "Vodka party?")
	(cons ;52 andrii
	 "Yeeeeeeee!"
	 "Yeeeeeeee!")
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

(define talk
	(lambda (c m track)
		(begin
			(puppeteer_say c m track)
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

(define talk_and_go
	(lambda (c m track)
		(begin
			(puppeteer_say c m track)
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
(effecteer_play "moscow_mule_relaxed" "moscow_mule_relaxed" 0 1000 10)
(puppeteer_disable_control)

(puppeteer_show "yuriy" 	1450)
(puppeteer_show "andrii" 	2750)

(animation "yuriy" 			"back_code")
(director_wait_time 1)
(animation "andrii" 		"back_code")
(director_camera_move 2200 800)
(stagecrafter_set_item "computer_A" "coding_A")
(stagecrafter_set_item "computer_C" "coding_C")
(director_wait_time 2)
(say "andrii"	(get_dialog dialogs language 0) "andrii_track1")
(say "yuriy"	(get_dialog dialogs language 1) "yuriy_track1")
(director_wait_time 1)
(animation "yuriy" 	"still_right")
(stagecrafter_set_item "computer_A" "still_A")
(say "yuriy"	(get_dialog dialogs language 2) "yuriy_track2")
(say "andrii"	(get_dialog dialogs language 3) "andrii_track2")
(say "yuriy"	(get_dialog dialogs language 4)	"yuriy_track3")
(animation "andrii" "back")
(stagecrafter_set_item "computer_C" "still_C")
(director_wait_time 1)
(animation "andrii" "still_left")
(say "andrii"	(get_dialog dialogs language 5) "andrii_track3")
(say "andrii"	(get_dialog dialogs language 6) "andrii_track4")
(say "yuriy"  	(get_dialog dialogs language 7) "yuriy_track4")
(director_wait_time 1)
(say "andrii" 	(get_dialog dialogs language 8)  "andrii_track5")
(say "andrii" 	(get_dialog dialogs language 9)  "andrii_track6")
(say "andrii" 	(get_dialog dialogs language 10) "andrii_track7")
(say "yuriy" 	(get_dialog dialogs language 11) "yuriy_track5")
(animation "andrii" "back")
(say "andrii"  (get_dialog dialogs language 12) "andrii_track8")
(say "yuriy"   (get_dialog dialogs language 13) "yuriy_track6")
(director_wait_time 1)
(animation "andrii" "back_code")
(stagecrafter_set_item "computer_C" "coding_C")
(say "andrii"  (get_dialog dialogs language 14) "andrii_track9")
(director_wait_time 1)
(stagecrafter_set_item "shutdown" "trigger")
(say "andrii" 	(get_dialog dialogs language 15) "andrii_track10")
(animation "yuriy" 	"back_code")
(stagecrafter_set_item "computer_A" "coding_A")
(say "yuriy" 	(get_dialog dialogs language 16) "yuriy_track7")
(say "andrii" 	(get_dialog dialogs language 17) "andrii_track11")
(effecteer_add "smoke1" "smoke_spot_particle" 2250 700 4 0 nil nil)
(director_wait_time 1)
(animation "andrii" "back")
(animation "yuriy"  "back")
(stagecrafter_set_item "computer_A" "still_A")
(stagecrafter_set_item "computer_B" "warning_B")
(stagecrafter_set_item "computer_C" "still_C")
(director_wait_time 1)
(say "yuriy"  	(get_dialog dialogs language 18) "yuriy_track8")
(animation "yuriy" 	"still_right")
(say "yuriy"  	(get_dialog dialogs language 19) "yuriy_track9")
(animation "andrii"	"still_left")
(say "andrii"  (get_dialog dialogs language 20) "andrii_track12")
(say "yuriy"  	(get_dialog dialogs language 21) "yuriy_track10")
(director_wait_time 1)
(animation "andrii"	"back_code")
(stagecrafter_set_item "computer_C" "coding_C")
(say "andrii" 	(get_dialog dialogs language 22) "andrii_track13")
(animation "yuriy" 	"back")
(say "yuriy"  	(get_dialog dialogs language 23) "yuriy_track11A")
(say "yuriy"  	(get_dialog dialogs language 24) "yuriy_track11B")
(effecteer_stop "moscow_mule_relaxed")
(say "yuriy"  	(get_dialog dialogs language 25) "yuriy_track11C")
(effecteer_play "moscow_mule_stressed" "moscow_mule_stressed" 0 1000 10)
(stagecrafter_set_item "computer_B" "error_B")
(stagecrafter_set_item "lhc_segment_B" "move_silence")
(stagecrafter_set_item "lhc_segment_D" "move_silence")
(stagecrafter_set_item "lhc_segment_A" "move_silence")
(stagecrafter_set_item "lhc_segment_C" "move_audio")
(stagecrafter_set_item "lhc_segment_E" "move_silence")
(effecteer_add "fire1" "fire_spot_particle" 2250 700 2 0 nil nil)
(director_wait_time 1)
(effecteer_add "redalarm1" "red_alarm_animation" 0 0 4 0 t nil)
(animation "andrii" "back")
(stagecrafter_set_item "computer_C" "still_C")
(director_wait_time 2)
(say "yuriy" 	(get_dialog dialogs language 26) "yuriy_track12")
(director_wait_time 2)
(puppeteer_move "andrii" 2240)
(say_and_go "andrii" (get_dialog dialogs language 27) "andrii_track14A")
(say_and_go "andrii" (get_dialog dialogs language 28) "andrii_track14B")
(say_and_go "andrii" (get_dialog dialogs language 29) "andrii_track14C")
(director_wait_movement "andrii")
(animation "andrii" "back_code")
(stagecrafter_set_item "computer_B" "error_coding_B")
(say "andrii" 	(get_dialog dialogs language 30) "andrii_track15")
(animation "yuriy" 	"still_right")
(say "yuriy"  	(get_dialog dialogs language 31) "yuriy_track13A")
(say "yuriy"  	(get_dialog dialogs language 32) "yuriy_track13B")
(say "yuriy"  	(get_dialog dialogs language 33) "yuriy_track13C")
(say "andrii" 	(get_dialog dialogs language 34) "andrii_track16A")
(say "andrii" 	(get_dialog dialogs language 35) "andrii_track16B")
(stagecrafter_set_item "lhc_segment_A" "still")
(stagecrafter_set_item "lhc_segment_B" "still")
(stagecrafter_set_item "lhc_segment_C" "still")
(stagecrafter_set_item "lhc_segment_D" "still")
(stagecrafter_set_item "lhc_segment_E" "still")
(effecteer_delete "redalarm1")
(effecteer_stop   "fire1")
(effecteer_stop   "smoke1")
(effecteer_stop   "moscow_mule_stressed")
(director_wait_time 1)
(animation "yuriy"  "back")
(animation "andrii" "back")
(stagecrafter_set_item "computer_B" "still_B")
(director_wait_time 1)
(say "yuriy"	(get_dialog dialogs language 36) "yuriy_track14")
(say "andrii" 	(get_dialog dialogs language 37) "andrii_track17")
(animation "yuriy" 	"still_right")
(say "yuriy" 	(get_dialog dialogs language 38) "yuriy_track15")
(effecteer_play   "moscow_mule_final" "moscow_mule_final" 0 1000 10 nil)
(animation "andrii"	"still_left")
(say "andrii"	(get_dialog dialogs language 39) "andrii_track18")
(say "yuriy"	(get_dialog dialogs language 40) "yuriy_track16")
(animation "andrii"	"back")
(say "andrii"	(get_dialog dialogs language 41) "andrii_track19A")
(say "andrii"	(get_dialog dialogs language 42) "andrii_track19B")
(say "andrii"	(get_dialog dialogs language 43) "andrii_track19C")
(say "andrii"	(get_dialog dialogs language 44) "andrii_track19D")
(effecteer_add "flash1" "thunder_flash"  0 0 4 0 t nil)
(stagecrafter_set_item "thunder_strike" "strike")
(director_wait_time 3)
(animation "yuriy"	"still_left")
(director_wait_time 2)
(say "yuriy"	(get_dialog dialogs language 45) "yuriy_track17")
(director_wait_time 1)
(animation "yuriy" "back")
(say "yuriy"	(get_dialog dialogs language 46) "yuriy_track18")
(animation "yuriy" "still_right")
(say "yuriy"	(get_dialog dialogs language 47) "yuriy_track19")
(animation "andrii" "still_left")
(say "andrii"	(get_dialog dialogs language 48) "andrii_track20")
(say "yuriy"	(get_dialog dialogs language 49) "yuriy_track20")
(say "andrii"	(get_dialog dialogs language 50) "andrii_track21")
(say "yuriy"	(get_dialog dialogs language 51) "yuriy_track21")
(say "andrii"	(get_dialog dialogs language 52) "andrii_track22")
(animation "yuriy" "back")
(say "yuriy"	(get_dialog dialogs language 53) "yuriy_track22")
(effecteer_stop "moscow_mule_final")
(director_wait_time 2)
(animation "andrii" "back")
(director_wait_time 2)
(effecteer_play 	"dream" "dream_a_little_dream_of_me" 4000 4000)
(animation "yuriy" 	"still_right")
(say "yuriy"	(get_dialog dialogs language 54) "yuriy_track23")
(animation "andrii" "still_left")
(say "andrii"	(get_dialog dialogs language 55) "andrii_track23")
(director_wait_time 1)
(effecteer_add  "black1" "black_hole_animation" 0 -1100 28 0 t nil)
(director_wait_time 5)
(effecteer_add  "pgs1"   "intro_pgs" -50 50 16 0 t nil)
(director_wait_time 45)
(effecteer_add  "clear1" "fade_out" 0 0 4 0 t nil)
(director_wait_time 2)

; and never again
(collector_set "intro_ran" 1.0)

; cleanup
(puppeteer_hide)
(stagecrafter_hide)
(effecteer_delete "fire1")
(effecteer_delete "smoke1")
(effecteer_delete "flash1")
(effecteer_delete "black1")
(effecteer_delete "pgs1")
(effecteer_delete "clear1")
(effecteer_delete "moscow_mule_relaxed")
(effecteer_delete "moscow_mule_stressed")
(effecteer_delete "moscow_mule_final")

; stop the music
(effecteer_stop   "dream")
