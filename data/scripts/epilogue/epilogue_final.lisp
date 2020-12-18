;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 PD
			"With the aim at passing the Artificial Intelligence test"    
			"Nell'intento di passare l'esame di intelligenza artificiale")   
		(cons ;2 PD
			"I was there, writing an algorithm in ML to beat"    
			"ero li, a scrivere in ML un algoritmo per battere")   
		(cons ;3 PD
			"the professor at 'connect four'"    
			"il professore a forza quattro")   
		(cons ;4 PD
			"But nothing, it was not working"    
			"Ma niente, non funzionava")   
		(cons ;5 PD
			"So I decided to take a cue from Pinterest!"    
			"Cosi' ho deciso di prendere qualche spunto da Pinterest!")   
		(cons ;6 PD
			"Among all the articles, I found a very interesting one"    
			"Tra tutti gli articoli, ne ho trovato uno veramente interessante")   
		(cons ;7 PD
			"The article, step by step, explained how to remove"    
			"L'articolo, passo dopo passo, spiegava come rimuovere")   
		(cons ;8 PD
			"a human brain in safety"    
			"un cervello umano in tutta sicurezza")   
		(cons ;9 PD
			"At that point I thought: why don't use a human brain"    
			"A quel punto ho pensato: perche' non usare un cervello umano")   
		(cons ;10 PD
			"to beat the professor and pass the test?"    
			"per battere il professore e passare l'esame?")   
		(cons ;11 PD
			"The plan was ther, but the guinea pig was still missing ..."    
			"Il piano era li, ma mancava la vittima sacrificale ...")   
		(cons ;12 PD
			"... The brain was not there!"    
			"... mancava il cervello!")   
		(cons ;13 PD
			"So I took advantage of the only available person"    
			"Cosi' ho approfittato dell'unica persona disponibile")   
		(cons ;14 PD
			"at that moment ..."    
			"in quel momento ...")   
		(cons ;15 PD
			"Bruno!"    
			"Bruno!")   
		(cons ;16 PD
			"A small hit to the head and, as the French say:"    
			"Un lieve colpo alla testa e, come dicono i francesi:")   
		(cons ;17 PD
			"Le Jeux sont faits!"    
			"Le Jeux sont faits!")   
		(cons ;18 PD
			"Following carefully the instruction I opened his head ..."    
			"Seguendo con attenzione le istruzioni ho aperto la sua testa ...")   
		(cons ;19 PD
			"... and I removed the brain"    
			"... e ho estratto il cervello")   
		(cons ;20 PD
			"However I could not risk to start a murder investigation,"    
			"Non potevo pero' rischiare di far partire un indagine per omicidio,")   
		(cons ;21 PD
			"so I had to put back Bruno on the road!"    
			"cosi' dovevo rimettere Bruno in circolazione!")   
		(cons ;22 PD
			"I quickly wrote an Artificial Intelligence in order to simulate"    
			"Ho velocemente scritto un'intelligenza artificiale che simulasse il")   
		(cons ;23 PD
			"Bruno's behavior"    
			"comportamento di Bruno")   
		(cons ;24 PD
			"And I installed it!"    
			"E l'ho installata!")   
		(cons ;25 PD
			"But my fill of brains was still up and running ..."    
			"Ma la mia sete di cervelli non si si e' spenta ...")   
		(cons ;26 PD
			"... even more ...."    
			"... anzi ...")   
		(cons ;27 PD
			"So, I ordered Bruno to bring here as much people as he can and,"    
			"Cosi' ho ordinato a Bruno di recuperare tutte le persone possibili e,")   
		(cons ;28 PD
			"with his help and the help of the fake ads that I attached around the city"    
			"con il suo aiuto e quello dei finiti annunci sparsi per la citta'")   
		(cons ;29 PD
			"I am becoming a supercomputer!"    
			"sto diventando un super computer!")   
		(cons ;30 PD
			"My goal: conquer the world"    
			"Il mio obiettivo: conquistare il mondo!")   
		nil
		))

;High level functions
;@brief: subtitle <effect name> <line> <string>
;@description: shows a subtitle on the screen
(define subtitle
  (lambda (name l s)
    (begin
      (effecteer_write name s 10 t (+ 820 (* (-l 1) 60)) 1.5 1 0)
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

;Stop everything
(effecteer_stop   "stone_paradise")
(effecteer_add    "clear_out" "fade_out" (+ 480 450) (+ 360 180) 4 0 t t)
(director_wait_time 3)
(effecteer_delete "stone_paradise")

;Music
(effecteer_play "and_now" "and_now" 2000 2000 8 nil)
(director_wait_time 2)

;Slide number one
(effecteer_add   "slide0A"    "epilogue_1_middle" -1000 -500 1.0 0 t t)
(effecteer_play  "message1"  "epilogue_temple01" 0 0 128 nil)
(subtitle "subtitle1" 1 (get_dialog dialogs language 1))
(subtitle "subtitle2" 2 (get_dialog dialogs language 2))
(subtitle "subtitle3" 3 (get_dialog dialogs language 3))
(director_wait_time 9)
(effecteer_delete "subtitle1")
(director_wait_time 1)
(effecteer_delete "subtitle2")
(director_wait_time 1)
(effecteer_delete "subtitle3")
(director_wait_time 1)
(effecteer_play "message2" "epilogue_temple02" 0 0 128 nil)
(subtitle "subtitle1" 3 (get_dialog dialogs language 4))
(director_wait_time 2)
(effecteer_delete "subtitle1")
(director_wait_time 1)
(effecteer_play "message3" "epilogue_temple03" 0 0 128 nil)
(subtitle "subtitle1" 3 (get_dialog dialogs language 5))
(director_wait_time 4)
(effecteer_delete "subtitle1")
(director_wait_time 1)
(effecteer_play "message4" "epilogue_temple04" 0 0 128 nil)
(subtitle "subtitle1" 3 (get_dialog dialogs language 6))
(director_wait_time 6)
(effecteer_delete "subtitle1")
(director_wait_time 1)
(effecteer_delete "subtitle2")
(director_wait_time 1)
(effecteer_delete "slide0A")
(effecteer_delete "message1")
(effecteer_delete "message2")
(effecteer_delete "message3")
(effecteer_delete "message4")

;Slide number two
(effecteer_add "slide0B"     "epilogue_2_middle" -1000  -500 1.0 0 t t)
(effecteer_play "message1"  "epilogue_temple05" 0 0 128 nil)
(subtitle "subtitle1" 2 (get_dialog dialogs language 7))
(subtitle "subtitle2" 3 (get_dialog dialogs language 8))
(director_wait_time 8)
(effecteer_delete "subtitle1")
(director_wait_time 1)
(effecteer_delete "subtitle2")
(director_wait_time 6)
(effecteer_delete "slide0B")
(effecteer_delete "message1")

;Slide number three
(effecteer_add "slide0C"     "epilogue_3_middle" -1000  -500 1.0 0 t t)
(effecteer_play "message1"  "epilogue_temple06" 0 0 128 nil)
(subtitle "subtitle1" 2 (get_dialog dialogs language 9))
(subtitle "subtitle2" 3 (get_dialog dialogs language 10))
(director_wait_time 6)
(effecteer_delete "subtitle1")
(director_wait_time 1)
(effecteer_delete "subtitle2")
(director_wait_time 1)
(effecteer_play "message2"  "epilogue_temple07" 0 0 128 nil)
(subtitle "subtitle1" 2 (get_dialog dialogs language 11))
(subtitle "subtitle2" 3 (get_dialog dialogs language 12))
(director_wait_time 4)
(effecteer_delete "subtitle1")
(director_wait_time 1)
(effecteer_delete "subtitle2")
(director_wait_time 1)
(effecteer_play "message3"  "epilogue_temple08" 0 0 128 nil)
(subtitle "subtitle1" 2 (get_dialog dialogs language 13))
(subtitle "subtitle2" 3 (get_dialog dialogs language 14))
(director_wait_time 4)
(effecteer_delete "subtitle1")
(director_wait_time 1)
(effecteer_delete "subtitle2")
(director_wait_time 1)
(effecteer_delete "slide0C")
(effecteer_delete "message1")
(effecteer_delete "message2")
(effecteer_delete "message3")

;Slide number four
(director_atomic)
(effecteer_add "test1D" "epilogue_4_background" -1000  -500 1.0 0 t t)
(effecteer_add "test2D" "epilogue_4_middle"     -500   -500 1.0 0 t t)
(effecteer_add "test3D" "epilogue_4_front"      -500   -500 1.0 0 t t)
(director_atomic)
(effecteer_play "message1" "epilogue_temple09" 0 0 128 nil)
(subtitle "subtitle1" 3 (get_dialog dialogs language 15))
(director_wait_time 3)
(effecteer_delete "subtitle1")
(director_wait_time 8)
(effecteer_delete "message1")
(effecteer_delete "test1D")
(effecteer_delete "test2D")
(effecteer_delete "test3D")

;Slide number five
(director_atomic)
(effecteer_add "test1E" "epilogue_5_background" -1000  -500 1.0 0 t t)
(effecteer_add "test2E" "epilogue_5_middle"     -500   -500 1.0 0 t t)
(effecteer_add "test3E" "epilogue_5_front"      -500   -500 1.0 0 t t)
(director_atomic)
(effecteer_play "message1" "epilogue_temple10" 0 0 128 nil)
(subtitle "subtitle1" 2 (get_dialog dialogs language 16))
(subtitle "subtitle2" 3 (get_dialog dialogs language 17))
(director_wait_time 6)
(effecteer_delete "subtitle1")
(director_wait_time 1)
(effecteer_delete "subtitle2")
(director_wait_time 4)
(effecteer_delete "message1")
(effecteer_delete "test1E")
(effecteer_delete "test2E")
(effecteer_delete "test3E")

;Slide number six
(effecteer_add "slide0F" "epilogue_6_middle"     -1000  -500 1.0 0 t t)
(effecteer_play "message1" "epilogue_temple11" 0 0 128 nil)
(subtitle "subtitle1" 3 (get_dialog dialogs language 18))
(director_wait_time 4)
(effecteer_delete "subtitle1")
(director_wait_time 12)
(effecteer_delete "message1")
(effecteer_delete "slide0F")

;Slide number seven
(effecteer_add "slide0G" "epilogue_7_middle"     -1000  -500 1.0 0 t t)
(effecteer_play "message1" "epilogue_temple12" 0 0 128 nil)
(subtitle "subtitle1" 3 (get_dialog dialogs language 19))
(director_wait_time 4)
(effecteer_delete "subtitle1")
(director_wait_time 7)
(effecteer_delete "message1")
(effecteer_delete "slide0G")

(effecteer_play "message1" "epilogue_temple13" 0 0 128 nil)
(subtitle "subtitle1" 2 (get_dialog dialogs language 20))
(subtitle "subtitle2" 3 (get_dialog dialogs language 21))
(director_wait_time 5)
(effecteer_delete "subtitle1")
(director_wait_time 1)
(effecteer_delete "subtitle2")
(director_wait_time 1)
(effecteer_play "message2" "epilogue_temple14" 0 0 128 nil)
(subtitle "subtitle1" 2 (get_dialog dialogs language 22))
(subtitle "subtitle2" 3 (get_dialog dialogs language 23))
(director_wait_time 3)
(effecteer_delete "subtitle1")
(director_wait_time 1)
(effecteer_delete "subtitle2")
(director_wait_time 1)
(effecteer_delete "message1")
(effecteer_delete "message2")

;Slide number eight
(effecteer_add "slide0H" "epilogue_8_middle"     -1000  -500 1.0 0 t t)
(effecteer_play "message1" "epilogue_temple15" 0 0 128 nil)
(subtitle "subtitle1" 3 (get_dialog dialogs language 24))
(director_wait_time 2)
(effecteer_delete "subtitle1")
(director_wait_time 12)
(effecteer_delete "message1")
(effecteer_delete "slide0H")


(effecteer_play "message1" "epilogue_temple16" 0 0 128 nil)
(subtitle "subtitle1" 2 (get_dialog dialogs language 25))
(subtitle "subtitle2" 3 (get_dialog dialogs language 26))
(director_wait_time 2)
(effecteer_delete "subtitle1")
(director_wait_time 1)
(effecteer_delete "subtitle2")
(director_wait_time 1)
(effecteer_delete "message1")

;Slide number nine
(effecteer_add "slide0I" "epilogue_9_middle"     -1000  -500 1.0 0 t t)
(effecteer_play "message1" "epilogue_temple17" 0 0 128 nil)
(subtitle "subtitle1" 1 (get_dialog dialogs language 27))
(subtitle "subtitle2" 2 (get_dialog dialogs language 28))
(subtitle "subtitle3" 3 (get_dialog dialogs language 29))
(director_wait_time 15)
(effecteer_delete "subtitle1")
(director_wait_time 1)
(effecteer_delete "subtitle2")
(director_wait_time 1)
(effecteer_delete "subtitle3")
(director_wait_time 1)
(effecteer_delete "message1")
(effecteer_delete "message2")
(effecteer_delete "message3")
(effecteer_delete "slide0I")

(effecteer_play "message1" "epilogue_temple18" 0 0 128 nil)
(subtitle "subtitle1" 3 (get_dialog dialogs language 30))
(director_wait_time 4)
(effecteer_delete "subtitle1")
(director_wait_time 3)
(effecteer_delete "message1")

(effecteer_delete "and_now")

;Wait for the end of the epilogue animation
(effecteer_play "the_duel" "the_duel" 2000 2000 16)
(effecteer_delete "clear_out")

;Move to the next act
(collector_set "temple_part_two" 1.0)
(director_script "epilogue_intro_temple")
