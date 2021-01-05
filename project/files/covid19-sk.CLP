;Tento dotazník bol vytvorenı a slúi na zistenie prítomnosti koronavírusu z odpovedí. 

(defrule banner ""
  (declare (salience 10))
  =>
  (printout t crlf crlf)
  (printout t "Call centrum pre Slovensko: +421 222 200 910" crlf )
  (printout t "Dôleité informácie nájdete na: https://www.korona.gov.sk/" crlf)
  (printout t "Ako poiada o vyšetrenie: https://www.korona.gov.sk/poziadat-o-vysetrenie-na-covid-19/" crlf)
  (printout t crlf crlf))
;--------------------------
(defrule horucka>38
=>
(printout t "Máte teplotu nad 38 stupòov Celzia? [ano/nie] " crlf)
(assert (priznak-horucka (read))))

(defrule historia-cestovania
(priznak-horucka nie)
=>
(printout t "Cestovali ste za posledné obdobie do zahranicia? [ano/nie] " crlf)
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
(printout t "Prosim, dostavte sa co najskôr na otestovanie." crlf)
(printout t "Ako poiada o vyšetrenie: https://www.korona.gov.sk/poziadat-o-vysetrenie-na-covid-19/" crlf)
(assert (kondicia-rizikovy ano)))

(defrule prechladnutie
(priznak-horucka ano)
=>
(printout t "Máte kašel, nádchu alebo oboje [ano/nie]?  " clrf)
(assert (je-prechladnuty (read))))

(defrule podozrenie-chripka
(and (priznak-horucka ano)
(je-prechladnuty nie))
=>
(printout t crlf "-------- VYSLEDOK --------" crlf)
(printout t "Vyzerá to na horúcku. Prosím, zostante doma a odpocívajte. V prípade zhorsenia zdravotného stavu kontaktujte svojho lekára." crlf)
(assert (ma-horucku ano)))

(defrule tazkosti-dychania
(and (priznak-horucka ano)
(je-prechladnuty ano))
=>
(printout t "Máte zápal plúc, zápal priedušiek alebo dıchavicnost [ano/nie]? " crlf)
(assert (dychavicnost(read))))

(defrule bez-dychavicnosti
(and (priznak-horucka ano)
(je-prechladnuty ano)
(dychavicnost nie))
=>
(printout t crlf "-------- VYSLEDOK --------" crlf)
(printout t "Vyzerá to na chrípku. Nezabudnite nosit spravne rúško, dodriavat odstup a umıvajte si pravidelne ruky. A hlavne si odpoèinte." crlf)
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
(printout t "Váš stav bude monitorovanı v priebehu nasledujúcich 2 tıdnov. Zostante prosím doma a vyhıbajte sa kontaktu s ludmi." )
(assert (mierne-rizikovy(read))))


(defrule historia-kontaktu
(and (priznak-horucka ano)
(je-prechladnuty ano)
(dychavicnost ano)
(naposledy-cestoval ano))
=>
(printout t "Dostali ste sa do kontaktu s niekım, kto je infikovanı chorobou Covid-19? [ano/nie] " clrf)
(assert (bol-v-kontakte(read))))

(defrule je-rizikovy
(and (priznak-horucka ano)
(je-prechladnuty ano)
(dychavicnost ano)
(naposledy-cestoval ano)
(bol-v-kontakte nie))
=>
(printout t crlf "-------- VYSLEDOK --------" crlf)
(printout t "Je nutná izolácia a otestovanie." crlf)
(printout t "Ako poiada o vyšetrenie: https://www.korona.gov.sk/poziadat-o-vysetrenie-na-covid-19/" crlf)
(assert (moze-byt-infikovany)))

(defrule velmi-rizikovy
(and (priznak-horucka ano)
(je-prechladnuty ano)
(dychavicnost ano)
(naposledy-cestoval ano)
(bol-v-kontakte ano))
=>
(printout t crlf "-------- VYSLEDOK --------" crlf)
(printout t "Hrozí, e ste boli infikovanı vírusom Covid-19. Je nutná izolácia a otestovanie. Prosím, co najskôr kontaktujte svojho lekára a rodinu.")
(printout t "Call centrum pre Slovensko: +421 222 200 910" crlf )
(printout t "Dôleité informácie nájdete na: https://www.korona.gov.sk/" crlf)
(printout t "Ako poiada o vyšetrenie: https://www.korona.gov.sk/poziadat-o-vysetrenie-na-covid-19/" crlf)
(assert (je-infikovany(read))))