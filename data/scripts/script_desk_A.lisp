;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : quietdwmovie
;Location   : Canama
;Author     : Nardinan
;Description: Here Andrea uses his computer to download the movie required by the ticket inspector

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 andrea
			"My Mac . . ."    
			"Il mio Mac . . .")   
		(cons ;2 andrea
			"This is a fantastic computer!"    
			"Questo si che e' un computer!")   
		(cons ;3 andrea
			"With a fantastic operating system!"    
			"Questo si che e' un sistema operativo!")   
		(cons ;4 andrea
			"I would like to download 'I Soliti Idioti' for the Pallotta's ticket inspector!"    
			"Mi piacerebbe mettere a scaricare il film de 'I Soliti Idioti' per il controllore della Pallotta!")   
		(cons ;5 andrea
			"Unfortunately this kind of operation requires an Internet connection."    
			"Sfortunatamente questo genere di cose richiede una connessione ad Internet.")   
		(cons ;6 andrea
			"A Internet connection that I don't have, because of my poverty."    
			"Connessione che non ho, per via della mia poverta'.")   
		(cons ;7 andrea
			"A bad condition that is part of my life."    
			"Una condizione straziante, parte della mia vita.")   
		(cons ;8 andrea
			"Finally I have an Internet connection."    
			"Finalmente ho internet!")   
		(cons ;9 andrea
			"Really?"    
			"Ma che, davvero?")   
		(cons ;10 andrea
			"What year is this?"    
			"Ma in che anno siamo?")   
		(cons ;11 andrea
			"Diomatonne . . ."    
			"Diomatonne pero' . . .")   
		(cons ;12 andrea
			"Done!"    
			"Fatto!")   
		(cons ;13 andrea
			"Now, let me search for Torrent of the movie . . ."    
			"Cerchiamo il Torrent del film . . .")   
		(cons ;14 andrea
			"Here it is!"    
			"Eccolo!")   
		(cons ;15 andrea
			"So many feeds, the download will take just few minutes."    
			"Ci sono cosi' tanti seeds che finira' in pochissimo tempo.")   
		(cons ;16 andrea
			"And this is very, very sad, due to the nature of this movie."    
			"Il che e' veramente triste, considerando il genere di film.")   
		(cons ;17 andrea
			"10%"    
			"10%")   
		(cons ;18 andrea
			"40%"    
			"40%")   
		(cons ;19 andrea
			"80%"    
			"80%")   
		(cons ;20 andrea
			"Aaaaaand . . ."    
			"Eeeeeeee . . .")   
		(cons ;21 andrea
			"Done!"    
			"Fatto!")   
		(cons ;22 andrea
			"Let me copy it on my USB key . . ."    
			"Lo copio su chiavetta . . .")   
		(cons ;23 andrea
			"Done!"    
			"Fatto!")   
		(cons ;24 
			"However . . ."    
			"Comunque . . .")   
		(cons ;25 andrea
			". . . there is no point in download the movie without the USB key!"    
			". . . non c'e' ragione di scaricare il film senza una chiavetta USB!")   
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
(define request_movie (collector_get "request_movie"))
(define got_disk      (collector_get "got_disk"))
(define got_internet  (collector_get "got_internet"))
(define done_movie    (collector_get "done_movie"))

;Action!
(puppeteer_set "andrea" "back")
(if (= done_movie 1.0)
  (begin
    (say "andrea" (get_dialog dialogs language 1) "quietdwmovie_track1") ;preview: My Mac . . . | animation back
    (say "andrea" (get_dialog dialogs language 2) "quietdwmovie_track2") ;preview: This is a fantastic computer! | animation back
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 3) "quietdwmovie_track3")) ;preview: With a fantastic operating s... | animation front
  (if (= request_movie 1.0)
    (if (= got_internet 1.0)
      (if (= got_disk 1.0)
        (begin
          (say "andrea" (get_dialog dialogs language 8) "quietdwmovie_track8") ;preview: Finally I have an Internet c... | animation back

          ;Internet connection sequence
          (effecteer_play "internet_connection_noise" "internet_connection_noise" 0 1000 10 nil)
          (director_wait_time 4.0)
          (say "andrea" (get_dialog dialogs language 9) "quietdwmovie_track9") ;preview: Really? | animation back
          (director_wait_time 2.0)
          (puppeteer_set "andrea" "scratch_front")
          (say "andrea" (get_dialog dialogs language 10) "quietdwmovie_track10") ;preview: What year is this? | animation back
          (director_wait_time 1.0)
          (puppeteer_set "andrea" "back")
          (director_wait_time 2.0)
          (say "andrea" (get_dialog dialogs language 11) "quietdwmovie_track11") ;preview: Diomatonne . . . | animation back
          (director_wait_time 1.0)
          (effecteer_delete "internet_connection_noise")

          (say "andrea" (get_dialog dialogs language 12) "quietdwmovie_track12") ;preview: Done! | animation back
          (say "andrea" (get_dialog dialogs language 13) "quietdwmovie_track13") ;preview: Now, let me search for Torre... | animation back
          ;Script suggestion: Andrea scrive sul computer
          ;Script suggestion: Andrea scrive sul computer
          (puppeteer_set "andrea" "back_code")
          (director_wait_time 2.0)
          (puppeteer_set "andrea" "back")
          (say "andrea" (get_dialog dialogs language 14) "quietdwmovie_track14") ;preview: Here it is! | animation back
          (say "andrea" (get_dialog dialogs language 15) "quietdwmovie_track15") ;preview: So many feeds, the download ... | animation back
          (say "andrea" (get_dialog dialogs language 16) "quietdwmovie_track16") ;preview: And this is very, very sad, ... | animation back
          ;Script suggestion: Andrea scrive sul computer
          ;Script suggestion: Andrea scrive sul computer
          (puppeteer_set "andrea" "back_code")
          (director_wait_time 2.0)
          (puppeteer_set "andrea" "back")
          (say "andrea" (get_dialog dialogs language 17) "quietdwmovie_track17") ;preview: 10% | animation back
          (say "andrea" (get_dialog dialogs language 18) "quietdwmovie_track18") ;preview: 30% | animation back
          (say "andrea" (get_dialog dialogs language 19) "quietdwmovie_track19") ;preview: 60% | animation back
          (say "andrea" (get_dialog dialogs language 20) "quietdwmovie_track20") ;preview: 80% | animation back
          (say "andrea" (get_dialog dialogs language 21) "quietdwmovie_track21") ;preview: Done! | animation back
          (say "andrea" (get_dialog dialogs language 22) "quietdwmovie_track22") ;preview: Let me copy it on my USB key... | animation back
          ;Script suggestion: Andrea scrive sul computer
          ;Script suggestion: Andrea scrive sul computer
          (puppeteer_set "andrea" "back_code")
          (director_wait_time 2.0)
          (puppeteer_set "andrea" "back")
          (say "andrea" (get_dialog dialogs language 23) "quietdwmovie_track23") ;preview: Done! | animation front

          ;And never again
          (collector_set "got_movie"    1.0)
          (collector_set "got_internet" 0.0)
          (collector_set "got_disk"     0.0)
          (collector_set "done_movie"   1.0)

          ;Refresh interface
          (director_script "update_items_interface"))
        (begin
          (say "andrea" (get_dialog dialogs language 8) "quietdwmovie_track8") ;preview: Finally I have an Internet c... | animation back
          (say "andrea" (get_dialog dialogs language 24) "quietdwmovie_track24") ;preview: However . . . | animation back
          (puppeteer_set "andrea" "front")
          (say "andrea" (get_dialog dialogs language 25) "quietdwmovie_track25")) ;preview: . . . there is no point in d... | animation front
        )
      (begin
        (say "andrea" (get_dialog dialogs language 4) "quietdwmovie_track4") ;preview: I would like to download 'I ... | animation back
        (puppeteer_set "andrea" "front")
        (say "andrea" (get_dialog dialogs language 5) "quietdwmovie_track5") ;preview: . . . but this kind of opera... | animation front
        (puppeteer_set "andrea" "scratch_front")
        (say "andrea" (get_dialog dialogs language 6) "quietdwmovie_track6") ;preview: A Internet connection that I... | animation front
        (say "andrea" (get_dialog dialogs language 7) "quietdwmovie_track7") ;preview: A bad condition that is part... | animation front

        ;Now is it possible to take THE INTERNET
        (collector_set "request_internet" 1.0))
      )
    (begin
      (say "andrea" (get_dialog dialogs language 1) "quietdwmovie_track1") ;preview: My Mac . . . | animation back
      (say "andrea" (get_dialog dialogs language 2) "quietdwmovie_track2") ;preview: This is a fantastic computer! | animation back
      (puppeteer_set "andrea" "front")
      (say "andrea" (get_dialog dialogs language 3) "quietdwmovie_track3")) ;preview: With a fantastic operating s... | animation front
    )
  )

;Return the control
(main_control "andrea")
