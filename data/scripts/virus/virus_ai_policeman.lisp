;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : povirus
;Location   : Corso Vannucci
;Author     : Madmoon
;Description: The policeman is concerned about the virus and he wants to go home

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 policeman
                    "Boy, are you contagious? "
                    "Ragazzo, sei contagioso? ")
                  (cons ;2 andrea
                    "Only my laugh is contagious."
                    "Solo le mie risate sono contagiose.")
                  (cons ;3 andrea
                    "Do you want to listen me laughing? "
                    "Vuole sentirmi ridere?")
                  (cons ;4 policeman
                    "I don't find anything funny in this situation!"
                    "Non ci trovo nulla di divertente in questa situazione!")
                  (cons ;5 andrea
                    "What situation? "
                    "Quale situazione?")
                  (cons ;6 policeman
                    "There's a virus in the city . . ."
                    "C'e' un virus in citta' . . .")
                  (cons ;7 policeman
                    "Something dangerous"
                    "Qualcosa di pericoloso")
                  (cons ;8 andrea
                    "Don't worry!"
                    "Ma stai tranquillo! ")
                  (cons ;9 andrea
                    "For sure it's something less dangerous than how it looks!"
                    "Sicuramente e' meno pericoloso di quello che sembra!")
                  (cons ;10 policeman
                    "Well, I don't think so!"
                    "Bhe, non credo!")
                  (cons ;11 policeman
                    "I would prefer to be home instead of being around . . "
                    "Preferirei starmene a casa piuttosto che in giro . . .")
                  (cons ;12 andrea
                    "Who will protect the city?"
                    "Chi proteggera' la citta'?")
                  (cons ;13 policeman
                    "I'm not the only policeman around!"
                    "Mica sono l'unico poliziotto in giro!")
                  (cons ;14 andrea
                    "Fair enough!"
                    "Mi sembra giusto!")
                  (cons ;15 andrea
                    "I am infeeeeeeeeecteeeeeeeeeed!"
                    "Sono infeeeeeeeettoooooooooooo!")
                  (cons ;16 policeman
                    "AAAAAAAAAAAH!"
                    "AAAAAAAAAAAH!")
                  (cons ;17 policeman
                    "Go away, you daemon!"
                    "Pussa via, demonio!")
                  (cons ;18 andrea
                    "Ahahaha . . ."
                    "Ahahaha . . .")
                  (cons ;19 andrea
                    ". . . I am so facetious."
                    ". . . come sono faceto.")
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
(define dialog_done         (collector_get "policeman_virus_dialog"))
(define andrea_position     (puppeteer_get_position "andrea"))
(define policeman_position  (puppeteer_get_position "policeman"))

;Calculate position of luca in respect of andrea
(define policeman_still_side     "still_left")
(define policeman_point_side     "point_left")
(if (> andrea_position policeman_position)
  (begin
    (define policeman_still_side     "still_right")
    (define policeman_point_side     "point_right"))
  nil
  )

;Action!
(puppeteer_look "andrea" "policeman")
(puppeteer_look "policeman" "andrea")
(if (= dialog_done 1.0)
  (begin
    (say "andrea" (get_dialog dialogs language 15) "povirus_track15") ;preview: initialize.bin[44]: segfault... | looking at Policeman
    (puppeteer_set "policeman" policeman_point_side)
    (say "policeman" (get_dialog dialogs language 16) "povirus_track16") ;preview: AAAAAAAAAAAH! | looking at Andrea | animation pointing
    (puppeteer_set "policeman" policeman_still_side)
    (say "policeman" (get_dialog dialogs language 17) "povirus_track17") ;preview: Go away, you daemon! | looking at Andrea
    (say "andrea" (get_dialog dialogs language 18) "povirus_track18") ;preview: Ahahaha . . . | looking at Policeman
    (say "andrea" (get_dialog dialogs language 19) "povirus_track19")) ;preview: . . . I am so facetious. | looking at Policeman
  (begin
    (say "policeman" (get_dialog dialogs language 1) "povirus_track1") ;preview: Boy, are you contagious?  | looking at Andrea
    (say "andrea" (get_dialog dialogs language 2) "povirus_track2") ;preview: Only my laugh is contagious. | looking at Policeman
    (say "andrea" (get_dialog dialogs language 3) "povirus_track3") ;preview: Do you want to listen me lau... | looking at Policeman
    (say "policeman" (get_dialog dialogs language 4) "povirus_track4") ;preview: I don't find anything funny ... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 5) "povirus_track5") ;preview: What situation?  | looking at Policeman
    (say "policeman" (get_dialog dialogs language 6) "povirus_track6") ;preview: There's a virus in the city ... | looking at Andrea
    (say "policeman" (get_dialog dialogs language 7) "povirus_track7") ;preview: Something dangerous | looking at Andrea
    (say "andrea" (get_dialog dialogs language 8) "povirus_track8") ;preview: Don't worry! | looking at Policeman
    (say "andrea" (get_dialog dialogs language 9) "povirus_track9") ;preview: For sure it's something less... | looking at Policeman
    (say "policeman" (get_dialog dialogs language 10) "povirus_track10") ;preview: Well, I don't think so! | looking at Andrea
    (say "policeman" (get_dialog dialogs language 11) "povirus_track11") ;preview: I would prefer to be home in... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 12) "povirus_track12") ;preview: Who will protect the city? | looking at Policeman
    (say "policeman" (get_dialog dialogs language 13) "povirus_track13") ;preview: I'm not the only policeman a... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 14) "povirus_track14") ;preview: Fair enough! | looking at Policeman

    (collector_set "policeman_virus_dialog" 1.0))
  )
(puppeteer_set "policeman" "front")

;Return the control
(main_control "andrea")
