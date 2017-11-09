;Pomodoro - I have no money and I must eat an ice cream
;Module: quiet_update_innamorati
;Author: nardinan
;Date  : 27 Sept 2017
;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 marta
                    "Look, what is this about?"
                    "Ma si puo' sapere che ti prende?")
                  (cons ;2 marta
                    "I will show you 'Lost' again from the beginning to the end, eh!"
                    "Guarda che ti faccio vedere di nuovo Lost dall'inizio alla fine, eh?")
                  (cons ;3 marta
                    "Please, talk to me!"
                    "Parla, ti prego!")
                  (cons ;4 marta
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

;Parameters configuration
(define marta_quiet_dialog      (collector_get "marta_quiet_dialog"))
(define marta_quiet_discussing  (collector_get "marta_quiet_discussing"))
(define marta_quiet_answer      (collector_get "marta_quiet_answer"))

(if (= marta_quiet_dialog 1.0)
  nil
  (if (= marta_quiet_discussing 1.0)
    nil
    (begin
      (if (= marta_quiet_answer 0.0)
        (say "marta" (get_dialog dialogs language 1) "mbrquiet_track19") ;preview: Look, what is this about? | looking at Bruno
        (if (= marta_quiet_answer 1.0)
          (say "marta" (get_dialog dialogs language 2) "mbrquiet_track20") ;preview: I will show you 'Lost' again... | looking at Bruno
          (if (= marta_quiet_answer 2.0)
            (say "marta" (get_dialog dialogs language 3) "mbrquiet_track21") ;preview: Please, talk to me! | looking at Bruno
            (say "marta" (get_dialog dialogs language 4) "mbrquiet_track22") ;preview: Tell me what is going on! | looking at Bruno
            )
          )
        )
      )
    )
  )

;Configure environment for the next hop
(define marta_next_quiet_answer (+ marta_quiet_answer 1.0))
(if (> marta_next_quiet_answer 3.0)
  (collector_set "marta_quiet_answer" 0.0)
  (collector_set "marta_quiet_answer" marta_next_quiet_answer)
  )
