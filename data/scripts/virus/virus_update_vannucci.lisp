;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : anyurassvirus
;Location   : Corso Vannucci
;Author     : Nardinan
;Description: Andrii and Yuriy are taking fun of Andrea and they explain him their responsibility in the overall situation

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 andrii
			"You begged me to disable the security grids . . ."    
			"Tu mi hai pregato di disabilitare le griglie di sicurezza . .")   
		(cons ;2 yuriy
			"I asked only if you knew how to do it!"    
			"Io ti ho solo chiesto se sapevi come farlo!")   
		(cons ;3 andrii
			". . . and you increased the energy of the LHC to 14TeV!"    
			". . . e poi hai tirato su il LHC a 14TeV!")   
		(cons ;4 yuriy
			"You were the one that wanted to change the history!"    
			"Tu eri quello che voleva cambiare le storia!")   
		(cons ;5 andrii
			"I was talking metaphorically, arsehole!"    
			"Nel senso metaforico del termine stupido ritardato!")   
		(cons ;6 yuriy
			"Is impossible to understand you . . ."    
			"Non si capisce niente di quello che dici . . .")   
		(cons ;7 yuriy
			". . . and you were responsible for the experiment!"    
			". . . eri tu a dover tenere sotto controllo l'esperimento!")   
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
(define virus_andrii_and_yuriy_line      (collector_get "virus_andrii_and_yuriy_line"))
(define virus_andrii_and_yuriy_next_line (+ virus_andrii_and_yuriy_line 1.0))
(define andrii_yuriy_virus_dialog        (collector_get "andrii_yuriy_virus_dialog"))


(if (= andrii_yuriy_virus_dialog 1.0)
  (begin
    (puppeteer_look "andrii" "yuriy")
    (puppeteer_look "yuriy" "andrii")
    (if (= virus_andrii_and_yuriy_line 0.0)
      (say "andrii" (get_dialog dialogs language 1) "anyurassvirus_track33") ;preview: You begged me to disable the... | looking at Yuriy
      (if (= virus_andrii_and_yuriy_line 1.0)
        (say "yuriy" (get_dialog dialogs language 2) "anyurassvirus_track34") ;preview: I asked only if you knew how... | looking at Andrii
        (if (= virus_andrii_and_yuriy_line 2.0)
          (say "andrii" (get_dialog dialogs language 3) "anyurassvirus_track35") ;preview: . . . and you increased the ... | looking at Yuriy
          (if (= virus_andrii_and_yuriy_line 3.0)
            (say "yuriy" (get_dialog dialogs language 4) "anyurassvirus_track36") ;preview: You were the one that wanted... | looking at Andrii
            (if (= virus_andrii_and_yuriy_line 4.0)
              (say "andrii" (get_dialog dialogs language 5) "anyurassvirus_track37") ;preview: I was talking metaphorically... | looking at Yuriy
              (if (= virus_andrii_and_yuriy_line 5.0)
                (say "yuriy" (get_dialog dialogs language 6) "anyurassvirus_track38") ;preview: Is impossible to understand y... | looking at Andrii
                (if (= virus_andrii_and_yuriy_line 6.0)
                  (say "yuriy" (get_dialog dialogs language 7) "anyurassvirus_track39") ;preview: . . . and you were responsib... | looking at Andrii | animation pointing
                  nil
                  )
                )
              )
            )
          )
        )
      )

    ;Configure environment for the next hop
    (if (> virus_andrii_and_yuriy_next_line 6.0)
      (collector_set "virus_andrii_and_yuriy_line" 0.0)
      (collector_set "virus_andrii_and_yuriy_line" virus_andrii_and_yuriy_next_line)
      ))
  nil
  )
