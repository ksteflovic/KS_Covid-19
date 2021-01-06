;Tento dotazn�k bol vytvoren� a sl��i na zistenie pr�tomnosti koronav�rusu z odpoved� u opytaneho.

(defrule banner ""
  (declare (salience 10))
  =>
  (printout t crlf crlf)
  (printout t "Call centrum pre Slovensko: +421 222 200 910" crlf )
  (printout t "D�le�it� inform�cie n�jdete na: https://www.korona.gov.sk/" crlf)
  (printout t "Ako po�iada� o vy�etrenie: https://www.korona.gov.sk/poziadat-o-vysetrenie-na-covid-19/" crlf)
  (printout t crlf crlf))
;--------------------------
(defrule horucka>38
=>
(printout t "M�te teplotu nad 38 stup�ov Celzia? [ano/nie] " crlf)
(assert (priznak-horucka (read))))

(defrule historia-cestovania
(priznak-horucka nie)
=>
(printout t "Cestovali ste za posledn� obdobie do zahranicia? [ano/nie] " crlf)
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
(printout t "Prosim, dostavte sa co najsk�r na otestovanie." crlf)
(printout t "Ako po�iada� o vy�etrenie: https://www.korona.gov.sk/poziadat-o-vysetrenie-na-covid-19/" crlf)
(assert (kondicia-rizikovy ano)))

(defrule prechladnutie
(priznak-horucka ano)
=>
(printout t "M�te ka�el, n�dchu alebo oboje [ano/nie]?  " clrf)
(assert (je-prechladnuty (read))))

(defrule podozrenie-chripka
(and (priznak-horucka ano)
(je-prechladnuty nie))
=>
(printout t crlf "-------- VYSLEDOK --------" crlf)
(printout t "Vyzer� to na hor�cku. Pros�m, zostante doma a odpoc�vajte. V pr�pade zhorsenia zdravotn�ho stavu kontaktujte svojho lek�ra." crlf)
(assert (ma-horucku ano)))

(defrule tazkosti-dychania
(and (priznak-horucka ano)
(je-prechladnuty ano))
=>
(printout t "M�te z�pal pl�c, z�pal priedu�iek alebo d�chavicnost� [ano/nie]? " crlf)
(assert (dychavicnost(read))))

(defrule bez-dychavicnosti
(and (priznak-horucka ano)
(je-prechladnuty ano)
(dychavicnost nie))
=>
(printout t crlf "-------- VYSLEDOK --------" crlf)
(printout t "Vyzer� to na chr�pku. Nezabudnite nosi�t spravne r��ko, dodr�iavat� odstup a um�va�jte si pravidelne ruky. A hlavne si odpo�inte." crlf)
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
(printout t "V� stav bude monitorovan� v priebehu nasleduj�cich 2 t��dnov. Zostante pros�m doma a vyh�bajte sa kontaktu s ludmi." )
(assert (mierne-rizikovy(read))))


(defrule historia-kontaktu
(and (priznak-horucka ano)
(je-prechladnuty ano)
(dychavicnost ano)
(naposledy-cestoval ano))
=>
(printout t "Dostali ste sa do kontaktu s niek�m, kto je infikovan� chorobou Covid-19? [ano/nie] " clrf)
(assert (bol-v-kontakte(read))))

(defrule je-rizikovy
(and (priznak-horucka ano)
(je-prechladnuty ano)
(dychavicnost ano)
(naposledy-cestoval ano)
(bol-v-kontakte nie))
=>
(printout t crlf "-------- VYSLEDOK --------" crlf)
(printout t "Je nutn� izol�cia a otestovanie." crlf)
(printout t "Ako po�iada� o vy�etrenie: https://www.korona.gov.sk/poziadat-o-vysetrenie-na-covid-19/" crlf)
(assert (moze-byt-infikovany)))

(defrule velmi-rizikovy
(and (priznak-horucka ano)
(je-prechladnuty ano)
(dychavicnost ano)
(naposledy-cestoval ano)
(bol-v-kontakte ano))
=>
(printout t crlf "-------- VYSLEDOK --------" crlf)
(printout t "Hroz�, �e ste boli infikovan� v�rusom Covid-19. Je nutn� izol�cia a otestovanie. Pros�m, co najsk�r kontaktujte svojho lek�ra a rodinu.")
(printout t "Call centrum pre Slovensko: +421 222 200 910" crlf )
(printout t "D�le�it� inform�cie n�jdete na: https://www.korona.gov.sk/" crlf)
(printout t "Ako po�iada� o vy�etrenie: https://www.korona.gov.sk/poziadat-o-vysetrenie-na-covid-19/" crlf)
(assert (je-infikovany(read))))