;Tento dotaznik bol vytvoreny a sluzi na zistenie pritomnosti koronavirusu z odpovedi u opytaneho.

(defrule banner ""
  (declare (salience 10))
  =>
  (printout t crlf crlf)
  (printout t "Call centrum pre Slovensko: +421 222 200 910" crlf )
  (printout t "Dalsie informacie najdete na: https://www.korona.gov.sk/" crlf)
  (printout t "Ako poziadat o vysetrenie: https://www.korona.gov.sk/poziadat-o-vysetrenie-na-covid-19/" crlf)
  (printout t crlf crlf))
;--------------------------
(defrule horucka>38
=>
(printout t "Mate teplotu nad 38 stupnov Celzia? [ano/nie] " crlf)
(assert (priznak-horucka (read))))

(defrule historia-cestovania
(priznak-horucka nie)
=>
(printout t "Cestovali ste za posledne obdobie do zahranicia? [ano/nie] " crlf)
(assert (cestoval (read))))

(defrule predpoklad-zdravy
(and (priznak-horucka nie)
(cestoval nie))
=>
(printout t "Ste zdravotne v poriadku." crlf)
(assert (kondicia-zdravy ano)))

(defrule porusil-lockdown
(and (priznak-horucka nie)
(cestoval ano))
=>
(printout t crlf "-------- VYSLEDOK --------" crlf)
(printout t "Prosim, dostavte sa co najskor na pretestovanie." crlf)
(printout t "Ako poziadat o vysetrenie: https://www.korona.gov.sk/poziadat-o-vysetrenie-na-covid-19/" crlf)
(assert (kondicia-rizikovy ano)))

(defrule prechladnutie
(priznak-horucka ano)
=>
(printout t "Mate kasel, nadchu alebo oboje [ano/nie]?  " crlf)
(assert (je-prechladnuty (read))))

(defrule podozrenie-chripka
(and (priznak-horucka ano)
(je-prechladnuty nie))
=>
(printout t crlf "-------- VYSLEDOK --------" crlf)
(printout t "Vyzera to na horucku. Prosim, zostante doma a odpocivajte. V pripade zhorsenia zdravotneho stavu kontaktujte svojho lekara." crlf)
(assert (ma-horucku ano)))

(defrule tazkosti-dychania
(and (priznak-horucka ano)
(je-prechladnuty ano))
=>
(printout t "Mate zapal pluc, zapal priedusiek alebo dychavicnost [ano/nie]? " crlf)
(assert (dychavicnost(read))))

(defrule bez-dychavicnosti
(and (priznak-horucka ano)
(je-prechladnuty ano)
(dychavicnost nie))
=>
(printout t crlf "-------- VYSLEDOK --------" crlf)
(printout t "Vyzera to na horucku. Prosim, zostante doma a odpocivajte. V pripade zhorsenia zdravotneho stavu kontaktujte svojho lekara." crlf)
(assert (kondicia-chripka ano)))

(defrule ma-dychavicnost
(and (priznak-horucka ano)
(je-prechladnuty ano)
(dychavicnost ano))
=>
(printout t "Cestovali ste v poslednej dobe do zahranicia? [ano/nie]? " clrf)
(assert (naposledy-cestoval(read))))

(defrule podozrenie-covid
(and (priznak-horucka ano)
(je-prechladnuty ano)
(dychavicnost ano)
(naposledy-cestoval nie))
=>
(printout t crlf "-------- VYSLEDOK --------" crlf)
(printout t "Vas stav bude monitorovany v priebehu nasledujucich 2 tyzdnov. Zostante prosim doma a vyhybajte sa kontaktu s ludmi." )
(assert (mierne-rizikovy(read))))


(defrule historia-kontaktu
(and (priznak-horucka ano)
(je-prechladnuty ano)
(dychavicnost ano)
(naposledy-cestoval ano))
=>
(printout t "Dostali ste sa do kontaktu s niekym, kto je infikovany chorobou Covid-19? [ano/nie] " clrf)
(assert (bol-v-kontakte(read))))

(defrule je-rizikovy
(and (priznak-horucka ano)
(je-prechladnuty ano)
(dychavicnost ano)
(naposledy-cestoval ano)
(bol-v-kontakte nie))
=>
(printout t crlf "-------- VYSLEDOK --------" crlf)
(printout t "Je nutna izolacia a pretestovanie." crlf)
(printout t "Ako poziadat o vysetrenie: https://www.korona.gov.sk/poziadat-o-vysetrenie-na-covid-19/" crlf)
(assert (moze-byt-infikovany)))

(defrule velmi-rizikovy
(and (priznak-horucka ano)
(je-prechladnuty ano)
(dychavicnost ano)
(naposledy-cestoval ano)
(bol-v-kontakte ano))
=>
(printout t crlf "-------- VYSLEDOK --------" crlf)
(printout t "Hrozi, ze ste boli infikovany virusom Covid-19. Je nutna izolacia a pretestovanie. Prosim, co najskor kontaktujte svojho lekara a rodinu.")
(printout t "Call centrum pre Slovensko: +421 222 200 910" crlf )
(printout t "Dalsie informacie najdete na: https://www.korona.gov.sk/" crlf)
(printout t "Ako poziadat o vysetrenie: https://www.korona.gov.sk/poziadat-o-vysetrenie-na-covid-19/" crlf)
(assert (je-infikovany(read))))