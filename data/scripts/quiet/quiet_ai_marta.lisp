;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : mbrquiet
;Location   : Innamorati
;Author     : Madmoon
;Description: Marta is worried because Bruno appeared to be sick. She will bring him to the doctor.

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 marta
			"Hi Andrea!"    
			"Ciao Andrea!")   
		(cons ;2 andrea
			"Hy guys, what's up?"    
			"Hey ragazzi, che combinate?")   
		(cons ;3 andrea
			"They are Marta and Bruno"    
			"Loro sono Marta e Bruno")   
		(cons ;4 andrea
			"She is the bestie of my girlfriend, Luna"    
			"Lei, la migliore amica della mia ragazza Luna")   
		(cons ;5 andrea
			"He is one of my best friend"    
			"Lui, uno dei miei migliori amici")   
		(cons ;6 andrea
			"And he is even one of the most talented programmers"    
			"E e' anche uno dei piu' talentuosi programmatori")   
		(cons ;7 marta
			"With Bruno we were going to UniPG"    
			"Io e Bruno dovevamo andare in facolta'")   
		(cons ;8 marta
			"But I think he's not in his best shape"    
			"Ma credo che Bruno non stia molto bene")   
		(cons ;9 bruno
			"I'm fin-segmentation fault (core dumped)."    
			"Sto ben-segmentation fault (core dumped).")   
		(cons ;10 andrea
			"Brunetto what's going on?"    
			"Brunetto che succede?")   
		(cons ;11 bruno
			"Nothi-say.bin[512]: segfault at bfaec4 error 6"    
			"Non succe-say.bin[512]: segfault at bfaec4 error 6")   
		(cons ;12 marta
			"For once in his life he can't speak"    
			"Per una volta nella vita, non parla")   
		(cons ;13 marta
			"I try to enjoy the moment, you know"    
			"Cerco di godermi il momento, sai com'e'")   
		(cons ;14 andrea
			"I see"    
			"Capisco")   
		(cons ;15 marta
			"Let's go, the doctor is waiting for us"    
			"Ora andiamo, il dottore ci aspetta")   
		(cons ;16 bruno
			"Bye-move.bin[256]: segfault at f32aac error 1"    
			"Cia-move.bin[256]: segfault at f32aac error 1")   
		(cons ;17 andrea
			"Looks like I'm talking with dmesg"    
			"Sembra di parlare con dmesg")   
		(cons ;18 andrea
			"embarrassing"    
			"Imbarazzante")   
		(cons ;19 marta
			"Look, what is this about?"    
			"Ma si puo' sapere che ti prende?")   
		(cons ;20 marta
			"I will show you 'Lost' again from the beginning to the end, eh!"    
			"Guarda che ti faccio vedere di nuovo Lost dall'inizio alla fine, eh?")   
		(cons ;21 marta
			"Please, talk to me!"    
			"Parla, ti prego!")   
		(cons ;22 marta
			"Tell me what is going on!"    
			"Dimmi che succede!")   
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
(collector_set "marta_quiet_discussing" 1.0)

;Parameters configuration
(define marta_quiet_dialog (collector_get "marta_quiet_dialog"))

;Action!
(if (= marta_quiet_dialog 1.0)
  nil
  (begin
    (puppeteer_move "andrea" 12000)
    (director_wait_movement "andrea")

    (puppeteer_set "marta"  "still_left")
    (puppeteer_set "bruno"  "still_left")
    (puppeteer_set "andrea" "still_right")
    (say "marta" (get_dialog dialogs language 1) "mbrquiet_track1") ;preview: Hi Andrea! | looking at Andrea
    (say "andrea" (get_dialog dialogs language 2) "mbrquiet_track2") ;preview: Hy guys, what's up? | looking at Marta
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 3) "mbrquiet_track3") ;preview: They are Marta and Bruno | looking at Main Camera
    (say "andrea" (get_dialog dialogs language 4) "mbrquiet_track4") ;preview: She is the bestie of my girl... | looking at Main Camera
    (puppeteer_set "marta" "front")
    (say "andrea" (get_dialog dialogs language 5) "mbrquiet_track5") ;preview: He is one of my best friend | looking at Main Camera
    (puppeteer_set "bruno"  "scratch_left")
    (say "andrea" (get_dialog dialogs language 6) "mbrquiet_track6") ;preview: And he is even one of the mo... | looking at Main Camera
    (puppeteer_set "andrea" "still_right")
    (puppeteer_set "marta" "point_left")
    (say "marta" (get_dialog dialogs language 7) "mbrquiet_track7") ;preview: With Bruno we were going to ... | looking at Andrea | animation pointing
    (puppeteer_set "marta" "scratch_right")
    (say "marta" (get_dialog dialogs language 8) "mbrquiet_track8") ;preview: But I think he's not in his ... | looking at Bruno | animation scratching his head
    (say "bruno" (get_dialog dialogs language 9) "mbrquiet_track9") ;preview: I'm fin-segmentation fault, ... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 10) "mbrquiet_track10") ;preview: Brunetto what's going on?  | looking at Bruno
    (puppeteer_set "bruno"  "scratch_left")
    (say "bruno" (get_dialog dialogs language 11) "mbrquiet_track11") ;preview: Nothi-say.bin[512]: segfault... | looking at Andrea | animation scratching his head
    ;Script suggestion: Marta e Andrea si guardano in silenzio
    (director_wait_time 3)
    (say "marta" (get_dialog dialogs language 12) "mbrquiet_track12") ;preview: For once in his life he can'... | looking at Bruno
    (puppeteer_set "marta" "still_left")
    (say "marta" (get_dialog dialogs language 13) "mbrquiet_track13") ;preview: I try to enjoy the moment, y... | looking at Andrea
    (puppeteer_set "andrea" "scratch_right")
    (say "andrea" (get_dialog dialogs language 14) "mbrquiet_track14") ;preview: I see | looking at Marta | animation scratching his head
    (puppeteer_set "marta" "still_right")
    (say "marta" (get_dialog dialogs language 15) "mbrquiet_track15") ;preview: Let's go, the doctor is wait... | looking at Bruno | animation pointing
    ;Script suggestion: Marta e Bruno se ne vanno mentre Andrea resta a guardarli
    (puppeteer_move "marta" 10000)
    (puppeteer_move "bruno" 10000)
    (puppeteer_stare "andrea" "bruno")

    (say "bruno" (get_dialog dialogs language 16) "mbrquiet_track16") ;preview: Bye-move.bin[256]: segfault ... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 17) "mbrquiet_track17") ;preview: Looks like I'm talking with ... | looking at Main Camera
    (director_wait_time 1)
    (say "andrea" (get_dialog dialogs language 18) "mbrquiet_track18") ;preview: embarrassing | looking at Main Camera

    (director_wait_movement "marta")
    (director_wait_movement "bruno")
    (puppeteer_stare "andrea" "#null")

    (puppeteer_show "marta" the_void)
    (puppeteer_show "bruno" the_void)

    ;And never again
    (collector_set "marta_quiet_dialog" 1.0))
  )

;Restore the environment
(collector_set "marta_quiet_discussing" 0.0)

;Return the control
(main_control "andrea")
