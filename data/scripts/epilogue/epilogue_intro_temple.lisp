;Pomodoro - I have no money and I must eat an ice cream
;this script has been generated automatically and then has been polished manually
;(sounds professional, uh? Well, it is not)
;Code name  : pdeepilogue
;Location   : Tempio maledetto
;Author     : Nardinan
;Description: When you discover the final plan

;Dialogs
(define language (collector_get "language"))
(define dialogs (list
		(cons ;0 default
			""    
			"")   
		(cons ;1 andrea
			"Valerio?"    
			"Valerio?")   
		(cons ;2 andrea
			"Valerio?"    
			"Valerio?")   
		(cons ;3 andrea
			"There is nobody here . . ."    
			"Qui non c'e' proprio nessuno . . .")   
		(cons ;4 andrea
			". . . except for those brains and that computer with a giant face."    
			". . . a parte questi cervelli e quel computer con la facciona.")   
		(cons ;5 valerio
			"*beeep*"    
			"*beeep*")   
		(cons ;6 andrea
			"That beepping computer."    
			"Quel computer che bippa.")   
		(cons ;7 andrea
			"Does 'beepping' exists as word?"    
			"Ma 'bippa' esiste come parola?")   
		(cons ;8 valerio
			"No."    
			"No.")   
		(cons ;9 andrea
			"No?"    
			"No?")   
		(cons ;10 valerio
			"No."    
			"No.")   
		(cons ;11 andrea
			"That voice sounds familiar."    
			"Questa voce mi sembra familiare.")   
		(cons ;12 valerio
			"It's me!"    
			"Sono io!")   
		(cons ;13 valerio
			"Valerio!"    
			"Valerio!")   
		(cons ;14 andrea
			". . ."    
			". . .")   
		(cons ;15 valerio
			"I was waiting for you, Andrea!"    
			"Ti stavo aspettando, Andrea!")   
		(cons ;16 andrea
			"I . . ."    
			"Io . . .")   
		(cons ;17 andrea
			"I am still shook up about this thing."    
			"Io credo d'essere ancora traumatizzato da questa cosa.")   
		(cons ;18 andrea
			"What's become of you?"    
			"Cosa sei diventato?")   
		(cons ;19 andrea
			"A software?"    
			"Un programma?")   
		(cons ;20 andrea
			"A computer?"    
			"Un computer?")   
		(cons ;21 andrea
			"An operating system?"    
			"Un sistema operativo?")   
		(cons ;22 valerio
			"As you can clearly see, I am a computer . . ."    
			"Come puoi ben vedere, sono un computer . . .")   
		(cons ;23 valerio
			"A computer connected to dozens and dozens of brains!"    
			"Un computer connesso a decine e decine di cervelli!")   
		(cons ;24 valerio
			"I am a super intelligent unit!"    
			"Sono un'entita' superintelligente!")   
		(cons ;25 valerio
			"Do you know Portal's GlaDOS?"    
			"Hai presente GlaDOS di Portal?")   
		(cons ;26 andrea
			"Yes?"    
			"Si?")   
		(cons ;27 valerio
			"GlaDOS is nothing compared to me!"    
			"GlaDOS mi spiccia casa!")   
		(cons ;28 andrea
			"GlaDOS was charming."    
			"GlaDOS era piu' affascinante.")   
		(cons ;29 valerio
			"I am charming."    
			"Io sono affascinante.")   
		(cons ;30 andrea
			"Mah."    
			"Mah.")   
		(cons ;31 valerio
			"Let me explain you . . ."    
			"Lascia che ti spieghi . . .")   
		(cons ;32 andrea
			"Ehm . . ."    
			"Ehm . . .")   
		(cons ;33 andrea
			". . ."    
			". . .")   
		(cons ;34 andrea
			"I am sorry, I have a question."    
			"Scusami tanto avrei una domanda.")   
		(cons ;35 andrea
			"You are a computer, aren't you?"    
			"Sei un computer, giusto?")   
		(cons ;36 valerio
			"Correct."    
			"Esatto.")   
		(cons ;37 andrea
			"Well . . ."    
			"Ma . . .")   
		(cons ;38 andrea
			"Uhm."    
			"Uhm.")   
		(cons ;39 andrea
			"Ho can you dominate the world?"    
			"Come farai a conquistare il mondo?")   
		(cons ;40 valerio
			"Good question!"    
			"Giusta domanda!")   
		(cons ;41 valerio
			"Do you know about Solaris?"    
			"Hai presente il Solaris?")   
		(cons ;42 andrea
			"The virus?"    
			"Il virus?")   
		(cons ;43 valerio
			"How sweet you are, so clueless . . ."    
			"Che dolce che sei, ignaro di tutto . . .")   
		(cons ;44 valerio
			"Solaris it's just a name that I randomly picked up from the book written by Mel Brooks' son and called 'The Zombie Survival Guide'."    
			"Solaris e' solo un nome che ho preso in prestito da un libro scritto dal figlio di Mel Brooks e intitolato 'The Zombie Survival Guide'.")   
		(cons ;45 andrea
			"I don't know that book."    
			"Non conosco quel libro.")   
		(cons ;46 valerio
			"That's the reason why I used that name that, in the book, is the name of a deadly virus that transforms people into Zombies!"    
			"Proprio questa e' la ragione per cui ho scelto quel nome che, nel libro, viene usato come nome del mortale virus che trasforma le persone in Zombie!")   
		(cons ;47 andrea
			"Honestly . . ."    
			"Sinceramente . . .")   
		(cons ;48 andrea
			". . .  I thought I'd get some better stuff."    
			". . . mi aspettavo qualcosa di piu' subdolo e intrigante.")   
		(cons ;49 valerio
			"In our world Solaris is the name that I gave to my Artificial Intelligence that controls all the people whose brains I removed."    
			"In realta' Solaris e' il nome dell'intelligenza artificiale che ho scritto e che controlla tutte le persone a cui ho rimosso il cervello.")   
		(cons ;50 andrea
			"That Artificial Intelligence sucks."    
			"Questa intelligenza artificiale fa veramente schifo.")   
		(cons ;51 andrea
			"Crash continously and is extremely unstable."    
			"Crasha in continuazione ed e' instabile.")   
		(cons ;52 andrea
			"Well, I wrote it in a rush."    
			"Va beh, l'ho scritto di corsa.")   
		(cons ;53 andrea
			"I'll make it better lately."    
			"Piano piano lo ottimizzero'.")   
		(cons ;54 valerio
			"However, every person controlled by me can be moved to 'SLAVE mode' and can be fully controlled by me."    
			"Intanto tutte le persone controllate dalla mia intelligenza artificiale possono essere switchate in modalita' SLAVE ed essere controllate direttamente da me.")   
		(cons ;55 valerio
			"And now, the final step of my plan!"    
			"E ora la mossa finale finale!")   
		(cons ;56 valerio
			"I need a brain of a mathematician to complete my plan . . ."    
			"Ho bisogno del cervello di una matematico per terminare il mio piano . . .")   
		(cons ;57 valerio
			". . . and that's the reason why I bring here some company!"    
			". . . ed e' per questo che ho portato compagnia!")   
		(cons ;58 valerio
			"Ehm . . ."    
			"Ehm . . .")   
		(cons ;59 valerio
			"Andrea, could you please move here on the right?"    
			"Andrea, potresti cortesemente spostarti qui a destra?")   
		(cons ;60 valerio
			"You're out from the camera frame."    
			"Altrimenti non entri nell'inquadratura.")   
		(cons ;61 andrea
			"It's OK like this?"    
			"Va bene cosi'?")   
		(cons ;62 valerio
			"Yes, awesome."    
			"Si, perfetto.")   
		(cons ;63 andrea
			"OH MY GOD!"    
			"OH MIO DIO!")   
		(cons ;64 andrea
			"CUG!"    
			"CUG!")   
		(cons ;65 andrea
			"LUNA!"    
			"LUNA!")   
		(cons ;66 andrea
			"What they are doing to you!"    
			"Che vi stanno facendo!")   
		(cons ;67 valerio
			"AHAHAH!"    
			"AHAHAH!")   
		(cons ;68 valerio
			"Bruno!"    
			"Bruno!")   
		(cons ;69 valerio
			"Prepare our patients for the brain removal . . ."    
			"Prepara i pazienti alla rimozione del cervello . . .")   
		(cons ;70 bruno
			"But sir . . ."    
			"Ma signore . . .")   
		(cons ;71 valerio
			"NO 'SIR'!"    
			"NIENTE 'SIGNORE'!")   
		(cons ;72 valerio
			"DO IT!"    
			"FALLO E BASTA!")   
		(cons ;73 bruno
			"<Bruno.bin is not responding>"    
			"<Bruno.bin is not responding>")   
		(cons ;74 valerio
			"Ehm . . ."    
			"Ehm . . .")   
		(cons ;75 valerio
			"Now I'll upload a new firmware . . ."    
			"Adesso faccio l'upload del nuovo firmware . . .")   
		(cons ;76 andrea
			"Please, go ahead."    
			"Fai con comodo.")   
		(cons ;77 valerio
			"OK, let me launch the uploader."    
			"OK, ora lancio l'uploader.")   
		(cons ;78 valerio
			"FFFFFFFF!"    
			"FFFFFFFF!")   
		(cons ;79 valerio
			"Ehm . . ."    
			"Ehm . . .")   
		(cons ;80 andrea
			"I see you're having a tough time there PD . . ."    
			"Ti vedo in leggera difficolta' PD . . .")   
		(cons ;81 andrea
			"Do you want me to reboot you?"    
			"Vuoi essere riavviato?")   
		(cons ;82 valerio
			"NO!"    
			"NO!")   
		(cons ;83 valerio
			"DON'T TOUCH ME!"    
			"NON TOCCARE!")   
		(cons ;84 andrea
			"Take it easy mate."    
			"Oh rilassati.")   
		(cons ;85 valerio
			"I have to anticipare the final step . . ."    
			"Devo anticipare la fase finale . . .")   
		(cons ;86 valerio
			". . . and activate the SLAVE mode."    
			". . . e attivare la modalita' SLAVE.")   
		(cons ;87 valerio
			"Soon all the people of the city will be under my control!"    
			"Presto tutti gli abitanti della citta' saranno sotto il mio controllo!")   
		(cons ;88 valerio
			"AHAHAH!"    
			"AHAHAH!")   
		(cons ;89 andrea
			"AHAHAH!"    
			"AHAHAH!")   
		(cons ;90 valerio
			"You should not laugh."    
			"No tu non devi ridere.")   
		(cons ;91 andrea
			"Oh, sorry."    
			"Oh, scusa.")   
		(cons ;92 andrea
			"Can you release my cousin and my girlfriend?"    
			"Puoi liberare mio cugino e la mia ragazza?")   
		(cons ;93 valerio
			"No."    
			"No.")   
		(cons ;94 andrea
			"So, can you give me back Luca Caprini's money?"    
			"E puoi darmi i soldi che devi ridare a Luca Caprini?")   
		(cons ;95 valerio
			"No."    
			"No.")   
		(cons ;96 andrea
			". . ."    
			". . .")   
		(cons ;97 valerio
			". . ."    
			". . .")   
		(cons ;98 andrea
			". . ."    
			". . .")   
		(cons ;99 valerio
			". . ."    
			". . .")   
		(cons ;100 andrea
			"You were about to activate the SLAVE mode."    
			"Stavi per attivare la modalita' SLAVE.")   
		(cons ;101 valerio
			"Oh yes!"    
			"Ah gia!")   
		(cons ;102 valerio
			"SLAVE mode activated!"    
			"Modalita' SLAVE attivata!")   
		(cons ;103 valerio
			"./slave.bin"    
			"./slave.bin")   
		(cons ;104 valerio
			"THE WORLD IS MINE!"    
			"IL MONDO E' MIO!")   
		(cons ;105 valerio
			"Eh, I need a little bit of time."    
			"Eh, ci vuole tempo.")   
		(cons ;106 valerio
			"Network is very slow."    
			"La rete e' lenta.")   
		(cons ;107 andrea
			"Take your time, mate."    
			"Tranquillo, fai con calma.")   
		(cons ;108 andrea
			"Is everything fine?"    
			"Va tutto bene?")   
		(cons ;109 valerio
			"Uhm, I've some problems in uploading the SLAVE.bin application into the nodes . . ."    
			"Uhm, ho qualche problema a caricare l'applicazione SLAVE.bin nei nodi . . .")   
		(cons ;110 valerio
			"Let me try to restart my FTP client."    
			"Provo a riavviare il client FTP.")   
		(cons ;111 andrea
			"Wooops."    
			"Oooops.")   
		(cons ;112 bruno
			"SIGPIPE"    
			"SIGPIPE")   
		(cons ;113 bruno
			"Connection with the remote server has been interrupted"    
			"Conessione con server centrale interrotta")   
		(cons ;114 luca
			"Great job Andrea!"    
			"Fantastico lavoro Andrea!")   
		(cons ;115 luna
			"You saved the world, Cug!"    
			"Hai salvato il mondo, Cug!")   
		(cons ;116 andrea
			"What?"    
			"Cosa?")   
		(cons ;117 andrea
			"So guys?"    
			"Allora ragazzi?")   
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
(define temple_part_one       (collector_get "temple_part_one"))
(define temple_part_two       (collector_get "temple_part_two"))
(define temple_part_three     (collector_get "temple_part_three"))
(define temple_part_four      (collector_get "temple_part_four"))
(define server_disconnected   (collector_get "server_disconnected"))

;Action!
(if (= temple_part_one 1.0)
  (if (= temple_part_two 1.0)
    (if (= temple_part_three 1.0)
      (begin
        (puppeteer_set          "bruno"   "front_loading")
        (stagecrafter_set_item  "boss"    "left_really_angry")
        (if (= server_disconnected 1.0)
          (begin
            (puppeteer_move "andrea" 3600)
            (director_wait_movement "andrea")
            (stagecrafter_set_item "boss" "right_really_angry")
            (say_and_go "andrea" (get_dialog dialogs language 117) "pdeepilogue_track117") ;preview: So, guys? | looking at Andrea
            (director_wait_time 1)
            (puppeteer_set "luna" "hung_left")
            (puppeteer_set "luca" "hung_left")
            (director_wait_message "andrea")
            (puppeteer_set "andrea" "still_left")
            (say "andrea"  (get_dialog dialogs language 108) "pdeepilogue_track108") ;preview: So, is everything fine? | looking at Andrea
            (say "valerio" (get_dialog dialogs language 109) "pdeepilogue_track109") ;preview: Uhm, I've some problems in . . .| looking at Andrea
            (say "valerio" (get_dialog dialogs language 110) "pdeepilogue_track110") ;preview: Let me try to restart . . . | looking at Andrea
            (director_wait_time 1)
            (stagecrafter_set_item "boss" "offline")
            (director_wait_time 1)
            (say "andrea" (get_dialog dialogs language 111) "pdeepilogue_track111") ;preview: Wooops. | looking at Andrea
            (puppeteer_move "bruno" 100)
            (puppeteer_stare "andrea" "bruno")
            (say "bruno" (get_dialog dialogs language 112) "pdeepilogue_track112") ;preview: SIGPIPE
            (say "bruno" (get_dialog dialogs language 113) "pdeepilogue_track113") ;preview: Connection with the remote . . .
            (say "bruno" (get_dialog dialogs language 112) "pdeepilogue_track112") ;preview: SIGPIPE
            (puppeteer_set "luna" "still_left_simple")
            (director_wait_time 1)
            (puppeteer_set "luca" "still_left")
            (effecteer_stop "the_duel")
            (effecteer_stop "stone_paradise")
            (say_and_go "luna" (get_dialog dialogs language 114) "pdeepilogue_track114") ;preview: Great job Andrea! | looking at Andrea
            (director_wait_time 1)
            (puppeteer_stare "andrea" "#null")
            (puppeteer_set "andrea" "still_right")
            (director_wait_message "luna")
            (say "luca" (get_dialog dialogs language 115) "pdeepilogue_track115") ;preview: You saved the world! | looking at Andrea
            (director_wait_time 2)
            (effecteer_play "camera_one"    "camera_effect_one"   0 0 64 nil)
            (director_wait_time 0.75)
            (director_camera_set 3600 850  1.5)
            (director_wait_time 2)
            (effecteer_play "camera_two"    "camera_effect_two"   0 0 64 nil)
            (director_wait_time 0.6)
            (director_camera_set 3600 850  2.0)
            (director_wait_time 1)
            (effecteer_play "camera_three"  "camera_effect_three" 0 0 64 nil)
            (director_wait_time 0.6)
            (director_camera_set 3600 850 3.5)
            (director_wait_time 3)
            (say "andrea" (get_dialog dialogs language 116) "pdeepilogue_track116") ;preview: What? | looking at Andrea
            (director_wait_time 1)
            (effecteer_delete "the_duel")
            (effecteer_delete "stone_paradise")
            (effecteer_delete "camera_one")
            (effecteer_delete "camera_two")
            (effecteer_delete "camera_three")
            (effecteer_play "the_duel" "the_duel" 2000 2000 16)
            (director_script "epilogue_credits"))
          (main_control "andrea")
          ))
      (begin
        ;Restore location of the character
        (puppeteer_show "andrea" 2800)
        (director_wait_time 2)

        (puppeteer_set "andrea" "still_right")
        (say "andrea" (get_dialog dialogs language 33) "pdeepilogue_track33") ;preview: . . . | looking at Valerio
        (say "andrea" (get_dialog dialogs language 34) "pdeepilogue_track34") ;preview: I am sorry, I have a question. | looking at Valerio
        (say "andrea" (get_dialog dialogs language 35) "pdeepilogue_track35") ;preview: You are a computer, aren't y... | looking at Valerio
        (stagecrafter_set_item "boss" "left_sadic")
        (say "valerio" (get_dialog dialogs language 36) "pdeepilogue_track36") ;preview: Correct. | looking at Andrea
        (puppeteer_set "andrea" "scratch_right")
        (say "andrea" (get_dialog dialogs language 37) "pdeepilogue_track37") ;preview: Well . . . | looking at Valerio
        (say "andrea" (get_dialog dialogs language 38) "pdeepilogue_track38") ;preview: Uhm. | looking at Valerio
        (puppeteer_set "andrea" "point_right")
        (say "andrea" (get_dialog dialogs language 39) "pdeepilogue_track39") ;preview: Ho can you dominate the world? | looking at Valerio
        (puppeteer_set "andrea" "still_right")
        (say "valerio" (get_dialog dialogs language 40) "pdeepilogue_track40") ;preview: Good question! | looking at Andrea
        (say "valerio" (get_dialog dialogs language 41) "pdeepilogue_track41") ;preview: Do you know about Solaris? | looking at Andrea
        (puppeteer_set "andrea" "scratch_right")
        (say "andrea" (get_dialog dialogs language 42) "pdeepilogue_track42") ;preview: The virus? | looking at Valerio
        (stagecrafter_set_item "boss" "right_sadic")
        (say "valerio" (get_dialog dialogs language 43) "pdeepilogue_track43") ;preview: How sweet, so clueless . . . | looking at Andrea
        (stagecrafter_set_item "boss" "left_sadic")
        (say "valerio" (get_dialog dialogs language 44) "pdeepilogue_track44") ;preview: Solaris is a Virus that tran... | looking at Andrea
        (say "andrea" (get_dialog dialogs language 45) "pdeepilogue_track45") ;preview: I don't know that book. | looking at Valerio
        (say "valerio" (get_dialog dialogs language 46) "pdeepilogue_track46") ;preview: I was sure, and that's the r... | looking at Andrea
        (say "andrea" (get_dialog dialogs language 47) "pdeepilogue_track47") ;preview: Honestly . . . | looking at Valerio
        (puppeteer_set "andrea" "scratch_right")
        (say "andrea" (get_dialog dialogs language 48) "pdeepilogue_track48") ;preview: . . .  I thought I'd get som... | looking at Valerio
        (say "valerio" (get_dialog dialogs language 49) "pdeepilogue_track49") ;preview: In our world Solaris isn't a... | looking at Andrea
        (puppeteer_set "andrea" "point_right")
        (say "andrea" (get_dialog dialogs language 50) "pdeepilogue_track50") ;preview: That Artificial Intelligence... | looking at Valerio
        (puppeteer_set "andrea" "still_right")
        (say "andrea" (get_dialog dialogs language 51) "pdeepilogue_track51") ;preview: Crash continously and is ext... | looking at Valerio
        (say "valerio" (get_dialog dialogs language 52) "pdeepilogue_track52") ;preview: Well, I wrote it in a rush. | looking at Valerio
        (say "valerio" (get_dialog dialogs language 53) "pdeepilogue_track53") ;preview: I'll make it better lately. | looking at Valerio
        (say "valerio" (get_dialog dialogs language 54) "pdeepilogue_track54") ;preview: However, every person contro... | looking at Andrea
        (say "valerio" (get_dialog dialogs language 55) "pdeepilogue_track55") ;preview: And now, the final step of m... | looking at Andrea
        (say "valerio" (get_dialog dialogs language 56) "pdeepilogue_track56") ;preview: I need a brain of a mathemat... | looking at Andrea
        (say "valerio" (get_dialog dialogs language 57) "pdeepilogue_track57") ;preview: . . . and that's the reason ... | looking at Andrea
        (director_camera_follow "bruno" -100.0 1.0)
        (director_wait_time 3)
        (say "valerio" (get_dialog dialogs language 58) "pdeepilogue_track58") ;preview: Ehm . . . | looking at Andrea
        (director_wait_time 1)
        (say "valerio" (get_dialog dialogs language 59) "pdeepilogue_track59") ;preview: Andrea, could you please mov... | looking at Andrea
        (say "valerio" (get_dialog dialogs language 60) "pdeepilogue_track60") ;preview: You're out from the camera f... | looking at Andrea
        (puppeteer_move "andrea" 3600)
        (director_wait_movement "andrea")
        (puppeteer_set "andrea" "still_left")
        (say "andrea" (get_dialog dialogs language 61) "pdeepilogue_track61") ;preview: It's OK like this? | looking at Valerio
        (stagecrafter_set_item "boss" "right_sadic")
        (say "valerio" (get_dialog dialogs language 62) "pdeepilogue_track62") ;preview: Yes, awesome. | looking at Andrea
        (director_wait_time 1)
        (puppeteer_set "andrea" "still_right")
        (director_wait_time 1)
        (say_and_go "andrea" (get_dialog dialogs language 63) "pdeepilogue_track63") ;preview: OH MY GOD! | looking at Valerio
        (director_wait_time 1)
        (puppeteer_set "luna" "hung_left")
        (puppeteer_set "luca" "hung_left")
        (puppeteer_set "andrea" "point_right")
        (say "andrea" (get_dialog dialogs language 64) "pdeepilogue_track64") ;preview: CUG! | looking at Valerio
        (say "andrea" (get_dialog dialogs language 65) "pdeepilogue_track65") ;preview: LUNA! | looking at Valerio
        (puppeteer_set "andrea" "still_right")
        (say "andrea" (get_dialog dialogs language 66) "pdeepilogue_track66") ;preview: What they are doing to you! | looking at Valerio
        (say "valerio" (get_dialog dialogs language 67) "pdeepilogue_track67") ;preview: AHAHAH! | looking at Andrea
        (say "valerio" (get_dialog dialogs language 68) "pdeepilogue_track68") ;preview: Bruno! | looking at Bruno
        (say "valerio" (get_dialog dialogs language 69) "pdeepilogue_track69") ;preview: Prepare our patients for the... | looking at Bruno
        (puppeteer_set "bruno" "point_left")
        (say "bruno" (get_dialog dialogs language 70) "pdeepilogue_track70") ;preview: But sir . . .  | looking at Valerio
        (puppeteer_set "bruno" "still_left")
        (stagecrafter_set_item "boss" "right_angry")
        (say "valerio" (get_dialog dialogs language 71) "pdeepilogue_track71") ;preview: NO 'SIR'! | looking at Bruno
        (say "valerio" (get_dialog dialogs language 72) "pdeepilogue_track72") ;preview: DO IT! | looking at Bruno
        (say "bruno" (get_dialog dialogs language 73) "pdeepilogue_track73") ;preview: <Bruno.bin is not responding> | looking at Valerio
        (say "valerio" (get_dialog dialogs language 74) "pdeepilogue_track74") ;preview: Ehm . . . | looking at Bruno
        (stagecrafter_set_item "boss" "right_sadic")
        (say "valerio" (get_dialog dialogs language 75) "pdeepilogue_track75") ;preview: Now I'll upload a new firmwa... | looking at Andrea
        (puppeteer_set "andrea" "still_left")
        (say "andrea" (get_dialog dialogs language 76) "pdeepilogue_track76") ;preview: Please, go ahead. | looking at Valerio
        (director_wait_time 1)
        (say "valerio" (get_dialog dialogs language 77) "pdeepilogue_track77") ;preview: OK, let me launch the upload... | looking at Andrea
        (director_wait_time 2)
        (stagecrafter_set_item "boss" "right_really_angry")
        (director_wait_time 1)
        (say "valerio" (get_dialog dialogs language 78) "pdeepilogue_track78") ;preview: FFFFFFFF! | looking at Andrea
        (say "valerio" (get_dialog dialogs language 79) "pdeepilogue_track79") ;preview: Ehm . . . | looking at Andrea
        (puppeteer_set "andrea" "point_left")
        (say "andrea" (get_dialog dialogs language 80) "pdeepilogue_track80") ;preview: I see you're having a tough ... | looking at Valerio
        (puppeteer_set "andrea" "still_left")
        (say "andrea" (get_dialog dialogs language 81) "pdeepilogue_track81") ;preview: Do you want me to reboot you? | looking at Valerio
        (say "valerio" (get_dialog dialogs language 82) "pdeepilogue_track82") ;preview: NO! | looking at Andrea
        (say "valerio" (get_dialog dialogs language 83) "pdeepilogue_track83") ;preview: DON'T TOUCH ME! | looking at Andrea
        (puppeteer_set "andrea" "scratch_left")
        (say "andrea" (get_dialog dialogs language 84) "pdeepilogue_track84") ;preview: Take it easy mate. | looking at Valerio
        (say "valerio" (get_dialog dialogs language 85) "pdeepilogue_track85") ;preview: I have to anticipare the fin... | looking at Andrea
        (say "valerio" (get_dialog dialogs language 86) "pdeepilogue_track86") ;preview: . . . and activate the SLAVE... | looking at Andrea
        (say "valerio" (get_dialog dialogs language 87) "pdeepilogue_track87") ;preview: Soon all the people of the c... | looking at Andrea
        (say_and_go "valerio" (get_dialog dialogs language 88) "pdeepilogue_track88") ;preview: AHAHAH! | looking at Andrea
        (say_and_go "andrea" (get_dialog dialogs language 89) "pdeepilogue_track89") ;preview: AHAHAH! | looking at Valerio
        (director_wait_message "valerio")
        (director_wait_message "andrea")
        (director_wait_time 2)
        (say "valerio" (get_dialog dialogs language 90) "pdeepilogue_track90") ;preview: You should not laugh. | looking at Andrea
        (say "andrea" (get_dialog dialogs language 91) "pdeepilogue_track91") ;preview: Oh, sorry. | looking at Valerio
        (director_wait_time 1)
        (say "andrea" (get_dialog dialogs language 92) "pdeepilogue_track92") ;preview: Can you release my cousin an... | looking at Valerio
        (say "valerio" (get_dialog dialogs language 93) "pdeepilogue_track93") ;preview: No. | looking at Andrea
        (say "andrea" (get_dialog dialogs language 94) "pdeepilogue_track94") ;preview: So, can you give me back Luc... | looking at Valerio
        (say "valerio" (get_dialog dialogs language 95) "pdeepilogue_track95") ;preview: No. | looking at Andrea
        (say "andrea" (get_dialog dialogs language 96) "pdeepilogue_track96") ;preview: . . . | looking at Valerio
        (say "valerio" (get_dialog dialogs language 97) "pdeepilogue_track97") ;preview: . . . | looking at Andrea
        (say "andrea" (get_dialog dialogs language 98) "pdeepilogue_track98") ;preview: . . . | looking at Valerio
        (say "valerio" (get_dialog dialogs language 99) "pdeepilogue_track99") ;preview: . . . | looking at Andrea
        (say "andrea" (get_dialog dialogs language 100) "pdeepilogue_track100") ;preview: You were about to activate t... | looking at Valerio
        (say "valerio" (get_dialog dialogs language 101) "pdeepilogue_track101") ;preview: Oh yes! | looking at Andrea
        (say "valerio" (get_dialog dialogs language 102) "pdeepilogue_track102") ;preview: SLAVE mode activated! | looking at Andrea
        (say "valerio" (get_dialog dialogs language 103) "pdeepilogue_track113") ;preview: ./slave.bin | looking at Andrea

        (puppeteer_set "bruno" "front_loading")
        (say "valerio" (get_dialog dialogs language 104) "pdeepilogue_track114") ;preview: THE WORLD IS MINE! | looking at Andrea

        ;Move to the next act
        (collector_set "temple_part_three" 1.0)
        (director_script "epilogue_intro_temple"))
      )
    (begin
      ;Restore location of the character
      (puppeteer_show "andrea" 2800)
      (director_wait_time 2)

      (director_script "epilogue_final"))
    )
  (begin
    (director_wait_time 2)
    (say "andrea" (get_dialog dialogs language 32) "pdeepilogue_track32") ;preview: Uhm . . . | animation front
    (puppeteer_set "andrea" "still_left")
    (say "andrea" (get_dialog dialogs language 1) "pdeepilogue_track1") ;preview: Valerio? | animation left
    (director_wait_time 2)
    (puppeteer_set "andrea" "still_right")
    (say "andrea" (get_dialog dialogs language 2) "pdeepilogue_track2") ;preview: Valerio? | animation right
    (director_wait_time 2)
    (puppeteer_move "andrea" 2800)
    ;Script suggestion: Andrea inizia a camminare verso destra
    (say "andrea" (get_dialog dialogs language 32) "pdeepilogue_track32") ;preview: Uhm . . . | animation front
    (say "andrea" (get_dialog dialogs language 3) "pdeepilogue_track3") ;preview: There is nobody here . . .
    (director_wait_movement "andrea")
    (director_wait_time 2)
    ;Script suggestion: Andrea si ferma
    (say_and_go "andrea" (get_dialog dialogs language 4) "pdeepilogue_track4") ;preview: . . . except for those brain...
    (director_wait_time 1)
    (stagecrafter_set_item "boss" "left_sadic")
    (director_wait_message "andrea")
    (say "valerio" (get_dialog dialogs language 5) "pdeepilogue_track5") ;preview: *beeep*
    (say "andrea" (get_dialog dialogs language 6) "pdeepilogue_track6") ;preview: That beepping computer.
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 7) "pdeepilogue_track7") ;preview: Does 'beepping' exists as wo... | animation front
    (stagecrafter_set_item "boss" "right_sadic")
    (say "valerio" (get_dialog dialogs language 8) "pdeepilogue_track8") ;preview: No. | looking at Andrea
    (say "andrea" (get_dialog dialogs language 9) "pdeepilogue_track9") ;preview: No? | looking at Valerio
    (say "valerio" (get_dialog dialogs language 10) "pdeepilogue_track10") ;preview: No. | looking at Andrea
    (say "andrea" (get_dialog dialogs language 11) "pdeepilogue_track11") ;preview: That voice sounds familiar. | looking at Valerio
    (stagecrafter_set_item "boss" "left_sadic")
    (say "valerio" (get_dialog dialogs language 12) "pdeepilogue_track12") ;preview: It's me! | looking at Andrea
    (director_wait_time 1)
    (puppeteer_set "andrea" "still_right")
    (director_wait_time 1)
    (say "valerio" (get_dialog dialogs language 13) "pdeepilogue_track13") ;preview: Valerio! | looking at Andrea
    (director_wait_time 1)
    (say "andrea" (get_dialog dialogs language 14) "pdeepilogue_track14") ;preview: . . . | looking at Valerio
    (director_wait_time 1)
    (say "valerio" (get_dialog dialogs language 15) "pdeepilogue_track15") ;preview: I was waiting for you, Andrea! | looking at Andrea
    (director_wait_time 1)
    (say "andrea" (get_dialog dialogs language 16) "pdeepilogue_track16") ;preview: I . . . | looking at
    (director_wait_time 1)
    (puppeteer_set "andrea" "front")
    (say "andrea" (get_dialog dialogs language 17) "pdeepilogue_track17") ;preview: I am still shook up about th... | looking at Valerio
    (puppeteer_set "andrea" "still_right")
    (say "andrea" (get_dialog dialogs language 18) "pdeepilogue_track18") ;preview: What's become of you, PD? | looking at Valerio
    (say "andrea" (get_dialog dialogs language 19) "pdeepilogue_track19") ;preview: A software? | looking at Valerio
    (say "andrea" (get_dialog dialogs language 20) "pdeepilogue_track20") ;preview: A computer? | looking at Valerio
    (say "andrea" (get_dialog dialogs language 21) "pdeepilogue_track21") ;preview: An operating system? | looking at Valerio
    (say "valerio" (get_dialog dialogs language 22) "pdeepilogue_track22") ;preview: As you can clearly see, I am... | looking at Andrea
    (say "valerio" (get_dialog dialogs language 23) "pdeepilogue_track23") ;preview: A computer connected to doze... | looking at Andrea
    (say "valerio" (get_dialog dialogs language 24) "pdeepilogue_track24") ;preview: I am a super intelligent unit! | looking at Andrea
    (say "valerio" (get_dialog dialogs language 25) "pdeepilogue_track25") ;preview: Do you know Portal's GlaDOS? | looking at Andrea
    (say "andrea" (get_dialog dialogs language 26) "pdeepilogue_track26") ;preview: Yes? | looking at Valerio
    (say "valerio" (get_dialog dialogs language 27) "pdeepilogue_track27") ;preview: GlaDOS is nothing compared t... | looking at Andrea
    (say "andrea" (get_dialog dialogs language 28) "pdeepilogue_track28") ;preview: GlaDOS was charming, PD. | looking at Valerio
    (stagecrafter_set_item "boss" "left_angry")
    (say "valerio" (get_dialog dialogs language 29) "pdeepilogue_track29") ;preview: I am charming. | looking at Andrea
    (say "andrea" (get_dialog dialogs language 30) "pdeepilogue_track30") ;preview: Mah. | looking at Valerio
    (stagecrafter_set_item "boss" "left_sadic")
    (say "valerio" (get_dialog dialogs language 31) "pdeepilogue_track31") ;preview: Let me explain you . . . | looking at Andrea

    ;Move to the next act
    (collector_set "temple_part_one" 1.0)
    (director_script "epilogue_intro_temple"))
  )
