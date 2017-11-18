;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : robcrzvirus
;Location   : Piazza S. Francesco
;Author     : Nardinan
;Description: Robero is infected with the virus

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 roberto
                    "Oh Andrea . . ."
                    "Oh Andrea . . .")
                  (cons ;2 roberto
                    ". . . are you always hanging around?"
                    ". . . ma tu sei sempre in giro?")
                  (cons ;3 andrea
                    "Mah!"
                    "Mah!")
                  (cons ;4 andrea
                    "You know Roberto . . ."
                    "Ti diro' Roberto . . .")
                  (cons ;5 andrea
                    ". . . sometimes I just spend my time minding my own business."
                    ". . . ogni tanto mi piace farmi i cazzi miei.")
                  (cons ;6 andrea
                    "You should try!"
                    "Dovresti provarlo!")
                  (cons ;7 roberto
                    "You are a kidder, mate!"
                    "Che burlone!")
                  (cons ;8 andrea
                    "Kidder?"
                    "Che burlone?")
                  (cons ;9 andrea
                    "This sound something that Roberto would never say!"
                    "Non e' una cosa che Roberto avrebbe detto!")
                  (cons ;10 andrea
                    "What is going on?"
                    "Che succede?")
                  (cons ;11 roberto
                    "Are you cra - pick_answer.bin[44]: segfault at fa223b error 12"
                    "Sei matt - pick_answer.bin[44]: segfault at fa223b error 12")
                  (cons ;12 roberto
                    "I am Rob - introduce.bin[44]: segfault at ba654a error 23"
                    "Sono Ro - introduce.bin[44]: segfault at ba654a error 23")
                  (cons ;13 andrea
                    "Oh, you are infected, aren't you?"
                    "Oh, sei infetto, vero?")
                  (cons ;14 roberto
                    "No, I am not."
                    "No, non lo sono.")
                  (cons ;15 andrea
                    "Uhm, I think you are."
                    "Uhm, credo che tu lo sia.")
                  (cons ;16 andrea
                    ". . ."
                    ". . .")
                  (cons ;17 roberto
                    ". . ."
                    ". . .")
                  (cons ;18 andrea
                    "So?"
                    "Beh?")
                  (cons ;19 roberto
                    "<Roberto.bin is not responding err 0x000b>"
                    "<Roberto.bin is not responding err 0x000b>")
                  (cons ;20 andrea
                    "Intriguing discussion."
                    "Converazione intrigante . . .")
                  (cons ;21 andrea
                    "If I were you, I would get it checked, Roberto!"
                    "Ma fossi in te mi farei vedere da un dottore, Roberto.")
                  (cons ;22 roberto
                    "Unable to compute, available data insufficient."
                    "Impossible computare, dati disponibili insufficienti.")
                  (cons ;23 andrea
                    "What?"
                    "Cosa?")
                  (cons ;24 roberto
                    "Does not compute."
                    "Non computa.")
                  (cons ;25 andrea
                    "You are quoting Alien, aren't you?"
                    "Ma cosa fai, citi Alien?")
                  (cons ;26 andrea
                    ". . ."
                    ". . .")
                  (cons ;27 roberto
                    ". . ."
                    ". . .")
                  (cons ;28 roberto
                    "<Roberto.bin is not responding err 0x000b>"
                    "<Roberto.bin is not responding err 0x000b>")
                  (cons ;29 andrea
                    "Oh, he really does not compute."
                    "Oh, non computa veramente.")
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
(define dialog_done         (collector_get "roberto_virus_dialog"))
(define andrea_position     (puppeteer_get_position "andrea"))
(define roberto_position    (puppeteer_get_position "roberto"))

;Calculate position of the technician in respect of andrea
(define roberto_still_side    "still_left")
(define roberto_point_side    "point_left")
(define roberto_scratch_side  "scratch_left")
(define andrea_still_side     "still_right")
(define andrea_point_side     "point_right")
(define andrea_scratch_side   "scratch_right")
(if (> andrea_position roberto_point_side)
  (begin
    (define roberto_still_side    "still_right")
    (define roberto_point_side    "point_right")
    (define roberto_scratch_side  "scratch_right")
    (define andrea_still_side     "still_left")
    (define andrea_point_side     "point_left")
    (define andrea_scratch_side   "scratch_left"))
  nil
  )

;Action!
(puppeteer_stare "roberto" "#null")
(puppeteer_look "roberto" "andrea")
(puppeteer_look "andrea" "roberto")
(if (= dialog_done 1.0)
  (begin
    (say "roberto" (get_dialog dialogs language 22) "robcrzvirus_track22") ;preview: Unable to compute, available... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 23) "robcrzvirus_track23") ;preview: What? | looking at Roberto
    (say "roberto" (get_dialog dialogs language 24) "robcrzvirus_track24") ;preview: Does not compute. | looking at Andrea
    (say "andrea" (get_dialog dialogs language 25) "robcrzvirus_track25") ;preview: You are quoting Alien, aren'... | looking at Roberto
    (say "andrea" (get_dialog dialogs language 26) "robcrzvirus_track26") ;preview: . . . | looking at Roberto
    (say "roberto" (get_dialog dialogs language 27) "robcrzvirus_track27") ;preview: . . . | looking at Andrea
    (say "roberto" (get_dialog dialogs language 28) "robcrzvirus_track28") ;preview: <Roberto.bin is not respondi... | looking at Andrea
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 29) "robcrzvirus_track29")) ;preview: Oh, he really does not compu... | animation front
  (begin
    (say "roberto" (get_dialog dialogs language 1) "robcrzvirus_track1") ;preview: Oh Andrea . . . | looking at Andrea
    (say "roberto" (get_dialog dialogs language 2) "robcrzvirus_track2") ;preview: . . . are you always hanging... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 3) "robcrzvirus_track3") ;preview: Mah! | looking at Roberto
    (say "andrea" (get_dialog dialogs language 4) "robcrzvirus_track4") ;preview: You know Roberto . . . | looking at Roberto
    (say "andrea" (get_dialog dialogs language 5) "robcrzvirus_track5") ;preview: . . . sometimes I just spend... | looking at Roberto
    (say "andrea" (get_dialog dialogs language 6) "robcrzvirus_track6") ;preview: You should try! | looking at Andrea
    (say "roberto" (get_dialog dialogs language 7) "robcrzvirus_track7") ;preview: You are a kidder, mate! | looking at Roberto
    (say "andrea" (get_dialog dialogs language 8) "robcrzvirus_track8") ;preview: Kidder? | looking at Roberto
    (puppeteer_set "andrea" andrea_point_side)
    (say "andrea" (get_dialog dialogs language 9) "robcrzvirus_track9") ;preview: This sound something that Ro... | looking at Roberto | animation pointing
    (puppeteer_set "andrea" andrea_still_side)
    (say "andrea" (get_dialog dialogs language 10) "robcrzvirus_track10") ;preview: What is going on? | looking at Roberto
    (puppeteer_set "roberto" roberto_point_side)
    (say "roberto" (get_dialog dialogs language 11) "robcrzvirus_track11") ;preview: Are you cra - pick_answer.bi... | looking at Andrea | animation pointing
    (say_and_go "roberto" (get_dialog dialogs language 12) "robcrzvirus_track12") ;preview: I am Rob - introduce.bin[44]... | looking at Andrea
    (puppeteer_set "roberto" roberto_still_side)
    (director_wait_time 1.0)
    (puppeteer_set "roberto" roberto_point_side)
    (director_wait_time 1.0)
    (puppeteer_set "roberto" roberto_still_side)
    (director_wait_time 1.0)
    (puppeteer_set "roberto" roberto_point_side)
    (director_wait_time 1.0)
    (puppeteer_set "roberto" roberto_still_side)
    (director_wait_message "roberto")
    ;Script suggestion: Qui Roberto inizia a puntare continuamente.
    (say "andrea" (get_dialog dialogs language 13) "robcrzvirus_track13") ;preview: Oh, you are infected, aren't... | looking at Roberto
    (say "roberto" (get_dialog dialogs language 14) "robcrzvirus_track14") ;preview: No, I am not. | looking at Andrea
    (puppeteer_set "andrea" andrea_scratch_side)
    (say "andrea" (get_dialog dialogs language 15) "robcrzvirus_track15") ;preview: Uhm, I think you are. | looking at Roberto | animation scratching his head
    (say "andrea" (get_dialog dialogs language 16) "robcrzvirus_track16") ;preview: . . . | looking at Roberto
    (say "roberto" (get_dialog dialogs language 17) "robcrzvirus_track17") ;preview: . . . | looking at Andrea
    (say "andrea" (get_dialog dialogs language 18) "robcrzvirus_track18") ;preview: So? | looking at Roberto
    (say "roberto" (get_dialog dialogs language 19) "robcrzvirus_track19") ;preview: <Roberto.bin is not respondi... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 20) "robcrzvirus_track20") ;preview: Intriguing discussion. | looking at Roberto
    (say "andrea" (get_dialog dialogs language 21) "robcrzvirus_track21") ;preview: If I were you, I would get i... | looking at Roberto

    ;And never again
    (collector_set "roberto_virus_dialog" 1.0))
  )
(puppeteer_stare "roberto" "andrea")

;Return the control
(main_control "andrea")
