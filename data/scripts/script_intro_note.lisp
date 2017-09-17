;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : cugmny
;Location   : Canama
;Author     : Nardinan
;Description: In this cut-scene cug asks Andrea the money for the electric bill

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 andrea
   "Oh, look!"
   "Oh ma tu guarda!")
  (cons ;2 andrea
   "Calculus 2"
   "Analisi Matematica 2")
  (cons ;3 andrea
   "These are the holy notes from Cug"
   "Questi sono i sacri appunti di Cug")
  (cons ;4 andrea
   "Let me take them ..."
   "Sara' il caso che li prenda io ...")
  (cons ;5 andrea
   "Ehm"
   "Ehm")
  (cons ;6 andrea
   "Hello Cug, how are you?"
   "Ciao Cug, come stai?")
  (cons ;7 andrea
   "He is Cug"
   "Lui e' Cug")
  (cons ;8 andrea
   "I woke up twenty minutes ago and I am ready for this amazing day"
   "Mi sono svegliato venti minuti fa e sono pronto per questa meravigliosa giornata")
  (cons ;9 cug
   "I am not here to judge you"
   "Io non sono qui per giudicarti")
  (cons ;10 cug
   "But I want you to know that it is three in the evening"
   "Voglio solo che tu sappia che sono le tre di pomeriggio")
  (cons ;11 andrea
   "Ah"
   "Ah")
  (cons ;12 cug
   "Listen very careful now. The electricity bill is arrived and we have to pay it as soon as possible"
   "Ascolta attentamente ora. E' arrivata la bolletta della luce e dobbiamo pagarla al piu' presto")
  (cons ;13 andrea
   "We have time"
   "Abbiamo tempo")
  (cons ;14 cug
   "No, idiot. Tomorrow I have to send them the receipt otherwise . . ."
   "No, idiota. Domani devo mandare il bollettino, altrimenti . . .")
  (cons ;15 cug
   "THEY WILL CUT US OUT!"
   "CI TAGLIERANNO LA CORRENTE!")
  (cons ;16 andrea
   "Wow! How did you do that?"
   "Wow! Ma come hai fatto a farlo?")
  (cons ;17 cug
   "Do what?"
   "Fare cosa?")
  (cons ;18 andrea
   "That thing with thunderbolt"
   "Quella cosa del fulmine")
  (cons ;19 cug
   "What thunderbolt thing?"
   "Quale cosa del fulmine?")
  (cons ;20 andrea
   "It is fine. Listen, how much do I have to give you?"
   "Fa niente. Ascolta, quanto ti devo dare?")
  (cons ;21 cug
   "One hundred twenty euros and ninety five cents"
   "Centoventi euro e novantasette centesimi")
  (cons ;22 cug
   "Cash"
   "In contanti")
  (cons ;23 cug
   "Before this evening, otherwise I will be pissed off"
   "Entro stasera, altrimenti mi incazzo")
  (cons ;24 andrea
   "I ..."
   "Io ...")
  (cons ;25 andrea
   "I hope you are aware about the fact that I have no idea where I could find those money"
   "Io spero che tu ti renda conto che non ho la minima idea di dove recuperare tutti quei soldi")
  (cons ;26 cug
   "I care less than a dog that pees in the desert"
   "Mi interessa meno di un cane che orina nel deserto")
  (cons ;27 andrea
   "We'd better get a move on"
   "Sara' il caso di darsi da fare")
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
;Parameters configuration
(define note_A_taken (collector_get "note_A_taken"))

;Environment configuration (music, effect, whatever)
(puppeteer_disable_control)
(animation "andrea" "back")

;Action!
(puppeteer_disable_control)
(animation "andrea" "back")
(if (not (= note_A_taken 1.0))
	(begin
		(say "andrea" (get_dialog dialogs language 1) "cugmny_track1") ;preview: Oh, look! | animation back
		(say "andrea" (get_dialog dialogs language 2) "cugmny_track2") ;preview: Calculus 2 | animation back
		(say "andrea" (get_dialog dialogs language 3) "cugmny_track3") ;preview: These are the holy notes fro... | animation back
		(stagecrafter_set_item "notes_A" "none")
		(stagecrafter_enable_item "bed_B")
		(animation "andrea" "front")
		(say "andrea" (get_dialog dialogs language 4) "cugmny_track4") ;preview: Let me take them ... | animation front
		(puppeteer_show "luca" 3500)
		(puppeteer_move "luca" 4500)
		(director_wait_movement "luca")
		(animation "andrea" "still_left")
		(animation "luca" "still_right")
		(director_wait_time 2)
		(say "andrea" (get_dialog dialogs language 5) "cugmny_track5") ;preview: Ehm | looking at Cug | animation back
		(animation "andrea" "scratch_left")
		(say "andrea" (get_dialog dialogs language 6) "cugmny_track6") ;preview: Hello Cug, how are you? | looking at Cug | animation scratching his head
		(animation "andrea" "front")
		(say "andrea" (get_dialog dialogs language 7) "cugmny_track7") ;preview: He is Cug | looking at Main Camera
		(animation "andrea" "still_left")
		(say "andrea" (get_dialog dialogs language 8) "cugmny_track8") ;preview: I woke up twenty minutes ago... | looking at Cug
		;Script suggestion: Lunga pausa in cui i due si guardano
		(director_wait_time 2)
		(say "luca" (get_dialog dialogs language 9) "cugmny_track9") ;preview: I am not here to judge you | looking at Andrea
		(say "luca" (get_dialog dialogs language 10) "cugmny_track10") ;preview: But I want you to know that ... | looking at Andrea
		(director_wait_time 2)
		(say "andrea" (get_dialog dialogs language 11) "cugmny_track11") ;preview: Ah | looking at Cug | animation hands in the pocket
		(director_wait_time 1)
		(say "luca" (get_dialog dialogs language 12) "cugmny_track12") ;preview: Listen very careful now. The... | looking at Andrea
		(say "andrea" (get_dialog dialogs language 13) "cugmny_track13") ;preview: We have time | looking at Cug | animation hands in the pocket
		(animation "luca" "point_right")
		(say "luca" (get_dialog dialogs language 14) "cugmny_track14") ;preview: No, idiot. Tomorrow I have t... | looking at Andrea | animation pointing
		(animation "luca" "still_right")
		(say "luca" (get_dialog dialogs language 15) "cugmny_track15") ;preview: THEY WILL CUT US OUT! | looking at Andrea
		;Script suggestion: Tuono
		(effecteer_add "flash" "thunder_flash"  0 0 4 0 t nil)
		(stagecrafter_set_item "thunder_strike" "strike")
		(director_wait_time 3)
		(say "andrea" (get_dialog dialogs language 16) "cugmny_track16") ;preview: Wow! How did you do that? | looking at Cug | animation hands in the air
		(say "luca" (get_dialog dialogs language 17) "cugmny_track17") ;preview: Do what? | looking at Andrea
		(animation "andrea" "point_left")
		(say "andrea" (get_dialog dialogs language 18) "cugmny_track18") ;preview: That thing with thunderbolt | looking at Cug | animation pointing
		(say "luca" (get_dialog dialogs language 19) "cugmny_track19") ;preview: What thunderbolt thing? | animation left
		(animation "andrea" "still_left")
		(director_wait_time 2)
		(say "andrea" (get_dialog dialogs language 20) "cugmny_track20") ;preview: It is fine. Listen, how much... | looking at Cug
		(say "luca" (get_dialog dialogs language 21) "cugmny_track21") ;preview: One hundred twenty euros and... | looking at Andrea
		;Script suggestion: Lunga pausa in cui i due si guardano
		(director_wait_time 2)
		(say "luca" (get_dialog dialogs language 22) "cugmny_track22") ;preview: Cash | looking at Andrea
		;Script suggestion: Lunga pausa in cui i due si guardano
		(director_wait_time 2)
		(say "luca" (get_dialog dialogs language 23) "cugmny_track23") ;preview: Before this evening, otherwi... | looking at Andrea
		;Script suggestion: Lunga pausa in cui i due si guardano
		(director_wait_time 2)
		(animation "andrea" "scratch_left")
		(say "andrea" (get_dialog dialogs language 24) "cugmny_track24") ;preview: I ... | looking at Cug | animation stroking his chin
		(animation "andrea" "still_left")
		(say "andrea" (get_dialog dialogs language 25) "cugmny_track25") ;preview: I hope you are aware about t... | looking at Cug
		(say "luca" (get_dialog dialogs language 26) "cugmny_track26") ;preview: I care less than a dog that ... | looking at Andrea
		(animation "andrea" "front")
		(say "andrea" (get_dialog dialogs language 27) "cugmny_track27") ;preview: We'd better get a move on | looking at Main Camera
		(puppeteer_stare "luca" "andrea")

		;And never again
		(collector_set "intro_canama" 1)
    (collector_set "note_A_taken" 1)

		;Cleanup
		(effecteer_delete "flash")

		;And now, please, play the track
		(effecteer_play "stone_paradise" "stone_paradise" 2000 2000 16))
	nil)
;Return the control
(main_control "andrea")
