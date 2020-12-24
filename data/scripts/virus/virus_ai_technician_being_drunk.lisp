;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : techdrivirus
;Location   : Lupattelli
;Author     : Nardinan
;Description: The guy drinks the altered cocktail and gives you the key

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 technician
			"Oh god . . ."    
			"Oddio . . .")   
		(cons ;2 technician
			". . . what did you put inside that . . ."    
			". . . ma che c'era in quel . . .")   
		(cons ;3 technician
			". . . COCKTAIL."    
			". . . COCKTAIL.")   
		(cons ;4 technician
			"I . . ."    
			"Io . . .")   
		(cons ;5 technician
			"Everything is so strange."    
			"Io vedo tutto strano.")   
		(cons ;6 technician
			"Everything is so bad!"    
			"Io vedo tutto male!")   
		(cons ;7 technician
			"What what what?"    
			"Cosa cosa cosa?!")   
		(cons ;8 andrea
			"Uh?"    
			"Eh?")   
		(cons ;9 technician
			"What did you just say?"    
			"Cosa hai detto?")   
		(cons ;10 andrea
			"I didn't say anything!"    
			"Io non ho detto niente!")   
		(cons ;11 technician
			"Eeeeeeeh, come on!"    
			"Eeeeeeh, come no!")   
		(cons ;12 technician
			"You said a lot of stuff."    
			"Tu hai detto un sacco di cose.")   
		(cons ;13 technician
			"You're a funny person!"    
			"Sei una persona simpatica!")   
		(cons ;14 andrea
			"Hey, thanks!"    
			"Hey grazie!")   
		(cons ;15 andrea
			"Can I have the key of the ENEL's cabin in Viale Innamorati now?"    
			"Mi daresti la chiave della cabina ENEL di Viale Innamorati ora?")   
		(cons ;16 technician
			"Sure, I'll put them into your beard."    
			"Certo, te l'appendo sulla barba.")   
		(cons ;17 andrea
			"Eh?"    
			"Eh?")   
		(cons ;18 technician
			"Your scruffy beard from years of . . ."    
			"Sulla barba incolta da anni di . . .")   
		(cons ;19 technician
			". . . missed shaving."    
			". . . rasature mancate.")   
		(cons ;20 andrea
			"Thankfully they were only expired sleeping pills."    
			"Per fortuna erano solo sonniferi scaduti . . .")   
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
(define animation_done      (collector_get "technician_virus_animation"))
(define done_cabin_key      (collector_get "done_cabin_key"))
(define andrea_position     (puppeteer_get_position "andrea"))
(define technician_position (puppeteer_get_position "technician"))

;Calculate position of the technician in respect of andrea
(define drink_side "drink_left")
(define drunk_side "drunk_left")
(if (> andrea_position technician_position)
  (begin
    (set drink_side "drink_right")
    (set drunk_side "drunk_right"))
  nil
  )

;Action!
(if (= animation_done 1.0)
  nil
  (if (= done_cabin_key 1.0)
    (begin
      (puppeteer_stare "technician" "#null")
      (puppeteer_set "technician" drink_side)
      (director_wait_time 2.0)
      (say "technician" (get_dialog dialogs language 1) "techdrivirus_track1") ;preview: Oh god . . . | looking at Andrea
      (say "technician" (get_dialog dialogs language 2) "techdrivirus_track2") ;preview: . . . what did you put insid... | looking at Andrea
      (say "technician" (get_dialog dialogs language 3) "techdrivirus_track3") ;preview: . . . COCKTAIL. | looking at Andrea
      (puppeteer_set "technician" drunk_side)
      (say "technician" (get_dialog dialogs language 4) "techdrivirus_track4") ;preview: I . . . | looking at Andrea
      (say "technician" (get_dialog dialogs language 5) "techdrivirus_track5") ;preview: Everything is so strange. | looking at Andrea
      (say "technician" (get_dialog dialogs language 6) "techdrivirus_track6") ;preview: Everything is so bad! | looking at Andrea
      (say "technician" (get_dialog dialogs language 7) "techdrivirus_track7") ;preview: What what what? | looking at Andrea
      (say "andrea" (get_dialog dialogs language 8) "techdrivirus_track8") ;preview: Uh? | looking at Andrea | animation scratching his head
      (say "technician" (get_dialog dialogs language 9) "techdrivirus_track9") ;preview: What did you just say? | looking at Andrea
      (say "andrea" (get_dialog dialogs language 10) "techdrivirus_track10") ;preview: I didn't say anything! | looking at Andrea
      (say "technician" (get_dialog dialogs language 11) "techdrivirus_track11") ;preview: Eeeeeeeh, come on! | looking at Andrea
      (say "technician" (get_dialog dialogs language 12) "techdrivirus_track12") ;preview: You said a lot of stuff. | looking at Andrea
      (say "technician" (get_dialog dialogs language 13) "techdrivirus_track13") ;preview: You're a funny person! | looking at Andrea
      (say "andrea" (get_dialog dialogs language 14) "techdrivirus_track14") ;preview: Hey, thanks! | looking at Technician | animation pointing
      (say "andrea" (get_dialog dialogs language 15) "techdrivirus_track15") ;preview: Can I have the key of the EN... | looking at Technician
      (say "technician" (get_dialog dialogs language 16) "techdrivirus_track16") ;preview: Sure, I'll put them into you... | looking at Andrea
      (say "andrea" (get_dialog dialogs language 17) "techdrivirus_track17") ;preview: Eh? | looking at Technician | animation scratching his head
      (say "technician" (get_dialog dialogs language 18) "techdrivirus_track18") ;preview: Your scruffy beard from year... | looking at Andrea
      (say "technician" (get_dialog dialogs language 19) "techdrivirus_track19") ;preview: . . . missed shaving. | looking at Andrea
      (say "andrea" (get_dialog dialogs language 20) "techdrivirus_track20") ;preview: Thankfully they were only ex... | animation front

      ;And never again
      (collector_set "technician_virus_animation" 1.0))
    nil
    )
  )

;Refresh interface
(director_script "update_items_interface")

;Return the control
(main_control "andrea")
