(deftemplate covid19
        (slot vysledok (type SYMBOL) (allowed-symbols ano nie))
        (slot teplota (type FLOAT))
        (slot unava (type FLOAT))
        (slot hrdlo (type FLOAT))
        (slot hrudnik (type FLOAT))
        (slot dychanie (type FLOAT))
        (slot zmysly (type FLOAT))
        (slot cestovanie (type FLOAT)))

(deftemplate vstupne_premenne
        (slot teplota (type FLOAT))
        (slot unava (type FLOAT))
        (slot hrdlo (type FLOAT))
        (slot hrudnik (type FLOAT))
        (slot dychanie (type FLOAT))
        (slot zmysly (type FLOAT))
        (slot cestovanie (type FLOAT)))


(deffacts menucko
        (menu))

(defrule show_menu
?odstranit<-(menu)
=>
        (retract ?odstranit)
        (printout t "-----------<MENU>-----------" crlf)
        (printout t "Dotaznik ..................D" crlf)
        (printout t "Koniec programu ...........K" crlf)
        (printout t "----------------------------" crlf)
        (printout t "Zadajte Vasu volbu:")
        (assert (volba (read))))
        (printout t "Nasledujuce otazky sa tykaju vaseho zdravotneho stavu, vyplnte ich prosim pravdivo" crlf))
        (printout t "================================================" crlf crlf)


(defrule zadajte_vstupne_udaje
        (volba D)
=>
        (printout t "Zadajte vasu teplotu:  ")
        (bind ?o1 (read))
        (printout t "==== Zadavajte 0 = Nie, 1 = Ano ====" crlf)
        (printout t "Pocitujete slabost a unavu? [0/1] - Odpoved:")
        (bind ?o2 (read))
        (printout t "Mate suche hrdlo, pripadne bolest v hrdle? [0/1] - Odpoved: ")
        (bind ?o3 (read))
        (printout t "Citite bolest v hrudniku? [0/1] - Odpoved: ")
        (bind ?o4 (read))
        (printout t "Mate tazkosti s dychanim? [0/1] - Odpoved: ")
        (bind ?o5 (read))
        (printout t "Vsimli ste si poslednou dobou stratu chuti a cuchu? [0/1] - Odpoved: ")
        (bind ?o6 (read))
        (printout t "Cestovali ste do zahranicia? [0/1] - Odpoved: ")
        (bind ?o7 (read))

        (assert (vstupne_premenne (teplota ?o1) (unava ?o2) (hrdlo ?o3) (hrudnik ?o4) (dychanie ?o5) (zmysly ?o6) (cestovanie ?o7))))

(defrule nakazeny_covid
        (vstupne_premenne (teplota ?o1) (unava ?o2) (hrdlo ?o3) (hrudnik ?o4) (dychanie ?o5) (zmysly ?o6) (cestovanie ?o7))
        (test (or
                  (and (> ?o1 38)
                       (> ?o2 0.5)
                       (> ?o3 0.5) 
                       (> ?o4 0.5) 
                       (> ?o5 0.5) 
                       (> ?o6 0.5)
                       (> ?o7 0.5))

                  (and (> ?o1 38)
                       (> ?o2 0.5)
                       (> ?o3 0.5) 
                       (> ?o4 0.5) 
                       (> ?o5 0.5) 
                       (<= ?o6 0.5)
                       (> ?o7 0.5))

                  (and (> ?o1 38)
                       (<= ?o2 0.5)
                       (> ?o3 0.5) 
                       (> ?o4 0.5) 
                       (> ?o5 0.5) 
                       (> ?o7 0.5))

                  (and (> ?o1 38) 
                       (> ?o2 0.5)
                       (> ?o3 0.5)
                       (<= ?o4 0.5))

                  (and (> ?o1 38) 
                       (> ?o2 0.5)
                       (> ?o3 0.5)
                       (> ?o4 0.5)
                       (<= ?o7 0.5))

                  (and (> ?o1 38) 
                       (> ?o2 0.5)
                       (> ?o3 0.5)
                       (> ?o1 0.5)
                       (<= ?o6 0.5))
                )
        )
=>
        (printout t crlf "-------- VYSLEDOK --------" crlf)
        (printout t "Hrozi, ze ste boli infikovany virusom Covid-19. Je nutna izolacia a pretestovanie. Prosim, co najskor kontaktujte svojho lekara a rodinu.")
        (printout t "Call centrum pre Slovensko: +421 222 200 910" crlf )
        (printout t "Dalsie informacie najdete na: https://www.korona.gov.sk/" crlf)
        (printout t "Ako poziadat o vysetrenie: https://www.korona.gov.sk/poziadat-o-vysetrenie-na-covid-19/" crlf))

(defrule mozny_covid
        (vstupne_premenne (teplota ?o1) (unava ?o2) (hrdlo ?o3) (hrudnik ?o4) (dychanie ?o5) (zmysly ?o6) (cestovanie ?o7))
        (test (or
                  (and (<= ?o1 38) 
                       (> ?o2 0.5)
                       (> ?o3 0.5)
                       (<= ?o6 0.5)
                       (<= ?o7 0.5))

                  (and (<= ?o1 38) 
                       (<= ?o2 0.5)
                       (<= ?o3 0.5)
                       (<= ?o5 0.5)
                       (> ?o7 0.5))

                  (and (> ?o1 38)
                       (<= ?o3 0.5) 
                       (<= ?o4 0.5) 
                       (<= ?o7 0.5))

                  (and (> ?o1 38)
                       (> ?o4 38) 
                       (> ?o5 0.5)
                       (<= ?o6 0.5) 
                       (<= ?o7 0.5) )
                )
        )
=>
        (printout t " " crlf)
        (printout t crlf "-------- VYSLEDOK --------" crlf)
        (printout t "Je mozne, ze ste boli nakazeny covidom-19. Zostante prosim doma a vyhybajte sa kontaktu s ludmi." )
        (printout t "Call centrum pre Slovensko: +421 222 200 910" crlf )
        (printout t "Dalsie informacie najdete na: https://www.korona.gov.sk/" crlf))

(defrule nema_covid
        (vstupne_premenne (teplota ?o1) (unava ?o2) (hrdlo ?o3) (hrudnik ?o4) (dychanie ?o5) (zmysly ?o6) (cestovanie ?o7))
        (test (or
                  (and (<= ?o1 38) 
                       (<= ?o2 0.5)
                       (<= ?o3 0.5)
                       (<= ?o4 0.5)
                       (<= ?o5 0.5)
                       (<= ?o6 0.5)
                       (<= ?o7 0.5))

                  (and (<= ?o1 38) 
                       (> ?o2 0.5)
                       (<= ?o3 0.5)
                       (<= ?o4 0.5)
                       (<= ?o5 0.5)
                       (<= ?o6 0.5)
                       (<= ?o7 0.5))

                  (and (> ?o1 38) 
                       (<= ?o2 0.5)
                       (<= ?o3 0.5)
                       (<= ?o4 0.5)
                       (<= ?o5 0.5)
                       (<= ?o6 0.5)
                       (<= ?o7 0.5))

                  (and (> ?o3 0.5)
                       (<= ?o4 0.5)
                       (<= ?o5 0.5)
                       (<= ?o6 0.5)
                       (<= ?o7 0.5))     
                )
        )
=>
        (printout t " " crlf)
        (printout t "Podla zadanych udajov ste negativny" crlf)
        (printout t "V pripade zhorsenia zdravotneho stavu kontaktujte svojho lekara." crlf)
        (printout t "Nezabudnite dodrziavat odstup, umyvat si ruky a nosit rusko." crlf))
        
(defrule zrusit_vyhladavanie
        (declare (salience -1))
        ?aktualne<-(volba V)
?odstranit<-(vstupne_premenne (teplota ?o1) (unava ?o2) (hrdlo ?o3) (hrudnik ?o4) (dychanie ?o5) (zmysly ?o6) (cestovanie ?o7))
=>
        (retract ?odstranit ?aktualne)
        (assert(menu)))


(defrule konec_programu
	(volba K)
=>
	      (printout t "---------------------------------------" crlf)
        (printout t "----------- KONIEC PROGRAMU -----------" crlf)
        (printout t "---------------------------------------" crlf))