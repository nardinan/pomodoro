;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : minichaos
;Location   :
;Author     : Madmoon
;Description: 15 mini dialogues for 15 privates around the city

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 private
                    "Move on, nothing to see here!"
                    "Circolare! ")
                  (cons ;2 andrea
                    "Yes sir!"
                    "Agli ordini!")
                  (cons ;3 private
                    "I can't speak!"
                    "Non posso parlare!")
                  (cons ;4 andrea
                    "Nobody asked you anything!"
                    "E chi ti ha chiesto niente!")
                  (cons ;5 private
                    "Go home boy!"
                    "Torna a casa ragazzo!")
                  (cons ;6 andrea
                    "I think I will do it!"
                    "Penso che lo faro'! ")
                  (cons ;7 private
                    "These blackouts will drive me crazy!"
                    "Questi blackout mi faranno impazzire!")
                  (cons ;8 andrea
                    "Don't tell me!"
                    "A chi lo dici!")
                  (cons ;9 private
                    "I wish I wasn't here!"
                    "Vorrei tanto non essere qui!")
                  (cons ;10 andrea
                    "I'd say we are well covered!"
                    "Direi che siamo ben protetti! ")
                  (cons ;11 private
                    "Why are you hanghing around these streets?"
                    "Perche' giri per queste strade?")
                  (cons ;12 andrea
                    "Indeed I ask the same thing to myself . . ."
                    "In effetti me lo chiedo anche io . . . ")
                  (cons ;13 private
                    "Where can I go for a beer tonight?"
                    "Dove posso andare per una birra stasera?")
                  (cons ;14 andrea
                    "Easy, go to the Elfo!"
                    "Facile, vai all'Elfo!")
                  (cons ;15 private
                    "This city is scaring me!"
                    "Questa citta' mi mette paura!")
                  (cons ;16 andrea
                    "Now, I'm scared as well!"
                    "Adesso anche a me!")
                  (cons ;17 private
                    "For godness sake, go home before nightfall!"
                    "Mi raccomando torna a casa prima che faccia notte!")
                  (cons ;18 andrea
                    "Sure . . ."
                    "Certo . . . ")
                  (cons ;19 private
                    "I hope you don't have the virus!"
                    "Spero tu non abbia il virus!")
                  (cons ;20 andrea
                    "Peraphs you have it!"
                    "Magari ce l'hai tu!")
                  (cons ;21 private
                    "Right in Perugia I had to finish!"
                    "Proprio a Perugia dovevo finire!")
                  (cons ;22 andrea
                    "You're luck, you could have been moved to Terni! "
                    "Ti e' andata bene, pensa se fossi capitato a Terni!")
                  (cons ;23 private
                    "I don't understand what we can do against the virus!"
                    "Non capisco cosa potremmo fare noi contro il virus!")
                  (cons ;24 andrea
                    "Are you serious?"
                    "Sei serio? ")
                  (cons ;25 private
                    "Do you feel safe in this city?"
                    "Ti senti tranquillo in questa citta'?")
                  (cons ;26 andrea
                    "Yes, definetevely yes!"
                    "Si, direi proprio di si!")
                  (cons ;27 private
                    "Don't worry boy, soon everything will get back to normal!"
                    "Non ti preoccupare ragazzo, presto sara' tutto tornato alla normalita'!")
                  (cons ;28 andrea
                    "I'm not worried, I'm hungry!"
                    "Io non sono preoccupato, ho fame!")
                  (cons ;29 private
                    "You seem to be a nice person, don't look for any trouble! "
                    "Sembri una persona simpatica, non andare a cercare problemi! ")
                  (cons ;30 andrea
                    "The only thing I'm looking for are money! "
                    "L'unica cosa che cerco sono dei soldi! ")
                  (cons ;31 private
                    "Please, let me work in peace!"
                    "Per favore, lasciami lavorare in pace! ")
                  (cons ;32 andrea
                    "I will not let you asking me one more time! "
                    "Non me lo faro' chiedere un'altra volta!")
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
(define chaos_private_and_andrea_line   (collector_get "chaos_private_and_andrea_line"))
(define current_private                 (collector_get "current_private"))
(define current_line                    (+ (* chaos_private_and_andrea_line 2.0) 1.0))

;Action!
(puppeteer_stare current_private "andrea")
(puppeteer_look "andrea" current_private)
(say current_private (get_dialog dialogs language current_line)) ;preview: * | looking at Andrea
(say "andrea" (get_dialog dialogs language (+ current_line 1.0))) ;preview: * | looking at Private

;Configure environment for the next hop
(define chaos_private_and_andrea_next_line (+ chaos_private_and_andrea_line 1.0))
(if (> chaos_private_and_andrea_next_line 15.0)
  (collector_set "chaos_private_and_andrea_line" 0.0)
  (collector_set "chaos_private_and_andrea_line" chaos_private_and_andrea_next_line)
  )

;Return the control
(main_control "andrea")
