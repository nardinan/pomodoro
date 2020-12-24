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
			"There's nothing better to look at the people!"    
			"Non c'e' nulla di meglio che guardare la gente!")   
		(cons ;2 yuriy
			"Maybe eating while you look at the people!"    
			"Forse mangiare mentre guardi la gente!")   
		(cons ;3 andrea
			"Coding at home, no?"    
			"Stare a casa a programmare no?")   
		(cons ;4 andrea
			"Considering the current situation, stay home is always positive!"    
			"Considerando la situazione attuale poi, stare a casa e' sempre meglio!")   
		(cons ;5 andrii
			"A bad situation that could have been avoided . . ."    
			"Una situazione che magari si sarebbe potuta evitare . . .")   
		(cons ;6 andrii
			". . . right, Yuriy?"    
			". . . vero Yuriy?")   
		(cons ;7 andrii
			"Ahahah!"    
			"Ahahah!")   
		(cons ;8 yuriy
			"Ahahah!"    
			"Ahahah!")   
		(cons ;9 andrea
			"What are you laughing?"    
			"Ma che ridete?")   
		(cons ;10 andrii
			"If only someone had done things in a better way, maybe today could have been a day like the others . . ."    
			"Se qualcuno avesse fatto le cose con criterio magari oggi sarebbe potuto essere un giorno come gli altri . . .")   
		(cons ;11 andrii
			". . . right, Yuriy?"    
			". . . vero Yuriy?")   
		(cons ;12 andrii
			"Ahahah!"    
			"Ahahah!")   
		(cons ;13 yuriy
			"Ahahah!"    
			"Ahahah!")   
		(cons ;14 yuriy
			"Wait, are you implying I am responsible for this?"    
			"Aspetta, stai dicendo che sono stato io?")   
		(cons ;15 andrea
			"I beg your pardon?"    
			"Scusate, ma che e' 'sta storia?")   
		(cons ;16 andrii
			"Just pretend that nothing happened."    
			"Niente niente, facciamo finta di niente.")   
		(cons ;17 yuriy
			"Now you have to talk!"    
			"Eh no, ora parli!")   
		(cons ;18 yuriy
			"If you have a problem with me, just say it!"    
			"Se hai un problema con me, me lo dici subito!")   
		(cons ;19 andrea
			"What's up, guys?"    
			"Ma che state dicendo?")   
		(cons ;20 andrea
			"Are you drunk?"    
			"Avete bevuto?")   
		(cons ;21 andrii
			"I will be short . . ."    
			"Saro' breve . . .")   
		(cons ;22 andrii
			"Somebody generated an hole in the fabric of space and time . . ."    
			"Qualcuno potrebbe aver generato un buco nel tessuto spazio temporale . . .")   
		(cons ;23 andrii
			". . . changing the natural course of history."    
			". . . cambiando il naturale corso della storia.")   
		(cons ;24 andrea
			"So, you are telling me that if the history wasn't modified . . ."    
			"Quindi mi stai dicendo che se la storia non fosse stata modificata . . .")   
		(cons ;25 andrea
			". . . today could have been a day like the others?"    
			". . . oggi sarebbe un giorno come gli altri?")   
		(cons ;26 andrii
			"Possible."    
			"Possibile.")   
		(cons ;27 andrea
			"Who changed it?"    
			"E chi l'ha cambiata?")   
		(cons ;28 andrii
			"I have no idea . . ."    
			"Io proprio non saprei . . .")   
		(cons ;29 andrii
			"Yuriy, who changed it?"    
			"Yuriy, chi ha cambiato la storia?")   
		(cons ;30 yuriy
			"Asshole!"    
			"Bastardo!")   
		(cons ;31 yuriy
			"It's your fault if we are in this mess!"    
			"E' solo colpa tua se siamo in questo casino!")   
		(cons ;32 andrii
			"You fucker!"    
			"Ma che dici?")   
		(cons ;33 andrii
			"You begged me to disable the security grids . . ."    
			"Tu mi hai pregato di disabilitare le griglie di sicurezza . .")   
		(cons ;34 yuriy
			"I asked only if you knew how to do it!"    
			"Io ti ho solo chiesto se sapevi come farlo!")   
		(cons ;35 andrii
			". . . and you increased the energy of the LHC to 14TeV!"    
			". . . e poi hai tirato su il LHC a 14TeV!")   
		(cons ;36 yuriy
			"You were the one that wanted to change the history!"    
			"Tu eri quello che voleva cambiare le storia!")   
		(cons ;37 andrii
			"I was talking metaphorically, arsehole!"    
			"Nel senso metaforico del termine stupido ritardato!")   
		(cons ;38 yuriy
			"Is impossible to understand you . . ."    
			"Non si capisce niente di quello che dici . . .")   
		(cons ;39 yuriy
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

;Environment configuration (music, effect, whatever)
(puppeteer_disable_control)

;Parameters configuration
(define dialog_done         (collector_get "andrii_yuriy_virus_dialog"))
(define andrea_position     (puppeteer_get_position "andrea"))
(define yuriy_position      (puppeteer_get_position "yuriy"))
(define andrii_position     (puppeteer_get_position "andrii"))

;Calculate position of andrii and yuriy in respect of andrea
(define yuriy_look_andrea    "still_left")
(define yuriy_point_andrea   "point_left")
(define yuriy_scratch_andrea "scratch_left")
(if (> andrea_position yuriy_position)
  (begin
    (set yuriy_look_andrea    "still_right")
    (set yuriy_point_andrea   "point_right")
    (set yuriy_scratch_andrea "scratch_right"))
  nil
  )
(define andrii_look_andrea    "still_left")
(define andrii_point_andrea   "point_left")
(define andrii_scratch_andrea "scratch_left")
(if (> andrea_position andrii_position)
  (begin
    (set andrii_look_andrea    "still_right")
    (set andrii_point_andrea   "point_right")
    (set andrii_scratch_andrea "scratch_right"))
  nil
  )
(define andrea_look_yuriy    "still_left")
(define andrea_point_yuriy   "point_left")
(define andrea_scratch_yuriy "scratch_left")
(if (> yuriy_position andrea_position)
  (begin
    (set andrea_look_yuriy    "still_right")
    (set andrea_point_yuriy   "point_right")
    (set andrea_scratch_yuriy "scratch_right"))
  nil
  )
(define andrea_look_andrii    "still_left")
(define andrea_point_andrii   "point_left")
(define andrea_scratch_andrii "scratch_left")
(if (> andrii_position andrea_position)
  (begin
    (set andrea_look_andrii    "still_right")
    (set andrea_point_andrii   "point_right")
    (set andrea_scratch_andrii "scratch_right"))
  nil
  )

;Action!
(if (= dialog_done 1.0)
  nil
  (begin
    (puppeteer_look "andrea" "andrii")
    (puppeteer_look "andrii" "yuriy")
    (puppeteer_look "yuriy" "andrii")
    (say "andrii" (get_dialog dialogs language 1) "anyurassvirus_track1") ;preview: There's nothing better to lo... | looking at Andrea
    (say "yuriy" (get_dialog dialogs language 2) "anyurassvirus_track2") ;preview: Maybe eating while you look ... | looking at Andrii
    (say_and_go "andrea" (get_dialog dialogs language 3) "anyurassvirus_track3") ;preview: Coding at home, no? | looking at Andrii
    (director_wait_time 1.0)
    (puppeteer_set "andrii" andrii_look_andrea)
    (puppeteer_set "yuriy" yuriy_look_andrea)
    (director_wait_message "andrea")
    (puppeteer_set "andrea" andrea_look_yuriy)
    (say "andrea" (get_dialog dialogs language 4) "anyurassvirus_track4") ;preview: Considering the current situ... | looking at Yuriy
    (say "andrii" (get_dialog dialogs language 5) "anyurassvirus_track5") ;preview: A bad situation that could h... | looking at Andrea
    (puppeteer_set "andrii" "still_right")
    (say_and_go "andrii" (get_dialog dialogs language 6) "anyurassvirus_track6") ;preview: . . . right, Yuriy? | looking at Yuriy
    (director_wait_time 1.0)
    (puppeteer_set "yuriy" "still_left")
    (director_wait_message "andrii")
    (puppeteer_set "andrii" "point_right")
    (puppeteer_set "yuriy" "point_left")
    (say_and_go "andrii" (get_dialog dialogs language 7) "anyurassvirus_track7") ;preview: Ahahah! | looking at Andrea | animation pointing
    (say_and_go "yuriy" (get_dialog dialogs language 8) "anyurassvirus_track8") ;preview: Ahahah! | looking at Andrea | animation pointing
    (director_wait_message "andrii")
    (director_wait_message "yuiry")
    (puppeteer_set "andrii" "still_right")
    (puppeteer_set "yuriy" "still_left")
    (puppeteer_set "andrea" andrea_look_andrii)
    (say_and_go "andrea" (get_dialog dialogs language 9) "anyurassvirus_track9") ;preview: What are you laughing?  | looking at Yuriy
    (director_wait_time 1.0)
    (puppeteer_set "andrii" andrii_look_andrea)
    (puppeteer_set "yuriy" yuriy_look_andrea)
    (director_wait_message "andrea")
    (say "andrii" (get_dialog dialogs language 10) "anyurassvirus_track10") ;preview: If only someone had done thi... | looking at Andrea
    (puppeteer_set "andrii" "still_right")
    (say_and_go "andrii" (get_dialog dialogs language 11) "anyurassvirus_track11") ;preview: . . . right, Yuriy? | looking at Yuriy
    (director_wait_time 1.0)
    (puppeteer_set "yuriy" "still_left")
    (director_wait_message "andrii")
    (puppeteer_set "andrii" "point_right")
    (puppeteer_set "yuriy" "point_left")
    (say_and_go "andrii" (get_dialog dialogs language 12) "anyurassvirus_track12") ;preview: Ahahah! | looking at Andrea | animation pointing
    (say_and_go "yuriy" (get_dialog dialogs language 13) "anyurassvirus_track13") ;preview: Ahahah! | looking at Andrea | animation pointing
    (director_wait_message "andrii")
    (director_wait_message "yuiry")
    (puppeteer_set "andrii" "still_right")
    (puppeteer_set "yuriy" "still_left")
    (say "yuriy" (get_dialog dialogs language 14) "anyurassvirus_track14") ;preview: Wait, are you implying I am r... | looking at Andrii
    (say_and_go "andrea" (get_dialog dialogs language 15) "anyurassvirus_track15") ;preview: I beg your pardon? | looking at Andrii
    (director_wait_time 1.0)
    (puppeteer_set "andrii" andrii_look_andrea)
    (director_wait_message "andrea")
    (say "andrii" (get_dialog dialogs language 16) "anyurassvirus_track16") ;preview: Just pretend pretend that no... | looking at Andrea
    (puppeteer_set "yuriy" "point_left")
    (say_and_go "yuriy" (get_dialog dialogs language 17) "anyurassvirus_track17") ;preview: Now you have to talk! | looking at Andrii | animation pointing
    (director_wait_time 1.0)
    (puppeteer_set "andrii" "still_right")
    (director_wait_message "yuriy")
    (say "yuriy" (get_dialog dialogs language 18) "anyurassvirus_track18") ;preview: If you have a problem with m... | looking at Andrea
    (puppeteer_set "yuriy" "still_left")
    (puppeteer_set "andrea" andrea_look_yuriy)
    (say "andrea" (get_dialog dialogs language 19) "anyurassvirus_track19") ;preview: What's up, g... | looking at Yuriy
    (puppeteer_set "andrea" andrea_scratch_yuriy)
    (say "andrea" (get_dialog dialogs language 20) "anyurassvirus_track20") ;preview: Are you drunk? | looking at Andrii | animation scratching his head
    (puppeteer_set "andrii" andrii_look_andrea)
    (say_and_go "andrii" (get_dialog dialogs language 21) "anyurassvirus_track21") ;preview: I will be short . . .  | looking at Andrea
    (director_wait_time 1.0)
    (puppeteer_set "andrea" andrea_look_andrii)
    (director_wait_message "andrii")
    (say "andrii" (get_dialog dialogs language 22) "anyurassvirus_track22") ;preview: Somebody generated an hole i... | looking at Andrea
    (say "andrii" (get_dialog dialogs language 23) "anyurassvirus_track23") ;preview: . . . changing the natural c... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 24) "anyurassvirus_track24") ;preview: So, you are telling me that ... | looking at Andrii
    (say "andrea" (get_dialog dialogs language 25) "anyurassvirus_track25") ;preview: . . . today could have been ... | looking at Andrii
    (say "andrii" (get_dialog dialogs language 26) "anyurassvirus_track26") ;preview: Possible. | looking at Andrea
    (say "andrea" (get_dialog dialogs language 27) "anyurassvirus_track27") ;preview: Who changed it? | looking at Andrii
    (say "andrii" (get_dialog dialogs language 28) "anyurassvirus_track28") ;preview: I have no idea . . . | looking at Andrea
    (puppeteer_set "andrii" "still_right")
    (say "andrii" (get_dialog dialogs language 29) "anyurassvirus_track29") ;preview: Yuriy, who changed it? | looking at Yuriy
    (puppeteer_set "yuriy" "point_left")
    (say "yuriy" (get_dialog dialogs language 30) "anyurassvirus_track30") ;preview: Asshole! | looking at Andrii
    (puppeteer_set "yuriy" "still_left")
    (say "yuriy" (get_dialog dialogs language 31) "anyurassvirus_track31") ;preview: It's your fault if we are in... | looking at Andrii
    (say "andrii" (get_dialog dialogs language 32) "anyurassvirus_track32") ;preview: You fucker! | looking at Yuriy

    ;And never again
    (collector_set "andrii_yuriy_virus_dialog" 1.0))
  )

;Return the control
(main_control "andrea")
