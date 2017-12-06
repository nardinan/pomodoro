;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : anyucachaos
;Location   : Elfo Pub
;Author     : Nardinan
;Description: Andrii, Yuriy and Caprini are drinking to the end of the world

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 andrii
                    "Guys . . ."
                    "Signori . . .")
                  (cons ;2 andrii
                    ". . . I would like to propose a toast for the end of the world!"
                    ". . . vorrei proporre un brindisi alla fine del mondo!")
                  (cons ;3 caprini
                    "Nazdarovya!"
                    "Nazdarovya!")
                  (cons ;4 yuriy
                    "Nazdarovya!"
                    "Nazdarovya!")
                  (cons ;5 andrii
                    "I would then thank our friend 'il Profeta' for his attempt to warn us . . ."
                    "E ringraziare il nostro amico 'il Profeta' per aver provato ad avvertirci . . .")
                  (cons ;6 andrii
                    ". . . and for his sacrifice!"
                    ". . . ed essere morto nel tentativo!")
                  (cons ;7 caprini
                    "Nazdarovya!"
                    "Nazdarovya!")
                  (cons ;8 yuriy
                    "Nazdarovya!"
                    "Nazdarovya!")
                  (cons ;9 andrii
                    "I would then thank . . ."
                    "E vorrei poi ringraziare . . .")
                  (cons ;10 caprini
                    "Yes, we've enough of your shit."
                    "Si ma ora hai rotto il cazzo!")
                  (cons ;11 yuriy
                    "True, let's drink!"
                    "E' vero, beviamo su!")
                  (cons ;12 andrii
                    "What a bunch of cyka blyat!"
                    "Che branco di cyka blyat!")
                  (cons ;13 andrea
                    "What's the occasion?"
                    "Scusate, ma cosa si festeggia?")
                  (cons ;14 andrii
                    "We are celebrating the end of the world!"
                    "Si festeggia la fine del mondo!")
                  (cons ;15 andrea
                    "The end of the world?"
                    "Ma come la fine del mondo?")
                  (cons ;16 caprini
                    "What do you mean by 'the end of the world'?"
                    "Si infatti, in che senso?")
                  (cons ;17 andrii
                    "You were partying with us!"
                    "Ma tu stavi brindando con noi!")
                  (cons ;18 caprini
                    "No, you told me 'I'll offer you a beer' and I said yes . . ."
                    "No, tu mi hai detto 'ti offro una birra' e io ho accettato . . .")
                  (cons ;19 caprini
                    ". . . but you never told me why!"
                    ". . . ma non mi hai mai spiegato di cosa stavi parlando!")
                  (cons ;20 andrii
                    "Ah."
                    "Ah.")
                  (cons ;21 yuriy
                    "Is it not clear for me as well . . ."
                    "Neanche io ne sono proprio certo . . .")
                  (cons ;22 andrii
                    ". . ."
                    ". . .")
                  (cons ;23 andrii
                    "Seems that 'il Profeta' was a resident in Perugia 2017 . . ."
                    "Beh sembrerebbe che 'il Profeta' fosse un cittadino della Perugia del 2017 . . .")
                  (cons ;24 andrii
                    ". . . and he was back in time, like us, to warn us about the incoming end of the world."
                    ". . . e che sia tornato indietro nel tempo, come noi, per avvertirci della fine del mondo.")
                  (cons ;25 caprini
                    "Wait wait wait . . ."
                    "Aspetta aspetta aspetta . . .")
                  (cons ;26 caprini
                    "Are you from the future?"
                    "Voi venite dal futuro?")
                  (cons ;27 andrii
                    "Yes."
                    "Si.")
                  (cons ;28 yuriy
                    "Yes."
                    "Si.")
                  (cons ;29 andrea
                    "Yes."
                    "Si.")
                  (cons ;30 andrii
                    "No, you are not!"
                    "No tu no!")
                  (cons ;31 andrea
                    "Oh, no I am not."
                    "Ah no, io no.")
                  (cons ;32 caprini
                    "From when?"
                    "E da che anno?")
                  (cons ;33 andrii
                    "From 2017."
                    "Dal 2017.")
                  (cons ;34 caprini
                    "What's about 2017 Perugia?"
                    "E che ne sara' di Perugia nel 2017?")
                  (cons ;35 andrii
                    "I have no idea . . ."
                    "Non lo so . . .")
                  (cons ;36 andrii
                    ". . . we are from Geneva!"
                    ". . . noi veniamo da Ginevra!")
                  (cons ;37 andrea
                    "I am sorry but aren't you tearing the fabric of space and time telling us these things?"
                    "Scusate ma tipo non si rischia un collasso dello spazio tempo a raccontare 'ste cose?")
                  (cons ;38 andrii
                    "It doesn't matter anymore . . ."
                    "A questo punto non importa piu' . . .")
                  (cons ;39 andrii
                    ". . . 'il Profeta' has been killed before he could help us . . ."
                    ". . . 'il Profeta' e' stato ucciso prima d'avvertirci del male in arrivo . . .")
                  (cons ;40 andrii
                    ". . . so whatever is going on right now, cannot be stopped anymore."
                    ". . . quindi qualsiasi cosa stia accadendo ora, non puo' essere piu' fermata.")
                  (cons ;41 andrii
                    "Nazdarovya!"
                    "Nazdarovya!")
                  (cons ;42 yuriy
                    "Nazdarovya!"
                    "Nazdarovya!")
                  (cons ;43 caprini
                    "Nazdarovya!"
                    "Nazdarovya!")
                  (cons ;44 andrea
                    "Came on . . ."
                    "Su su . . .")
                  (cons ;45 andrea
                    ". . . let's not get discouraged, okay?"
                    ". . . non scoraggiamoci!")
                  (cons ;46 andrea
                    "We just need to find enough moeny for the electric bill!"
                    "Si tratta solo di trovare i soldi per una bolletta.")
                  (cons ;47 andrii
                    ". . ."
                    ". . .")
                  (cons ;48 yuriy
                    ". . ."
                    ". . .")
                  (cons ;49 andrea
                    "I am sorry, do you have Magnifico Rettore's MacBook?"
                    "Piuttosto, non e' che avete il MacBook pro del magnifico rettore?")
                  (cons ;50 andrii
                    "I have not . . ."
                    "No io no . . .")
                  (cons ;51 yuriy
                    "Me neither . . ."
                    "Nemmeno io . . .")
                  (cons ;52 caprini
                    ". . ."
                    ". . .")
                  (cons ;53 andrea
                    "So?"
                    "Beh?")
                  (cons ;54 caprini
                    "Well, you know . . ."
                    "Beh, insomma . . .")
                  (cons ;55 caprini
                    ". . . was here, on the table of the pub and I would like to watch a video!"
                    ". . . l'ho trovato appoggiato su un tavolino qui al pub e volevo vedere un video!")
                  (cons ;56 andrea
                    "OK then, can you please give it to me?"
                    "Va bene, ora puoi restituirmelo?")
                  (cons ;57 caprini
                    "I was watching the video of the yelling goaths!"
                    "Ma stavo guardando il video delle capre che urlano!")
                  (cons ;58 andrii
                    "Ahahah!"
                    "Ahahah!")
                  (cons ;59 yuriy
                    "Ahahah!"
                    "Ahahah!")
                  (cons ;60 caprini
                    "Take it!"
                    "Toh, prenditelo.")
                  (cons ;61 caprini
                    "I don't like it."
                    "Tanto non mi piace.")
                  (cons ;62 andrea
                    "OK Thanks."
                    "OK grazie.")
                  (cons ;63 andrii
                    "A toss to the end of the world!"
                    "Alla fine del mondo!")
                  (cons ;64 andrii
                    "To an uncertain future!"
                    "Ad un futuro incerto!")
                  (cons ;65 andrii
                    "To a destiny that surely could have been avoided!"
                    "Ad un destino che poteva essere evitato!")
                  (cons ;66 andrii
                    "To a friend, 'il Profeta', that sacrificed himself for us!"
                    "Ad un amico, 'il profeta', che si e' sacrificato per aiutarci!")
                  (cons ;67 andrii
                    "To whatever is going on that will drive the humanity to the extinction!"
                    "A qualsiasi cosa stia succedendo che portera' all'estinzione la razza umana!")
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
(define got_computer        (collector_get "got_computer"))
(define done_computer       (collector_get "done_computer"))
(define andrea_position     (puppeteer_get_position "andrea"))
(define andrii_position     (puppeteer_get_position "andrii"))
(define yuriy_position      (puppeteer_get_position "yuriy"))
(define caprini_position    (puppeteer_get_position "caprini"))

;Calculate position of andrii, yuriy and caprini in respect of andrea
(define andrii_look_andrea "drink_left")
(if (> andrea_position andrii_position)
  (set andrii_look_andrea "drink_right")
  nil
  )
(define yuriy_look_andrea "drink_left")
(if (> andrea_position yuriy_position)
  (set yuriy_look_andrea "drink_right")
  nil
  )
(define caprini_look_andrea "drink_left")
(if (> andrea_position caprini_position)
  (set caprini_look_andrea "drink_right")
  nil
  )
(define andrea_look_andrii "still_left")
(if (> andrii_position andrea_position)
  (set andrea_look_andrii "still_right")
  nil
  )
(define andrea_look_yuriy "still_left")
(if (> yuriy_position andrea_position)
  (set andrea_look_yuriy "still_right")
  nil
  )
(define andrea_look_caprini "still_left")
(if (> caprini_position andrea_position)
  (set andrea_look_caprini "still_right")
  nil
  )
;Action!
(if (= done_computer 1.0)
  nil
  (begin
    ;The scene is quite big, we need to move the camera to Caprini
    (director_camera_follow "caprini" -100.0 1.0)
    (puppeteer_set "andrii" "drink_right")
    (puppeteer_set "yuriy" "drink_left")
    (puppeteer_set "caprini" "drink_left")
    (say_and_go "andrii" (get_dialog dialogs language 1) "anyucachaos_track1") ;preview: Guys . . . | animation right
    (director_wait_time 1.0)
    (puppeteer_set "andrea" andrea_look_andrii)
    (director_wait_message "andrii")
    (say "andrii" (get_dialog dialogs language 2) "anyucachaos_track2") ;preview: . . . I would like to propos... | animation right
    (say_and_go "caprini" (get_dialog dialogs language 3) "anyucachaos_track3") ;preview: Nazdarovya! | looking at Andrii
    (say_and_go "yuriy" (get_dialog dialogs language 4) "anyucachaos_track4") ;preview: Nazdarovya! | looking at Andrii
    (director_wait_message "caprini")
    (director_wait_message "yuriy")
    (say "andrii" (get_dialog dialogs language 5) "anyucachaos_track5") ;preview: I would then thank our frien... | animation right
    (say "andrii" (get_dialog dialogs language 6) "anyucachaos_track6") ;preview: . . . and for his sacrifice! | animation right
    (say_and_go "caprini" (get_dialog dialogs language 7) "anyucachaos_track7") ;preview: Nazdarovya! | looking at Andrii
    (say_and_go "yuriy" (get_dialog dialogs language 8) "anyucachaos_track8") ;preview: Nazdarovya! | looking at Andrii
    (director_wait_message "caprini")
    (director_wait_message "yuriy")
    (say "andrii" (get_dialog dialogs language 9) "anyucachaos_track9") ;preview: I would then thank . . . | animation right
    (say "caprini" (get_dialog dialogs language 10) "anyucachaos_track10") ;preview: Yes, we've enough of your sh... | looking at Andrii | animation pointing
    (say "yuriy" (get_dialog dialogs language 11) "anyucachaos_track11") ;preview: True, let's drink! | looking at Andrii
    (say "andrii" (get_dialog dialogs language 12) "anyucachaos_track12") ;preview: What a bunch of cyka blyat! | animation right
    ;Script suggestion: Andrii, Yuriy e Luca bevono
    (say_and_go "andrea" (get_dialog dialogs language 13) "anyucachaos_track13") ;preview: What's the occasion? | looking at Andrii
    (director_wait_time 1.0)
    (puppeteer_set "andrii" andrii_look_andrea)
    (puppeteer_set "yuriy" yuriy_look_andrea)
    (puppeteer_set "caprini" caprini_look_andrea)
    (director_wait_message "andrea")
    (say "andrii" (get_dialog dialogs language 14) "anyucachaos_track14") ;preview: We are celebrating the end o... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 15) "anyucachaos_track15") ;preview: The end of the world? | looking at Andrii
    (puppeteer_set "caprini" "drink_left")
    (say_and_go "caprini" (get_dialog dialogs language 16) "anyucachaos_track16") ;preview: What do you mean by 'the end... | looking at Andrii | animation scratching his head
    (director_wait_time 1.0)
    (puppeteer_set "yuriy" "drink_right")
    (puppeteer_set "andrii" "drink_right")
    (puppeteer_set "andrea" andrea_look_caprini)
    (director_wait_message "caprini")
    (say "andrii" (get_dialog dialogs language 17) "anyucachaos_track17") ;preview: You were partying with us! | looking at Caprini
    (say "caprini" (get_dialog dialogs language 18) "anyucachaos_track18") ;preview: No, you told me 'I'll offer ... | looking at Andrii
    (say "caprini" (get_dialog dialogs language 19) "anyucachaos_track19") ;preview: . . . but you never told me ... | looking at Andrii | animation pointing
    (say "andrii" (get_dialog dialogs language 20) "anyucachaos_track20") ;preview: Ah. | looking at Caprini
    (puppeteer_set "yuriy" "drink_left")
    (say_and_go "yuriy" (get_dialog dialogs language 21) "anyucachaos_track21") ;preview: I am not sure are well about... | looking at Andrii
    (director_wait_time 1.0)
    (puppeteer_set "andrea" andrea_look_yuriy)
    (director_wait_message "yuriy")
    (say "andrii" (get_dialog dialogs language 22) "anyucachaos_track22") ;preview: . . . | looking at Yuriy
    (director_wait_time 2.0)
    (puppeteer_set "andrii" andrii_look_andrea)
    (puppeteer_set "andrea" andrea_look_andrii)
    (say "andrii" (get_dialog dialogs language 23) "anyucachaos_track23") ;preview: Seems that 'il Profeta' was ... | looking at Andrea
    (say "andrii" (get_dialog dialogs language 24) "anyucachaos_track24") ;preview: . . . and he was back in tim... | looking at Andrea
    (say_and_go "caprini" (get_dialog dialogs language 25) "anyucachaos_track25") ;preview: Wait wait wait . . . | looking at Andrii
    (director_wait_time 1.0)
    (puppeteer_set "andrii" "drink_right")
    (puppeteer_set "yuriy" "drink_right")
    (puppeteer_set "andrea" andrea_look_caprini)
    (director_wait_message "caprini")
    (say "caprini" (get_dialog dialogs language 26) "anyucachaos_track26") ;preview: Are you from the future? | looking at Andrii
    (say "andrii" (get_dialog dialogs language 27) "anyucachaos_track27") ;preview: Yes. | looking at Caprini
    (say "yuriy" (get_dialog dialogs language 28) "anyucachaos_track28") ;preview: Yes. | looking at Caprini
    (say "andrea" (get_dialog dialogs language 29) "anyucachaos_track29") ;preview: Yes. | looking at Caprini
    (puppeteer_set "andrii" andrii_look_andrea)
    (say "andrii" (get_dialog dialogs language 30) "anyucachaos_track30") ;preview: No, you are not! | looking at Andrea
    (puppeteer_set "andrii" "drink_right")
    (say "andrea" (get_dialog dialogs language 31) "anyucachaos_track31") ;preview: Oh, no I am not. | looking at Caprini
    (say "caprini" (get_dialog dialogs language 32) "anyucachaos_track32") ;preview: From when? | looking at Andrii
    (say "andrii" (get_dialog dialogs language 33) "anyucachaos_track33") ;preview: From 2017. | looking at Caprini
    (say "caprini" (get_dialog dialogs language 34) "anyucachaos_track34") ;preview: What's about 2017 Perugia? | looking at Andrii
    (say "andrii" (get_dialog dialogs language 35) "anyucachaos_track35") ;preview: I have no idea . . . | looking at Caprini
    (say "andrii" (get_dialog dialogs language 36) "anyucachaos_track36") ;preview: . . . we are from Geneva! | looking at Caprini
    (puppeteer_set "andrea" andrea_look_andrii)
    (say_and_go "andrea" (get_dialog dialogs language 37) "anyucachaos_track37") ;preview: I am sorry but aren't you te... | looking at Andrii
    (director_wait_time 1.0)
    (puppeteer_set "andrii" andrii_look_andrea)
    (puppeteer_set "yuriy" yuriy_look_andrea)
    (puppeteer_set "caprini" caprini_look_andrea)
    (director_wait_message "andrea")
    (say_and_go "andrii" (get_dialog dialogs language 38) "anyucachaos_track38") ;preview: It doesn't matter anymore . ... | looking at Andrea
    (director_wait_time 1.0)
    (puppeteer_set "yuriy" "drink_left")
    (puppeteer_set "caprini" "drink_left")
    (director_wait_message "andrii")
    (say "andrii" (get_dialog dialogs language 39) "anyucachaos_track39") ;preview: . . . 'il Profeta' has been ... | looking at Andrea
    (say "andrii" (get_dialog dialogs language 40) "anyucachaos_track40") ;preview: . . . so whatever is going o... | looking at Andrea
    (say "andrii" (get_dialog dialogs language 41) "anyucachaos_track41") ;preview: Nazdarovya! | animation right
    (say_and_go "yuriy" (get_dialog dialogs language 42) "anyucachaos_track42") ;preview: Nazdarovya! | looking at Andrii
    (say_and_go "caprini" (get_dialog dialogs language 43) "anyucachaos_track43") ;preview: Nazdarovya! | looking at Andrii
    (director_wait_message "caprini")
    (director_wait_message "yuriy")
    (say_and_go "andrea" (get_dialog dialogs language 44) "anyucachaos_track44") ;preview: Came on . . . | looking at Andrii
    (director_wait_time 1.0)
    (puppeteer_set "yuriy" yuriy_look_andrea)
    (puppeteer_set "caprini" caprini_look_andrea)
    (director_wait_message "andrea")
    (say "andrea" (get_dialog dialogs language 45) "anyucachaos_track45") ;preview: . . . let's not get discoura... | looking at Andrii
    (say "andrea" (get_dialog dialogs language 46) "anyucachaos_track46") ;preview: We just need to find enough ... | looking at Andrii
    (say "andrii" (get_dialog dialogs language 47) "anyucachaos_track47") ;preview: . . . | looking at Andrea
    (say "yuriy" (get_dialog dialogs language 48) "anyucachaos_track48") ;preview: . . . | looking at Andrea
    (say "andrea" (get_dialog dialogs language 49) "anyucachaos_track49") ;preview: I am sorry, do you have Magn... | looking at Andrii
    (say "andrii" (get_dialog dialogs language 50) "anyucachaos_track50") ;preview: I have not . . . | looking at Andrea
    (puppeteer_set "andrea" andrea_look_yuriy)
    (say "yuriy" (get_dialog dialogs language 51) "anyucachaos_track51") ;preview: Me neither . . . | looking at Andrea
    (puppeteer_set "andrea" andrea_look_caprini)
    (say "caprini" (get_dialog dialogs language 52) "anyucachaos_track52") ;preview: . . . | looking at Andrea
    (puppeteer_set "andrii" "drink_right")
    (puppeteer_set "yuriy" "drink_right")
    (say "andrea" (get_dialog dialogs language 53) "anyucachaos_track53") ;preview: So? | looking at Caprini
    (say "caprini" (get_dialog dialogs language 54) "anyucachaos_track54") ;preview: Well, you know . . . | looking at Andrea
    (say "caprini" (get_dialog dialogs language 55) "anyucachaos_track55") ;preview: . . . was here, on the table... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 56) "anyucachaos_track56") ;preview: OK then, can you please give... | looking at Caprini
    (say "caprini" (get_dialog dialogs language 57) "anyucachaos_track57") ;preview: I was watching the video of ... | looking at Andrea
    (say_and_go "andrii" (get_dialog dialogs language 58) "anyucachaos_track58") ;preview: Ahahah! | looking at Caprini | animation pointing
    (say_and_go "yuriy" (get_dialog dialogs language 59) "anyucachaos_track59") ;preview: Ahahah! | looking at Caprini | animation pointing
    (director_wait_message "andrii")
    (director_wait_message "yuriy")
    (say "caprini" (get_dialog dialogs language 60) "anyucachaos_track60") ;preview: Take it! | looking at Andrea
    (say "caprini" (get_dialog dialogs language 61) "anyucachaos_track61") ;preview: I don't like it. | looking at Andrea
    (say "andrea" (get_dialog dialogs language 62) "anyucachaos_track62") ;preview: OK Thanks. | looking at Caprini

    ;And never again
    (collector_set "got_computer" 1.0)
    (collector_set "done_computer" 1.0))
  )
;Refresh interface
(director_script "update_items_interface")

;Return the control
(main_control "andrea")
