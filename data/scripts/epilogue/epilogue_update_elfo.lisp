;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : drunkepilogue
;Location   : Elfo Pub
;Author     : Nardinan
;Description: Luca, Andrii and Yuriy are completely drunk at Elfo

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 andrii
			"MA CHE CE FREGA"    
			"MA CHE CE FREGA")   
		(cons ;2 caprini
			"MA CHE CE FREGA"    
			"MA CHE CE FREGA")   
		(cons ;3 yuriy
			"MA CHE CE FREGA"    
			"MA CHE CE FREGA")   
		(cons ;4 andrii
			"MA CHE CE M'PORTA"    
			"MA CHE CE M'PORTA")   
		(cons ;5 caprini
			"MA CHE CE M'PORTA"    
			"MA CHE CE M'PORTA")   
		(cons ;6 yuriy
			"MA CHE CE M'PORTA"    
			"MA CHE CE M'PORTA")   
		(cons ;7 andrii
			"SE L'OSTE NEL VINO C'HA MESSO L'ACQUA!"    
			"SE L'OSTE NEL VINO C'HA MESSO L'ACQUA!")   
		(cons ;8 caprini
			"SE L'OSTE NEL VINO C'HA MESSO L'ACQUA!"    
			"SE L'OSTE NEL VINO C'HA MESSO L'ACQUA!")   
		(cons ;9 yuriy
			"SE L'OSTE NEL VINO C'HA MESSO L'ACQUA!"    
			"SE L'OSTE NEL VINO C'HA MESSO L'ACQUA!")   
		(cons ;10 andrii
			"E NOI JE DIMMO . . ."    
			"E NOI JE DIMMO . . .")   
		(cons ;11 caprini
			"E NOI JE DIMMO . . ."    
			"E NOI JE DIMMO . . .")   
		(cons ;12 yuriy
			"E NOI JE DIMMO . . ."    
			"E NOI JE DIMMO . . .")   
		(cons ;13 andrii
			"E NOI JE FAMMO . . ."    
			"E NOI JE FAMMO . . .")   
		(cons ;14 caprini
			"E NOI JE FAMMO . . ."    
			"E NOI JE FAMMO . . .")   
		(cons ;15 yuriy
			"E NOI JE FAMMO . . ."    
			"E NOI JE FAMMO . . .")   
		(cons ;16 andrii
			"C'HAI MESSO L'ACQUA E NUN TE PAGAMO MA PERO'"    
			"C'HAI MESSO L'ACQUA E NUN TE PAGAMO MA PERO'")   
		(cons ;17 caprini
			"C'HAI MESSO L'ACQUA E NUN TE PAGAMO MA PERO'"    
			"C'HAI MESSO L'ACQUA E NUN TE PAGAMO MA PERO'")   
		(cons ;18 yuriy
			"C'HAI MESSO L'ACQUA E NUN TE PAGAMO MA PERO'"    
			"C'HAI MESSO L'ACQUA E NUN TE PAGAMO MA PERO'")   
		(cons ;19 andrii
			"NOI SEMO QUELLI . . ."    
			"NOI SEMO QUELLI . . .")   
		(cons ;20 caprini
			"NOI SEMO QUELLI . . ."    
			"NOI SEMO QUELLI . . .")   
		(cons ;21 yuriy
			"NOI SEMO QUELLI . . ."    
			"NOI SEMO QUELLI . . .")   
		(cons ;22 andrii
			"CHE JE RISPONDEMO 'N COROOOOOOOO"    
			"CHE JE RISPONDEMO 'N COROOOOOOOO")   
		(cons ;23 caprini
			"CHE JE RISPONDEMO 'N COROOOOOOOO"    
			"CHE JE RISPONDEMO 'N COROOOOOOOO")   
		(cons ;24 yuriy
			"CHE JE RISPONDEMO 'N COROOOOOOOO"    
			"CHE JE RISPONDEMO 'N COROOOOOOOO")   
		(cons ;25 andrii
			"E' MEJO ER VINOOOOO"    
			"E' MEJO ER VINOOOOO")   
		(cons ;26 caprini
			"E' MEJO ER VINOOOOO"    
			"E' MEJO ER VINOOOOO")   
		(cons ;27 yuriy
			"E' MEJO ER VINOOOOO"    
			"E' MEJO ER VINOOOOO")   
		(cons ;28 andrii
			"DE LI CASTELLI!"    
			"DE LI CASTELLI!")   
		(cons ;29 caprini
			"DE LI CASTELLI!"    
			"DE LI CASTELLI!")   
		(cons ;30 yuriy
			"DE LI CASTELLI!"    
			"DE LI CASTELLI!")   
		(cons ;31 andrii
			"DE QUESTA ZOZZA SOCIETAAAAAAA!"    
			"DE QUESTA ZOZZA SOCIETAAAAAAA!")   
		(cons ;32 caprini
			"DE QUESTA ZOZZA SOCIETAAAAAAA!"    
			"DE QUESTA ZOZZA SOCIETAAAAAAA!")   
		(cons ;33 yuriy
			"DE QUESTA ZOZZA SOCIETAAAAAAA!"    
			"DE QUESTA ZOZZA SOCIETAAAAAAA!")   
		(cons ;34 andrea
			"Ehy, what are you doing?"    
			"Ehy, che state facendo?")   
		(cons ;35 andrii
			"Chieshieshe."    
			"Coshieshieshe.")   
		(cons ;36 andrea
			"What?"    
			"Cosa?")   
		(cons ;37 andrii
			"I am shaying . . ."    
			"No dico . . .")   
		(cons ;38 andrii
			". . . we are having a pharshty."    
			". . . festesshiamo tutti inshieme.")   
		(cons ;39 andrea
			"Are you drunk?"    
			"Ah sei ubriaco?")   
		(cons ;40 andrii
			"Yes."    
			"Si.")   
		(cons ;41 andrea
			"OK."    
			"OK.")   
		(cons ;42 yuriy
			"I am drinshking to the enshd of the woooorld."    
			"Io festesshio la fine del mooooondo.")   
		(cons ;43 andrea
			"You're drinking a lot, aren't you?"    
			"Si beve eh?")   
		(cons ;44 yuriy
			"I shamh!"    
			"Shi!")   
		(cons ;45 andrea
			"Good job!"    
			"Ma che bravi!")   
		(cons ;46 caprini
			"I don't know."    
			"Guarda non lo so.")   
		(cons ;47 caprini
			"The tall guy is buying me a lots of drinks."    
			"Quello alto offre da bere.")   
		(cons ;48 caprini
			"I am drinking."    
			"Io bevo.")   
		(cons ;49 andrea
			"Amazing!"    
			"Daje!")   
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
(define epilogue_andrii_ongoing                           (collector_get "epilogue_andrii_ongoing"))
(define epilogue_yuriy_ongoing                            (collector_get "epilogue_yuriy_ongoing"))
(define epilogue_caprini_ongoing                          (collector_get "epilogue_caprini_ongoing"))
(define epilogue_andrii_yuriy_and_caprini_line            (collector_get "epilogue_andrii_yuriy_and_caprini_line"))
(define epilogue_andrii_yuriy_and_caprini_line_next_line  (+ epilogue_andrii_yuriy_and_caprini_line 1.0))

;@brief: song_society_of_big_magnaccias <dialog list> <language> <line of the song>
;@description: Andrii, Yuriy and Caprini sing the Society of Big Magniaccias' song
(define song_society_of_big_magnaccias
  (lambda (d lang n)
    (begin
      (if (= epilogue_andrii_ongoing 1.0)
        nil
        (begin
          (puppeteer_set "andrii"  "drink_right")
          (say_and_go "andrii" (get_dialog d lang   (+ (* n 3) 1))))
        )
      (if (= epilogue_yuriy_ongoing 1.0)
        nil
        (begin
          (puppeteer_set "yuriy"   "drink_left")
          (say_and_go "yuriy" (get_dialog d lang    (+ (* n 3) 2))))
        )
      (if (= epilogue_caprini_ongoing 1.0)
        nil
        (begin
          (puppeteer_set "caprini" "drink_left")
          (say_and_go "caprini" (get_dialog d lang  (+ (* n 3) 3))))
        ))
    )
  )

;Action!
(song_society_of_big_magnaccias dialogs language epilogue_andrii_yuriy_and_caprini_line)
(director_wait_message "andrii")
(director_wait_message "caprini")
(director_wait_message "yuriy")

;Configure environment for the next hop
(if (> epilogue_andrii_yuriy_and_caprini_line_next_line 10.0)
  (collector_set "epilogue_andrii_yuriy_and_caprini_line" 0.0)
  (collector_set "epilogue_andrii_yuriy_and_caprini_line" epilogue_andrii_yuriy_and_caprini_line_next_line)
  )
