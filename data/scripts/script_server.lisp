;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : discgroupepilogue
;Location   : Unipg P1
;Author     : Nardinan
;Description: What if I disconnect the group?

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 andrea
                    "Uhm . . ."
                    "Uhm . . .")
                  (cons ;2 andrea
                    "I could try to shut it off!"
                    "Potrei provare a spegnerlo!")
                  (cons ;3 nerd
                    "Ehy!"
                    "Ehy!")
                  (cons ;4 nerd
                    "Don't even try to touch that thing, mate!"
                    "Non ci provare a toccare quel coso!")
                  (cons ;5 nerd
                    "I'll explode your hands and I'll cut off your balls!"
                    "Ti faccio saltare le mani e ti taglio le palle!")
                  (cons ;6 andrea
                    "Do you have an Oxford degree?"
                    "Il signorino s'e' laureato a Oxford?")
                  (cons ;7 nerd
                    "Yes, I have it."
                    "Anche li, si.")
                  (cons ;8 andrea
                    "Ah."
                    "Ah.")
                  (cons ;9 andrea
                    "Well, it's not funny like this."
                    "Beh cosi' non fa ridere.")
                  (cons ;10 andrea
                    "Done!"
                    "Ecco fatto!")
                  (cons ;11 andrea
                    "It's off!"
                    "E' spento")
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

;Collect environment
(define server_disconnected (collector_get "server_disconnected"))
(define current_chapter (collector_get "current_chapter"))

;Action!
(puppeteer_move "andrea" 7740)
(director_wait_movement "andrea")
(puppeteer_set "andrea" "back")
(if (compare current_chapter "epilogue")
  (begin
    (if (= server_disconnected 1.0)
      (begin
        (say "andrea" (get_dialog dialogs language 11) "discgroupepilogue_track11") ;preview: It's off | animation back
        (puppeteer_set "andrea" "front"))
      (begin
        (say "andrea" (get_dialog dialogs language 1) "discgroupepilogue_track1") ;preview: Uhm . . . | animation back
        (say "andrea" (get_dialog dialogs language 2) "discgroupepilogue_track2") ;preview: I could try to shut it off! | animation back
        (puppeteer_set "andrea" "back_code")
        (director_wait_time 2)
        (puppeteer_set "andrea" "back")
        (stagecrafter_set_item "rack_A" "still_A")
        (director_wait_time 1)
        (puppeteer_set "andrea" "front")
        (say "andrea" (get_dialog dialogs language 10) "discgroupepilogue_track10") ;preview: Done! | animation back
        (collector_set "server_disconnected" 1.0))
      ))
  (begin
    (say "andrea" (get_dialog dialogs language 1) "discgroupepilogue_track1") ;preview: Uhm . . . | animation back
    (say "andrea" (get_dialog dialogs language 2) "discgroupepilogue_track2") ;preview: I could try to shut it off! | animation back
    (puppeteer_set "nerd" "still_right")
    (stagecrafter_set_item "computer_A" "still_A")
    (say "nerd" (get_dialog dialogs language 3) "discgroupepilogue_track3") ;preview: Ehy! | looking at Andrea
    (puppeteer_set "andrea" "still_left")
    (puppeteer_set "nerd" "point_right")
    (say "nerd" (get_dialog dialogs language 4) "discgroupepilogue_track4") ;preview: Don't even try to touch that... | looking at Andrea
    (puppeteer_set "nerd" "still_right")
    (say "nerd" (get_dialog dialogs language 5) "discgroupepilogue_track5") ;preview: I'll explode your hands and ... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 6) "discgroupepilogue_track6") ;preview: Do you have an Oxford degree? | looking at Nerd
    (say "nerd" (get_dialog dialogs language 7) "discgroupepilogue_track7") ;preview: Yes, I have it. | looking at Andrea
    (say "andrea" (get_dialog dialogs language 8) "discgroupepilogue_track8") ;preview: Ah. | looking at Nerd
    (puppeteer_set "nerd" "back_code")
    (stagecrafter_set_item "computer_A" "coding_A")
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 9) "discgroupepilogue_track9")) ;preview: Well, it's not funny like th... | animation front
  )

(main_control "andrea")
