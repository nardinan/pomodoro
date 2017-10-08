;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : margiaquiet
;Location   : Corso Vannucci
;Author     : Nardinan
;Description: Mariano and Gianni discuss about the current situation, before the character interrupts them

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 gianni
   "It's drug business and petty crime."
   "Tutto un problema di droga e microcriminalita'.")
  (cons ;2 mariano
   "It is impossible to go around, safely."
   "Adesso e' impossibile circolare in tranquillita'.")
  (cons ;3 gianni
   "The police should take care of this stuation, and they should not do only tickets"
   "La polizia qui dovrebbe impegnarsi di piu' e non dovrebbe solo far multe")
  (cons ;4 mariano
   "They should close pubs at eight in the evening!"
   "Dovrebbero chiudere i locali alle otto di sera!")
  (cons ;5 gianni
   "The major is not doing his job!"
   "Il sindaco non si sta impegnando come dovrebbe!")
  (cons ;6 mariano
   "Bad people!"
   "Brutta gente!")
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
(define quiet_mariano_and_gianni_line (collector_get "quiet_mariano_and_gianni_line"))

;Parameters configuration
(define quiet_mariano_and_gianni_line      (collector_get "quiet_mariano_and_gianni_line"))
(define quiet_mariano_and_gianni_ongoing   (collector_get "quiet_mariano_and_gianni_ongoing"))

(if (= quiet_mariano_and_gianni_ongoing 1.0)
  nil
  (begin
    (puppeteer_look "gianni" "mariano")
    (puppeteer_look "mariano" "gianni")
    (if (= quiet_mariano_and_gianni_line 0.0)
      (say "gianni" (get_dialog dialogs language 1) "margiaquiet_track1") ;preview: It's drug business and petty... | looking at Mariano
      (if (= quiet_mariano_and_gianni_line 1.0)
        (say "mariano" (get_dialog dialogs language 2) "margiaquiet_track2") ;preview: It is impossible to go aroun... | looking at Gianni
        (if (= quiet_mariano_and_gianni_line 2.0)
          (say "gianni" (get_dialog dialogs language 3) "margiaquiet_track3") ;preview: The police should take care ... | looking at Mariano
          (if (= quiet_mariano_and_gianni_line 3.0)
            (say "mariano" (get_dialog dialogs language 4) "margiaquiet_track4") ;preview: They should close pubs at ei... | looking at Gianni
            (if (= quiet_mariano_and_gianni_line 4.0)
              (say "gianni" (get_dialog dialogs language 5) "margiaquiet_track5") ;preview: The major is not doing his j... | looking at Mariano
              (if (= quiet_mariano_and_gianni_line 5.0)
                (say "mariano" (get_dialog dialogs language 6) "margiaquiet_track6") ;preview: Bad people! | looking at Gianni
                nil
              )
            )
          )
        )
      )
    )
  )
)

;Configure environment for the next hop
(define quiet_mariano_and_gianni_next_line (+ quiet_mariano_and_gianni_line 1.0))
(if (> quiet_mariano_and_gianni_next_line 5.0)
  (collector_set "quiet_mariano_and_gianni_line" 0.0)
  (collector_set "quiet_mariano_and_gianni_line" quiet_mariano_and_gianni_next_line)
)
