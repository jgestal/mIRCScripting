;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; Noticias del script
; (desactivadas, ahora simplemente abre mi página).
;*************************************

alias noticias {
  run $_web.noticias
  return
  clear @Noticias 
  if ($sock(noticias,1)) .sockclose noticias
  .sockopen noticias 62.52.93.153 80
  window -kal @Noticias
  aline $color(info) @Noticias *** Conectando con el servidor...
}
on 1:sockopen:noticias: {
  if ($sockerr > 1) { 
    aline 4 @Noticias *** Error al conectar
    .sockclose $sockname
  }
  else {
    clear @Noticias
    aline $color(info) @Noticias *** Descargando noticias
    sockwrite -nt noticias GET /canalscripting/backbeat.txt
    sockwrite -n noticias
  }
}
on 1:sockread:noticias: {
  if ($sockerr > 0) return
  :nextread
  sockread %sockread.tmp
  if ($sockbr == 0) return
  aline $color(normal) @Noticias - %sockread.tmp
  goto nextread
}
on 1:sockclose:noticias: {
  aline $color(info) @Noticias *** Fin de las noticias
  .sockclose $sockname
}
on 1:close:@Noticias: { .sockclose noticias }
menu @Noticias {
  &recargar:noticias
  -
  &email al autor:mail $_email
  -
  &visitar web:run $_web
  -
  &cerrar:window -c $active
}

alias visitar_web {
  window -kp @web
  dll dll\nHTMLn.dll attach $window(@web).hwnd
  dll dll\nHTMLn.dll navigate $_web
}
;*************************************
; Scan de Puertos
;
;*************************************

alias portscan makedialog -md psc
dialog psc {
  title "Port Scan" 
  size -1 -1 460 390
  icon icons\portscan.ico,main
  text "&Host:",1,10 10 30 15
  edit "",2,60 8 300 22,autohs
  button "Scan",3,370 10 80 25,default disable
  text "&Desde:",4,10 40 40 15
  edit "",5,60 38 105 22,autohs
  text "&hasta el puerto:",6,175 40 80 15
  edit "",7,255 38 105 22,autohs
  button "Pausa",8,370 40 80 25,disable
  text "&Retraso (ms):",9,60 75 65 15
  edit "",10,130 73 40 22,center
  text "&Máx de sockets abiertos:",11,190 75 130 15
  edit "",12,320 73 40 22,center
  button "Detener",13,370 70 80 25,disable
  Text "&Mirando el puerto:",14,10 105 100 15,disable
  edit "",15,110 103 60 22,read right
  Text "&Sockets abiertos:",16,190 105 100 15,disable
  edit "",17,300 103 60 22,read right
  list 18,10 140 440 220
  button "Limpiar",19,10 355 80 25
  button "Cerrar",20,370 355 80 25,cancel
}
on 1:dialog:psc:init:*: {
  _mdx.buttons_style 3 8 13 19 20
  dll $mdx SetControlMDX $dname 18 listview rowselect grid showsel single flatsb labeltip headerdrag report > $views 
  did -i $dname 18 1 header @130,90,210 0 Host/ip $chr(9) Puerto $chr(9) Descripción
  if (!%tmp.psc.puerto.inicio) %tmp.psc.puerto.inicio = 1
  pscdid -ra psc 5 %tmp.psc.puerto.inicio
  if (!%tmp.psc.puerto.final) %tmp.psc.puerto.final = 65535
  pscdid -ra psc 7 %tmp.psc.puerto.final
  if (!%tmp.psc.retraso.ms) %tmp.psc.retraso.ms = 30
  pscdid -ra psc 10 %tmp.psc.retraso.ms
  if (!%tmp.psc.max.sock) %tmp.psc.max.sock = 100
  pscdid -ra psc 12 %tmp.psc.max.sock
  set %tmp.psc.psccnt 0
  set %tmp.psc.sockets.abiertos 0
  unset  %tmp.psc.psc.halt

  if ($did(psc,2)) && ($did(psc,5)) && ($did(psc,7)) && ($did(psc,10)) && ($did(psc,12)) pscdid -e psc 3
  if ($did(psc,2) == $null) || ($did(psc,5) == $null) || ($did(psc,7) == $null) || ($did(psc,10) == $null) || ($did(psc,12) == $null) pscdid -b psc 3
  pscinforma
}
on 1:dialog:psc:edit:*: {
  %tmp.psc.puerto.inicio = $did(psc,5)
  %tmp.psc.puerto.final = $did(psc,7)
  %tmp.psc.retraso.ms = $did(psc,10)
  %tmp.psc.max.sock = $did(psc,12)

  if ($did(psc,2)) && ($did(psc,5)) && ($did(psc,7)) && ($did(psc,10)) && ($did(psc,12)) && (%tmp.psc.puerto.inicio < %tmp.psc.puerto.final) pscdid -e psc 3
  if ($did(psc,2) == $null) || ($did(psc,5) == $null) || ($did(psc,7) == $null) || ($did(psc,10) == $null) || ($did(psc,12) == $null) || (%tmp.psc.puerto.inicio >= %tmp.psc.puerto.final) pscdid -b psc 3
  pscinforma
}
on 1:dialog:psc:sclick:*: {
  if ($did == 3) {
    pscdid -b psc 1,2,3,4,5,6,7,9,10,11,12
    pscdid -e psc 8,13
    dialog -t $dname Portscan 2.0 Escaneando $did(psc,2) $+ ...
    if (%tmp.psc.psc.halt != on) %tmp.psc.psccnt = %tmp.psc.puerto.inicio
    unset %tmp.psc.psc.halt
    .timerpsc -m 0 %tmp.psc.retraso.ms pscstartscan
  }
  if ($did == 8) {
    pscdid -b psc 8
    set %tmp.psc.psc.halt on
    .timerpsc off
    pscdid -e psc 3
    dialog -t $dname Portscan 2.0 El scan de puertos ha sido pausado.

  }
  if ($did == 13) {
    pscdid -e psc 1,2,3,4,5,6,7,9,10,11,12
    pscdid -b psc 8,13
    unset %tmp.psc.psc.halt
    dialog -t $dname Portscan 2.0 El scan de puertos ha sido detenido.
    .timerpsc off
    .sockclose psc.*
    %tmp.psc.sockets.abiertos = 0
    %tmp.psc.psccnt = 0
  }
  if ($did == 19) pscdid -r psc 18
  pscinforma
  if ($did == 20) { .timerpsc off | unset %tmp.psc.* | sockclose psc.* }
}
alias pscinforma {
  pscdid -ra psc 15 %tmp.psc.psccnt
  pscdid -ra psc 17 %tmp.psc.sockets.abiertos 
}
alias psclog pscdid -a psc 18 1 $1-
alias pscdid if ($dialog(psc)) did $1-
alias pscstartscan {
  if (%tmp.psc.sockets.abiertos <= %tmp.psc.max.sock) {
    inc %tmp.psc.psccnt  
    if ($dialog(psc)) .sockopen psc. [ $+ [ %tmp.psc.psccnt ] ] $did(psc,2) %tmp.psc.psccnt
    inc %tmp.psc.sockets.abiertos
  }
  if (%tmp.psc.psccnt >= %tmp.psc.puerto.final) { .timerpsc off | pscdid -b psc 8,13 }
  pscinforma
}
on 1:sockopen:psc.*: {
  if ($sockerr <= 0) { psclog $sock($sockname,1).ip $chr(9) $gettok($sockname,2,46) $chr(9) $pscname($gettok($sockname,2,46)) }
  .sockclose $sockname
  dec %tmp.psc.sockets.abiertos
  if (%tmp.psc.sockets.abiertos == 0) && (%tmp.psc.psc.halt != on) {
    dialog -t psc Portscan 2.0 Fin del scan de puertos.
    pscdid -b psc 8,13
    pscdid -e psc 1,2,3,4,5,6,7,9,10,11,12
    .timerpsc off
    %tmp.psc.psccnt = 0
  }
  pscinforma
}
alias pscname { if ($1 == 1) return Tcpmux | if ($1 == 7) return Echo | if ($1 == 9) return Discard
  if ($1 == 11) return Systat | if ($1 == 13) return Daytime | if ($1 == 15) return Netstat | if ($1 == 17) return qotd
  if ($1 == 18) return msp | if ($1 == 19) return chargen | if ($1 == 20) return Ftp Data | if ($1 == 21) return Ftp
  if ($1 == 22) return ssh | if ($1 == 23) return Telnet | if ($1 == 25) return Smtp | if ($1 == 37) return time
  if ($1 == 42) return Nameserver | if ($1 == 43) return Whois | if ($1 == 53) return Dns | if ($1 == 59) return Dcc
  if ($1 == 70) return Gopher | if ($1 == 80) return http | if ($1 == 87) return Link | if ($1 == 88) return kerberos
  if ($1 == 101) return hostname | if ($1 == 102) return iso-tsap | if ($1 == 107) return Rtelnet | if ($1 == 109) return Pop2
  if ($1 == 110) return Pop3 | if ($1 == 113) return Identd | if ($1 == 119) return News | if ($1 == 135) return Nb Datagram
  if ($1 == 137) return Nb sesión | if ($1 == 138) return Nb sesión | if ($1 == 139) return NetBios | if ($1 == 143) return imap2
  if ($1 == 177) return xdmcp | if ($1 == 179) return bgp | if ($1 == 191) return prospero | if ($1 == 512) return exec
  if ($1 == 513) return login | if ($1 == 514) return shell | if ($1 == 515) return printer | if ($1 == 526) return tempo
  if ($1 == 530) return courier | if ($1 == 531) return conference | if ($1 == 540) return uucp | if ($1 == 544) return hshell
  if ($1 == 556) return remotefs | if ($1 == 765) return webster | if ($1 == 1080) return Wingate proxy | if ($1 == 1234) return Sub7
  if ($1 == 1503) return Net Meeting | if ($1 == 1720) return Net Meeting | if ($1 == 3150) return Deep Throat | if ($1 == 3333) return Eggdrop
  if ($1 == 6543) return Soul | if ($1 == 6665) return IRC Server | if ($1 == 6666) return IRC Server | if ($1 == 6667) return IRC Server
  if ($1 == 6668) return IRC Server | if ($1 == 6669) return IRC Server | if ($1 == 6699) return Napster | if ($1 == 7000) return IRC Server
  if ($1 == 8080) return Http proxy | if ($1 == 12076) return Gjamer | if ($1 == 12345) return NetBus | if ($1 == 20034) return NetBus 2
  if ($1 == 21554) return Girl Friend | if ($1 == 31337) return Back Orifice UDP | if ($1 == 40426) return Master's Paradise | if ($1 == 54320) return Back Orifice 2000 
  else return Desconocido 
}

;*************************************
; Envío de emails
;
;*************************************

alias email { set -u %mailto $1 | makedialog -md email email }
dialog email {
  title "Envio de emails"
  size -1 -1 200 220
  option dbu
  icon icons\mail.ico,main
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
  _mdx.buttons_style 13 21 22 26 27 1000
  dll $mdx SetControlMDX $dname 16 listview rowselect grid showsel single flatsb labeltip headerdrag report > $views 
  did -i $dname 16 1 header @100,100 0 E-mail $chr(9) Nombre
  dll $mdx SetControlMDX $dname 24 listview rowselect grid showsel single flatsb labeltip headerdrag report > $views 
  did -i $dname 24 1 header @250 0 Servidor
  did -a $dname 5 %mi.mail
  email_loadlists
  if (%mailto) { did -a $dname 7 %mailto | did -c $dname 7 $did($dname,7).lines }

  .timer -m 0 10 email_timer
}
on 1:dialog:email:sclick:*: {
  if ($did == 13) {
    .sockclose BaTmail
    .sockopen BaTmail $did($dname,3) 25
    did -ra $dname 12 Conectando con $did($dname,3) (25) ...
  }
  if ($did == 21) {
    write " $+ dat\mailagenda.dat $+ " $gettok($did($dname,18),1,32) $+ $chr(5) $+ $did($dname,20)
    did -r $dname 18,20    
    email_loadlists
  }
  if ($did == 22) { 
    write -dl $+ $calc($did($dname,16).sel - 1) " $+ dat\mailagenda.dat $+ "
    email_loadlists
  }
  if ($did == 26) {
    write " $+ dat\smtp.dat $+ " $did($dname,25)
    did -r $dname 25
    email_loadlists
  }
  if ($did == 27) { 
    write -dl $+ $calc($did($dname,24).sel - 1) " $+ dat\smtp.dat $+ "
    email_loadlists
  }
  did $iif($did($dname,16).sel,-e,-b) $dname 22
  did $iif($did($dname,24).sel,-e,-b) $dname 27
}
alias email_loadlists {
  mkdir dat
  if ($findfile(dat,mailagenda.dat,1) == $null) write -c dat\mailagenda.dat
  if ($findfile(dat,smtp.dat,1) == $null) write -c dat\smtp.dat
  did -r $dname 3,7,16,24
  did -b $dname 22,27
  var %i 1
  while (%i <= $lines(dat\mailagenda.dat))  {
    %x = $read -l %i dat\mailagenda.dat
    did -a $dname 7 $gettok(%x,2,5) ( $+ $gettok(%x,1,5) $+ )
    did -a $dname 16 $gettok(%x,2,5) $chr(9) $gettok(%x,1,5)
    inc %i
  }
  %i = 1
  while (%i <= $lines(dat\smtp.dat))  {
    %x = $read -l %i dat\smtp.dat
    did -a $dname 3 %x
    did -a $dname 24 %x
    inc %i
  }
  did -c $dname 3 1
}
alias email_timer { if ($dialog(email) == $null) { .sockclose BaTmail | unset %tmp.BaTmail.tmp | .timeremail off } }
on 1:dialog:email:edit:*: {
  if ($did($dname,3)) && ($did($dname,5)) && ($did($dname,7)) && ($did($dname,11)) did -e $dname 13
  if ($did($dname,3) == $null) || ($did($dname,5) == $null) || ($did($dname,7) == $null) || ($did($dname,11) == $null) did -b $dname 13
  if ($did == 5) %mi.mail = $did($dname,5)
  if ($did($dname,18)) && ($did($dname,20)) did -e $dname 21
  if ($did($dname,18) == $null) || ($did($dname,20) == $null) did -b $dname 21
  if ($did($dname,25)) did -e $dname 26
  if ($did($dname,25) == $null) did -b $dname 26
}
on 1:sockopen:BaTmail: {
  if ($sockerr) {
    did -ra email 12 Error conectando con el servidor
    .sockclose $sockname
  }
  else {
    %tmp.BaTmail.tmp = 1
    did -ra email 12 Conectado! Enviando datos...
    sockwrite -nt $sockname HELO $ip
  }
}
on 1:sockread:BaTmail: {
  sockread %tmp.BaTmail
  if ($gettok(%tmp.BaTmail,1,32) == 250) {
    if (%tmp.BaTmail.tmp == 1) {
      sockwrite -nt $sockname mail from: $gettok($did(email,5),1,32)
      inc %tmp.BaTmail.tmp
      did -ra email 12 Enviando datos de remitente...
      return
    }
    elseif (%tmp.BaTmail.tmp == 2) {
      sockwrite -nt $sockname rcpt to: $did(email,7)
      inc %tmp.BaTmail.tmp
      did -ra email 12 Enviando datos de destino...
      return
    }
    elseif (%tmp.BaTmail.tmp == 3) {
      sockwrite -nt $sockname data
      did -ra email 12 Datos enviados... procediendo a mandar el contenido del email
      inc %tmp.BaTmail.tmp
      return
    }
    elseif (%tmp.BaTmail.tmp == 5) {
      sockwrite -nt $sockname QUIT
      did -ra email 12 El email ha sido enviado correctamente
      .sockclose $sockname
      return
    }
  }
  elseif ($gettok(%tmp.BaTmail,1,32) == 354) {
    did -ra email 12 Mandando email...
    sockwrite -nt $sockname From: $gettok($did(email,5),1,32)
    sockwrite -nt $sockname To: $did(email,7)
    sockwrite -nt $sockname Subject: $did(email,9)
    var %i 1
    while (%i <= $did(email,11).lines) {
      if ($did(email,11,%i) != .) sockwrite -nt $sockname $did(email,11,%i)
      inc %i
    }
    sockwrite -nt $sockname .
    inc %tmp.BaTmail.tmp
  }
  elseif ($gettok(%tmp.BaTmail,1,32) > 499) { 
    did -ra email 12 Error: %tmp.BaTmail
    .sockclose $sockname
  }
}

;*************************************
; Envío de SMS
;
;*************************************

alias batsms makedialog -md batsms
dialog BaTsms {
  title ""
  size -1 -1 150 150
  option dbu
  icon icons\phone.ico
  menu "&Archivo",1
  item "&Ir a la Agenda",7
  item break,8
  item "&Servidores SMTP",9
  item break,10
  item "&Cerrar BaT SMS",11, ok
  menu "&Ayuda",12
  item "&Abrir la ayuda",13
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
on 1:dialog:BaTsms:*:*: {
  if ($devent == init) {
    _mdx.buttons_style 27 28 30 39 40 45 46

    unset %BaTsms.tmp
    .timerBaTsms -m 0 10 BaTsms_timer
    mkdir dat
    mkdir dat\sms
    if ($findfile(dat\sms,agenda.dat,1) == $null) write -c dat\sms\agenda.dat
    if ($findfile(dat\sms,servers.dat,1) == $null) write -c dat\sms\servers.dat
    if ($findfile(dat\sms,config.dat,1) == $null) writeini dat\sms\config.dat conf email tu@email
    BaTsms_loadlists
    did -a $dname 23 %BaTsms.mimail
  }
  if ($devent == edit) && ($did == 26) BaTsmscuerposms
  if ($did == 7) did -f $dname 33
  if ($did == 9) did -f $dname 41
  if ($did == 2) did -f $dname 19
  %BaTsms.mimail = $did($dname,23)
  if ($did == 13) run dat\sms\batayuda.txt 
  if ($did == 16) run $_web
  if ($did == 18) about
  if ($did == 27) BaTsmssend
  if ($did == 28) BaTsmsstop
  if ($did == 30) {
    if ($did($dname,30) == <-) { dialog -s BaTsms -1 -1 300 300 | did -ra $dname 30 -> }
    else { dialog -s BaTsms -1 -1 555 300 | did -ra $dname 30 <- }
  }
  if ($did == 39) {
    write dat\sms\agenda.dat $did($dname,37) $+ $chr(5) $+ $did($dname,35)
    did -r $dname 35,37
    BaTsms_loadlists
  } 
  if ($did == 40) {
    write $+(-dl,$did($dname,38).sel) dat\sms\agenda.dat
    BaTsms_loadlists
  }
  if ($did == 45) {
    write dat\sms\servers.dat $did($dname,43)
    did -r $dname 43
    BaTsms_loadlists
  }  
  if ($did == 46) {
    write -dl $+ $did($dname,44).sel dat\sms\servers.dat 
    BaTsms_loadlists
  }
  BaTsms_checkBaT
  dialog -t $dname BaT SMS - $BaTsmscomp($did($dname,25))
}
alias BaTsms_checkBaT {
  if ($did($dname,21)) && ($did($dname,23)) && ($BaTsmsvalnum($gettok($did($dname,25),1,32))) && ($len($BaTsmscuerposms) <= 135) && ($len($BaTsmscuerposms)) && ($sock(BaTsms,1) == $null) did -e $dname 27
  if ($did($dname,21) == $null) || ($did($dname,23) == $null) || ($BaTsmsvalnum($gettok($did($dname,25),1,32)) == $null) || ($len($BaTsmscuerposms) > 135) || ($len($BaTsmscuerposms) == 0) did -b $dname 27
  if ($sock(BaTsms,1)) {
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
alias BaTsms_loadlists {
  var %i, var %x
  %i = 1
  if ($findfile(dat\sms,agenda.dat,1) == $null) write -c dat\sms\agenda.dat
  %x = $read -l1 $findfile(dat\sms,agenda.dat,1)
  did -r $dname 25,38
  while (%x) {
    did -a $dname 25 $gettok(%x,1,5) ( $+ $gettok(%x,2,5) $+ )
    did -a $dname 38 $gettok(%x,1,5) ( $+ $gettok(%x,2,5) $+ )
    inc %i
    %x = $read -l %i $findfile(dat\sms,agenda.dat,1)
  }
  %i = 1
  if ($findfile(dat\sms,servers.dat,1) == $null) write -c dat\sms\servers.dat
  %x = $read -l1 $findfile(dat\sms,servers.dat,1)
  did -r $dname 21,44
  while (%x) {
    did -a $dname 21 %x
    did -a $dname 44 %x
    inc %i
    %x = $read -l %i $findfile(dat\sms,servers.dat,1)
  }
  did -c $dname 21 1
  unset %x %i
}
alias BaTsmscomp { 
  if ($1 == $null) || ($len($1) < 3)  return por Jimmy_RAY
  if ($istok(060.609.616.620.686.650.619.626.629.630.636.639.646.649.659.669.676.679.696.699.689.608,$left($1,3),46)) return Movistar
  elseif ($istok(651.652.653.654.655.656.657.658,$left($1,3),46)) return Amena
  else return Desconocido
}
alias BaTsmsmailcomp {
  if ($BaTsmscomp($1) == Movistar) return $1 $+ @ $+ correo.movistar.net
  if ($BaTsmscomp($1) == Amena) return $1 $+ @ $+ amena.com
}
alias BaTsmsvalnum { if ($1 isnum) && ($len($1) == 9) && ($BaTsmscomp($1) != Desconocido) return $true }
alias BaTsmscuerposms {
  unset %x
  %i = 1
  while (%i <= $did(BaTsms,26).lines) {
    %x = %x $did(BaTsms,26,%i)
    inc %i
  }
  did -ra BaTsms 29 $len(%x) $+ / $+ 135
  return %x
}
;sockets
alias BaTsms_timer BaTsmsclose
alias BaTsmsclose {
  if ($dialog(BaTsms) == $null) {
    .sockclose BaTsms
    unset %BaTsms.tmp 
    .timerBaTsms off 
  } 
}

alias BaTsmssend {
  .sockclose BaTsms
  .sockopen BaTsms $did($dname,21) 25
  did -r $dname 32
  BaTsmsdebug -> Conectando con $did($dname,21) $+ ...

}
alias BaTsmsdebug { if ($dialog(BaTsms)) did -o BaTsms 32 $did(BaTsms,32).lines $$1 $2- }
on 1:sockopen:BaTsms: {
  if ($sockerr) {
    BaTsmsdebug <- Error conectando con el servidor
    BaTsmsfin
    $_ok(Error en la conexión con el servidor)
    return
  }
  %BaTsms.tmp = 1
  BaTsmsdebug :: Conectado! Enviando datos...
  sockwrite -nt $sockname HELO $ip
}
on 1:sockread:BaTsms: {
  sockread %BaTsms
  if ($gettok(%BaTsms,1,32) == 250) {
    if (%BaTsms.tmp == 1) {
      sockwrite -nt $sockname mail from: $gettok(%BaTsms.mimail,1,32)
      inc %BaTsms.tmp
      BaTsmsdebug :: Enviando datos de remitente...
      return
    }
    elseif (%BaTsms.tmp == 2) {
      sockwrite -nt $sockname rcpt to: $BaTsmsmailcomp($gettok($did(BaTsms,25),1,32))
      inc %BaTsms.tmp
      BaTsmsdebug :: Enviando datos de destino...
      return
    }
    elseif (%BaTsms.tmp == 3) {
      sockwrite -nt $sockname data
      BaTsmsdebug :: Datos enviados... procediendo a mandar el contenido del SmS
      inc %BaTsms.tmp
      return
    }
    elseif (%BaTsms.tmp == 5) {
      sockwrite -nt $sockname QUIT
      BaTsmsdebug [!] El SmS ha sido enviado al servidor correctamente :)
      $_ok(El SmS ha sido enviado al servidor correctamente)
      BaTsmsfin
      return
    }
  }
  elseif ($gettok(%BaTsms,1,32) == 354) {
    BaTsmsdebug :: Mandando sms...
    sockwrite -nt $sockname From: $gettok($did(BaTsms,32),1,32)
    sockwrite -nt $sockname To: $BaTsmsmailcomp($gettok($did(BaTsms,25),1,32))
    sockwrite -nt $sockname Subject: 
    %i = 1
    while (%i <= $did(BaTsms,26).lines) {
      if ($did(BaTsms,26,%i) != .) sockwrite -nt $sockname $did(BaTsms,26,%i)
      inc %i
    }
    sockwrite -nt $sockname .
    inc %BaTsms.tmp
  }
  elseif ($gettok(%BaTsms,1,32) > 499) { 
    BaTsmsdebug :: [!] Error: %BaTsms
    $_ok(Error: %BaTsms)
    BaTsmsfin
  }
}
alias BaTsmsfin {
  did -b BaTsms 28
  .sockclose BaTsms
  did -ra BaTsms 27 Enviar
  did -e BaTsms 21,23,25,26,27
}
alias BaTsmsstop {
  did -b $dname $did
  .sockclose BaTsms
  did -ra $dname 27 Enviar
  did -e $dname 21,23,25,26,27
  $_ok(Error, el envío de SmS ha sido cancelado)

  BaTsmsdebug [!] Error, el envío del Sms ha sido cancelado.
}

;*************************************
; Cliente Telnet (multiconexión)
;
;************************************* 
alias tln telnet $_r(Introduce la ip) $_r(Introduce el puerto (por defecto el 23))
alias telnet {
  if ($2) && ($1) {
    inc %tln
    window  -ke @Telnet: [ $+ [ %tln ] ] 
    .sockclose telnet. [ $+ [ %tln ] ]
    .sockopen telnet. [ $+ [ %tln ] ] $1 $2 
    echo $colour(info) -t @Telnet: [ $+ [ %tln ] ] ***  Conectando con $1 ( $+ $2 $+ )
  }
  else echo $colour(highlight) -a *** Error: Usa "/Telnet ip puerto" para conectar
}
alias tln.id return $gettok($sockname,2,$asc(.))

on 1:sockopen:telnet.*: {
  if ($sockerr > 1) { 
    echo $colour(info) -t @Telnet: [ $+ [ $tln.id ] ] *** Error al conectar
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
  echo 1 -t @Telnet: [ $+ [ $tln.id ] ] %sockread.tmp
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
      echo 14 -t $target -> $1-
      halt 
    }
    else {
      echo $colour(highlight) -t $target *** Error: No estás conectado
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
    else echo $colour(highlight) -t @telnet: [ $+ [ $gettok($active,2,$asc(:)) ] ] *** Error: No estas conectado a ningún servidor. 
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


;*************************************
; Flood Bots
;
;*************************************

alias floodbots {
  if ($findfile($mircdir,fbsrv.dat,1) == $null) write -c $fb.servers.dat
  if ($dialog(fb)) dialog -v fb
  else  dialog -dm fb fb
  .timerfbon 0 1 fb.ifon
}
alias fb.ifon { if ($dialog(fb) == $null) { .timerfbon off | .sockclose fb.* | unset %fb.*  } }
dialog fb {
  title "Flood Bots"
  size -1 -1 365 220
  option dbu
  icon icons\floodbots.ico
  box "Conectar",1,5 5 200 50
  text "Servidor:",2,10 20 21 10
  combo 3,35 18 80 50,drop,edit
  text "Puerto:",4,120 20 20 10
  edit "6667",5,145 18 30 10,autohs
  button "&Editar",6,180 18 20 10
  button "&Conectar!",7,35 35 80 15,default
  button "&Desconectar todos",8,145 35 55 15
  box "Comandos",9,5 55 200 140
  box "Entradas y Salidas",10,10 65 190 25
  button "&Entrar",11,15 73 30 10
  button "&Salir",12,50 73 30 10
  text "Canal:",13,110 75 20 10
  edit "",14,130 73 65 10,autohs
  box "Ctcps",15,10 90 190 25
  button "&Mandar",16,15 98 30 10
  combo 17,50 98 50 50,drop
  text "Objetivo:",18,105 100 21 10
  edit "",19,130 98 65 10,autohs
  box "Mensajes",20,10 115 190 25
  button "&Mandar",21,15 123 30 10
  edit "",22,50 123 50 10,autohs
  text "Objetivo:",23,105 125 21 10
  edit "",24,130 123 65 10,autohs
  box "Otro comando",25,10 140 190 25
  button "&Mandar",26,15 148 30 10
  edit "",27,50 148 145 10
  box "NiCKs",28,10 165 190 25
  button "&Mandar",29,15 173 30 10
  radio "Lemmings",30,70 175 35 10
  radio "Aleatorio",31,115 175 35 10
  box "Información",33,210 5 150 50
  text "Clones conectados:",34,215 20 50 10
  edit "",35,270 18 30 10,read,right
  text "Puertos abiertos:",36,215 40 50 10
  edit "",37,270 38 30 10,read,right
  box "Debug",38,210 55 150 140,
  edit "",39,215 65 140 105,read,multi,vsbar
  button "&Limpiar log",40,310 173 35 15
  button "&Cerrar",41,330 200 30 15,cancel
}
on 1:dialog:fb:init:*: {
  set -u %i 1
  while ($fb.servers(%i)) {
    did -a fb 3 $fb.servers(%i)
  inc %i }
  did -c fb 3 1 | did -a fb 17 VERSION | did -a fb 17 PING | did -a fb 17 TIME | did -a fb 17 FINGER | did -a fb 17 USERINFO | did -a fb 17 CLIENTINFO | did -c fb 17 1 |did -c fb 30 
  %fb.sockopen = 0
  %fb.sockclon = 0
  %fb.sockcont = 0
  fb.date | .timer -m 1 1 fb.butcon | .sockclose fb.* 
  if (%fb.nick == $null) { set %fb.nick 30 }
  did -c fb %fb.nick
}
on 1:dialog:fb:sclick:*: {
  ;Botones de comandos:
  if ($did == 11) { sw fb.* JOIN $did(fb,14) | fb.wlog *** Entrando en $did(fb,14) }
  if ($did == 12) { sw fb.* PART $did(fb,14) | fb.wlog *** Saliendo de $did(fb,14) }
  if ($did == 16) { sw fb.* PRIVMSG $did(fb,19) : $+ $did(fb,17,$did(fb,17).sel).text $+   | fb.wlog *** Flood CTCP $did(fb,17,$did(fb,17).sel).text a $did(fb,19) } 
  if ($did == 21) { sw fb.* PRIVMSG $did(fb,24) : $+ $did(fb,22) | fb.wlog *** Mensaje a $did(fb,24) } 
  if ($did == 26) { sw fb.* $did(fb,27) | fb.wlog *** Otro comando }
  ;Resto
  if ($did == 6) run $fb.servers.dat
  if ($did == 40) did -r fb 39
  if ($did == 8) {
    set -u %i 0
    :loop
    if (%i <= %fb.sockcont) {
      sw fb. $+ %i QUIT : $+ 2BaT: BrAvOs AsSaULt TeaM
    inc %i | goto loop } 
    .sockclose fb.* | fb.wlog *** Clones desconectados | fb.date | fb.butcon
    %fb.sockopen = 0
    %fb.sockclon = 0
    %fb.sockcont = 0
    fb.date  
  }
  if ($did == 29) { set -u %i 0 | :looptwo 
    if (%i <= %fb.sockcont) {
  sw fb. $+ %i NICK $fb.nickclon | inc %i | goto looptwo } }
  if ($did == 30) set %fb.nick $did
  if ($did == 31) set %fb.nick $did
  fb.butcon
  if  ($did == 7) { fb.conclon | did -b fb 7 | .timerfb.1 -m 1 700 did -e fb 7 } 
}
on 1:dialog:fb:edit:*: { .timer -m 1 1 fb.butcon | .timer -m 1 1 fb.date }
;Alias
alias sw { if ($sock($1)) { sockwrite -nt $1- } }
alias fb.date { did -ra fb 35 %fb.sockclon | did -ra fb 37 %fb.sockopen
  if (%fb.sockclon == 0) did -b fb 8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29
  if (%fb.sockclon != 0) {
    did -e fb 8,9,10,13,14,15,17,18,19,20,22,23,24,25,27,28,29
    did $iif($did(fb,14),-e,-b) fb 11
    did $iif($did(fb,14),-e,-b) fb 12
    did $iif($did(fb,19),-e,-b) fb 16
    if ($did(fb,22)) && ($did(fb,24))  did -e fb 21
    if ($did(fb,22) == $null) || ($did(fb,24) == $null) did -b fb 21
    did $iif($did(fb,27),-e,-b) fb 26
    did $iif($did(fb,19),-e,-b) fb 16
    did $iif($did(fb,19),-e,-b) fb 16
    did $iif($did(fb,19),-e,-b) fb 16
} }
alias fb.butcon {
  if ($did(fb,3)) && ($did(fb,5)) did -e fb 7
  if ($did(fb,3) == $null) || ($did(fb,5) == $null) did -b fb 7
}
;Identificadores:
alias fb.wlog did -i fb 39 1 $1-
alias fb.servers return $read -l $1 dat\fbsrv.dat
alias fb.servers.dat return dat\fbsrv.dat
alias fb.nickclon {
  if (%fb.nick == 30) return lemming $+ $rand(0,99999) 
  else return $rand(A,Z) $+ $rand(a,z) $+ $rand(A,Z) $+ $rand(a,z) $+ $rand(A,Z) $+ $rand(a,z)
}
alias fb.conclon {
  inc %fb.sockcont
  inc %fb.sockopen
  fb.date
  fb.wlog -> Lanzando un clon a $did(fb,3) ( $+ $did(fb,5) $+ )
  sockopen fb. $+ %fb.sockcont $did(fb,3) $did(fb,5)
}
on 1:sockopen:fb.*: {
  if ($sockerr > 1) {
    dec %fb.sockopen
    .sockclose $sockname
    fb.date
    fb.wlog <- Error en la conexión con el servidor.
  }
  else {
    inc %fb.sockclon
    sw $sockname NICK $fb.nickclon
    sw $sockname USER $rand(a,z) $rand(a,z) $rand(a,z) $rand(a,z)
    fb.date
    fb.wlog -> Conexión aceptada por parte de $sock($sockname,1).ip
} }
on 1:sockclose:fb.*: {
  dec %fb.sockopen
  dec %fb.sockclon
  fb.date
  fb.wlog <- Un clon desconectado de $sock($sockname,1).ip
}
on 1:sockread:fb.*: { 
  :nextread
  sockread %sockread.tmp
  if ($sockbr == 0) return
  if (%sockread.tmp == $null) %sockread.tmp = -
  if ($left(%sockread.tmp,1) == :) && ($gettok(%sockread.tmp,2,32) == 001) sw $sockname USERHOST $gettok(%sockread.tmp, 3,32)
  if ($left(%sockread.tmp,1) == :) && ($gettok(%sockread.tmp,2,32) == 433) sw $sockname NICK $fb.nickclon $+ $rand(0,9)
  if ($left(%sockread.tmp,1) == :) && ($gettok(%sockread.tmp,2,32) == 432) sw $sockname NICK $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(0,9)
  if ($gettok(%sockread.tmp,1,32) == PING)  { sw $sockname PONG $gettok(%sockread.tmp,2,32) | sw $sockname silence *!*@* }
  goto nextread
}
