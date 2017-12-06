;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : plantechvirus
;Location   : Lupattelli
;Author     : Nardinan
;Description: You need to explain to the player the plan

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 andrea
                    "Hey, do you really want to give him the cocktail in this way?"
                    "Scusa, ma vuoi veramente dargli il cocktail cosi?")
                  (cons ;2 andrea
                    "Maybe is better if we find some kind of drugs to put in it so he will give us the key!"
                    "Non e' meglio trovare un qualche tipo di droga da metterci dentro per farci dare la chiave?")
                  (cons ;3 andrea
                    "Just to say . . ."
                    "Cosi' eh . . .")
                  (cons ;4 andrea
                    "I'm try to give you an idea of how this game works."
                    "Giusto per darti un'idea di come funziona il gioco.")
                  (cons ;5 andrea
                    "Hey, do you really want to give him the pills in this way?"
                    "Scusa ma vuoi veramente dargli le pillole cosi?")
                  (cons ;6 andrea
                    "Do you really think that he will accept these random pills?"
                    "Credi che accettera' di prendere delle pillole a caso?")
                  (cons ;7 andrea
                    "Maybe is better if we find something tasty to mix with these pills!"
                    "Non e' meglio trovare qualcosa in cui mettere le pillole?")
                  (cons ;8 andrea
                    "More or less the same approach when you have to give pills to the cat . . ."
                    "Tipo quando dai al gatto il medicinale . . . ")
                  (cons ;9 andrea
                    ". . . and you hide those pills in a delicious piece of meat!"
                    ". . . e per farglielo mangiare lo mischi con le crocchette!")
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
(define technician_virus_dialog_cocktail  (collector_get "technician_virus_dialog_cocktail"))
(define technician_virus_dialog_pills     (collector_get "technician_virus_dialog_pills"))
(collector_set "technician_virus_dialog_cocktail" 0.0)
(collector_set "technician_virus_dialog_pills" 0.0)

;Action!
(if (>= (+ technician_virus_dialog_cocktail technician_virus_dialog_pills) 1.0)
  (begin
    (puppeteer_move "andrea" 1600)
    (director_wait_movement "andrea")
    (puppeteer_set "andrea" "front")
    (if (= technician_virus_dialog_cocktail 1.0)
      (begin
        (say "andrea" (get_dialog dialogs language 1) "plantechvirus_track1") ;preview: Hey, do you really want to g... | animation front
        (say "andrea" (get_dialog dialogs language 2) "plantechvirus_track2") ;preview: Maybe is better if we find s... | animation front
        (say "andrea" (get_dialog dialogs language 3) "plantechvirus_track3") ;preview: Just to say . . . | animation front
        (say "andrea" (get_dialog dialogs language 4) "plantechvirus_track4")) ;preview: I'm try to give you an idea ... | animation front
      (begin
        (say "andrea" (get_dialog dialogs language 5) "plantechvirus_track5") ;preview: Hey, do you really want to g... | animation front
        (say "andrea" (get_dialog dialogs language 6) "plantechvirus_track6") ;preview: Do you really think that he ... | animation front
        (say "andrea" (get_dialog dialogs language 7) "plantechvirus_track7") ;preview: Maybe is better if we find s... | animation front
        (say "andrea" (get_dialog dialogs language 8) "plantechvirus_track8") ;preview: More or less the same approc... | animation front
        (say "andrea" (get_dialog dialogs language 9) "plantechvirus_track9")) ;preview: . . . and you hide those pil... | animation front
      ))
  )

;Refresh interface
(director_script "update_items_interface")

;Return the control
(main_control "andrea")
