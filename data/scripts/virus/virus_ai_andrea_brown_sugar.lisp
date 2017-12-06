;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : lunpdstravirus
;Location   : Gallenga
;Author     : Nardinan
;Description: Luna is at the unistrapg with her coffee and PD is with her. Luna gave us the sugar!

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
                  (cons ;0 default
                    ""
                    "")
                  (cons ;1 valerio
                    "I told you that is not true!"
                    "No, ti ho detto.")
                  (cons ;2 luna
                    "And I told you that is true true true!"
                    "Si, ti dico.")
                  (cons ;3 andrea
                    "The guy, next to my girlfriend is Valerio."
                    "Lui, vicino alla mia ragazza e' Valerio.")
                  (cons ;4 andrea
                    "We call him PD."
                    "Chiamato PD da tutti noi.")
                  (cons ;5 andrea
                    "PD is nerd . . ."
                    "PD e' un nerd . . .")
                  (cons ;6 andrea
                    ". . . is a little obsessed with parkour and League of Legends."
                    ". . . un po' fissato con il parkour e con League of Legends.")
                  (cons ;7 andrea
                    "He study Computer Science with me."
                    "Studia informatica con me.")
                  (cons ;8 andrea
                    "He lives in the same apartment with my girlfriend and Marta . . ."
                    "Convive con la mia ragazza e Marta . . .")
                  (cons ;9 andrea
                    ". . that's slightly odd . . ."
                    ". . . il che e' un po' strano . . .")
                  (cons ;10 luna
                    "The virus story is just a bunch of bullshits!"
                    "Mi sta dicendo che la storia del virus e' una cazzata!")
                  (cons ;11 valerio
                    "I am sorry Luna, but the people that you call 'infected' are just normal people."
                    "Scusa ma per me, quelli che chiami 'infetti', sono persone normalissime.")
                  (cons ;12 luna
                    "You have potatoes in your head!"
                    "Questo perche' tu hai le patate nel cervello!")
                  (cons ;13 valerio
                    "Uff, OK."
                    "Vabbe'.")
                  (cons ;14 andrea
                    "Are you still on break?"
                    "Ma tu sei ancora in pausa?")
                  (cons ;15 luna
                    "So?"
                    "Beh?")
                  (cons ;16 andrea
                    "Just asking."
                    "No niente, chiedevo.")
                  (cons ;17 andrea
                    "Is this the very same coffee you were drinking before?"
                    "Ma e' lo stesso caffe' che stavi bevendo prima?")
                  (cons ;18 luna
                    "Are you mad?"
                    "Sei pazzo?")
                  (cons ;19 andrea
                    "I drank two other coffees between the one that you saw before and this one."
                    "Tra quello che hai visto tu e questo ne ho bevuti altri due.")
                  (cons ;20 valerio
                    "Andrea I heard that some noobs feeder took advantage of an aggro on a champion, they raised badly and they killed a Baron."
                    "Comunque Andrea ho sentito dire che dei noobs feeder hanno sfruttato l'aggro su un champion nemico, sono cresciuti di violenza e hanno ammazzato un Baron. ")
                  (cons ;21 andrea
                    "I . . ."
                    "PD io . . .")
                  (cons ;22 andrea
                    ". . . I have no words."
                    ". . . io non so che dire.")
                  (cons ;23 valerio
                    "Me neither!"
                    "Nemmeno io.")
                  (cons ;24 andrea
                    "Totally incomprehensible."
                    "Non ho capito niente.")
                  (cons ;25 andrea
                    "Are you scared for the infection?"
                    "Ma non ti preoccupa per niente questa cosa del virus?")
                  (cons ;26 valerio
                    "The infection does not exist."
                    "Questa cosa del virus non esiste.")
                  (cons ;27 valerio
                    "A virus would create a global panic and I don't see it . . ."
                    "Un virus avrebbe creato un panico generale che io qui non vedo . . .")
                  (cons ;28 valerio
                    "A virus would draw attention of media and government . . ."
                    "Avrebbe attirato l'attenzione dei media e del governo . . .")
                  (cons ;29 valerio
                    "The city would be under quarantine!"
                    "La citta' sarebbe sotto quarantena!")
                  (cons ;30 valerio
                    "Whilst everybody here is free to leave and go wherever he wants."
                    "A me sembra che qui chiunque sia libero di andarsene.")
                  (cons ;31 andrea
                    "I see."
                    "Ho capito.")
                  (cons ;32 andrea
                    "This is an interesting position."
                    "Posizione interessante.")
                  (cons ;33 luna
                    "You guys are just crazy!"
                    "Secondo me siete impazziti!")
                  (cons ;34 luna
                    "This morning I saw a couple of infected guys that were talking in a strange way."
                    "Stamattina sono venuti dei ragazzi, parlavano in modo strano.")
                  (cons ;35 luna
                    "They were crashing continously!"
                    "Crashavano in continuazione!")
                  (cons ;36 valerio
                    "Do you think people crashes so easily?"
                    "Ma ti pare che crashavano?")
                  (cons ;37 valerio
                    "Moreover I intensively debug them."
                    "Poi con tutti i debug fatti, ci mancherebbe altro.")
                  (cons ;38 andrea
                    "What do you mean?"
                    "In che senso?")
                  (cons ;39 valerio
                    ". . ."
                    ". . .")
                  (cons ;40 valerio
                    "Just kidding."
                    "Nel senso ironico.")
                  (cons ;41 andrea
                    "Oh OK."
                    "Ah, certo.")
                  (cons ;42 luna
                    "People is crashing!"
                    "La gente crasha, ti dico!")
                  (cons ;43 valerio
                    "Impossible!"
                    "Impossibile!")
                  (cons ;44 valerio
                    "My skills with gdb and valgrind are incredible."
                    "Uso gdb e valgrind con maestria assoluta.")
                  (cons ;45 luna
                    "Are you kidding me?"
                    "Mi prendi in giro?")
                  (cons ;46 valerio
                    ". . ."
                    ". . .")
                  (cons ;47 valerio
                    "Maybe?"
                    "Forse?")
                  (cons ;48 andrea
                    "Did you put brown sugar on that coffee?"
                    "Per caso metti zucchero di canna nel caffe'?")
                  (cons ;49 luna
                    "Yes."
                    "Si.")
                  (cons ;50 andrea
                    "Do you have it?"
                    "Ne hai?")
                  (cons ;51 luna
                    "Yes."
                    "Si.")
                  (cons ;52 andrea
                    "Can I have some?"
                    "Posso averne?")
                  (cons ;53 luna
                    "Yes."
                    "Si.")
                  (cons ;54 andrea
                    "Thanks!"
                    "Grazie.")
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
(define dialog_done         (collector_get "luna_virus_dialog"))
(define request_sugar       (collector_get "request_sugar"))
(define done_sugar          (collector_get "done_sugar"))
(define andrea_position     (puppeteer_get_position "andrea"))
(define valerio_position    (puppeteer_get_position "valerio"))
(define luna_position       (puppeteer_get_position "luna"))

;Calculate position of valerio and luna in respect of andrea
(define valerio_look_andrea    "still_left")
(define valerio_point_andrea   "point_left")
(define valerio_scratch_andrea "scratch_left")
(if (> andrea_position valerio_position)
  (begin
    (set valerio_look_andrea    "still_right")
    (set valerio_point_andrea   "point_right")
    (set valerio_scratch_andrea "scratch_right"))
  nil
  )
(define luna_look_andrea    "still_left")
(define luna_point_andrea   "point_left")
(define luna_scratch_andrea "scratch_left")
(if (> andrea_position luna_position)
  (begin
    (set luna_look_andrea    "still_right")
    (set luna_point_andrea   "point_right")
    (set luna_scratch_andrea "scratch_right"))
  nil
  )
(define andrea_look_luna    "still_left")
(define andrea_point_luna   "point_left")
(define andrea_scratch_luna "scratch_left")
(if (> luna_position andrea_position)
  (begin
    (set andrea_look_luna    "still_right")
    (set andrea_point_luna   "point_right")
    (set andrea_scratch_luna "scratch_right"))
  nil
  )
(define andrea_look_valerio    "still_left")
(define andrea_point_valerio   "point_left")
(define andrea_scratch_valerio "scratch_left")
(if (> valerio_position andrea_position)
  (begin
    (set andrea_look_valerio    "still_right")
    (set andrea_point_valerio   "point_right")
    (set andrea_scratch_valerio "scratch_right"))
  nil
  )

;Action!
(puppeteer_set "valerio" "still_right")
(puppeteer_set "luna" "still_left")

(if (= dialog_done 1.0)
  (if (= (+ request_sugar done_sugar) 1.0)
    nil
    (begin
      ;Script suggestion: La seconda volta
      (puppeteer_set "luna" "point_left")
      (say "luna" (get_dialog dialogs language 42) "lunpdstravirus_track42") ;preview: People is crashing! | looking at Valerio | animation pointing
      (puppeteer_set "luna" "still_left")
      (say "valerio" (get_dialog dialogs language 43) "lunpdstravirus_track43") ;preview: Impossible! | looking at Luna
      (say "valerio" (get_dialog dialogs language 44) "lunpdstravirus_track44") ;preview: My skills with gdb and valgri... | looking at Luna
      (say "luna" (get_dialog dialogs language 45) "lunpdstravirus_track45") ;preview: Are you kidding me? | looking at Valerio
      (say "valerio" (get_dialog dialogs language 46) "lunpdstravirus_track46") ;preview: . . . | looking at Luna
      (puppeteer_set "valerio" "scratch_right")
      (say "valerio" (get_dialog dialogs language 47) "lunpdstravirus_track47")) ;preview: Maybe? | looking at Luna | animation scratching his head
    )
  (begin
    ;Script suggestion: La prima volta
    (say "valerio" (get_dialog dialogs language 1) "lunpdstravirus_track1") ;preview: I told you that is not true! | looking at Luna
    (say "luna" (get_dialog dialogs language 2) "lunpdstravirus_track2") ;preview: And I told you that is true ... | looking at Valerio | animation pointing
    (puppeteer_set "andrea" "front")
    (say_and_go "andrea" (get_dialog dialogs language 3) "lunpdstravirus_track3") ;preview: The guy, next to my girlfrie... | animation front
    (director_wait_time 1.0)
    (puppeteer_set "valerio" valerio_look_andrea)
    (puppeteer_set "luna" luna_look_andrea)
    (director_wait_message "andrea")
    (say "andrea" (get_dialog dialogs language 4) "lunpdstravirus_track4") ;preview: We call him PD. | animation front
    (say "andrea" (get_dialog dialogs language 5) "lunpdstravirus_track5") ;preview: PD is nerd . . . | animation front
    (say "andrea" (get_dialog dialogs language 6) "lunpdstravirus_track6") ;preview: . . . is a little obsessed w... | animation front
    (say "andrea" (get_dialog dialogs language 7) "lunpdstravirus_track7") ;preview: He study Computer Science wi... | animation front
    (say "andrea" (get_dialog dialogs language 8) "lunpdstravirus_track8") ;preview: He lives in the same appartm... | animation front
    (puppeteer_set "andrea" andrea_look_valerio)
    (say "andrea" (get_dialog dialogs language 9) "lunpdstravirus_track9") ;preview: . . that's slightly odd . . . | looking at Valerio
    (director_wait_time 1.0)
    (say_and_go "luna" (get_dialog dialogs language 10) "lunpdstravirus_track10") ;preview: The virus story is just a bu... | looking at Valerio
    (director_wait_time 1.0)
    (puppeteer_set "valerio" "still_right")
    (puppeteer_set "andrea" andrea_look_luna)
    (director_wait_message "luna")
    (say "valerio" (get_dialog dialogs language 11) "lunpdstravirus_track11") ;preview: I am sorry Luna, but the peo... | looking at Luna
    (say "luna" (get_dialog dialogs language 12) "lunpdstravirus_track12") ;preview: You have potatoes in your he... | looking at Valerio
    (puppeteer_set "valerio" "scratch_right")
    (say "valerio" (get_dialog dialogs language 13) "lunpdstravirus_track13") ;preview: Uff, OK. | looking at Luna | animation scratching his head
    (say "andrea" (get_dialog dialogs language 14) "lunpdstravirus_track14") ;preview: Are you still on break? | looking at Luna
    (puppeteer_set "luna" luna_look_andrea)
    (say "luna" (get_dialog dialogs language 15) "lunpdstravirus_track15") ;preview: So? | looking at Andrea
    (say "andrea" (get_dialog dialogs language 16) "lunpdstravirus_track16") ;preview: Just asking. | looking at Luna
    (puppeteer_set "andrea" andrea_point_luna)
    (say "andrea" (get_dialog dialogs language 17) "lunpdstravirus_track17") ;preview: Is this the very same coffee... | looking at Luna | animation pointing
    (puppeteer_set "andrea" andrea_look_luna)
    (say "luna" (get_dialog dialogs language 18) "lunpdstravirus_track18") ;preview: Are you mad? | looking at Andrea
    (puppeteer_set "luna" luna_point_andrea)
    (say "luna" (get_dialog dialogs language 19) "lunpdstravirus_track19") ;preview: I drank two other coffees be... | looking at Luna | animation pointing
    (puppeteer_set "luna" luna_look_andrea)
    (puppeteer_set "valerio" valerio_point_andrea)
    (say_and_go "valerio" (get_dialog dialogs language 20) "lunpdstravirus_track20") ;preview: Andrea I heard that some noo... | looking at Andrea | animation pointing
    (director_wait_time 1.0)
    (puppeteer_set "andrea" andrea_look_valerio)
    (director_wait_message "valerio")
    (puppeteer_set "valerio" valerio_look_andrea)
    (say "andrea" (get_dialog dialogs language 21) "lunpdstravirus_track21") ;preview: I . . . | looking at Valerio
    (director_wait_time 2.0)
    ;Script suggestion: Una lunga pausa
    (say "andrea" (get_dialog dialogs language 22) "lunpdstravirus_track22") ;preview: . . . I have no words. | looking at Valerio
    (say "valerio" (get_dialog dialogs language 23) "lunpdstravirus_track23") ;preview: Me neither! | looking at Andrea
    (puppeteer_set "andrea" andrea_scratch_valerio)
    (say "andrea" (get_dialog dialogs language 24) "lunpdstravirus_track24") ;preview: Totally incomprehensible. | looking at Valerio | animation scratching his head
    (puppeteer_set "andrea" andrea_point_valerio)
    (say "andrea" (get_dialog dialogs language 25) "lunpdstravirus_track25") ;preview: Are you scared for the infec... | looking at Valerio | animation pointing
    (puppeteer_set "andrea" andrea_look_valerio)
    (say "valerio" (get_dialog dialogs language 26) "lunpdstravirus_track26") ;preview: The infection does not exist. | looking at Andrea
    (puppeteer_set "valerio" valerio_point_andrea)
    (say "valerio" (get_dialog dialogs language 27) "lunpdstravirus_track27") ;preview: A virus would create a globa... | looking at Andrea | animation pointing
    (puppeteer_set "valerio" "still_right")
    (say "valerio" (get_dialog dialogs language 28) "lunpdstravirus_track28") ;preview: A virus would draw attention... | looking at Luna
    (puppeteer_set "valerio" valerio_look_andrea)
    (say "valerio" (get_dialog dialogs language 29) "lunpdstravirus_track29") ;preview: The city would be under quar... | looking at Andrea
    (puppeteer_set "valerio" "point_right")
    (say "valerio" (get_dialog dialogs language 30) "lunpdstravirus_track30") ;preview: Whilst everybody here is fre... | looking at Luna | animation pointing
    (puppeteer_set "valerio" valerio_look_andrea)
    (say "andrea" (get_dialog dialogs language 31) "lunpdstravirus_track31") ;preview: I see. | looking at Valerio
    (say "andrea" (get_dialog dialogs language 32) "lunpdstravirus_track32") ;preview: This is an interesting posit... | looking at Valerio
    (puppeteer_set "luna" luna_point_andrea)
    (say_and_go "luna" (get_dialog dialogs language 33) "lunpdstravirus_track33") ;preview: You guys are just crazy! | looking at Andrea | animation pointing
    (director_wait_time 1.0)
    (puppeteer_set "andrea" andrea_look_luna)
    (puppeteer_set "valerio" "still_right")
    (director_wait_message "luna")
    (puppeteer_set "luna" luna_look_andrea)
    (say "luna" (get_dialog dialogs language 34) "lunpdstravirus_track34") ;preview: This morning I saw a couple ... | looking at Andrea
    (say "luna" (get_dialog dialogs language 35) "lunpdstravirus_track35") ;preview: They were crashing continous... | looking at Andrea
    (say "valerio" (get_dialog dialogs language 36) "lunpdstravirus_track36") ;preview: Do you think people crashes ... | looking at Luna
    (say "valerio" (get_dialog dialogs language 37) "lunpdstravirus_track37") ;preview: Moreover I intensively debu... | looking at Luna
    (director_wait_time 1.0)
    (puppeteer_set "luna" "still_left")
    (puppeteer_set "andrea" andrea_point_valerio)
    (director_wait_time 2.0)
    (puppeteer_set "andrea" andrea_look_valerio)
    (director_wait_time 1.0)
    (say_and_go "andrea" (get_dialog dialogs language 38) "lunpdstravirus_track38") ;preview: What do you mean? | looking at Valerio
    (director_wait_time 1.0)
    (puppeteer_set "valerio" valerio_look_andrea)
    (director_wait_message "andrea")
    (say "valerio" (get_dialog dialogs language 39) "lunpdstravirus_track39") ;preview: . . . | looking at Andrea
    (say "valerio" (get_dialog dialogs language 40) "lunpdstravirus_track40") ;preview: Just kidding. | looking at Andrea
    (say "andrea" (get_dialog dialogs language 41) "lunpdstravirus_track41") ;preview: Oh OK. | looking at Valerio
    (puppeteer_set "valerio" "still_right")

    ;And never again
    (collector_set "luna_virus_dialog" 1.0))
  )

(if (= (+ request_sugar done_sugar) 1.0)
  (begin
    ;Script suggestion: Quando Andrea ha bisogno dello zucchero di canna
    (puppeteer_set "luna" luna_look_andrea)
    (puppeteer_set "andrea" andrea_look_luna)
    (say "andrea" (get_dialog dialogs language 48) "lunpdstravirus_track48") ;preview: Did you put brown sugar on t... | looking at Luna
    (say "luna" (get_dialog dialogs language 49) "lunpdstravirus_track49") ;preview: Yes. | looking at Andrea
    (say "andrea" (get_dialog dialogs language 50) "lunpdstravirus_track50") ;preview: Do you have it? | looking at Luna
    (say "luna" (get_dialog dialogs language 51) "lunpdstravirus_track51") ;preview: Yes. | looking at Andrea
    (say "andrea" (get_dialog dialogs language 52) "lunpdstravirus_track52") ;preview: Can I have some? | looking at Luna
    (say "luna" (get_dialog dialogs language 53) "lunpdstravirus_track53") ;preview: Yes. | looking at Andrea
    (say "andrea" (get_dialog dialogs language 54) "lunpdstravirus_track54") ;preview: Thanks! | looking at Luna

    ;And never again
    (collector_set "got_sugar" 1.0)
    (collector_set "done_sugar" 1.0))
  nil)
;Refresh interface
(director_script "update_items_interface")

;Return the control
(main_control "andrea")
