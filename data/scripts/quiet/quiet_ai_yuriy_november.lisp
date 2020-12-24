;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : yuriyttquiet
;Location   : Piazza IV Novembre
;Author     : Nardinan
;Description: There are other time travelers in the city, and Yuriy knows

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 yuriy
			"Seems that we have other time travelers around the city!"    
			"Apparentemente ci sono altri viaggiatori del tempo in giro per la citta!")   
		(cons ;2 yuriy
			"Probably there is someone that helps them to access this specific time."    
			"Sembra che qualcuno permetta loro di entrare in questo preciso periodo.")   
		(cons ;3 andrea
			"Will we ever meet somewhere in the future?"    
			"Ma io e te ci conosceremo in futuro?")   
		(cons ;4 yuriy
			"Yes."    
			"Si.")   
		(cons ;5 yuriy
			"And you will convince me that Java is the best programming language in the world."    
			"E tu mi convincerai che Java e' il miglior linguaggio del mondo.")   
		(cons ;6 andrea
			"Me?"    
			"Io?")   
		(cons ;7 andrea
			"Java?"    
			"Java?")   
		(cons ;8 andrea
			"Oh God . . ."    
			"Gesu' . . .")   
		(cons ;9 yuriy
			"The city is full of time travelers!"    
			"La citta' e' piena di viaggiatori del tempo!")   
		(cons ;10 yuriy
			"Somebody is letting them in . . ."    
			"Qualcuno li sta lasciando entrare . . .")   
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
(define yuriy_quiet_dialog_november (collector_get "yuriy_quiet_dialog_november"))

;Action!
(puppeteer_look "andrea" "yuriy")
(puppeteer_look "yuriy" "andrea")
(if (= yuriy_quiet_dialog_november 1.0)
  (begin
    (say "yuriy" (get_dialog dialogs language 9) "yuriyttquiet_track9") ;preview: The city is full of time tra... | looking at Andrea
    (say "yuriy" (get_dialog dialogs language 10) "yuriyttquiet_track10")) ;preview: Somebody is letting them in ... | looking at Andrea
  (begin
    (say "yuriy" (get_dialog dialogs language 1) "yuriyttquiet_track1") ;preview: Seems that we have other tim... | looking at Andrea
    (say "yuriy" (get_dialog dialogs language 2) "yuriyttquiet_track2") ;preview: Probably there is someone th... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 3) "yuriyttquiet_track3") ;preview: Will we meet somewhere in th... | looking at Yuriy
    (say "yuriy" (get_dialog dialogs language 4) "yuriyttquiet_track4") ;preview: Yes. | looking at Andrea
    (say "yuriy" (get_dialog dialogs language 5) "yuriyttquiet_track5") ;preview: And you will convince me tha... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 6) "yuriyttquiet_track6") ;preview: Me? | looking at Yuriy
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 7) "yuriyttquiet_track7") ;preview: Java? | animation front
    (puppeteer_set "andrea" "scratch_front")
    (say "andrea" (get_dialog dialogs language 8) "yuriyttquiet_track8") ;preview: Oh God . . . | animation scratching his head

    ;And never again
    (collector_set "yuriy_quiet_dialog_november" 1.0))
  )

;Character Yuriy stare at Andrii
(puppeteer_look "yuriy" "andrii")

;Return the control
(main_control "andrea")
