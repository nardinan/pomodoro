;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : lunquiet
;Location   : Gallenga
;Author     : Madmoon
;Description: Andrea meets for the very first time Luna at Gallenga. She is on her break and she heard about something that happend in the city center

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 luna
   "What do you do here?"
   "Che ci fai da queste parti?")
  (cons ;2 andrea
   "I'm looking for some stuff"
   "Sto cercando cose")
  (cons ;3 luna
   "Money for a bill, I suppose!"
   "Soldi per una bolletta, suppongo!")
  (cons ;4 andrea
   "Don't be so melodramatic"
   "Non essere cosi' melodrammatica")
  (cons ;5 andrea
   "She is Luna"
   "Lei e' Luna")
  (cons ;6 andrea
   "She is my girlfriend"
   "E' la mia ragazza")
  (cons ;7 andrea
   "She is even one of the two reasons why I was able to survive so far"
   "E' anche uno dei due motivi per cui sono sopravvissuto fino ad ora")
  (cons ;8 andrea
   "In this precise moment of her life, she is studying and working here, at University for Foreigners of Perugia"
   "In questo momento della sua vita, studia e lavora part-time qui all'Universita' per Stranieri di Perugia")
  (cons ;9 andrea
   "By the way, why you're not working?"
   "Piuttosto, perche' non stai lavorando?")
  (cons ;10 luna
   "I need a break, too much stress and chaos in the office!"
   "Ho bisogno di fare un break, troppo stress e confusione!")
  (cons ;11 andrea
   "Chaos, for what?"
   "Confusione? Perche'? ")
  (cons ;12 luna
   "I don't know exactly, I heard something happened downtown"
   "Non so di preciso ma ho sentito dire che e' successo qualcosa in centro. ")
  (cons ;13 luna
   "Maybe you could go to have a look!"
   "Magari potresti andare a dare un'occhiata!")
  (cons ;14 andrea
   "Free pizza?"
   "Pizza gratis?")
  (cons ;15 luna
   "I . . ."
   "Io . . .")
  (cons ;16 luna
   "Are you actually asking me that?"
   "Ma me lo stai chiedendo seriamente?")
  (cons ;17 andrea
   "No?"
   "No?")
  (cons ;18 luna
   "Why don't you go instead of wasting time?"
   "Perche' invece di perdere tempo non vai a vedere?")
  (cons ;19 andrea
   "And why don't you go back to work?"
   "E perche' tu non rientri a lavoro?")
  (cons ;20 luna
   "Touche'!"
   "Touche'! ")
  (cons ;21 luna
   "I'm just taking a break and you are wasting my time"
   "Sono in pausa e tu mi stai facendo perdere tempo")
  (cons ;22 luna
   "Get off my ass!"
   "Via dalle palle!")
  (cons ;23 andrea
   "A reference point in my life!"
   "Un punto di riferimento nella mia vita!")
  (cons ;24 andrea
   "My ispiration"
   "La mia musa ispiratrice")
  (cons ;25 andrea
   "My reason for being"
   "La mia ragione d'essere")
  (cons ;26 andrea
   "Irritating"
   "Fastidio")
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
(define luna_quiet_dialog (collector_get "luna_quiet_dialog"))
(define luna_quiet_answer (collector_get "luna_quiet_answer"))

;Action!
(if (= luna_quiet_dialog 1.0)
	(begin
		(puppeteer_look "andrea" "luna")
		(say "luna" (get_dialog dialogs language 21) "lunquiet_track21") ;preview: I'm just taking a break and ... | looking at Andrea
		(say "luna" (get_dialog dialogs language 22) "lunquiet_track22") ;preview: Get off my ass! | looking at Andrea
		(puppeteer_set "andrea" "front")
		(if (= luna_quiet_answer 0.0)
			(say "andrea" (get_dialog dialogs language 23) "lunquiet_track23") ;preview: A reference point in my life! | looking at Main Camera
			(if (= luna_quiet_answer 1.0)
				(say "andrea" (get_dialog dialogs language 24) "lunquiet_track24") ;preview: My ispiration | looking at Main Camera
				(if (= luna_quiet_answer 2.0)
					(say "andrea" (get_dialog dialogs language 25) "lunquiet_track25") ;preview: My reason for being | looking at Main Camera
					(say "andrea" (get_dialog dialogs language 26) "lunquiet_track26") ;preview: Irritating | looking at Main Camera
				)
			)
		)
		;Next answer
		(collector_set "luna_quiet_answer" (+ luna_quiet_answer 1.0)))
	(begin
		(puppeteer_move "andrea" 2600)
    (director_wait_movement "andrea")
		(puppeteer_stare "luna" "#null")

    (puppeteer_set "andrea" "still_right")
		(puppeteer_set "luna" "still_left")
		(say "luna" (get_dialog dialogs language 1) "lunquiet_track1") ;preview: What do you do here? | looking at Andrea
		(say "andrea" (get_dialog dialogs language 2) "lunquiet_track2") ;preview: I'm looking for some stuff | looking at Luna
		(puppeteer_set "luna" "point_left")
		(say "luna" (get_dialog dialogs language 3) "lunquiet_track3") ;preview: Money for a bill, I suppose! | looking at Andrea | animation pointing
		(puppeteer_set "luna" "still_left")
		(puppeteer_set "andrea" "scratch_right")
		(say "andrea" (get_dialog dialogs language 4) "lunquiet_track4") ;preview: Don't be so melodramatic | looking at Luna | animation scratching his head
		(puppeteer_set "andrea" "front")
		(say "andrea" (get_dialog dialogs language 5) "lunquiet_track5") ;preview: She is Luna | looking at Main Camera
		(say "andrea" (get_dialog dialogs language 6) "lunquiet_track6") ;preview: She is my girlfriend | looking at Main Camera
		(say "andrea" (get_dialog dialogs language 7) "lunquiet_track7") ;preview: She is even one of the two r... | looking at Main Camera
		(puppeteer_set "andrea" "scratch_front")
		(say "andrea" (get_dialog dialogs language 8) "lunquiet_track8") ;preview: In this precise moment of he... | looking at Main Camera | animation scratching his head
		(puppeteer_set "andrea" "still_right")
		(say "andrea" (get_dialog dialogs language 9) "lunquiet_track9") ;preview: What are you doing here? | looking at Luna
		(say "luna" (get_dialog dialogs language 10) "lunquiet_track10") ;preview: I need a break, too much str... | looking at Andrea
		(puppeteer_set "andrea" "scratch_right")
		(say "andrea" (get_dialog dialogs language 11) "lunquiet_track11") ;preview: Chaos, for what? | looking at Luna | animation scratching his head
		(say "luna" (get_dialog dialogs language 12) "lunquiet_track12") ;preview: I don't know exactly, I hear... | looking at Andrea
		(puppeteer_set "luna" "point_left")
		(say "luna" (get_dialog dialogs language 13) "lunquiet_track13") ;preview: Maybe you could go to have a... | looking at Andrea | animation pointing
		(puppeteer_set "luna" "still_left")
		(say "andrea" (get_dialog dialogs language 14) "lunquiet_track14") ;preview: Free pizza? | looking at Luna | animation pointing
		;Script suggestion: I due si guardano in silenzio
		(director_wait_time 2)
		(say "luna" (get_dialog dialogs language 15) "lunquiet_track15") ;preview: I . . . | looking at Andrea
		(say "luna" (get_dialog dialogs language 16) "lunquiet_track16") ;preview: Are you actually asking me t... | looking at Andrea
		;Script suggestion: I due si guardano in silenzio
		(director_wait_time 2)
		(say "andrea" (get_dialog dialogs language 17) "lunquiet_track17") ;preview: No? | looking at Luna
		(puppeteer_set "luna" "point_left")
		(say "luna" (get_dialog dialogs language 18) "lunquiet_track18") ;preview: Why don't you go instead of ... | looking at Andrea | animation pointing
		(puppeteer_set "luna" "still_left")
		(say "andrea" (get_dialog dialogs language 19) "lunquiet_track19") ;preview: And why don't you go back to... | looking at Luna
		(say "luna" (get_dialog dialogs language 20) "lunquiet_track20") ;preview: Touche'! | looking at Andrea
		(puppeteer_stare "luna" "andrea")

		;And never again
		(collector_set "luna_quiet_dialog" 1.0)
		(collector_set "luna_quiet_answer" 0.0))
)

;Return the control
(main_control "andrea")
