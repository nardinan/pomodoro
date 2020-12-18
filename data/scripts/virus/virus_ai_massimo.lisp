;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : mavirus
;Location   : Med Store
;Author     : Madmoon
;Description: Massimo is about to asking for money for the Profeta

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 massimo
			"I am sorry, I cannot sell you anything . . ."    
			"Mi dispiace ma non posso venderti nulla . . .")   
		(cons ;2 massimo
			". . . all these electric blackouts damages my cash register."    
			". . . tutti questi blackout m'hanno rotto il registratore.")   
		(cons ;3 andrea
			"Let the electrical system checked."    
			"Ma fallo controllare l'impianto!")   
		(cons ;4 massimo
			"Pff, electrical system."    
			"Ma che impianto!")   
		(cons ;5 massimo
			"I called ENEL and apparently somebody is playing games . . ."    
			"Ho gia' chiamato l'ENEL e m'hanno detto che qualcuno fa il furbo . . .")   
		(cons ;6 andrea
			"What do you mean?"    
			"Ma in che senso?")   
		(cons ;7 massimo
			"Somebody is using all the electricity . . ."    
			"Nel senso che qualcuno sta usando tutta l'elettricita' possibile . . .")   
		(cons ;8 andrea
			"Some people . . ."    
			"Che gente!")   
		(cons ;9 massimo
			"Ah, we are raising some money for Profeta's funeral."    
			"Ah stiamo facendo una raccolta fondi per il funerale del Profeta.")   
		(cons ;10 andrea
			"Which one?"    
			"Quale Profeta?")   
		(cons ;11 massimo
			"The Profeta that has been killed in Piazza Quattro Novembre!"    
			"Quello che e' stato ucciso a piazza Quattro Novembre!")   
		(cons ;12 andrea
			"Which one?"    
			"Ma quale?")   
		(cons ;13 massimo
			"Seriously?"    
			"Ma come quale?")   
		(cons ;14 massimo
			"Are you deficient?"    
			"Ma sei deficiente?")   
		(cons ;15 massimo
			"The guy that has been killed!"    
			"Quello che e' stato ammazzato!")   
		(cons ;16 andrea
			"Ahhhh!"    
			"Ahhhh!")   
		(cons ;17 andrea
			"I see."    
			"Ho capito.")   
		(cons ;18 andrea
			"It happened like a hundred thousand years ago!"    
			"Ma e' successo tipo centomila anni fa!")   
		(cons ;19 massimo
			". . ."    
			". . .")   
		(cons ;20 massimo
			"It happened like five hours ago."    
			"E' successo tipo cinque ore fa.")   
		(cons ;21 andrea
			"Ah."    
			"Ah.")   
		(cons ;22 andrea
			"I have no money."    
			"Non ho soldi.")   
		(cons ;23 massimo
			"I am no surprised."    
			"Non ne sono stupito.")   
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
(puppeteer_disable_control)

;Parameters configuration
(define dialog_done (collector_get "massimo_virus_dialog"))

;Action!
(puppeteer_look "andrea" "massimo")
(puppeteer_look "massimo" "andrea")
(if (= dialog_done 1.0)
  (begin
    (say "massimo" (get_dialog dialogs language 1) "mavirus_track1") ;preview: I am sorry, I cannot sell yo... | looking at Andrea
    (say "massimo" (get_dialog dialogs language 2) "mavirus_track2")) ;preview: . . . all these electric bla... | looking at Andrea
  (begin
    (say "massimo" (get_dialog dialogs language 1) "mavirus_track1") ;preview: I am sorry, I cannot sell yo... | looking at Andrea
    (say "massimo" (get_dialog dialogs language 2) "mavirus_track2") ;preview: . . . all these electric bla... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 3) "mavirus_track3") ;preview: Let the electrical system ch... | looking at Massimo
    (say "massimo" (get_dialog dialogs language 4) "mavirus_track4") ;preview: Pff, electrical system. | looking at Andrea
    (say "massimo" (get_dialog dialogs language 5) "mavirus_track5") ;preview: I called ENEL and apparently... | looking at Andrea
    (puppeteer_set "andrea" "scratch_right")
    (say "andrea" (get_dialog dialogs language 6) "mavirus_track6") ;preview: What do you mean? | looking at Massimo
    (say "massimo" (get_dialog dialogs language 7) "mavirus_track7") ;preview: Somebody is using all the el... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 8) "mavirus_track8") ;preview: Some people . . . | looking at Massimo
    (puppeteer_set "massimo" "point_left")
    (say "massimo" (get_dialog dialogs language 9) "mavirus_track9") ;preview: Ah, we are raising some mone... | looking at Andrea
    (puppeteer_set "massimo" "still_left")
    (say "andrea" (get_dialog dialogs language 10) "mavirus_track10") ;preview: Which one? | looking at Massimo
    (say "massimo" (get_dialog dialogs language 11) "mavirus_track11") ;preview: The Profeta that has been ki... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 12) "mavirus_track12") ;preview: Which one? | looking at Massimo
    (say "massimo" (get_dialog dialogs language 13) "mavirus_track13") ;preview: Seriously? | looking at Andrea
    (puppeteer_set "massimo" "point_left")
    (say "massimo" (get_dialog dialogs language 14) "mavirus_track14") ;preview: Are you deficient? | looking at Andrea
    (puppeteer_set "massimo" "still_left")
    (say "massimo" (get_dialog dialogs language 15) "mavirus_track15") ;preview: The guy that has been killed! | looking at Andrea
    (say "andrea" (get_dialog dialogs language 16) "mavirus_track16") ;preview: Ahhhh! | looking at Massimo
    (say "andrea" (get_dialog dialogs language 17) "mavirus_track17") ;preview: I see. | looking at Massimo
    (say "andrea" (get_dialog dialogs language 18) "mavirus_track18") ;preview: It happened like a hundred t... | looking at Massimo
    (say "massimo" (get_dialog dialogs language 19) "mavirus_track19") ;preview: . . . | looking at Andrea
    (say "massimo" (get_dialog dialogs language 20) "mavirus_track20") ;preview: It happened like five hours ... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 21) "mavirus_track21") ;preview: Ah. | looking at Massimo
    (say "andrea" (get_dialog dialogs language 22) "mavirus_track22") ;preview: I have no money. | looking at Massimo
    (say "massimo" (get_dialog dialogs language 23) "mavirus_track23") ;preview: I am no surprised. | looking at Andrea

    (collector_set "massimo_virus_dialog" 1.0))
  )

;Return the control
(main_control "andrea")
