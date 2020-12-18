;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : polcen
;Location   : Piazza IV Novembre
;Author     : Nardinan
;Description: The policeman explains to Andrea about the omicide of the ""Il Profeta""

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 poliziotto
			"Keep moving, there is nothing to see here!"    
			"Circolare, qui non c'e' niente da vedere!")   
		(cons ;2 andrea
			"Probably you see nothing . . ."    
			"Tu magari non vedi niente . . .")   
		(cons ;3 andrea
			"But, apparently, somebody died here!"    
			"Ma a me sembra che qualcuno qui sia morto")   
		(cons ;4 poliziotto
			"My 'there is nothing to see here' was a polite way to kick you out"    
			"Il mio 'non c'e' niente da vedere' e' un modo delicato per dirti di andartene, sai?")   
		(cons ;5 andrea
			"Do you have some hairs there, under your hat?"    
			"Ci sono dei capelli sotto il tuo cappello?")   
		(cons ;6 poliziotto
			"We'll never know . . ."    
			"Non lo scopriremo mai . . .")   
		(cons ;7 andrea
			"OK Kojak, who is dead here?"    
			"Va bene Kojak, chi e' morto qui?")   
		(cons ;8 poliziotto
			"No one you know. Now, please . . ."    
			"Nessuno che conosci, ora cortesemente . . .")   
		(cons ;9 andrea
			"How can you say something like that?"    
			"Come puoi dire una cosa del genere?")   
		(cons ;10 andrea
			"I know everybody here in town!"    
			"Conosco praticamente tutti qui!")   
		(cons ;11 poliziotto
			"OK, do you know 'il Profeta'?"    
			"Bene, hai presente 'il Profeta'?")   
		(cons ;12 andrea
			"Nope"    
			"No")   
		(cons ;13 poliziotto
			"Is that guy that was going around in the city center screaming things"    
			"E' un tizio che girava qui per la piazza, profetizzando cose")   
		(cons ;14 poliziotto
			"Bad things"    
			"Spesso cose brutte")   
		(cons ;15 andrea
			"I've never heard of him"    
			"Mai sentito")   
		(cons ;16 poliziotto
			"Oh, came on! He was walking around here, with a Bible in his hand, screaming about an apocalypse that would arrive soon"    
			"Dai, girava sempre qui, con una bibbia in mano, dicendo che l'apocalisse sarebbe giunta a breve")   
		(cons ;17 andrea
			"Uh"    
			"Uh")   
		(cons ;18 poliziotto
			"However is him"    
			"Comunque e' lui")   
		(cons ;19 andrea
			"Where is his bible?"    
			"E dov'e' la sua bibbia?")   
		(cons ;20 poliziotto
			"Stolen"    
			"Rubata")   
		(cons ;21 andrea
			"Did he die of natural causes?"    
			"Morto di cause naturali?")   
		(cons ;22 poliziotto
			"He has been stabbed in the back. Is it a natural cause?"    
			"Se una coltellata alla schiena e' una causa naturale, allora si")   
		(cons ;23 andrea
			"Suspects?"    
			"Sospetti?")   
		(cons ;24 poliziotto
			"Yes, you."    
			"Si, te")   
		(cons ;25 andrea
			"Thanks, I'm going to go!"    
			"Grazie, tolgo il disturbo!")   
		(cons ;26 poliziotto
			"You're still here? Do you want to get arrested?"    
			"Ancora qui? Vuoi essere arrestato?")   
		(cons ;27 andrea
			"I want to be loved . . ."    
			"Vorrei solo essere amato . . .")   
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
(define intro_policeman_november (collector_get "intro_policeman_november"))

;Action!
(if (= intro_policeman_november 1.0)
  (begin
    (puppeteer_look "policeman" "andrea")
    (puppeteer_look "andrea" "policeman")
    (say "policeman" (get_dialog dialogs language 26) "polcen_track1") ;preview: You're still here? Do you wa... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 27) "polcen_track2") ;preview: Vorrei solo essere amato . . . | looking at Poliziotto
    (puppeteer_set "policeman" "front"))
  (begin
    (puppeteer_move "andrea" 2700)
    (director_wait_movement "andrea")
    (puppeteer_set "andrea" "still_right")
    (say "policeman" (get_dialog dialogs language 1) "polcen_track1") ;preview: Keep moving, there is nothin... | animation front
    (puppeteer_set "andrea" "point_right")
    (say "andrea" (get_dialog dialogs language 2) "polcen_track2") ;preview: Probably you see nothing . . . | looking at Poliziotto | animation pointing
    (puppeteer_set "andrea" "back")
    (say "andrea" (get_dialog dialogs language 3) "polcen_track3") ;preview: But, apparently, somebody di... | animation back
    (puppeteer_set "andrea" "still_right")
    (puppeteer_set "policeman" "still_left")
    (say "policeman" (get_dialog dialogs language 4) "polcen_track4") ;preview: My ""there is nothing to see... | looking at Andrea
    ;Script suggestion: I due si guardano in silenzio
    (director_wait_time 3)
    (puppeteer_set "andrea" "point_right")
    (say "andrea" (get_dialog dialogs language 5) "polcen_track5") ;preview: Do you have some hairs there... | looking at Poliziotto
    (puppeteer_set "andrea" "still_right")
    (say "policeman" (get_dialog dialogs language 6) "polcen_track6") ;preview: We'll never know . . . | looking at Andrea
    (director_wait_time 2)
    (puppeteer_set "andrea" "back")
    (say "andrea" (get_dialog dialogs language 7) "polcen_track7") ;preview: OK Kojak, who is dead here? | animation back
    (say "policeman" (get_dialog dialogs language 8) "polcen_track8") ;preview: No one you know. Now, please... | looking at Andrea
    (puppeteer_set "andrea" "scratch_right")
    (say "andrea" (get_dialog dialogs language 9) "polcen_track9") ;preview: How can you say something li... | looking at Poliziotto
    (puppeteer_set "andrea" "point_right")
    (say "andrea" (get_dialog dialogs language 10) "polcen_track10") ;preview: I know everybody here in town! | looking at Poliziotto
    (puppeteer_set "andrea" "still_right")
    (puppeteer_set "policeman" "point_left")
    (say "policeman" (get_dialog dialogs language 11) "polcen_track11") ;preview: OK, do you know 'il Profeta'? | looking at Andrea
    (puppeteer_set "policeman" "still_left")
    (puppeteer_set "andrea" "scratch_right")
    (say "andrea" (get_dialog dialogs language 12) "polcen_track12") ;preview: Nope | looking at Poliziotto | animation scratching his head
    (puppeteer_set "andrea" "still_right")
    (say "policeman" (get_dialog dialogs language 13) "polcen_track13") ;preview: Is that guy that was going a... | looking at Andrea
    (say "policeman" (get_dialog dialogs language 14) "polcen_track14") ;preview: Bad things | looking at Andrea
    (puppeteer_set "andrea" "scratch_right")
    (say "andrea" (get_dialog dialogs language 15) "polcen_track15") ;preview: I've never heard of him | looking at Poliziotto
    (puppeteer_set "andrea" "still_right")
    (say "policeman" (get_dialog dialogs language 16) "polcen_track16") ;preview: Oh, came on! He was walking ... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 17) "polcen_track17") ;preview: Uh | animation back
    (puppeteer_set "policeman" "front")
    (say "policeman" (get_dialog dialogs language 18) "polcen_track18") ;preview: However is him | looking at Andrea
    (say "andrea" (get_dialog dialogs language 19) "polcen_track19") ;preview: Where is his bible? | animation back
    (say "policeman" (get_dialog dialogs language 20) "polcen_track20") ;preview: Stolen | animation front
    (say "andrea" (get_dialog dialogs language 21) "polcen_track21") ;preview: Did he die of natural causes? | looking at Poliziotto
    (say "policeman" (get_dialog dialogs language 22) "polcen_track22") ;preview: He has been stabbed in the b... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 23) "polcen_track23") ;preview: Suspects? | looking at Poliziotto
    (puppeteer_set "policeman" "point_left")
    (say "policeman" (get_dialog dialogs language 24) "polcen_track24") ;preview: Yes, you. | looking at Andrea | animation pointing
    (puppeteer_set "policeman" "still_left")
    (say "andrea" (get_dialog dialogs language 25) "polcen_track25") ;preview: Thanks, I'm going to go! | looking at Poliziotto
    (puppeteer_set "policeman" "front")

    ;And never again
    (collector_set "intro_policeman_november" 1))
  )

;Return the control
(main_control "andrea")
