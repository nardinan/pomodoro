;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : lemvirus
;Location   : Panoramica
;Author     : Nardinan
;Description: Andrea wants a lemon from the lemon tree

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 andrea
   "This lemon tree has seen better days . . ."
   "Questo albero di limoni sembra aver visto giorni migliori . . .")
  (cons ;2 andrea
   "Uhm . . ."
   "Uhm . . .")
  (cons ;3 andrea
   "I would like to take a lemon but, apparently, there is an incredibly powerful force field that stops me!"
   "Vorrei prendere un limone ma sembrerebbe che ci sia un campo di forza che non me lo permette!")
  (cons ;4 andrea
   "Seems alien military technology!"
   "Sembra tecnologia aliena militare!")
  (cons ;5 andrea
   "What kind of trick is this?"
   "Che trucco e' questo!")
  (cons ;6 maria
   "No sci-fi explanations mate . . ."
   "Nessuna spegazione da film di fantascienza . . .")
  (cons ;7 maria
   ". . . you are just too short."
   ". . . sei solo estremamente basso.")
  (cons ;8 andrea
   "I liked her better when she was stuck in the time loop."
   "La preferivo quand'era bloccata nel loop temporale.")
  (cons ;9
   "Maybe I could search for something to launch at it . . ."
   "Magari posso cercare qualcosa da tirare per far cadere un limone.")
  (cons ;10 andrea
   "Again?"
   "Ancora?")
  (cons ;11 andrea
   "We have established that I'm too short."
   "Abbiamo appurato che sono troppo basso.")
  (cons ;12
   "Maybe I could search for something to launch at it . . ."
   "Magari posso cercare qualcosa da tirare per far cadere un limone.")
  (cons ;13 andrea
   "I can try to launch this shoe . . ."
   "Posso provare a tirare questa scarpa . . .")
  (cons ;14 andrea
   "Ngh!"
   "Ngh!")
  (cons ;15 andrea
   "Eh eh eh"
   "Eh eh eh")
  (cons ;16 andrea
   "I'm a genius!"
   "Sono un genio!")
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
(define got_shoe       (collector_get "got_shoe"))
(define request_shoe   (collector_get "request_shoe"))
(define request_lemon  (collector_get "request_lemon"))
(define done_lemon     (collector_get "done_lemon"))

;Action!
(puppeteer_move "andrea" 3980)
(director_wait_movement "andrea")
(animation "andrea" "back")
(if (= request_lemon 1.0)
  (if (= done_lemon 1.0)
    (say "andrea" (get_dialog dialogs language 1) "lemvirus_track1") ;preview: This lemon tree has seen bet... | animation back
    (if (= got_shoe 1.0)
      (begin
        (say "andrea" (get_dialog dialogs language 13) "lemvirus_track13") ;preview: I can try to launch this sho... | animation front
        (say "andrea" (get_dialog dialogs language 14) "lemvirus_track14") ;preview: Ngh! | animation back
        ;Animation
        (stagecrafter_set_item "lemon_tree_A" "drop_lemon")
        (director_wait_time 2.0)
        (stagecrafter_set_item "lemon_tree_A" "still_B")

        (collector_set "got_shoe" 0.0)
        (collector_set "got_lemon" 1.0)
        (collector_set "done_lemon" 1.0)

        ;Refresh interface
        (director_script "update_items_interface")

        (say "andrea" (get_dialog dialogs language 15) "lemvirus_track15") ;preview: Eh eh eh | animation back
        (animation "andrea" "front")
        (say "andrea" (get_dialog dialogs language 16) "lemvirus_track16")) ;preview: I'm a genius! | animation front
      (if (= request_shoe 1.0)
        (begin
          (say "andrea" (get_dialog dialogs language 10) "lemvirus_track10") ;preview: Again? | animation front
          (animation "andrea" "front")
          (say "andrea" (get_dialog dialogs language 11) "lemvirus_track11") ;preview: We have established that I'm... | animation front
          (say "andrea" (get_dialog dialogs language 12) "lemvirus_track12")) ;preview: Maybe I could search for som...
        (begin
          (say "andrea" (get_dialog dialogs language 2) "lemvirus_track2") ;preview: Uhm . . . | animation back
          (say "andrea" (get_dialog dialogs language 3) "lemvirus_track3") ;preview: I would like to take a lemon... | animation back
          (animation "andrea" "front")
          (say "andrea" (get_dialog dialogs language 4) "lemvirus_track4") ;preview: Seems alien military technol... | animation front
          (animation "andrea" "scratch_front")
          (say "andrea" (get_dialog dialogs language 5) "lemvirus_track5") ;preview: What kind of trick is this? | animation front
          ;Script suggestion: La signora Maria passa da sinistra a destra dello schermo mentre parla
          (puppeteer_show "maria" 2600)
          (puppeteer_move "maria" 5200)
          (say_and_go "maria" (get_dialog dialogs language 6) "lemvirus_track6") ;preview: No sci-fi explanations mate ...
          (director_wait_time 1.0)
          (puppeteer_stare "andrea" "maria")
          (director_wait_message "maria")
          (say "maria" (get_dialog dialogs language 7) "lemvirus_track7") ;preview: . . . you are just too short
          (director_wait_movement "maria")
          (puppeteer_show "maria" -200)
          (puppeteer_stare "andrea" "#null")
          (animation "andrea" "front")
          (say "andrea" (get_dialog dialogs language 8) "lemvirus_track8") ;preview: I liked her better when she ... | animation front
          (animation "andrea" "back")
          (say "andrea" (get_dialog dialogs language 9) "lemvirus_track9") ;preview: Maybe I could search for som...
          ;And never again
          (collector_set "request_shoe" 1.0))
      )
    )
  )
  (say "andrea" (get_dialog dialogs language 1) "lemvirus_track1") ;preview: This lemon tree has seen bet... | animation back
)

;Return the control
(main_control "andrea")
