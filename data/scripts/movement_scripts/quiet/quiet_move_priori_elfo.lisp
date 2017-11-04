;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : crisntquiet
;Location   : Via Priori
;Author     : Nardinan
;Description: Cristiano explains you that the only way to enter in Elfo is to have a tie. No tie, no in.

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 cristiano
   "Ehy, where do you think you are going?"
   "Ehi, dove credi di andare?")
  (cons ;2 andrea
   "Ehm"
   "Ehm")
  (cons ;3 andrea
   "Inside?"
   "Dentro?")
  (cons ;4 cristiano
   "Are you serious?"
   "Sei serio?")
  (cons ;5 andrea
   "Yes?"
   "Si?")
  (cons ;6 cristiano
   "I don't think so mate."
   "Non credo proprio.")
  (cons ;7 cristiano
   "They pay me to keep people dressed like you out of places like this!"
   "Mi pagano per tenere gente vestita come te fuori da posti come questi!")
  (cons ;8 andrea
   "What's the problem with my dress?"
   "Non capisco, cos'ho che non va?")
  (cons ;9 cristiano
   "Try to be a little bit more elegant than that . . ."
   "Fai almeno un piccolo sforzo per essere piu' elegante . . .")
  (cons ;10 cristiano
   ". . . and I'll let you in."
   ". . . e ti lascero' entrare.")
  (cons ;11 andrea
   "So?"
   "Quindi?")
  (cons ;12 cristiano
   "So, what?"
   "Quindi, cosa?")
  (cons ;13 andrea
   "What do you think about my new tie?"
   "Cosa ne pensi della mia cravatta?")
  (cons ;14 cristiano
   "I . . ."
   "Io . . .")
  (cons ;15 cristiano
   "Liste, I feel so sorry for you that I will let you in"
   "Ascolta, mi fai cosi' tanta pena che ti lascero' entrare")
  (cons ;16 andrea
   "Thankfully people feel sorry for me every time"
   "La pena e' il mio cavallo di battaglia")
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
(define request_tie (collector_get "request_tie"))
(define got_tie (collector_get "got_tie"))
(define approved_tie (collector_get "approved_tie"))

;Environment configuration (music, effect, whatever)
(puppeteer_disable_control)

;Action!
(if (= approved_tie 1.0)
  (begin
    (collector_set "destination_scenario" "elfo")
    (director_script "change_scenario"))
  (if (= got_tie 1.0)
    (begin
      (animation "andrea" "still_left")
      (say "andrea" (get_dialog dialogs language 11) "crisntquiet_track11") ;preview: So? | looking at Cristiano
      (animation "cristiano" "still_right")
      (director_wait_time 2.0)
      (say "cristiano" (get_dialog dialogs language 12) "crisntquiet_track12") ;preview: So, what? | looking at Andrea
      (animation "andrea" "point_left")
      (say "andrea" (get_dialog dialogs language 13) "crisntquiet_track13") ;preview: What do you think about my n... | looking at Cristiano
      (animation "andrea" "still_left")
      ;Script suggestion: Cristiano guarda Andrea qualche secondo
      (say "cristiano" (get_dialog dialogs language 14) "crisntquiet_track14") ;preview: I . . . | looking at Andrea
      ;Script suggestion: Pausa
      (director_wait_time 2.0)
      (say "cristiano" (get_dialog dialogs language 15) "crisntquiet_track15") ;preview: Liste, I feel so sorry for y... | looking at Andrea
      (animation "andrea" "front")
      (say "andrea" (get_dialog dialogs language 16) "crisntquiet_track16") ;preview: Thankfully people feel sorry... | animation front
      (animation "cristiano" "front")

      ;And never again
      (collector_set "approved_tie" 1.0)

      ;Advance to the next chapter
      (collector_set "current_chapter" "virus")
      (collector_set "show_chapter_two" 1.0)

      ;Setup characters
      (main_control "andrea"))
    (begin
      ;Fake "I am going in ..."
      (animation "andrea" "back")
      (if (= request_tie 1.0)
        nil
        (begin
          (animation "cristiano" "point_right")
          (say "cristiano" (get_dialog dialogs language 1) "crisntquiet_track1") ;preview: Ehy, where do you think you ... | looking at Andrea | animation pointing
          (animation "cristiano" "still_right")
          (animation "andrea" "still_left")
          (say "andrea" (get_dialog dialogs language 2) "crisntquiet_track2") ;preview: Ehm | looking at Cristiano
          (say "andrea" (get_dialog dialogs language 3) "crisntquiet_track3") ;preview: Inside? | looking at Cristiano
          (say "cristiano" (get_dialog dialogs language 4) "crisntquiet_track4") ;preview: Are you serious? | looking at Andrea
          (animation "andrea" "scratch_left")
          (say "andrea" (get_dialog dialogs language 5) "crisntquiet_track5") ;preview: Yes? | looking at Cristiano | animation scratching his head
          (animation "cristiano" "front")
          (say "cristiano" (get_dialog dialogs language 6) "crisntquiet_track6") ;preview: I don't think so mate. | animation front
          (say "cristiano" (get_dialog dialogs language 7) "crisntquiet_track7") ;preview: They pay me to keep people d... | animation front
          (animation "andrea" "scratch_left")
          (say "andrea" (get_dialog dialogs language 8) "crisntquiet_track8") ;preview: What's the problem with my d... | looking at Cristiano | animation scratching his head
          (animation "cristiano" "still_right")
          (director_wait_time 2.0)

          ;And never again
          (collector_set "request_tie" 1.0))
      )
      ;Script suggestion: Cristiano guarda Andrea qualche secondo
      (animation "cristiano" "still_right")
      (say "cristiano" (get_dialog dialogs language 9) "crisntquiet_track9") ;preview: Try to be a little bit more ... | animation front
      (animation "andrea" "still_left")
      (animation "cristiano" "front")
      (say "cristiano" (get_dialog dialogs language 10) "crisntquiet_track10")

      ;Setup characters
      (main_control "andrea")) ;preview: . . . and I'll let you in. | animation front
  )
)
