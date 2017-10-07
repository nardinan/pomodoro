;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : techquiet
;Location   : Lupattelli
;Author     : Nardinan
;Description: The technician, that asshole, tells to Andrea that they will disconnect their power line

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 technician
   "Ehi asshole!"
   "Ehi merda!")
  (cons ;2 andrea
   "Are you talking with me?"
   "Dici a me?")
  (cons ;3 technician
   "Do you live here, on the first floor?"
   "Abiti al primo piano di questo palazzo?")
  (cons ;4 andrea
   "Yes?"
   "Si?")
  (cons ;5 technician
   "Yes, I'm talking with you!"
   "Allora si, dico a te!")
  (cons ;6 andrea
   "What did I do?"
   "Che ho combinato ora?")
  (cons ;7 technician
   "Tomorrow I'll be here, to cut the power!"
   "Domani mi troverai qui, a staccarti la corrente!")
  (cons ;8 technician
   "I can't wait to do it!"
   "E ti assicuro che non vedo l'ora!")
  (cons ;9 andrea
   "Oh, ehm, I'm going to pay the bill right now!"
   "Ma no, sto andando a pagare la bolletta ora . . .")
  (cons ;10 technician
   "Are you kidding?"
   "Ma chi prendi in giro?")
  (cons ;11 technician
   "You're a beggar!"
   "Sei un morto di fame!")
  (cons ;12 andrea
   "Ehm . . ."
   "Ehm . . .")
  (cons ;13 technician
   "You'll be fucked up!"
   "Domani sono cazzi tuoi!")
  (cons ;14 andrea
   "God, it is a shitty day indeed"
   "Che giornata di merda")
  (cons ;15 technician
   "What do you want?"
   "Cosa vuoi?")
  (cons ;16 andrea
   "I wanted to know if I can postpone the cut of the power . . ."
   "Volevo sapere se c'era qualche possibilita' di posticipare il taglio della corrente?")
  (cons ;17 technician
   "Sure"
   "Certo")
  (cons ;18 technician
   "You have to pay the bill to avoid such fate"
   "Con i soldi della bolletta potresti scampare a questo destino")
  (cons ;19 technician
   "At least for another month"
   "Almeno per un altro mese")
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

;Action!
(say "technician" (get_dialog dialogs language 15) "techquiet_track15") ;preview: What do you want? | looking at Andrea
(say "andrea" (get_dialog dialogs language 16) "techquiet_track16") ;preview: I wanted to know if I can po... | looking at Technician
(say "technician" (get_dialog dialogs language 17) "techquiet_track17") ;preview: Sure | looking at Andrea
(say "technician" (get_dialog dialogs language 18) "techquiet_track18") ;preview: You have to pay the bill to ... | looking at Andrea
(say "technician" (get_dialog dialogs language 19) "techquiet_track19") ;preview: At least for another month | looking at Andrea

;Return the control
(main_control "andrea")
