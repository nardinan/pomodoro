;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : fevirus
;Location   : Panoramica
;Author     : Madmoon
;Description: You meet Federico in Panoramica

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 federico
   "Shhhh!"
   "Shhhh!")
  (cons ;2 federico
   "I am going to take an amazing picture!"
   "Sto per fare una foto da paura! ")
  (cons ;3 andrea
   "This is Federico!"
   "Questo e' Federico!")
  (cons ;4 andrea
   "A friend of mine and the brother of my girlfriend."
   "Mio amico e fratello della mia ragazza.")
  (cons ;5 andrea
   "He is a musician and a professional photographer!"
   "Musicista e fotografo professionista!")
  (cons ;6 andrea
   "Better known as Fettina."
   "Meglio conosciuto come Fettina.")
  (cons ;7 andrea
   "He's a great connoisseur of Simpson."
   "E' un grande intenditeur di Simpson.")
  (cons ;8 federico
   "Ulala!"
   "Ulala'!")
  (cons ;9 federico
   "The sir speaks french now!"
   "Il signore parla francese adesso!")
  (cons ;10 andrea
   "He has the power to break his computers! "
   "Ha il potere di rompere i computer! ")
  (cons ;11 andrea
   "He's genetically prone to the coffee break and animals' collection at home."
   "Geneticamente predisposto alla pausa caffe' e alla collezione di animali in casa.")
  (cons ;12 federico
   "Look, I don't know with who you are speaking . . ."
   "Senti non so con chi ce l'hai . . .")
  (cons ;13 federico
   ". . . but please keep some things for you! "
   ". . . ma ti prego di tenere certe cose riservate per te! ")
  (cons ;14 andrea
   "Sure, I'm sorry, I've just wanted . . . "
   "Certo, scusa, volevo solo . . .")
  (cons ;15 andrea
   "No matter!"
   "Fa niente!")
  (cons ;16 andrea
   "By the way what do you do here?"
   "Piuttosto che ci fai da queste parti?")
  (cons ;17 federico
   "Photos."
   "Foto.")
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
(define dialog_done         (collector_get "federico_virus_dialog"))
(define request_pills       (collector_get "request_pills"))
(define request_battery     (collector_get "request_battery"))
(define got_battery         (collector_get "got_battery"))
(define done_pills          (collector_get "done_pills"))

;Action!
(puppeteer_look "andrea" "federico")
(puppeteer_look "federico" "andrea")
(if (= dialog_done 1.0)
  (director_dialog "game_federico_intro_after_0x0b")
  (begin
    (say "federico" (get_dialog dialogs language 1) "fevirus_track1") ;preview: Shhhh! | looking at Andrea | animation pointing
    (say "federico" (get_dialog dialogs language 2) "fevirus_track2") ;preview: I am going to take an amazin... | looking at Andrea
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 3) "fevirus_track3") ;preview: This is Federico! | animation front
    (say "andrea" (get_dialog dialogs language 4) "fevirus_track4") ;preview: A friend of mine and the bro... | animation front
    (say "andrea" (get_dialog dialogs language 5) "fevirus_track5") ;preview: He is a musician and a profe... | animation front
    (say "andrea" (get_dialog dialogs language 6) "fevirus_track6") ;preview: Better known as Fettina. | animation front
    (say "andrea" (get_dialog dialogs language 7) "fevirus_track7") ;preview: He's a great connoisseur of ... | animation front
    ;Script suggestion: Federico interrompe Andrea
    (say_and_go "federico" (get_dialog dialogs language 8) "fevirus_track8") ;preview: Ulala! | looking at Andrea | animation pointing
    (director_wait_time 1.0)
    (puppeteer_look "andrea" "federico")
    (director_wait_message "federico")
    (say "federico" (get_dialog dialogs language 9) "fevirus_track9") ;preview: The sir speaks french now!
    (director_wait_time 2.0)
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 10) "fevirus_track10") ;preview: He has the power to break hi... | looking at Federico | animation front
    (say "andrea" (get_dialog dialogs language 11) "fevirus_track11") ;preview: He's genetically prone to th... | animation front
    (say_and_go "federico" (get_dialog dialogs language 12) "fevirus_track12") ;preview: Look, I don't know with who ... | looking at Andrea | animation scratching his head
    (director_wait_time 1.0)
    (puppeteer_look "andrea" "federico")
    (director_wait_message "andrea")
    (director_wait_message "federico")
    (say "federico" (get_dialog dialogs language 13) "fevirus_track13") ;preview: . . . but please keep some t... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 14) "fevirus_track14") ;preview: Sure, I'm sorry, I've just w... | looking at Federico
    (say "andrea" (get_dialog dialogs language 15) "fevirus_track15") ;preview: No matter! | looking at Federico
    (say "andrea" (get_dialog dialogs language 16) "fevirus_track16") ;preview: By the way what do you do he... | looking at Federico | animation pointing
    (say "federico" (get_dialog dialogs language 17) "fevirus_track17") ;preview: Photos. | looking at Andrea
    (director_dialog "game_federico_intro_first_0x0b")

    ;And never again
    (collector_set "federico_virus_dialog" 1.0))
  )
(director_wait_dialog)
(if (= request_pills 1.0)
  (if (= done_pills 1.0)
    (director_dialog "game_federico_done_0x0b")
    (if (>= got_battery 1.0)
      (director_dialog "game_federico_requested_tool_0x0b")
      (if (>= request_battery 1.0)
        (director_dialog "game_federico_requested_no_tool_0x0b")
        (director_dialog "game_federico_activated_no_tool_0x0b")
        )
      )
    )
  (director_dialog "game_federico_no_request_0x0b")
  )
(director_wait_dialog)
(puppeteer_set "federico" "back")

;Refresh interface
(director_script "update_items_interface")

;Return the control
(main_control "andrea")
