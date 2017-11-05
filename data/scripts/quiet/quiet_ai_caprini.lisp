;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : caprianvirus
;Location   : Elfo Pub
;Author     : Nardinan
;Description: Caprini tells Andrea that he puts the money in the Enel cabin

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
  (cons ;0 default
   ""
   "")
  (cons ;1 caprini
   "Stop!"
   "Fermati!")
  (cons ;2 caprini
   "I bet you want some money, didn't you?"
   "Scommetto che sei qui per i soldi.")
  (cons ;3 andrea
   "He is Luca!"
   "Lui e' Luca!")
  (cons ;4 andrea
   "A friend of mine and one of the game artists in Psycho Games!"
   "Amico e uno dei grafici storici della Psycho Games!")
  (cons ;5 andrea
   "Just like me, he is a student in the Department of Computer Science of the University of Perugia."
   "Anche lui studente del dipartimento di informatica dell'Universita' di Perugia.")
  (cons ;6 andrea
   "His nickname is 'Masterplan' but we call him 'Masturchief'."
   "Il suo nickname e' 'Masterplan' ma noi lo chiamiamo 'Masturchief'.")
  (cons ;7 caprini
   "You are the only one that calls me in that way . . ."
   "Sei il solo che mi chiama cosi' . . .")
  (cons ;8 caprini
   ". . . and I hate that name!"
   ". . . e lo odio!")
  (cons ;9 andrea
   "No, you like it!"
   "Ma no, ti piace!")
  (cons ;10 andrea
   "If I recall correctly, I met him the first time while I was . . ."
   "La prima volta che ci siamo conosciuti credo fosse . . .")
  (cons ;11 caprini
   "Are you crazy?"
   "Sei impazzito?")
  (cons ;12 caprini
   "Who you talking to?"
   "Con chi stai parlando?")
  (cons ;13 andrea
   "I . . ."
   "Io . . .")
  (cons ;14 andrea
   "Nobody."
   "Nessuno.")
  (cons ;15 caprini
   "Did you hear what is going on?"
   "Hai sentito cosa sta succedendo?")
  (cons ;16 andrea
   "Uhm . . ."
   "Uhm . . .")
  (cons ;17 andrea
   "Are you talking about the guy that has been killed in Piazza IV Novembre?"
   "Parli del morto in piazza IV Novembre?")
  (cons ;18 caprini
   "No, I am talking about the virus that has been released in the city . . ."
   "No, parlo del virus che si sta diffondendo per la citta' . . .")
  (cons ;19 caprini
   ". . . I am talking about Solaris!"
   ". . . Parlo di Solaris!")
  (cons ;20 andrea
   "What?!"
   "Cosa?!")
  (cons ;21 caprini
   "Seems that a virus has been released in the air and is contaminating the entire city of Perugia."
   "Sembrerebbe che un virus sia stato rilasciato nell'aria e stia lentamente contaminando tutta la citta'.")
  (cons ;22 caprini
   "They call it Solaris."
   "Solaris, cosi' lo chiamano.")
  (cons ;23 caprini
   "It makes people crazy!"
   "Rende la gente completamente pazza!")
  (cons ;24 andrea
   "Ehm . . ."
   "Ehm . . .")
  (cons ;25 andrea
   "As crazy as you are in this moment?"
   "Pazza come te in questo momento?")
  (cons ;26 caprini
   "Don't be facetious, I'm helping you!"
   "Non essere faceto, ti sto aiutando!")
  (cons ;27 andrea
   "OK, thanks for your help but now listen . . ."
   "OK, grazie per l'aiuto ma ora ascolta . . .")
  (cons ;28 andrea
   ". . . I need one hundred twenty euros and ninety five cents."
   ". . . avrei bisogno di centoventi euro e novantasette centesimi.")
  (cons ;29 caprini
   "I was right then."
   "Avevo ragione allora.")
  (cons ;30 caprini
   "You are looking for money, as always."
   "Sempre alla ricerca di soldi.")
  (cons ;31 caprini
   "You're so embarassing."
   "Sei imbarazzante.")
  (cons ;32 caprini
   "However I have no money with me and I don't want leave this place!"
   "Comunque non ho soldi con me e non ho intenzione di uscire da questo posto!")
  (cons ;33 andrea
   "Yes but, why?"
   "Perche'?")
  (cons ;34 caprini
   "Because I don't want to be infected!"
   "Perche' non vorrei che il virus infettasse anche me!")
  (cons ;35 andrea
   "I can go to grab your money if you want . . ."
   "Posso andare io a prenderti i soldi se vuoi . . .")
  (cons ;36 andrea
   ". . . so you can lend me some of them!"
   ". . . cosi' poi puoi prestarmeli!")
  (cons ;37 caprini
   "No pride at all, uh?"
   "Senza un briciolo di orgoglio eh?")
  (cons ;38 andrea
   "Pride is totally useless when they're threating to cut your power out!"
   "A che serve l'orgoglio quando minacciano di staccarti la corrente?")
  (cons ;39 caprini
   "Listen, I hid the last of my cash into the ENEL's cabin in Viale Innamorati."
   "Senti, ho nascosto gli unici soldi che mi sono rimasti dentro la cabina dell'ENEL in viale Innamorati.")
  (cons ;40 caprini
   "If you want, you can go there an take them."
   "Se vuoi, puoi andare li e prenderli.")
  (cons ;41 caprini
   "For all I care, I'll grab off that money from your cold, dead and contaminated by Solaris hands."
   "Per quel che mi riguarda, li strappero' dal tuo freddo cadavere contaminato dal Solaris quando sarai morto.")
  (cons ;42 andrea
   "OK!"
   "OK!")
  (cons ;43 andrea
   "Sounds good with me."
   "Mi sta bene.")
  (cons ;44 andrea
   "Where in Viale Innamorati?"
   "Ma in Viale Innamorati dove di preciso?")
  (cons ;45 caprini
   "Is a green door in Viale Innamorati."
   "E' una porta verde in viale Innamorati.")
  (cons ;46 caprini
   "Probably, is the only green door in Viale Innamorati."
   "Probabilmente e' l'unica porta verde in tutto viale Innamorati.")
  (cons ;47 andrea
   "It's time to go!"
   "Meglio Andare!")
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

;Action!
(puppeteer_move "andrea" 2600)
(director_wait_movement "andrea")

(puppeteer_stare "caprini" "#null")
(animation "andrea"  "still_right")
(animation "caprini" "point_left")
(say "caprini" (get_dialog dialogs language 1) "caprianvirus_track1") ;preview: Stop! | looking at Andrea | animation pointing
(animation "caprini" "still_left")
(say "caprini" (get_dialog dialogs language 2) "caprianvirus_track2") ;preview: I bet you want some money, d... | looking at Andrea
(animation "andrea" "front")
(say "andrea" (get_dialog dialogs language 3) "caprianvirus_track3") ;preview: He is Luca! | animation front
(say "andrea" (get_dialog dialogs language 4) "caprianvirus_track4") ;preview: A friend of mine and one of ... | animation front
(say "andrea" (get_dialog dialogs language 5) "caprianvirus_track5") ;preview: Just like me, he is a studen... | animation front
(say "andrea" (get_dialog dialogs language 6) "caprianvirus_track6") ;preview: His nickname is 'Masterplan'... | animation front
(animation "caprini" "point_left")
(say "caprini" (get_dialog dialogs language 7) "caprianvirus_track7") ;preview: You are the only one that ca... | looking at Andrea
(animation "caprini" "still_left")
(animation "andrea" "still_right")
(say "caprini" (get_dialog dialogs language 8) "caprianvirus_track8") ;preview: . . . and I hate that name! | looking at andrea
(say "andrea" (get_dialog dialogs language 9) "caprianvirus_track9") ;preview: No, you like it! | looking at Caprini
(animation "andrea" "front")
(say_and_go "andrea" (get_dialog dialogs language 10) "caprianvirus_track10") ;preview: If I recall correctly, I met... | animation front
(director_wait_time 2.0)
(say_and_go "caprini" (get_dialog dialogs language 11) "caprianvirus_track11") ;preview: Are you crazy? | looking at Andrea
(director_wait_time 1.0)
(animation "andrea" "still_right")
(director_wait_message "andrea")
(director_wait_message "caprini")
(animation "caprini" "front")
(say "caprini" (get_dialog dialogs language 12) "caprianvirus_track12") ;preview: Who you talking to? | animation front
(animation "caprini" "still_left")
(say "andrea" (get_dialog dialogs language 13) "caprianvirus_track13") ;preview: I . . . | looking at Caprini
(say "andrea" (get_dialog dialogs language 14) "caprianvirus_track14") ;preview: Nobody. | looking at Caprini
(say "caprini" (get_dialog dialogs language 15) "caprianvirus_track15") ;preview: Did you hear what is going on? | looking at Andrea
(animation "andrea" "scratch_right")
(say "andrea" (get_dialog dialogs language 16) "caprianvirus_track16") ;preview: Uhm . . . | looking at Caprini | animation scratching his head
(say "andrea" (get_dialog dialogs language 17) "caprianvirus_track17") ;preview: Are you talking about the gu... | looking at Caprini
(say "caprini" (get_dialog dialogs language 18) "caprianvirus_track18") ;preview: No, I am talking about the v... | looking at Andrea
(animation "caprini" "point_left")
(say "caprini" (get_dialog dialogs language 19) "caprianvirus_track19") ;preview: . . . I am talking about Sol... | looking at Andrea | animation pointing
(animation "caprini" "still_left")
(animation "andrea" "scratch_right")
(say "andrea" (get_dialog dialogs language 20) "caprianvirus_track20") ;preview: What?! | looking at Caprini | animation scratching his head
(say "caprini" (get_dialog dialogs language 21) "caprianvirus_track21") ;preview: Seems that a virus has been ... | looking at Andrea
(say "caprini" (get_dialog dialogs language 22) "caprianvirus_track22") ;preview: They call it Solaris.
(animation "caprini" "point_left")
(say "caprini" (get_dialog dialogs language 23) "caprianvirus_track23") ;preview: It makes people crazy! | looking at Andrea | animation pointing
(animation "caprini" "still_left")
(say "andrea" (get_dialog dialogs language 24) "caprianvirus_track24") ;preview: Ehm . . . | looking at Caprini
(animation "andrea" "point_right")
(say "andrea" (get_dialog dialogs language 25) "caprianvirus_track25") ;preview: As crazy as you are in this ... | looking at Caprini | animation pointing
(animation "andrea" "still_right")
(animation "caprini" "scratch_left")
(say "caprini" (get_dialog dialogs language 26) "caprianvirus_track26") ;preview: Don't be facetious, I'm help... | looking at Andrea | animation scratching his head
(say "andrea" (get_dialog dialogs language 27) "caprianvirus_track27") ;preview: OK, thanks for your help but... | looking at Caprini
(say "andrea" (get_dialog dialogs language 28) "caprianvirus_track28") ;preview: . . . I need one hundred twe... | looking at Caprini
(say "caprini" (get_dialog dialogs language 29) "caprianvirus_track29") ;preview: I was right then. | looking at Andrea
(animation "caprini" "point_left")
(say "caprini" (get_dialog dialogs language 30) "caprianvirus_track30") ;preview: You are looking for money, a... | looking at Andrea | animation pointing
(animation "caprini" "still_left")
(say "caprini" (get_dialog dialogs language 31) "caprianvirus_track31") ;preview: You're so embarassing. | looking at Andrea
(puppeteer_stare "andrea" "caprini")
(puppeteer_move "caprini" 1800)
(say "caprini" (get_dialog dialogs language 32) "caprianvirus_track32") ;preview: However I have no money with... | animation left
;Script suggestion: Luca cammina verso la porta, dando le spalle ad Andrea
(say "andrea" (get_dialog dialogs language 33) "caprianvirus_track33") ;preview: Yes but, why? | looking at Caprini
(director_wait_movement "caprini")
(say "caprini" (get_dialog dialogs language 34) "caprianvirus_track34") ;preview: Because I don't want to be i... | animation left
;Script suggestion: Luca torna al suo posto iniziale
(say "andrea" (get_dialog dialogs language 35) "caprianvirus_track35") ;preview: I can go to grab your money ... | looking at Caprini
(animation "caprini" "still_right")
(say "andrea" (get_dialog dialogs language 36) "caprianvirus_track36") ;preview: . . . so you can lend me som... | looking at Caprini
(animation "caprini" "point_right")
(say "caprini" (get_dialog dialogs language 37) "caprianvirus_track37") ;preview: No pride at all, uh? | looking at Andrea
(animation "caprini" "still_right")
(say "andrea" (get_dialog dialogs language 38) "caprianvirus_track38") ;preview: Pride is totally useless whe... | looking at Caprini
(puppeteer_move "caprini" 3000)
(say "caprini" (get_dialog dialogs language 39) "caprianvirus_track39") ;preview: Listen, I hidden the last of... | looking at Andrea | animation pointing
(say "caprini" (get_dialog dialogs language 40) "caprianvirus_track40") ;preview: If you want, you can go ther... | looking at Andrea
(director_wait_movement "caprini")
(puppeteer_stare "andrea" "#null")
(animation "caprini" "still_left")
(say "caprini" (get_dialog dialogs language 41) "caprianvirus_track41") ;preview: For all I care, I'll grab of... | looking at Andrea | animation scratching his head
(animation "andrea" "point_right")
(say "andrea" (get_dialog dialogs language 42) "caprianvirus_track42") ;preview: OK! | looking at Caprini | animation pointing
(animation "andrea" "still_right")
(say "andrea" (get_dialog dialogs language 43) "caprianvirus_track43") ;preview: Sounds good with me. | looking at Caprini
(say "andrea" (get_dialog dialogs language 44) "caprianvirus_track44") ;preview: Where in Viale Innamorati? | looking at Caprini
(say "caprini" (get_dialog dialogs language 45) "caprianvirus_track45") ;preview: Is a green door in Viale Inn... | looking at Andrea
(say "caprini" (get_dialog dialogs language 46) "caprianvirus_track46") ;preview: Probably, is the only green ... | looking at Andrea
(animation "andrea" "front")
(say "andrea" (get_dialog dialogs language 47) "caprianvirus_track47") ;preview: It's time to go! | animation front
(puppeteer_stare "caprini" "andrea")

;Advance to the next chapter
(collector_set "current_chapter" "virus")
(collector_set "show_chapter_two" 1.0)

;Return the control
(main_control "andrea")
