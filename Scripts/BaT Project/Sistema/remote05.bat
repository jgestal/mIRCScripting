;####################################;
;                                    ;
; BaT proyect by Fulg0re & Jimmy_RAY ;
;                                    ;
;     http://bat-proyect.da.ru       ;
;                                    ;
;                                    ;
;####################################;

alias ignora { set %tmp.ign $1 | if ($show) dialog -m ign ign | else .ignore $1- }
dialog ign {
  title "BaT: Lista de Ignore"
  size -1 -1 195 115
  option dbu
  text "", 1, 5 5 165 10, center
  combo 3, 10 15 115 75, drop edit 
  check "Msgs", 5, 30 30 25 10
  check "Notices", 6, 30 40 35 10
  check "Ctcps", 7, 30 50 30 10
  check "Invites", 8, 80 30 25 10
  check "Codigos", 9, 80 40 40 10
  check "Canal", 10, 80 50 30 10
  check "Borrar despues de:", 12, 15 75 55 10
  combo 13, 75 74 50 40, drop disable
  list 21, 130 15 55 70, hsbar extsel
  button "Borrar", 22, 132 80 25 10, ok disable
  button "Limpiar", 23, 157 80 25 10, ok disable
  box "", 25, -10 90 300 300
  button "Cancelar", 249, 120 98 70 13, cancel
  button "Ignorar", 250, 5 98 70 13, ok 
}

on *:dialog:ign:init:*: { 
  did -a ign 1 Ignorando a %tmp.ign $+ . Escoge máscara:
  if ($ignore(1)) { did -e ign 23 | %i = 1 | while ($ignore(%i)) { did -a ign 21 $ignore(%i) | inc %i } } 
  did -a ign 13 1 hora | did -a ign 13 30 min | did -a ign 13 15 min | did -a ign 13 5 min | did -c ign 13 1
  %i = 1 | did -a ign 3 %tmp.ign $+ !*@* | while ($address(%tmp.ign,%i)) { if (%i >= 9) { did -a ign 3 $address(%tmp.ign,%i) | break } | did -a ign 3 $address(%tmp.ign,%i) | inc %i } | did -c ign 3 1
}
on *:dialog:ign:edit:3: { if ($did(ign,3)) { did -e ign 250 } | else did -b ign 250 }
on *:dialog:ign:sclick:*:{
  if ($did == 21) { did -e ign 22 }
  if ($did == 12) { if ($did(12).state == 1) { did -e ign 13 } | else { did -b ign 13 } }
  if ($did == 22) { display delign $did(ign,21,$did(ign,21).sel).text | .ignore -r $did(ign,21,$did(ign,21).sel).text | did -r ign 21 | if ($ignore(1)) { did -e ign 23 | %i = 1 | while ($ignore(%i)) { did -a ign 21 $ignore(%i) | inc %i } } }
  if ($did == 23) { did -b ign 23 | did -r ign 21 | while ($ignore(1)) { display delign $ignore(1) | .ignore -r $ignore(1) } | did -a ign 21 ------ Lista Vacia ------ } 
  if ($did == 250) {
    if ($did(12).state == 1) { if ($did(13).sel == 1) set %ignor.t 3600 | elseif ($did(13).sel == 2) set %ignor.t 1800 | elseif ($did(13).sel == 3) set %ignor.t 900 | elseif ($did(13).sel == 4) set %ignor.t 300 } 
    set %isn por: | if ($did(ign,5).state == 1) %isn = %isn privados | if ($did(ign,10).state == 1) %isn = %isn canal | if ($did(ign,6).state == 1) %isn = %isn notices | if ($did(ign,7).state == 1) %isn = %isn ctcps | if ($did(ign,8).state == 1) %isn = %isn invites | if ($did(ign,9).state == 1) %is = %isn codes | if (%ignor.t) %isn = %isn durante $duration(%ignor.t) 
    %is = - | if ($did(ign,5).state == 1) %is = %is $+ p | if ($did(ign,10).state == 1) %is = %is $+ c | if ($did(ign,6).state == 1) %is = %is $+ n | if ($did(ign,7).state == 1) %is = %is $+ t | if ($did(ign,8).state == 1) %is = %is $+ i | if ($did(ign,9).state == 1) %is = %is $+ k | %is = %is $+ u $+ %ignor.t  | .ignore %is $did(ign,3) 
    if ($ignore(1)) { did -e ign 23 | %i = 1 | while ($ignore(%i)) { did -a ign 21 $ignore(%i) | inc %i } } 
    display ign $did(ign,3) %isn
    unset %i %is %isn %tmp.ign
  }
}
alias unignora {
  unset %ignor.* 
  if ($address($1,5)) set %ignore.mascara $address($1,5) | else { display ignerror | halt } 
  set %ignor.i 1 | :1 | set %ignor.tmp $ignore(%ignor.i) | if (%ignor.tmp) { if (%ignor.tmp iswm %ignore.mascara) { .ignore -r %ignor.tmp | set %ignor.did on } | inc %ignor.i | goto 1 } 
  if (%ignor.did) display delign $1 | else display noign $1 | unset %ignor.*
}
; Lista de ignorados:
alias iglist dialog -m il il
;
dialog il {
  title "BaT: lista de ignorados"
  size -1 -1 150 110
  option dbu
  list 1, 5 5 140 80
  button "Borrar", 2, 5 80 70 10, ok disable
  button "Limpiar", 3, 75 80 70 10, ok disable
  box "", 4, -10 -10 200 105
  button "Aceptar", 250, 5 97 140 12, ok
}
on *:dialog:il:init:*: { if ($ignore(1)) { did -e il 3 | %i = 1 | while ($ignore(%i)) { did -a il 1 $ignore(%i) | inc %i } }  }
on *:dialog:il:sclick:*: {
  if ($did == 1) did -e il 2
  if ($did == 2) { display delign $did(il,1,$did(il,1).sel).text | .ignore -r $did(il,1,$did(il,1).sel).text | did -r il 1 | if ($ignore(1)) { did -e il 3 | %i = 1 | while ($ignore(%i)) { did -a il 1 $ignore(%i) | inc %i } } }
  if ($did == 3) { did -b il 3 | did -r il 1 | while ($ignore(1)) { display delign $ignore(1) | .ignore -r $ignore(1) } } 
}
;~~~~~~~~~~~~~~~~~~~~
;Port Scaner 
;/psc
;~~~~~~~~~~~~~~~~~~~~
alias psc {
  if ($dialog(psc)) dialog -v psc psc
  else dialog -md psc psc
}
dialog psc {
  title "BaT: Port Scaner [/psc]" 
  size -1 -1 460 390
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
  button "Cerrar",20,370 355 80 25,ok
}
on 1:dialog:psc:init:*: {
  dll $mdx SetMircVersion $version 
  dll $mdx MarkDialog $dname 
  dll $mdx SetControlMDX $dname 18 listview rowselect grid showsel single flatsb labeltip headerdrag report > $views 
  did -i $dname 18 1 header @130,90,210 0 Host/ip $chr(9) Puerto $chr(9) Descripción
  if (%puerto.inicio == $null) %puerto.inicio = 1
  pscdid -ra psc 5 %puerto.inicio
  if (%puerto.final == $null) %puerto.final = 65535
  pscdid -ra psc 7 %puerto.final
  if (%retraso.ms == $null) %retraso.ms = 30
  pscdid -ra psc 10 %retraso.ms
  if (%max.sock == $null) %max.sock = 100
  pscdid -ra psc 12 %max.sock
  set %psccnt 0
  set %sockets.abiertos 0
  unset  %psc.halt

  if ($did(psc,2)) && ($did(psc,5)) && ($did(psc,7)) && ($did(psc,10)) && ($did(psc,12)) pscdid -e psc 3
  if ($did(psc,2) == $null) || ($did(psc,5) == $null) || ($did(psc,7) == $null) || ($did(psc,10) == $null) || ($did(psc,12) == $null) pscdid -b psc 3
  pscinforma
}
on 1:dialog:psc:edit:*: {
  %puerto.inicio = $did(psc,5)
  %puerto.final = $did(psc,7)
  %retraso.ms = $did(psc,10)
  %max.sock = $did(psc,12)

  if ($did(psc,2)) && ($did(psc,5)) && ($did(psc,7)) && ($did(psc,10)) && ($did(psc,12)) && (%puerto.inicio < %puerto.final) pscdid -e psc 3
  if ($did(psc,2) == $null) || ($did(psc,5) == $null) || ($did(psc,7) == $null) || ($did(psc,10) == $null) || ($did(psc,12) == $null) || (%puerto.inicio >= %puerto.final) pscdid -b psc 3
  pscinforma
}
on 1:dialog:psc:sclick:*: {
  if ($did == 3) {
    pscdid -b psc 1,2,3,4,5,6,7,9,10,11,12
    pscdid -e psc 8,13
    dialog -t $dname Portscan 2.0 Escaneando $did(psc,2) $+ ...
    if (%psc.halt != on) %psccnt = %puerto.inicio
    unset %psc.halt
    .timerpsc -m 0 %retraso.ms pscstartscan
  }
  if ($did == 8) {
    pscdid -b psc 8
    set %psc.halt on
    .timerpsc off
    pscdid -e psc 3
    dialog -t $dname Portscan 2.0 El scan de puertos ha sido pausado.

  }
  if ($did == 13) {
    pscdid -e psc 1,2,3,4,5,6,7,9,10,11,12
    pscdid -b psc 8,13
    unset %psc.halt
    dialog -t $dname Portscan 2.0 El scan de puertos ha sido detenido.
    .timerpsc off
    .sockclose psc.*
    %sockets.abiertos = 0
    %psccnt = 0
  }
  if ($did == 19) pscdid -r psc 18
  pscinforma
}
alias pscinforma {
  pscdid -ra psc 15 %psccnt
  pscdid -ra psc 17 %sockets.abiertos 
}
alias psclog pscdid -a psc 18 1 $1-
alias pscdid if ($dialog(psc)) did $1-
alias pscstartscan {
  if ($dialog(psc) == $null) { .timerpsc off | sockclose psc.* }
  if (%sockets.abiertos <= %max.sock) {
    inc %psccnt  
    if ($dialog(psc)) .sockopen psc. [ $+ [ %psccnt ] ] $did(psc,2) %psccnt
    inc %sockets.abiertos
  }
  if (%psccnt >= %puerto.final) { .timerpsc off | pscdid -b psc 8,13 }
  pscinforma
}
on 1:sockopen:psc.*: {
  if ($sockerr <= 0) { psclog $sock($sockname,1).ip $chr(9) $gettok($sockname,2,46) $chr(9) $pscname($gettok($sockname,2,46)) }
  .sockclose $sockname
  dec %sockets.abiertos

  if (%sockets.abiertos == 0) && (%psc.halt != on) {

    dialog -t $dname Portscan 2.0 Fin del scan de puertos.
    pscdid -b psc 8,13
    pscdid -e psc 1,2,3,4,5,6,7,9,10,11,12
    .timerpsc off
    %psccnt = 0
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
;~~~~~~~~~~~~~~~~~~~~
;Flood Bots
;/floodbots
;~~~~~~~~~~~~~~~~~~~~
alias floodbots {
  if ($findfile($mircdir,fbsrv.dat,1) == $null) write -c $fb.servers.dat
  if ($dialog(fb)) dialog -v fb
  else  dialog -dm fb fb
  .timerfbon 0 1 fb.ifon
}
alias fb.ifon { if ($dialog(fb) == $null) { .timerfbon off | .sockclose fb.* } }
dialog fb {
  title "BaT: FloodBots [/floodbots]"
  size -1 -1 365 220
  option dbu
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
;Eventos de diálogos
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
alias fb.servers.dat return fbsrv.dat
alias fb.nickclon {
  if (%fb.nick == 30) return lemming $+ $rand(0,99) 
  else return $rand(A,Z) $+ $rand(a,z) $+ $rand(A,Z) $+ $rand(a,z) $+ $rand(A,Z) $+ $rand(a,z)
}
;--------------------------
;Conectando...
;--------------------------
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
;~~~~~~~~~~~~~~~~~~~~
;Snake
;/snake_init
;~~~~~~~~~~~~~~~~~~~~
alias snake_init {
  window -pkrtoa +betl @snake 50 50 200 250
  titlebar @snake por Jimmy_RAY
  ;  snk.intro
  snk.present

}
alias snk.intro {
  drawfill -s @snake 1 0 1 1
  drawtext -bc @snake 0 1 "terminal" 50 5 5 290 50 Snake
  drawtext -bc @snake 11 1 "terminal" 20 10 70 290 50  - ! - ! ! ! - ! -
  drawtext -bc @snake 11 1 "terminal" 14 10 100 290 50 Opciones con el boton derecho
  drawtext -bc @snake 11 1 "terminal" 14 10 130 290 50 BravoS AssAulT TeaM (c)
}

alias snk.present {
  clear @snake 
  ;Colorea el fondo de negro
  drawfill -s @snake 10 0 1 1

  ;Tablero
  snk.tablero
  ;Marcador
  snk.scores 0000
  snk.pfr
}
alias snk.cas return 7
alias snk.scores { 
  drawtext -bc @snake 10 10 "terminal" 14 5 5 290 25 $str($chr(160),100)
  drawtext -bc @snake 1 10 "terminal" 14 10 5 290 25 $$1-  
}
alias snk.tablero {
  drawrect -f @snake 1 1 10 20 $calc($calc($snk.cas * 22)+14) $snk.cas
  drawrect -f @snake 1 1 15 30 $calc(($snk.cas * 22)+5) $snk.cas
  drawrect -f @snake 1 1 15 $calc(($snk.cas *11)+37) $calc(($snk.cas * 22)+5) $snk.cas
  drawrect -f @snake 1 1 10 30 $snk.cas $calc(($snk.cas * 12)+7)
  drawrect -f @snake 1 1 $calc(($snk.cas *22)+17) 30 $snk.cas $calc(($snk.cas * 12)+7)
}

alias snk.c { drawrect -f @snake $$1 1 $calc(10+($snk.cas * $$2)) $calc(30+($snk.cas * $$3)) $snk.cas $snk.cas }
alias snk.pfr {
  %i = 1
  while ($gettok(%snk.serp,%i,59)) {
    snk.c 0 $gettok($gettok(%snk.serp,%i,59),1,46) $gettok($gettok(%snk.serp,%i,59),2,46)
    inc %i
  }
}
alias snk.process {
  ;Control de direcciones que puede adoptar la serpiente
  set -u %tmp.var $gettok($gettok(%snk.serp,1,59),1,46) $+ . $+ $gettok($gettok(%snk.serp,1,59),2,46)
  if (%tmp.var == %snk.apple) {
    snk.eatapple
    %snk.points = $calc(%snk.points +9)
    snk.scores %snk.points 
  }
  if ($snk.freecas2(%tmp.var) == $true) {
    snk.gameover
  }
  if (%snk.dir = up) {
    if ($gettok($gettok(%snk.serp,1,59),2,46) == 1) snk.gameover
    else {
      %snk.serp = $gettok($gettok(%snk.serp,1,59),1,46) $+ . $+ $calc($gettok($gettok(%snk.serp,1,59),2,46)-1) $+ ; $+ %snk.serp 
      goto default
    }
  }
  if (%snk.dir = down) {
    if ($gettok($gettok(%snk.serp,1,59),2,46) == 11) snk.gameover
    else {
      %snk.serp = $gettok($gettok(%snk.serp,1,59),1,46) $+ . $+ $calc($gettok($gettok(%snk.serp,1,59),2,46)+1) $+ ; $+ %snk.serp 
      goto default
    }
  }
  if (%snk.dir = left) {
    if ($gettok($gettok(%snk.serp,1,59),1,46) == 1) snk.gameover
    else {
      %snk.serp = $calc($gettok($gettok(%snk.serp,1,59),1,46)-1) $+ . $+ $gettok($gettok(%snk.serp,1,59),2,46) $+ ; $+ %snk.serp 
      goto default
    }
  }
  if (%snk.dir = right) {
    if ($gettok($gettok(%snk.serp,1,59),1,46) == 22) snk.gameover
    else {
      %snk.serp = $calc($gettok($gettok(%snk.serp,1,59),1,46)+1) $+ . $+ $gettok($gettok(%snk.serp,1,59),2,46) $+ ; $+ %snk.serp 
      goto default    
    }
  }
  return
  :default
  snk.br
  snk.pfr
}
alias snk.gameover {
  .timersnk off
  display informa -a Has perdio chabal
}
;Borra el rastro dejado por la serpiente
alias snk.br { 
  set -u %tmp.var $gettok($gettok(%snk.serp,$calc($pos(%snk.serp,;,0) +1),$asc(;)),1,46) $+ . $+ $gettok($gettok(%snk.serp,$calc($pos(%snk.serp,;,0) +1),$asc(;)),2,46) 
  if (%snk.eated != on) {
    snk.c 10 $gettok($gettok(%snk.serp,$calc($pos(%snk.serp,;,0) +1),$asc(;)),1,46) $gettok($gettok(%snk.serp,$calc($pos(%snk.serp,;,0) +1),$asc(;)),2,46) 
    %snk.serp = $remtok(%snk.serp,$gettok(%snk.serp,$calc($pos(%snk.serp,;,0) +1),$asc(;)),1,59)
  }
  %snk.eated = off
}
on 1:KEYDOWN:@snake:*:{ 
  if ($keyval == 38) && (%snk.dir != down) %snk.dir = up
  if ($keyval == 40) && (%snk.dir != up) %snk.dir = down
  if ($keyval == 37) && (%snk.dir != right) %snk.dir = left
  if ($keyval == 39) && (%snk.dir != left) %snk.dir = right
  ;snk.process
}
alias snk.freecas {
  %i = 1
  while ($gettok(%snk.serp,%i,$asc(;))) {
    if ($gettok(%snk.serp,%i,$asc(;)) == $$1-) return $true
    inc %i
  }
  return $false
}
alias snk.freecas2 {
  %i = 2
  while ($gettok(%snk.serp,%i,$asc(;))) {
    if ($gettok(%snk.serp,%i,$asc(;)) == $$1-) return $true
    inc %i
  }
  return $false
}

alias snk.eatapple {
  :start
  set -u %tmp.var $rand(1,22) $+ . $+ $rand(1,11) 
  if ($snk.freecas(%tmp.var) == $true) goto start
  %snk.apple = %tmp.var
  %snk.eated = on 
  snk.c 4 $gettok(%snk.apple,1,$asc(.)) $gettok(%snk.apple,2,$asc(.))
}
alias sf2 { 
  snk.present
  %snk.serp = 5.5
  .timersnk -m 0 100 snk.process 
  snk.eatapple 
}
menu @snake {
  nueva partida: {
    snk.present
  }
}
;~~~~~~~~~~~~~~~~~~~~
;Auto Identify
;/ai
;~~~~~~~~~~~~~~~~~~~~
dialog ai2 {
  title "BaT: Auto Identify [/ai]"
  size -1 -1 140 150
  option dbu
  combo 1,5 5 130 50,drop,disable
  box "Lista de nicks",2,5 20 130 100
  button "Aceptar",100,1 1 1 1, ok hide
}


alias ai dialog -m ai ai
;
dialog ai {
  title "BaT: Auto Identify [/ai]"
  size -1 -1 140 100
  option dbu

  box "Lista de nicks", 1, 5 5 70 85
  list 2, 10 15 60 60
  button "Añadir", 3, 11 72 25 12, default
  button "Borrar", 4, 44 72 25 12, default

  text "Nick:", 5, 85 10 50 10, center
  edit "", 6, 85 20 50 10, center
  text "Pass:", 7, 85 35 50 10, center
  edit "", 8, 85 45 50 10, center pass
  text "Red:", 9, 85 60 50 10, center disable
  combo 10, 85 70 50 50, drop disable
  button "Aceptar", 100, 1 1 1 1, ok hide
}

on *:dialog:ai:init:*: danicks
on *:dialog:ai:sclick:*: {
  if ($did == 2) { did -ra ai 6 $read -l [ $+ [ $did(2).sel ] ] dat\ai.dat | did -ra ai 8 $dapass($did(6)) }
  if ($did == 3) { writeini dat\ai.ini ai $did(6) $did(8) | write dat\ai.dat $did(6) | did -a ai 2 $did(6) }
  if ($did == 4) { remini dat\ai.ini ai $did(6) | write -dl [ $+ [ $did(2).sel ] ] dat\ai.dat | actunicks }
}
alias actunicks { did -r ai 2 | danicks }
alias danicks {
  set %aict 1
  :init
  if ($read -l [ $+ [ %aict ] ] dat\ai.dat) { did -a ai 2 $read -l [ $+ [ %aict ] ] dat\ai.dat | inc %aict | goto init }
  else { unset %aict | halt }
}
alias dapass return $readini $mircdirdat\ai.ini ai $1

on bot:text:*:?: {
  if ($nick == NiCK) {
    if ((registrado y protegido isin $1-) || (Este nick pertenece a otra persona isin $1-)) { if ($dapass($me)) { display idnick $me | .msg nick@deep.space identify $dapass($me) } | else { display idnicknoconf $me } }
    elseif (contraseña aceptada isin $1-) { display idnickok $me }
    elseif (Contraseña incorrecta! isin $1-) { if ($dapass($me)) display idnickfail | else display idnickerr }
  }
}
