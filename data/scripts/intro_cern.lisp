;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : cern
;Location   : CERN
;Author     : Nardinan
;Description: With this scene we want to find a reason why, in a real existing date-time (Perugia 2012) something so bizarre could be possible.

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 None
    ""
    "")
  (cons ;1 andrii
   "Dilution magnets are up and kicking, ready to prevent a potential catastrophic event (PCE)"
   "I magneti di diluzione sono stati attivati e sono pronti a prevenire una possibile catastrofe")
  (cons ;2 yuriy
   "That's great!"
   "Fantastico!")
  (cons ;3 yuriy
   "Dr. Tykhonov?"
   "Dr. Tykhonov?")
  (cons ;4 andrii
   "Mh?"
   "Mh?")
  (cons ;5 yuriy
   "Could you please disable the security grid?"
   "Potrebbe cortesemente disabilitare la griglia di sicurezza?")
  (cons ;6 andrii
   "Dr. Tykhonov?"
   "Dr. Tykhonov?")
  (cons ;7 andrii
   "I am not 50 years old, please, call me Andrii"
   "Non ho cinquant'anni, puoi chiamarmi tranquillamente Andrii.")
  (cons ;8 yuriy
   "In 'Angel and Deamons' people follow this approach!"
   "Ma su 'Angeli e Demoni' le persone del CERN usano questi appellativi!")
  (cons ;9 yuriy
   "You want to be less professional that a Dan Brown's book?"
   "Vorresti esser meno professionale di un libro di Dan Brown?")
  (cons ;10 andrii
   "Anyway . . ."
   "Comunque . . .")
  (cons ;11 andrii
   "I don't think we should disable the security grids, Yuriy!"
   "Non credo che dovremo disabilitare le griglie di sicurezza, Yuriy")
  (cons ;12 andrii
   "Is too dangerous!"
   "E' troppo pericoloso!")
  (cons ;13 yuriy
   "Oh, came on!"
   "Oh, eddai!")
  (cons ;14 andrii
   "No!"
   "No.")
  (cons ;15 yuriy
   "I would do it for you!"
   "Per te io lo farei!")
  (cons ;16 andrii
   "OK, but you're fucking annoying!"
   "E va bene, rompipalle!")
  (cons ;17 andrii
   "If something explodes, it's on you"
   "Ma se qualcosa dovesse accadere, la colpa sara' solo tua.")
  (cons ;18 yuriy
   "If something explodes, it's on you"
   "Ma se qualcosa dovesse accadere, la colpa sara' solo tua.")
  (cons ;19 andrii
   "Stop to say what I'm saying!"
   "Non prendermi in giro!")
  (cons ;20 andrii
   "Security grids have been disable, Dr. Ilchenko!"
   "Le griglie di sicurezza sono state disabilitate Dr. Ilchenko!")
  (cons ;21 yuriy
   "Fantastic!"
   "Fantastico!")
  (cons ;22 yuriy
   "Dan Brown would be proud of you!"
   "Dan Brown sarebbe orgoglioso di te!")
  (cons ;23 andrii
   "Dan Brown is awkward"
   "Dan Brown e' un disagiato")
  (cons ;24 yuriy
   "Uhm"
   "Uhm")
  (cons ;25 yuriy
   "Andrii, smoke seems coming out from the LHC"
   "Andrii, del fumo esce dall'LHC")
  (cons ;26 yuriy
   "Is it normal?"
   "E' normale?")
  (cons ;27 andrii
   "No Yuriy, is not normal. Obviously."
   "No Yuriy, ovviamente non e' normale.")
  (cons ;28 yuriy
   "Even Dan Brown would be able to recognize my sarcasm!"
   "Si chiama 'sarcasmo' e anche Dan Brown sarebbe capace di riconoscerlo!")
  (cons ;29 andrii
   "I think we should shut it down now before it gets worse . . ."
   "Credo sia il caso di spegnerlo prima che la situazione peggiori . . .")
  (cons ;30 yuriy
   "Uh?"
   "Uh?")
  (cons ;31 yuriy
   "It gets worse?"
   "Peggiorare?")
  (cons ;32 yuriy
   "Is smoking! How could it gets worse?"
   "Sta uscendo del fumo! Come puo' peggiorare la situazione?")
  (cons ;33 yuriy
   "Oh, I see now!"
   "Oh! Capisco ora!")
  (cons ;34 andrii
   "CHTO ZA HUINYA, BLYAT!?"
   "CHTO ZA HUINYA, BLYAT!?")
  (cons ;35 andrii
   "DIOMATONNE!"
   "DIOMATONNE!")
  (cons ;36 andrii
   "We're polluting the fabric of space and time!"
   "Stiamo inquinando il tessuto spazio-tempo!")
  (cons ;37 yuriy
   "What?"
   "Cosa?")
  (cons ;38 yuriy
   "The fabric of space and time?"
   "Il tessuto spazio-tempo?")
  (cons ;39 yuriy
   "Where did you got your PhD?"
   "Dove hai preso il dottorato, scusa?")
  (cons ;40 andrii
   "Shut the fuck up!"
   "Stai zitto!")
  (cons ;41 andrii
   "Jesus Christ, shut up!"
   "Gesu' Cristo smettila di parlare!")
  (cons ;42 yuriy
   "Phew, we missed it by a hair!"
   "Phew, per un pelo!")
  (cons ;43 andrii
   "Uhm"
   "Uhm")
  (cons ;44 yuriy
   "What? What's the matter?"
   "Cosa? Che c'e'?")
  (cons ;45 andrii
   "Yuriy, I think that the energy peak that we got wasn't a random one"
   "Yuriy io credo che il picco d'enegia che abbiamo avuto non sia stato casuale")
  (cons ;46 yuriy
   "What?"
   "Spiegazione, prego")
  (cons ;47 andrii
   "The computer says that we had a total blackout in the magnets' power line"
   "Secondo il computer abbiamo avuto un backout dei magneti di controllo")
  (cons ;48 andrii
   "This means that for a small amount of time, the beam was going around without any control"
   "Questo vuol dire che per qualche secondo il fascio viaggiava totalmente per conto suo")
  (cons ;49 andrii
   "We may have changed something, somewhere in the past"
   "Potremmo aver cambiato qualcosa da qualche parte, nel passato")
  (cons ;50 andrii
   "We may have changed . . ."
   "Potremmo aver cambiato . . .")
  (cons ;51 andrii
   "THE HISTORY"
   "LA STORIA")
  (cons ;52 yuriy
   "Wow! How did you do that?"
   "Wow! Ma come hai fatto a farlo?")
  (cons ;53 andrii
   "That? What?"
   "Fare cosa?")
  (cons ;54 yuriy
   "The thunder stuff"
   "Quella cosa del fulmine!")
  (cons ;55 andrii
   "What thunder stuff?"
   "Quale cosa del fulmine?")
  (cons ;56 yuriy
   "However, we're still here!"
   "Comunque noi siamo ancora qui!")
  (cons ;57 yuriy
   "Probably we changed the story of a dork . . ."
   "Probabilmente abbiamo cambiato la storia di qualche idiota . . .")
  (cons ;58 andrii
   "Or a whole team of dorks!"
   "O magari di un gruppo di idioti!")
  (cons ;59 yuriy
   "Maybe in a unnamed city . . ."
   "Magari in una citta' senza nome . . .")
  (cons ;60 andrii
   "The kind of city that you cannot find, even in a map!"
   "La solita citta' che pur con una cartina davanti nessuno saprebbe dove cercarla!")
  (cons ;61 yuriy
   "Maybe somewhere, not so far in the past . . ."
   "Magari in un passato non troppo lontano . . .")
  (cons ;62 andrii
   "Do you want to tell them the rest of the story?"
   "Che, dobbiamo raccontare come va a finire?")
  (cons ;63 yuriy
   "You're right, that's enough"
   "Hai ragione, famo basta")
  (cons ;64 yuriy
   "Vodka party?"
   "Vodka party?")
  (cons ;65 andrii
   "Yeeeeeee!"
   "Yeeeeeee!")
  nil
))

;High level functions
;@brief: say <character> <message>
;@description: character <character> says <message> and the system waits for the bubble to disappear
(define say
  (lambda (c m)
    (begin
      (puppeteer_say c m (+ 1 (* (length m) 0.05)))
      (director_wait_message c)
      )
    )
  )

;@brief: talk <character> <message> <track>
;@description: similar to 'say', but is it possible to associate an audio track to the dialog
(define talk
  (lambda (c m track)
    (begin
      (puppeteer_say c m track)
      (director_wait_message c)
      )
    )
  )

;@brief: say_and_go <character> <message>
;@description: similar to 'say', but the control is returned immediately to the program before the end of the message
(define say_and_go
  (lambda (c m)
    (begin
      (puppeteer_say c m (+ 1 (* (length m) 0.05)))
      )
    )
  )

;@brief: talk_and_go <character> <message> <track>
;@description: similar to 'talk', but the control is returned immediately to the program before the end of the audio track
(define talk_and_go
  (lambda (c m track)
    (begin
      (puppeteer_say c m track)
      )
    )
  )

;@brief: animation <character> <animation>
;@description: changes the state/animation of <character> to <animation>
(define animation
  (lambda (c m)
    (begin
      (puppeteer_set c m)
      )
    )
  )

;@brief: main_control <character>
;@description: gives the main control of the game to the character <character>
(define main_control
  (lambda (c)
    (begin
      (director_camera_follow c -100.0 1.0)
      (puppeteer_enable_control c)
      )
    )
  )

;@brief: get_dialog <dialog list> <language> <number>
;@description: returns the message number <number> stored in the <dialog list> list in the <language> language
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

;Environment configuration (music, effect, whatever)
(effecteer_play "moscow_mule_relaxed" "moscow_mule_relaxed" 0 1000 10)
(puppeteer_disable_control)
(puppeteer_show "yuriy" 	1450)
(puppeteer_show "andrii" 	2750)
(animation "yuriy" 			"back_code")
(stagecrafter_set_item "computer_A" "coding_A")
(animation "andrii" 		"back_code")
(stagecrafter_set_item "computer_C" "coding_C")

;Action!
(director_camera_move 2200 800)
(director_wait_time 2)
(say "andrii" (get_dialog dialogs language 1) "cern_track1") ;preview: Dilution magnets are up and ... | animation programming
(say "yuriy" (get_dialog dialogs language 2) "cern_track2") ;preview: That's great! | animation programming
(director_wait_time 1)
(animation "yuriy" 	"still_right")
(stagecrafter_set_item "computer_A" "still_A")
(say "yuriy" (get_dialog dialogs language 3) "cern_track3") ;preview: Dr. Tykhonov? | looking at andrii
(say "andrii" (get_dialog dialogs language 4) "cern_track4") ;preview: Mh? | animation programming
(say "yuriy" (get_dialog dialogs language 5) "cern_track5") ;preview: Could you please disable the... | looking at andrii | animation scratching his ass
(animation "andrii" "back")
(stagecrafter_set_item "computer_C" "still_C")
(director_wait_time 1)
(animation "andrii" "still_left")
(say "andrii" (get_dialog dialogs language 6) "cern_track6") ;preview: Dr. Tykhonov? | looking at yuriy
(say "andrii" (get_dialog dialogs language 7) "cern_track7") ;preview: I am not 50 years old, pleas... | looking at yuriy
(animation "yuriy" "point_right")
(say "yuriy" (get_dialog dialogs language 8) "cern_track8") ;preview: In 'Angel and Deamons' peopl... | looking at andrii | animation pointing
(animation "yuriy" 	"still_right")
(say "yuriy" (get_dialog dialogs language 9) "cern_track9") ;preview: You want to be less professi... | looking at andrii
;Script suggestion: Lunga pausa
(director_wait_time 2)
(say "andrii" (get_dialog dialogs language 10) "cern_track10") ;preview: Anyway ... | looking at yuriy
(animation "andrii" "scratch_left")
(say "andrii" (get_dialog dialogs language 11) "cern_track11") ;preview: I don't think we should disa... | looking at yuriy | animation stroking his chin
(animation "andrii" "still_left")
(say "andrii" (get_dialog dialogs language 12) "cern_track12") ;preview: Is too dangerous! | looking at yuriy
(say "yuriy" (get_dialog dialogs language 13) "cern_track13") ;preview: Oh, came on! | looking at andrii
(say "andrii" (get_dialog dialogs language 14) "cern_track14") ;preview: No! | looking at yuriy
(say "yuriy" (get_dialog dialogs language 15) "cern_track15") ;preview: I would do it for you! | looking at andrii
(director_wait_time 2)
(animation "andrii" "back_code")
(stagecrafter_set_item "computer_C" "coding_C")
(say "andrii" (get_dialog dialogs language 16) "cern_track16") ;preview: OK, but you're fucking annoy... | looking at yuriy
(animation "andrii" "point_left")
(stagecrafter_set_item "computer_C" "still_C")
(say "andrii" (get_dialog dialogs language 17) "cern_track17") ;preview: If something explodes, it's ... | looking at yuriy | animation pointing
(animation "yuriy" "point_right")
(say "yuriy" (get_dialog dialogs language 18) "cern_track18") ;preview: If something explodes, it's ... | looking at andrii | animation pointing
(animation "andrii" "still_left")
(director_wait_time 2)
(say "andrii" (get_dialog dialogs language 19) "cern_track19") ;preview: Stop to say what I'm saying! | looking at yuriy
;Script suggestion: andrii si rimette a programmare
(animation "yuriy" "still_right")
(animation "andrii" "back_code")
(stagecrafter_set_item "computer_C" "coding_C")
(director_wait_time 1)
(stagecrafter_set_item "shutdown" "trigger")
(say "andrii" (get_dialog dialogs language 20) "cern_track20") ;preview: Security grids have been dis... | animation programming
(animation "yuriy" 	"back_code")
(stagecrafter_set_item "computer_A" "coding_A")
(say "yuriy" (get_dialog dialogs language 21) "cern_track21") ;preview: Fantastic! | looking at andrii
(say "yuriy" (get_dialog dialogs language 22) "cern_track22") ;preview: Dan Brown would be proud of ... | animation programming
(say "andrii" (get_dialog dialogs language 23) "cern_track23") ;preview: Dan Brown is awkward | animation programming
;Script suggestion: dall'LHC inizia ad uscire del fumo
(effecteer_add "smoke_lhc" "smoke_spot_particle" 2250 700 4 0 nil nil)
(stagecrafter_set_item "computer_B" "warning_B")
(director_wait_time 1)
(animation "andrii" "back")
(stagecrafter_set_item "computer_C" "still_C")
(animation "yuriy"  "back")
(stagecrafter_set_item "computer_A" "still_A")
(director_wait_time 1)
(say "yuriy" (get_dialog dialogs language 24) "cern_track24") ;preview: Uhm | animation scratching his head
(animation "yuriy" 	"scratch_right")
(say "yuriy" (get_dialog dialogs language 25) "cern_track25") ;preview: andrii, smoke seems coming o... | animation scratching his head
(say "yuriy" (get_dialog dialogs language 26) "cern_track26") ;preview: Is it normal? | looking at andrii
(animation "andrii"	"still_left")
(say "andrii" (get_dialog dialogs language 27) "cern_track27") ;preview: No yuriy, is not normal. Obv... | looking at yuriy
(say "yuriy" (get_dialog dialogs language 28) "cern_track28") ;preview: Even Dan Brown would be able... | looking at andrii
(animation "andrii" "back")
(director_wait_time 2)
(animation "andrii"	"back_code")
(stagecrafter_set_item "computer_C" "coding_C")
(say "andrii" (get_dialog dialogs language 29) "cern_track29") ;preview: I think we should shut it do... | animation stroking his chin
(say "yuriy" (get_dialog dialogs language 30) "cern_track30") ;preview: Uh? | looking at andrii
(animation "yuriy" 	"back")
(say "yuriy" (get_dialog dialogs language 31) "cern_track31") ;preview: It gets worse? | looking at Andrea | animation scratching his head
(effecteer_stop "moscow_mule_relaxed")
(say "yuriy" (get_dialog dialogs language 32) "cern_track32") ;preview: Is smoking! How could it get...
;Script suggestion: Fiamme iniziano ad uscire dall'LHC
(effecteer_play "moscow_mule_stressed" "moscow_mule_stressed" 0 1000 10)
(stagecrafter_set_item "computer_B" "error_B")
(stagecrafter_set_item "lhc_segment_B" "move_silence")
(stagecrafter_set_item "lhc_segment_D" "move_silence")
(stagecrafter_set_item "lhc_segment_A" "move_silence")
(stagecrafter_set_item "lhc_segment_C" "move_audio")
(stagecrafter_set_item "lhc_segment_E" "move_silence")
(effecteer_add "fire_lhc" "fire_spot_particle" 2250 700 2 0 nil nil)
(director_wait_time 1)
(effecteer_add "fire_alarm_lhc" "red_alarm_animation" 0 0 4 0 t nil)
(animation "andrii" "back")
(stagecrafter_set_item "computer_C" "still_C")
(director_wait_time 2)
(say "yuriy" (get_dialog dialogs language 33) "cern_track33") ;preview: Oh, I see now!
;Script suggestion: andrii corre verso un'altra postazione
(director_wait_time 1)
(puppeteer_move "andrii" 2240)
(say_and_go "andrii" (get_dialog dialogs language 34) "cern_track34") ;preview: Chto za huinyat, bliat!? | animation programming
(say_and_go "andrii" (get_dialog dialogs language 35) "cern_track35") ;preview: Diomatonne! | animation programming
(director_wait_movement "andrii")
(animation "andrii" "back_code")
(stagecrafter_set_item "computer_B" "error_coding_B")
(say "andrii" (get_dialog dialogs language 36) "cern_track36") ;preview: We're polluting the fabric o... | animation hands in the hairs
(animation "yuriy" 	"still_right")
(say "yuriy" (get_dialog dialogs language 37) "cern_track37") ;preview: What? | looking at andrii
(say "yuriy" (get_dialog dialogs language 38) "cern_track38") ;preview: The fabric of space and time? | looking at andrii
(animation "yuriy" 	"point_right")
(say "yuriy" (get_dialog dialogs language 39) "cern_track39") ;preview: Where did you got your PhD? | looking at andrii | animation pointing
(animation "yuriy"  "still_right")
(say "andrii" (get_dialog dialogs language 40) "cern_track40") ;preview: Shut the fuck up! | animation programming
(say "andrii" (get_dialog dialogs language 41) "cern_track41") ;preview: Jesus Christ, shut up! | animation programming
;Script suggestion: La situazione torna alla normalita'
(stagecrafter_set_item "lhc_segment_A" "still")
(stagecrafter_set_item "lhc_segment_B" "still")
(stagecrafter_set_item "lhc_segment_C" "still")
(stagecrafter_set_item "lhc_segment_D" "still")
(stagecrafter_set_item "lhc_segment_E" "still")
(effecteer_delete "fire_alarm_lhc")
(effecteer_stop "fire_lhc")
(effecteer_stop "smoke_lhc")
(effecteer_stop "moscow_mule_stressed")
(director_wait_time 1)
(animation "andrii" "back")
(stagecrafter_set_item "computer_B" "still_B")
(animation "yuriy"  "back")
(director_wait_time 2)
(say "yuriy" (get_dialog dialogs language 42) "cern_track42") ;preview: Phew, we missed it by a hair!
(say "andrii" (get_dialog dialogs language 43) "cern_track43") ;preview: Uhm
(animation "yuriy" 	"still_right")
(say "yuriy" (get_dialog dialogs language 44) "cern_track44") ;preview: What? What's the matter? | looking at andrii
(animation "andrii"	"still_left")
(say "andrii" (get_dialog dialogs language 45) "cern_track45") ;preview: yuriy, I think that the ener... | looking at yuriy
(say "yuriy" (get_dialog dialogs language 46) "cern_track46") ;preview: What? | looking at andrii
(effecteer_play "moscow_mule_final" "moscow_mule_final" 0 2000 10 nil)
(say "andrii" (get_dialog dialogs language 47) "cern_track47") ;preview: The computer says that we ha... | looking at yuriy
(animation "andrii"	"back")
(say "andrii" (get_dialog dialogs language 48) "cern_track48") ;preview: This means that for a small ...
(say "andrii" (get_dialog dialogs language 49) "cern_track49") ;preview: We may have changed somethin...
(say "andrii" (get_dialog dialogs language 50) "cern_track50") ;preview: We may have changed ...
(say "andrii" (get_dialog dialogs language 51) "cern_track51") ;preview: THE HISTORY | animation hands in the hairs
;Script suggestion: Tuono
(effecteer_add "flash" "thunder_flash"  0 0 4 0 t nil)
(stagecrafter_set_item "thunder_strike" "strike")
(director_wait_time 3)
(animation "yuriy"	"still_left")
(director_wait_time 2)
(say "yuriy" (get_dialog dialogs language 52) "cern_track52") ;preview: Wow! How did you do that?
(animation "andrii"	"still_left")
(say "andrii" (get_dialog dialogs language 53) "cern_track53") ;preview: That? What?
(animation "yuriy"	"point_left")
(say "yuriy" (get_dialog dialogs language 54) "cern_track54") ;preview: The thunder stuff | animation pointing
(say "andrii" (get_dialog dialogs language 55) "cern_track55") ;preview: What thunder stuff? | looking at yuriy
;Script suggestion: I due si guardano per qualche momento
(animation "yuriy" 	"still_right")
(director_wait_time 2)
(say "yuriy" (get_dialog dialogs language 56) "cern_track56") ;preview: However, we're still here! | looking at andrii | animation pointing
(animation "yuriy" 	"point_right")
(say "yuriy" (get_dialog dialogs language 57) "cern_track57") ;preview: Probably we changed the stor... | looking at andrii
(animation "yuriy" 	"still_right")
(animation "andrii" "point_left")
(say "andrii" (get_dialog dialogs language 58) "cern_track58") ;preview: Or a whole team of dorks! | looking at yuriy
(animation "andrii" "still_left")
(say "yuriy" (get_dialog dialogs language 59) "cern_track59") ;preview: Maybe in a unnamed city! | looking at andrii
(say "andrii" (get_dialog dialogs language 60) "cern_track60") ;preview: The kind of city that you ca... | looking at yuriy
(say "yuriy" (get_dialog dialogs language 61) "cern_track61") ;preview: Maybe somewhere, not so far ... | looking at andrii
(say "andrii" (get_dialog dialogs language 62) "cern_track62") ;preview: Do you want to tell them the... | looking at yuriy
(say "yuriy" (get_dialog dialogs language 63) "cern_track63") ;preview: You're right, that's enough
(effecteer_stop "moscow_mule_final")
;Script suggestion: Entrambi guardano l'LHC
(animation "yuriy" "back")
(director_wait_time 1)
(animation "andrii" "back")
(director_wait_time 2)
(effecteer_play "dream" "dream_a_little_dream_of_me" 4000 4000)
(animation "yuriy" 	"still_right")
(say "yuriy" (get_dialog dialogs language 64) "cern_track64") ;preview: Vodka party? | looking at andrii
(animation "andrii" "point_left")
(say "andrii" (get_dialog dialogs language 65) "cern_track65") ;preview: Yeeeeeee! | looking at yuriy | animation hands in the air
(director_wait_time 1)
(effecteer_add  "black_hole" "black_hole_animation" 0 -1100 28 0 t nil)
(director_wait_time 5)
(effecteer_add  "psycho_games_post" "intro_pgs_post" -50 50 16 0 t nil)
(director_wait_time 45)
(effecteer_add  "clear_out" "fade_out" 0 0 4 0 t nil)
(director_wait_time 2)

;And never again
(collector_set "intro_cern" 1.0)

;Cleanup
(puppeteer_hide)
(stagecrafter_hide)
(effecteer_delete "fire_alarm_lhc")
(effecteer_delete "fire_lhc")
(effecteer_delete "smoke_lhc")
(effecteer_delete "flash")
(effecteer_delete "black_hole")
(effecteer_delete "psycho_games_pre")
(effecteer_delete "psycho_games_post")
(effecteer_delete "clear_out")
(effecteer_delete "moscow_mule_relaxed")
(effecteer_delete "moscow_mule_stressed")
(effecteer_delete "moscow_mule_final")

;Stop the music
(effecteer_stop "dream")
