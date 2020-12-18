;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : brunaggrvirus
;Location   : Unipg P1
;Author     : Nardinan
;Description: Bruno is becoming more aggressive

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 andrea
			"Bruno!"    
			"Bruno!")   
		(cons ;2 andrea
			"Are you feeling any better?"    
			"Ti senti meglio?")   
		(cons ;3 andrea
			"How was the doctor visit?"    
			"Sei stato dal dottore?")   
		(cons ;4 bruno
			"I am not sick."    
			"Io non sono malato.")   
		(cons ;5 bruno
			"And I want to say something . . ."    
			"E vorrei dire una cosa . . .")   
		(cons ;6 andrea
			"Sure!"    
			"Si?")   
		(cons ;7 bruno
			". . . the fact that you spend so much time here in the department is annoying me."    
			". . . il fatto che passi cosi' tanto spesso per il dipartimento inizia a darmi fastidio.")   
		(cons ;8 bruno
			"You should go home and wait for the whole thing to be over."    
			"Perche' non te ne torni a casa e aspetti che tutto sia finito?")   
		(cons ;9 andrea
			"Ehm . . ."    
			"Ehm . . .")   
		(cons ;10 andrea
			"I beg your pardon?"    
			"Prego?")   
		(cons ;11 bruno
			"I said - - protect.bin[66]: segfault at 84ff98 error 7"    
			"Ho detto - protect.bin[66]: segfault at 84ff98 error 7")   
		(cons ;12 bruno
			". . . and wait for the whole thing to be over."    
			". . . e aspetti che sia tutto finito?")   
		(cons ;13 andrea
			"Brunetto, you are scaring me."    
			"Brunetto, mi metti un po' di paura cosi'.")   
		(cons ;14 andrea
			"What do I have to wait?"    
			"Cosa devo aspettare?")   
		(cons ;15 bruno
			"I am giving you a friendly advice."    
			"Ti sto dando un consiglio da amico.")   
		(cons ;16 bruno
			"Just disappear if you don't want me to - threat.bin[45]: segfault at 82ff1a error 6"    
			"Vedi di sparire se non - threat.bin[45]: segfault at 82ff1a error 6")   
		(cons ;17 andrea
			"You are really aggressive."    
			"Sei troppo aggressivo.")   
		(cons ;18 andrea
			"Where is Marta?"    
			"Dov'e' Marta?")   
		(cons ;19 bruno
			"You have to go."    
			"Sparisci.")   
		(cons ;20 bruno
			"<connection cannot be estabilished 0xffa231>"    
			"<connection cannot be estabilished 0xffa231>")   
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
(define dialog_done         (collector_get "bruno_virus_dialog"))
(define andrea_position     (puppeteer_get_position "andrea"))
(define bruno_position       (puppeteer_get_position "bruno"))

;Calculate position of luca in respect of andrea
(define bruno_still_side    "still_left")
(define bruno_point_side    "point_left")
(define andrea_still_side   "still_right")
(define andrea_scratch_side "scratch_right")
(if (> andrea_position bruno_position)
  (begin
    (define bruno_still_side    "still_right")
    (define bruno_point_side    "point_right")
    (define andrea_still_side   "still_left")
    (define andrea_scratch_side "scratch_left"))
  nil
  )

;Action!
(puppeteer_stare "bruno" "#null")
(puppeteer_look "andrea" "bruno")
(if (= dialog_done 1.0)
  (begin
    (puppeteer_set "bruno" bruno_point_side)
    (say "bruno" (get_dialog dialogs language 15) "brunaggrvirus_track15") ;preview: I am giving you a friendly a... | looking at Andrea | animation pointing
    (puppeteer_set "bruno" bruno_still_side)
    (say "bruno" (get_dialog dialogs language 16) "brunaggrvirus_track16") ;preview: Just disappear if you don't ... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 17) "brunaggrvirus_track17") ;preview: You are really aggressive. | looking at Bruno
    (say "bruno" (get_dialog dialogs language 20) "brunaggrvirus_track20")) ;preview: <connection cannot be estabi... | looking at Andrea
  (begin
    (say "andrea" (get_dialog dialogs language 1) "brunaggrvirus_track1") ;preview: Bruno! | looking at Bruno
    (puppeteer_set "andrea" andrea_scratch_side)
    (say "andrea" (get_dialog dialogs language 2) "brunaggrvirus_track2") ;preview: Are you feeling any better? | looking at Bruno | animation scratching his head
    (say "andrea" (get_dialog dialogs language 3) "brunaggrvirus_track3") ;preview: How was the doctor visit? | looking at Bruno
    (puppeteer_set "bruno" bruno_point_side)
    (say "bruno" (get_dialog dialogs language 4) "brunaggrvirus_track4") ;preview: I am not sick. | looking at Andrea | animation pointing
    (puppeteer_set "bruno" bruno_still_side)
    (say "bruno" (get_dialog dialogs language 5) "brunaggrvirus_track5") ;preview: And I want to say something ... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 6) "brunaggrvirus_track6") ;preview: Sure! | looking at Bruno
    (puppeteer_set "bruno" bruno_point_side)
    (say "bruno" (get_dialog dialogs language 7) "brunaggrvirus_track7") ;preview: . . . the fact that you spen... | looking at Andrea | animation pointing
    (puppeteer_set "bruno" bruno_still_side)
    (say "bruno" (get_dialog dialogs language 8) "brunaggrvirus_track8") ;preview: You should go home and wait ... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 9) "brunaggrvirus_track9") ;preview: Ehm . . . | looking at Bruno
    (say "andrea" (get_dialog dialogs language 10) "brunaggrvirus_track10") ;preview: I beg your pardon? | looking at Bruno
    (say "bruno" (get_dialog dialogs language 11) "brunaggrvirus_track11") ;preview: I said - - protect.bin[66]: ... | looking at Andrea
    (say "bruno" (get_dialog dialogs language 12) "brunaggrvirus_track12") ;preview: . . . and wait for the whole... | looking at Andrea
    (puppeteer_set "andrea" andrea_scratch_side)
    (say "andrea" (get_dialog dialogs language 13) "brunaggrvirus_track13") ;preview: Brunetto, you are scaring me. | looking at Bruno | animation scratching his head
    (say "andrea" (get_dialog dialogs language 14) "brunaggrvirus_track14") ;preview: What do I have to wait? | looking at Bruno
    (puppeteer_set "bruno" bruno_point_side)
    (say "bruno" (get_dialog dialogs language 15) "brunaggrvirus_track15") ;preview: I am giving you a friendly a... | looking at Andrea | animation pointing
    (puppeteer_set "bruno" bruno_still_side)
    (say "bruno" (get_dialog dialogs language 16) "brunaggrvirus_track16") ;preview: Just disappear if you don't ... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 17) "brunaggrvirus_track17") ;preview: You are really aggressive. | looking at Bruno
    (say "andrea" (get_dialog dialogs language 18) "brunaggrvirus_track18") ;preview: Where is Marta? | looking at Bruno
    (say "bruno" (get_dialog dialogs language 19) "brunaggrvirus_track19") ;preview: You have to go. | looking at Andrea
    (say "bruno" (get_dialog dialogs language 20) "brunaggrvirus_track20") ;preview: <connection cannot be estabi... | looking at Andrea

    ;And never again
    (collector_set "bruno_virus_dialog" 1.0))
  )
(puppeteer_stare "bruno" "andrea")

;Return the control
(main_control "andrea")
