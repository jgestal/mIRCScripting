;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; !seen server
;
;*************************************
on 1:start:{ makefile dat\seen.log }
alias seen makedialog -m seen
dialog seen {
  title "Servidor !seen"
  size -1 -1 100 80
  icon icons\eye.ico
  option dbu
  check "Activar servidor !seen",1,5 5 90 15,push
  edit "",2,5 25 15 10,autohs,center
  text "!Seen en",3,25 27 25 10
  edit "",4,50 25 15 10,autohs,center
  text "Segundos",5,70 27 25 10
  text "Limitar log a",6,5 42 30 10
  edit "",7,35 40 30 10,autohs,center

  text "lineas",8,70 42 20 10

  box "",9,-5 55 110 50
  button "Aceptar",10,10 65 30 10,ok,default
  button "Cancelar",11,60 65 30 10,cancel
}
on 1:dialog:seen:init:*: { 
  did $iif(%seen,-c,-u) seen 1 
  if (!%seen.2) %seen.2 = 4
  if (!%seen.4) %seen.4 = 15
  if (!%seen.7) %seen.7 = 670
  did -a seen 2 %seen.2
  did -a seen 4 %seen.4
  did -a seen 7 %seen.7
}
on 1:dialog:seen:sclick:10: {
  $iif($did(seen,1).state == 1,set,unset) %seen on
  %seen.2 = $did(seen,2)
  %seen.4 = $did(seen,4)
  %seen.7 = $iif($did(seen,7) < 700,$ifmatch,700)
  dialog -x $dname
  $_ok(Puede que notes que el mIRC se queda colgado. Es porque est� updateando el log del !seen. Espera un poco y el mIRC volver� a funcionar correctamente.)
  seen_checklines

}
on 1:text:!seen*:*: {
  if (%seen) {
    if (%seen.2 == $null) %seen.2 = 4
    if (%seen.4 == $null) %seen.4 = 15
    if (%tmp.seen == $null) set -u [ $+ [ %seen.4 ] ] %tmp.seen 0
    inc %tmp.seen
    if (%tmp.seen < %seen.2) {
      if ($2) { 
        %x = $seen_info($2) 
        if (!%x) set %x $seen_noinfo($2)
      }
      if ($2 == $null) %x = $seen_nonick
      notice $nick !seen %x
    }
  }
}
alias seen_nonick {
  goto $rand(1,10)
  :1 | return No suck nick channel.
  :2 | return �Buscando por nada?
  :3 | return No creo que encuentres aquello por lo que no buscas.
  :4 | return Si no sabes qu� buscar... estate quieto! :P
  :5 | return No such nick/channel :P
  :6 | return Nadie encuentra a nadie.
  :7 | return Nadie es perfecto. �Buscas la perfecci�n?
  :8 | return Si no me dices qui�n es, no te dir� d�nde est�
  :9 | return No buscas a nadie.
  :10 | return No lo encontrar�s si no sabes su nombre.
}
alias seen_info {
  if ($1 == $me) return $seen_me
  elseif ($nick == $1) return $seen_mismonick($1)
  elseif ($1 ison $chan) return $seen_mismocanal($1)
  elseif ($comchan($1,0) == 1) return $seen_uncanal($1)
  elseif ($comchan($1,0) > 1) { %x = $comchan($1,1) | %i = 2
    while ($comchan($1,%i)) { %x = %x $+ , $+ $comchan($1,%i) | inc %i }
  return $seen_varioscanales($1,%x) }
  else return $seen_loginfo($1)
}
alias seen_me {
  goto $rand(1,10)
  :1 | return �Me buscas?
  :2 | return Aqu� estoy :P
  :3 | return �Preguntando por mi?
  :4 | return �Hola? �No me ves? Pues mira bien!! :)
  :5 | return Aqu� te espero.
  :6 | return Eo aqu� estoy!!!
  :7 | return �No me ves?
  :8 | return Nunca me encuentras... pues yo no me escondo!!!
  :9 | return A ver si otro dia me ves sin tener que avisarte.
  :10 | return Siempre preguntando por mi...
}
alias seen_mismonick {
  goto $rand(1,10)
  :1 | return �No sabes donde est�s? �Otra vez has bebido?
  :2 | return �Buscando a tu yo?
  :3 | return No te encontrar�s tan facilmente.
  :4 | return No tengo ni idea de d�nde est�s, $1 $+ .
  :5 | return Mirate a un espejo.
  :6 | return �Buscando por ti mismo? No pierdas el tiempo hombre.
  :7 | return La vida es corta, no la malgastes buscandote.
  :8 | return �No te ves? Pues mirate a un espejo.
  :9 | return �Preguntando por ti?
  :10 | return No creo que no sepas d�nde est�s.
}
alias seen_mismocanal {
  goto $rand(1,10)
  :1 | return �Est�s ciego? $1 est� aqu� con nosotros en $chan $+ !!!
  :2 | return �De verdad que no ves a $1 en la lista de nicks de $chan $+ ?
  :3 | return �Tienes que comprarte gafas! Andas mal de la vista, � $+ $1 est� en $chan con nosotros!
  :4 | return Haz el favor de mirar para la lista de nicks y no me preguntes m�s por $1 $+ .
  :5 | return Pues... $1 est� en �ste canal! ser�s despistado...
  :6 | return Abre los ojos y mira a $1 en la lista de nicks de $chan $+ .
  :7 | return $1 est� escondido en la lista de nicks de $chan $+ .
  :8 | return Parece mentira que no sepas d�nde est� $1 $+ , miralo en el canal $chan $+ .
  :9 | return $1 est� en $chan $+ ; a ver si nos fijamos m�s...
  :10 | return $1 est� contigo en $chan $+ . 
}
alias seen_uncanal {
  goto $rand(1,10)
  :1 | return $1 Coincide conmigo en un canal: $comchan($1,1) $+ .
  :2 | return A $1 lo tengo visto por $comchan($1,1) $+ .
  :3 | return Se ve que a $1 le gusta la tem�tica de $comchan($1,1) $+ .
  :4 | return $1 est� ahoramismo en $comchan($1,1) $+ .
  :5 | return $1 te manda recuerdos desde $comchan($1,1) $+ .
  :6 | return $comchan($1,1) es el mejor sitio para buscar a $1 $+ .
  :7 | return Supongo que si miras en $comchan($1,1) encontrar�s a $1 $+ .
  :8 | return $1 est� en $comchan($1,1) pero no le digas que te lo dije yo! :P
  :9 | return $1 te espera en $comchan($1,1) impaciente
  :10 | return �Has mirado en $comchan($1,1) para encontrar a $1 $+ ?
}
alias seen_varioscanales {
  goto $rand(1,10)
  :1 | return A $1 lo ver�s en �stos canales: $2- $+ .
  :2 | return $1 anda por �stos canales: $2- $+ .
  :3 | return $1 suele venir por $2- $+ .
  :4 | return No le digas a $1 que te dije que est� en $2- $+ .
  :5 | return Ve a cualquiera de $2- canales para ver a $1 $+ .
  :6 | return No vas a junto de $1 a cualquier canal de �stos: $2- $+ .
  :7 | return $1 te espera en $2- $+ .
  :8 | return $1 anda escondido por los canales $2- $+ .
  :9 | return Date una vuelta por �stos canales: $2- $+ ; y encontrar�s a $1 $+ .
  :10 | return $1 est� por �stos canales $2- a qu� esperas para ir!!!!
}
alias seen_noinfo {
  goto $rand(1,10)
  :1 | return No tengo datos de $1 $+ .
  :2 | return Lo siento, no se nada de $1 $+ .
  :3 | return A saber d�nde est� $1 $+ ...
  :4 | return No conozco a $1 $+ .
  :5 | return Si veo a $1 tendr�s noticias m�as.
  :6 | return No encuentro a $1 $+ , �lo has escrito bien?
  :7 | return $1 no me suena de nada.
  :8 | return $1 est� bien escondido y no se le ve.
  :9 | return $1 no est� por �stos lugares.
  :10 | return Abr� que avisar a la polic�a como no aparezca $1 $+ .
}
on 1:quit: {
  seen_write $nick dej� el IRC el d�a $date ( $+ $time $+ ) con el mensaje: $$1-
  seen_checklines
}
on 1:nick: {
  seen_write $nick Visto por �ltima vez el $date ( $+ $time $+ ) cambiandose el nick a $newnick $+ .
  seen_checklines
}
on 1:part:#: {
  if ($comchan($nick,1) == $null) {
    seen_write $nick Visto por �ltima vez el $date  ( $+ $time $+ ) saliendo de $chan $+ .
    seen_checklines
  }
}
on 1:kick:#: {
  if ($comchan($knick,1) == $null) {
    seen_write $knick Visto por �ltima vez el $date  ( $+ $time $+ ) kickeado de $chan por: $1-
    seen_checklines
  }
}
alias seen_checklines {
  var %i $lines(dat\seen.log)
  while (%i => %seen.7) { write -dl2 dat\seen.log | dec %i }
}
alias seen_write return ;writeini dat\seen.log general $$1 $$2-

alias seen_loginfo {
  var %x $readini dat\seen.log general $$1 
  if (%x) {
    var %x $$1 %x
    return %x 
  }
}
