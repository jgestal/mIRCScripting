;####################################;
;                                    ;
; BaT proyect by Fulg0re & Jimmy_RAY ;
;                                    ;
;     http://bat-proyect.da.ru       ;
;                                    ;
;                                    ;
;####################################;

on ^*:START: {
  if (%nuevo) { unset %nuevo | set %servidor libres.irc-hispano.org | set %kicks 0 | set %nk.num 1 | set %nk On | set %clock On | set %timerlag.dismon On | .nick bat $+ $rand(1,999) }
  echo -s $ts $lgn BaT[v0.9b] by Jimmy_RAY & Fulg0re: $read dat\frases.txt
  echo -s $ts $lgn Theme: $th.nombre by $th.autor (v. $+ $th.version $+ )
  echo -s  | echo -s 
  Clock On
  echo -s $ts $lgn Pulsa F12 para conectar por %servidor
  unset %tln %fl_* %pp_*
  set %we 0 | set %timerlag.dismon On
}
on *:CONNECT:{
  set %time.conexion $ctime | set %servidor $server | set %red $gettok($server,2-3,46) | mlagon | set %we 0
  .timeridle 0 60 aw.compidle
  if (%aw) aw.desc 
}
alias logo {  
  window -c @logo
  window -phka +l @logo $window(-1).w 50 30 165 @logo
  drawpic -c @logo 0 0 sistema\im\bat.jpg
  window -a @logo
}


alias awmsg { set -u %i 1 | while ($chan(%i)) { if ($chan(%i) !isin $diaw(exentos)) { if ($me isop $chan(%i)) $brny(@,$chan(%i),$me,$1-) | elseif ($me isvo $chan(%i)) $brny(+,$chan(%i),$me,$1-) | else $brny(!,$chan(%i),$me,$1-) | .msg $chan(%i) $1- } | inc %i  } }
alias doptod { set -u %i 1 | while ($chan(%i)) { if (($1 isop $chan(%i)) && ($me isop $chan(%i))) { mode $chan(%i) -o $1 } | inc %i } }
alias aw.compidle { if ($server == $null) resetidle | if (($away == $false) && ($server) && ($diaw(idaway) == On) && ($idle >= $diaw(idawayc))) { bataway -i } }
alias wa.log { write logs\away.log  $+ $1 $+ $ts $2- }
alias diaw return $readini dat\conf.ini away $1
alias graw { 
  if ($2) writeini dat\conf.ini away $1 $2- 
  else remini dat\conf.ini away $1
}
alias aw.mm {
  inc %aw.anun 
  if (%aw.tipo == Idle) { set %aw.tiempo $calc(%aw.anun * $diaw(idmsgc)) }
  else { set %aw.tiempo $calc(%aw.anun * $diaw(msgc)) }
  if ($aw.theme) { $aw.theme }
  else { awmsg Away: $diaw(razon) [L: $+ $diaw(pager) P: $+ $diaw(loger) $+ ] [ $+ $duration(%aw.tiempo) $+ ] }
}
alias away { if ($away) { back } | else { dialog -m aw aw } }
alias bataway {
  if ($away) halt | set %aw 1
  if ($1 == -r) { display restaway | if ($diaw(unick) != No) { nick $diaw(unick) } | if (($diaw(msg) == Normal) || ($diaw(msg) == Primera)) { if ($chan(1)) { awmsg Away: $diaw(razon) [L: $+ $diaw(pager) P: $+ $diaw(loger) $+ ] } | if ($diaw(msg) == Normal) { .timerawmsg Off | .timerawmsg 0 $diaw(msgc) aw.mm } } }
  elseif ($1 == -i) { set %aw.tipo Idle | set %aw.inicio $ctime | display awidle | writeini dat\conf.ini away razon AutoAway (idle) | if ($diaw(idunick) != Off) { set %aw.an $me | nick $diaw(idunick) } | if (($diaw(idmsg) == Normal) || ($diaw(idmsg) == Primera)) { awmsg Away: $diaw(razon) [L: $+ $diaw(pager) P: $+ $diaw(loger) $+ ] | if ($diaw(idmsg) == Normal) { .timerawmsg Off | .timerawmsg 0 $diaw(idmsgc) aw.mm } } }
  else { set %aw.tipo Normal | set %aw.inicio $ctime | if ($diaw(unick) != No) { set %aw.an $me | nick $diaw(unick) } | if (($diaw(msg) == Normal) || ($diaw(msg) == Primera)) { awmsg Away: $diaw(razon) [l: $+ $diaw(pager) $+ ][ $+ p: $+ $diaw(loger) $+ ] BaT | if ($diaw(msg) == Normal) { .timerawmsg Off | .timerawmsg 0 $diaw(msgc) aw.mm } } }
  if ($diaw(loger) == On) { .enable #awev | wa.log 5 ------ ----- ---- --- -- - - (x) - - -- --- ---- ----- ------ | wa.log 2 · Comienzo de Sesión: $asctime | wa.log 2 · Razón del Away: $diaw(razon) | wa.log 5 ------ ----- ---- --- -- - - (x) - - -- --- ---- ----- ------ }
  if ($diaw(pager) == On) .enable #awpager
  if ($diaw(noflood) == si) set %aw.noflood 1
  if ($diaw(ulist) == si) set %aw.ulist 1
  if ($diaw(aget) == si) set %aw.aget 1
  if ($diaw(adeop) == si) doptod $me
  if ($diaw(minimice) != No) { if ($diaw(minimice) == On) showmirc -m | elseif ($diaw(minimice) == Tray) showmirc -t }
  .raw away : $+ $diaw(razon)
}
alias back {
  if ($away == $false) { halt } | .disable #awev | .disable #awpager | .timerawmsg off 
  if (%aw.an) { nick %aw.an | unset %aw.an }
  if (($diaw(msg) == Primera) || ($diaw(msg) == Normal)) if ($chan(1)) { awmsg Away Off: $diaw(razon) [durante... $duration($calc($ctime - %aw.inicio)) $+ ] }
  .raw away | unset %aw* | if ($diaw(loger) == On) { wa.log 5 ------ ----- ---- --- -- - - (x) - - -- --- ---- ----- ------ | wa.log 2 · Fin de Sesión: $asctime | wa.log 5 ------ ----- ---- --- -- - - (x) - - -- --- ---- ----- ------ }
  if ($diaw(msg) == No) display awsilencreg 
}
;--- -- - - Dialog rápido para poner away - - -- ---;
dialog aw {
  title "BaT: Ponerse Away... [/away]"
  size -1 -1 240 40
  option dbu
  combo 1, 10 5 220 50, edit, drop, tab 1
  button "Opciones", 248, 95 20 50 15, ok
  button "Cancelar", 249, 180 20 50 15, cancel 
  button "Away", 250, 10 20 50 15, ok default
}
on *:dialog:aw:init:*:{ if ($findfile($mircdir,away.dat,1) == $null) write -c dat\away.dat | set -u %i 1 | :inicio | set -u %tmp.var $read -l %i dat\away.dat | if (%tmp.var) { did -a aw 1 %tmp.var | inc %i | goto inicio } | did -c aw 1 $diaw(nrazon) }
on *:dialog:aw:sclick:*: {
  if ($did == 248) { dialog -x aw | dialog -m awcf awcf }
  if ($did == 250) {
    if ($did(1)) { 
      set -u %aw.razon $did(1).text | writeini dat\conf.ini away razon $did(1).text
      set -u %i 1 | :inicio | set -u %tmp.var $read -l %i $findfile($mircdir,away.dat,1)
      if (%tmp.var) { if (%aw.razon == %tmp.var) goto razonvieja | inc %i | goto inicio }
      write $findfile($mircdir,away.dat,1) %aw.razon | writeini dat\conf.ini away nrazon $lines($findfile($mircdir,away.dat,1))
      goto razonnueva
    }
    :razonvieja | writeini dat\conf.ini away nrazon $did(1).sel
    :razonnueva
    if (%aw.razon == $null) writeini dat\conf.ini away razon Sin Razón Aparente...
    if ($lines($findfile($mircdir,away.dat,1)) >= 11) { write -dl1 $findfile($mircdir,away.dat,1) | set -u %tempawvar $diaw(nrazon) | writeini dat\conf.ini away nrazon $calc(%tempawvar - 1) }
    bataway
  }
}
;--- -- - - Dialog para restaurar el away al conectar - - -- ---;
alias aw.desc $dialog(awdesc,awdesc,2)
dialog awdesc {
  title "BaT: Confirmación de away"
  size -1 -1 120 50
  option dbu
  box "Info:", 1, 5 2 110 4
  text "En el momento de la desconexión estabas away, ¿deseas restaurar el away?", 2, 10 10 100 30, center
  button "Si (auto: 10secs)", 250, 5 35 50 12, ok
  button "No", 249, 65 35 50 12, cancel
}
on *:dialog:awdesc:init:*: { set %awdesc.temp 10 | .timerawdesc 0 1 awpertdesc }
on *:dialog:awdesc:sclick:*: { if ($did == 250) { .timerawdesc off | unset %awdesc.temp | bataway -r | dialog -x awdesc } | if ($did == 249) { .timerawdesc off | unset %awdesc.temp | dialog -x awdesc | unset %aw | .disable #awev | .disable #awpager } }
alias awpertdesc { dec %awdesc.temp | if (%awdesc.temp == 0) { awdescya } | else did -ra awdesc 250 Si (auto: $duration(%awdesc.temp) $+ ) }
alias awdescya { .timerawdesc off | dialog -x awdesc | unset %awdesc.temp | bataway -r }
;--- -- - - Loger de eventos remotos - - -- ---;
#awev off
on *:OPEN:?: if ($diaw(cquery) == Si) close -m $nick
on *:NOTIFY: if ($diaw(lognotify) == On) wa.log $colour(Notify Text) [Nofity] $nick entra al IRC
on *:UNOTIFY:  if ($diaw(lognotify) == On) wa.log $colour(Notify Text) [Nofity] $nick sale dell IRC (o cambia de nick)
on *:JOIN:#: {
  if (($readini $mircdirdat\users.ini $nick nivel == 200) && ($diaw(logjoinuser) == On)) wa.log $colour(join text) [Join: $+ $chan $+ ] $nick ( $+ $address $+ ) - Usuario Protegido
  if (($readini $mircdirdat\users.ini $nick nivel == 150) && ($diaw(logjoinuser) == On)) wa.log $colour(join text) [Join: $+ $chan $+ ] $nick ( $+ $address $+ ) - Usuario AutoOp
  if (($readini $mircdirdat\users.ini $nick nivel == 100) && ($diaw(logjoinuser) == On)) wa.log $colour(join text) [Join: $+ $chan $+ ] $nick ( $+ $address $+ ) - Usuario AutoVoz
  if (($readini $mircdirdat\users.ini $nick nivel == 75) && ($diaw(logjoinuser) == On)) wa.log $colour(join text) [Join: $+ $chan $+ ] $nick ( $+ $address $+ ) - Usuario Peligroso
  if (($readini $mircdirdat\users.ini $nick nivel == 50) && ($diaw(logjoinuser) == On)) wa.log $colour(join text) [Join: $+ $chan $+ ] $nick ( $+ $address $+ ) - Usuario Asqueroso
}
on *:OP:#: {
  if (($opnick == $me) && ($diaw(logmodeme) == On)) wa.log $colour(mode text) [Op: $+ $chan $+ ] $nick te da op
  if (($nick == $me) && ($diaw(logmemode) == On)) wa.log $colour(mode text) [Op: $+ $chan $+ ] le das op a $opnick
}
on *:DEOP:#: {
  if (($opnick == $me) && ($diaw(logmodeme) == On)) wa.log $colour(mode text) [Deop: $+ $chan $+ ] $nick te quita op
  if (($nick == me) && ($diaw(logmemode) == On)) wa.log $colour(mode text) [Deop: $+ $chan $+ ] le quitas op a $opnick
  if (($readini $mircdirdat\users.ini $nick nivel == 200) && ($diaw(logmodeproteg) == On)) wa.log $colour(mode text) [Deop: $+ $chan $+ ] $nick le quita op a $opnick (Usuario Protegido)
}
on *:KICK:#: {
  if (($knick == $me) && ($diaw(logmodeme) == On)) wa.log $colour(kick text) [Kick: $+ $chan $+ ] $nick te kickea: $1-
  if (($nick == $me) && ($diaw(logmemode) == On)) wa.log $colour(kick text) [Kick: $+ $chan $+ ] Kickeas a $knick $+ : $1-
  if (($readini $mircdirdat\users.ini $nick nivel == 200) && ($diaw(logmodeproteg) == On)) wa.log $colour(kick text) [Kick: $+ $chan $+ ] $nick kickea a $opnick (Usuario Protegido): $1-
}
on *:BAN:#: {
  if (($banmask iswm $address($me,5)) && ($diaw(logmodeme) == On)) wa.log $colour(mode text) [Ban: $+ $chan $+ ] $nick te banea ( $+ $banmask $+ )
  if (($nick == $me) && ($diaw(logmemode) == On)) wa.log $colour(mode text) [Ban: $+ $chan $+ ] Baneas a $ialcalc($banmask) ( $+ $banmask $+ )
  if (($readini $mircdirdat\users.ini $ialcalc($banmask) nivel == 200) && ($diaw(logmodeproteg) == On)) wa.log $colour(mode text) [Ban: $+ $chan $+ ] $nick Banea a $ialcalc($banmask) (Usuario Protegido): $banmask
}
on *:TEXT:*:#: {
  if ($me isin $strip($1-)) {
    if ($diaw(logcitame) == On) wa.log $colour(Normal Text) [Msg( $+ $nick $+ : $+ $chan $+ )] $1-
    if ($diaw(respond) == On) { if ([ %awtxt. [ $+ [ $nick ] ] ]) halt | else { .notice $nick Away: $diaw(razon) [L: $+ $diaw(loger) P: $+ $diaw(pager) $+ ] [ $+ $duration($calc($ctime - %aw.inicio)) $+ ] BaT | set -u300 %awtxt. [ $+ [ $nick ] ] 1 } } 
  }
}
on *:TEXT:*:?: { 
  if ($diaw(lognotiquery) == On) wa.log $colour(Normal Text) [Msg( $+ $nick $+ )] $1- 
  if ($diaw(respond) == On) {
    if ([ %awtxt. [ $+ [ $nick ] ] ]) halt
    else .msg $nick Away: $diaw(razon) [L: $+ $diaw(loger) P: $+ $diaw(pager) $+ ] [ $+ $duration($calc($ctime - %aw.inicio)) $+ ] BaT  | set -u300 %awtxt. [ $+ [ $nick ] ] 1 
  }
}
on *:NOTICE:*:*:{
  if ($diaw(lognotiquery) == On) {
    if (# != $null) { 
      set %notice.chan $target | set %notice.where $target
      if ($left($target,1) == @) { set %notice.where $right($target,-1) | set %notice.chan @ $+ %notice.where }
      wa.log $colour(notice text) [Notice( $+ $nick $+ : $+ %notice.chan $+ )] $1-
    }
    else wa.log $colour(notice text) [Notice( $+ $nick $+ )] $1-
    unset %notice.chan %notice.where
    if ($diaw(respond) == On) { if ([ %awtxt. [ $+ [ $nick ] ] ]) halt | else { .notice $nick Away: %aw.razon [L: $+ $diaw(loger) P: $+ $diaw(pager) $+ ] [ $+ $duration($calc($ctime - %aw.inicio)) $+ ] BaT | set -u300 %awtxt. [ $+ [ $nick ] ] 1 } } 
  }
}
ctcp *:*:*:{ if ($diaw(logctcp) == On) wa.log $colour(ctcp text) [Ctcp( $+ $nick $+ ! $+ $address $+ )] $1- $iif($target ischan,a [ $target ] ) }
#awev End
alias awconf dialog -m awcf awcf
dialog awcf {
  title "BaT: Configuración del Sistema de Away [/awconf]"
  size -1 -1 250 180
  option dbu
  tab "General", 1, 5 5 240 150 
  tab "Loger", 2
  tab "AutoAway y Theme", 3
  combo 12, 15 25 220 50, edit, drop, tab 1
  check "Mostrar msg de Away en los canales:", 13, 20 47 100 10, tab 1
  radio "Normal, cada...", 14, 125 44 50 10, tab 1, group disable
  radio "Solo la 1ª vez", 15, 125 54 50 10, tab 1 disable
  combo 17, 180 43 55 50, drop disable, tab 1
  check "Nick de Away:", 18, 20 60 45 10, tab 1 
  edit "", 19, 70 60 40 10, center tab 1 disable
  check "Cerrar Querys en Away", 20, 125 80 70 10, tab 1
  check "Desactivar lista AutoGet DCC", 21, 20 80 100 10, tab 1 disable
  check "Desactivar lista de Usuarios", 22, 20 90 100 10, tab 1
  check "Desactivar Protecciones de Flood", 23, 20 100 100 10, tab 1
  check "Minimizar mIRC", 24, 125 90 50 10, tab 1
  check "en bandeja", 25, 175 90 70 10, tab 1 disable
  check "Auto Deopearnos en Away", 26, 125 100 75 10, tab 1
  check "Activar Pager (msgs urgentes)", 30, 20 110 80 10, tab 1
  check "Responder msgs/notices", 31, 125 110 75 10, tab 1
  text "Canales exentos del msg:", 27, 20 125 75 10, tab 1
  edit "", 28, 15 140 220 10, tab 1
  check "Activar Grabador", 101, 60 25 120 10, push, tab 2
  check "Querys/Notices (canal/privados)", 102, 70 40 100 10, disable, tab 2
  check "CTCPs recibidos incluido Pager (canal/privados)", 103, 70 50 150 10, disable, tab 2
  check "Si nombran tu nick en un canal", 104, 70 60 100 10, disable, tab 2
  check "Op/Deop/Kick/Ban sufridos", 105, 70 75 100 10, disable, tab 2
  check "Op/Deop/Kick/Ban realizados", 106, 70 85 100 10, disable, tab 2
  check "Joins de Usuarios en tus Listas", 107, 70 100 100 10, disable, tab 2
  check "Deop/Kick/Ban a Usuarios Protegidos", 108, 70 110 100 10, disable, tab 2
  check "Conexión/Desconexión de Usuarios en Notify", 109, 70 125 120 10, disable, tab 2
  check "Activar AutoAway despues de alcanzar un Idle superior a...", 202, 20 30 150 10, tab 3
  combo 203, 180 30 55 50, drop, disable, tab 3
  check "Mostrar msg de Auto Away...:", 204, 40 47 80 10, tab 3 disable
  radio "Normal, cada...", 205, 125 44 50 10, tab 3, group disable
  radio "Solo la 1ª vez", 206, 125 54 50 10, tab 3 disable
  combo 207, 180 43 55 50, drop disable, tab 3
  check "Usar nick de AutoAway:", 208, 40 70 70 10, disable, tab 3
  edit "", 209, 120 70 50 10, center disable, tab 3
  text "Msg Away On:", 211, 20 90 40 10, tab 3 disable hide
  ; edit "", 212
  text "Msg Away Off:", 213, 20 105 40 10, tab 3 disable hide
  ; edit "", 214
  text "Msg de respuesta (privado):", 215, 20 120 100 10, tab 3 disable hide
  ; edit "", 216
  text "Notice de respuesta (canal):", 217, 20 135 100 10, tab 3 disable hide
  ; edit "", 218

  button "Cancelar", 248, 190 162 50 15, cancel
  button "Ponerse Away", 249, 10 162 50 15 , ok
  button "Salvar y Salir", 250, 135 162 50 15, ok
}
on *:dialog:awcf:init:*: {
  if ($findfile($mircdir,away.dat,1) == $null) write -c dat\away.dat | set -u %i 1 | :inicio | set -u %tmp.var $read -l %i dat\away.dat | if (%tmp.var) { did -a awcf 12 %tmp.var | inc %i | goto inicio } | did -c awcf 12 $diaw(nrazon)
  did -a awcf 17 2 horas | did -a awcf 17 1 hora | did -a awcf 17 30 min | did -a awcf 17 15 min | did -a awcf 17 10 min |   did -a awcf 28 $diaw(exentos)
  if ($diaw(msgc) == 600) did -c awcf 17 5 | elseif ($diaw(msgc) == 900) did -c awcf 17 4 | elseif ($diaw(msgc) == 1800) did -c awcf 17 3 | elseif ($diaw(msgc) == 3600) did -c awcf 17 2 | else did -c awcf 17 1
  if ($diaw(msg) != No) { did -c awcf 13 | did -e awcf 14 | did -e awcf 15 | if ($diaw(msg) == Normal) { did -c awcf 14 | did -e awcf 17 } | elseif ($diaw(msg) == Primera) { did -c awcf 15 } }
  if ($diaw(unick) != No) { did -c awcf 18 | did -a awcf 19 $diaw(unick) | did -e awcf 19 } | if ($diaw(pager) == On) did -c awcf 30 | if ($diaw(respond) == On) did -c awcf 31
  if ($diaw(aget) == Si) did -c awcf 21 | if ($diaw(ulist) == Si) did -c awcf 22 | if ($diaw(noflood) == Si) did -c awcf 23 | if ($diaw(cquery) == Si) did -c awcf 20 | if ($diaw(minimice) != No) { did -c awcf 24 | did -e awcf 25 | if ($diaw(minimice) == tray) did -c awcf 25 } | if ($diaw(adeop) == Si) did -c awcf 26
  if ($diaw(loger) == On) { did -c awcf 101 | did -e awcf 102 | did -e awcf 103 | did -e awcf 104 | did -e awcf 105 | did -e awcf 106 | did -e awcf 107 | did -e awcf 108 | did -e awcf 109 }
  if ($diaw(lognotiquery) == On) did -c awcf 102 | if ($diaw(logctcp) == On) did -c awcf 103 | if ($diaw(logcitame) == On) did -c awcf 104 | if ($diaw(logmodeme) == On) did -c awcf 105
  if ($diaw(logmemode) == On) did -c awcf 106 | if ($diaw(logjoinuser) == On) did -c awcf 107 | if ($diaw(logmodeproteg) == On) did -c awcf 108 | if ($diaw(lognotify) == On) did -c awcf 109
  did -a awcf 203 2 horas | did -a awcf 203 1 hora | did -a awcf 203 30 min | did -a awcf 203 15 min | did -a awcf 203 10 min | did -a awcf 207 2 horas | did -a awcf 207 1 hora | did -a awcf 207 30 min | did -a awcf 207 15 min | did -a awcf 207 10 min
  if ($diaw(idawayc) == 600) did -c awcf 203 5 | elseif ($diaw(idawayc) == 900) did -c awcf 203 4 | elseif ($diaw(idawayc) == 1800) did -c awcf 203 3 | elseif ($diaw(idawayc) == 3600) did -c awcf 203 2 | else did -c awcf 203 1
  if ($diaw(idmsgc) == 600) did -c awcf 207 5 | elseif ($diaw(idmsgc) == 900) did -c awcf 207 4 | elseif ($diaw(idmsgc) == 1800) did -c awcf 207 3 | elseif ($diaw(idmsgc) == 3600) did -c awcf 207 2 | else did -c awcf 207 1
  if ($diaw(idaway) == On) { did -c awcf 202 | did -e awcf 203 | did -e awcf 208 } 
  else { did -b awcf 203 | did -b awcf 204 | did -b awcf 205 | did -b awcf 206 | did -b awcf 207 | did -b awcf 208 | did -b awcf 209 }
  if ($diaw(idmsg) != Off) did -c awcf 204 | $iif($diaw(idaway) == On,did -e awcf 204) | $iif($diaw(idaway) == On,did -e awcf 205) | $iif($diaw(idaway) == On,did -e awcf 206)
  if ($diaw(idmsg) == Primera) did -c awcf 206 | elseif ($diaw(idmsg) == Normal) { did -c awcf 205 | $iif($diaw(idaway) == On,did -e awcf 207) }
  if ($diaw(idunick) != Off) { $iif($diaw(idaway) == On,did -e awcf 208) | $iif($diaw(idaway) == On,did -e awcf 209) | did -c awcf 208 | did -a awcf 209 $diaw(idunick) }
}
on *:dialog:awcf:sclick:*:{
  if ($did == 13) { if ($did(13).state == 1) { did -e awcf 14 | did -e awcf 15 | $iif($did(14).state == 1,did -e awcf 17) } | else { did -b awcf 14 | did -b awcf 15 | did -b awcf 17 } } | if ($did == 14) did -e awcf 17 | if ($did == 15) did -b awcf 17
  if ($did == 18) { if ($did(18).state == 1) did -e awcf 19 | else did -b awcf 19 }
  if ($did == 24) { if ($did(24).state == 1) did -e awcf 25 | else did -b awcf 25 }
  if ($did == 101) { if ($did(101).state == 1) { did -e awcf 102 | did -e awcf 103 | did -e awcf 104 | did -e awcf 105 | did -e awcf 106 | did -e awcf 107 | did -e awcf 108 | did -e awcf 109 } | else { did -b awcf 102 | did -b awcf 103 | did -b awcf 104 | did -b awcf 105 | did -b awcf 106 | did -b awcf 107 | did -b awcf 108 | did -b awcf 109 } }
  if ($did == 202) { 
    if ($did(202).state == 1) { did -e awcf 203 | did -e awcf 204 | $iif($did(204).state == 1,did -e awcf 205) | if ($did(204).state == 1) { did -e awcf 206) | $iif($did(205).state == 1,did -e awcf 207) } | did -e awcf 208 | $iif($did(208).state == 1,did -e awcf 209) } 
    else { did -b awcf 203 | did -b awcf 204 | did -b awcf 205 | did -b awcf 206 | did -b awcf 207 | did -b awcf 208 | did -b awcf 209 } 
  } 
  if ($did == 204) { if ($did(204).state == 1) { did -e awcf 205 | did -e awcf 206 | $iif($did(205).state == 1,did -e awcf 207) } | else { did -b awcf 205 | did -b awcf 206 | did -b awcf 207 } } 
  if ($did == 205) did -e awcf 207 | if ($did == 206) did -b awcf 207
  if ($did == 208) { if ($did(208).state == 1) { did -e awcf 209 } | else { did -b awcf 209 } }
  if (($did == 249) || ($did == 250)) { 
    if ($did(12)) { 
      set %aw.razon $did(12).text | set -u %i 1
      :inicio
      set -u %tmp.var $read -l %i $findfile($mircdir,away.dat,1)
      if (%tmp.var) { if (%aw.razon == %tmp.var) goto razonvieja | inc %i | goto inicio }
      write $findfile($mircdir,away.dat,1) %aw.razon | graw nrazon $lines($findfile($mircdir,away.dat,1)) | graw razon razon %aw.razon
      goto razonnueva
    }
    :razonvieja
    graw nrazon $did(12).sel
    graw razon $did(12).text
    :razonnueva
    if (%aw.razon == $null) graw razon Sin Razón
    if ($lines($findfile($mircdir,away.dat,1)) >= 11) { write -dl1 $findfile($mircdir,away.dat,1) | dec %aw.nrazon }
    if ($did(13).state == 1) { if ($did(14).state == 1) graw msg Normal | else graw msg Primera } | else graw msg No
    if ($did(17).sel == 2) graw msgc 3600 | elseif ($did(17).sel == 3) graw msgc 1800 | elseif ($did(17).sel == 4) graw msgc 900 | elseif ($did(17).sel == 5) graw msgc 600 | else graw msgc 7200
    if ($did(18).state == 1) graw unick $did(19).text | else graw unick No | if ($did(30).state == 1) graw pager On | else graw pager Off
    if ($did(20).state == 1) graw cquery Si | else graw cquery No | if ($did(21).state == 1) graw aget Si | else graw aget No | if ($did(22).state == 1) graw ulist Si | else graw ulist No | if ($did(26).state == 1) graw adeop Si | else graw adeop No
    if ($did(23).state == 1) graw noflood Si | else graw noflood No | if ($did(24).state == 1) { if ($did(25).state == 1) graw minimice tray | else graw minimice Si } | else graw minimice No | graw exentos $did(28).text | if ($did(31).state == 1) graw respond On | else graw respond Off
    if ($did(101).state == 1) graw loger On | else graw loger Off
    if ($did(102).state == 1) graw lognotiquery On | else graw lognotiquery Off
    if ($did(103).state == 1) graw logctcp On | else graw logctcp Off
    if ($did(104).state == 1) graw logcitame On | else graw logcitame Off
    if ($did(105).state == 1) graw logmodeme On | else graw logmodeme Off
    if ($did(106).state == 1) graw logmemode On | else graw logmemode Off
    if ($did(107).state == 1) graw logjoinuser On | else graw logjoinuser Off
    if ($did(108).state == 1) graw logmodeproteg On | else graw logmodeproteg Off
    if ($did(109).state == 1) graw lognotify On | else graw lognotify Off
    if ($did(202).state == 1) graw idaway On | else graw idaway Off
    if ($did(203).sel == 2) graw idawayc 3600 | elseif ($did(203).sel == 3) graw idawayc 1800 | elseif ($did(203).sel == 4) graw idawayc 900 | elseif ($did(203).sel == 5) graw idawayc 600 | else graw idawayc 7200
    if ($did(204).state == 1) { if ($did(205).state == 1) graw idmsg Normal | else graw idmsg Primera } | else graw idmsg No
    if ($did(207).sel == 2) graw idmsgc 3600 | elseif ($did(207).sel == 3) graw idmsgc 1800 | elseif ($did(207).sel == 4) graw idmsgc 900 | elseif ($did(207).sel == 5) graw idmsgc 600 | else graw idmsgc 7200
    if ($did(208).state == 1) graw idunick $did(209).text | else graw idunick Off
    if ($did == 249) { bataway }
    dialog -x awcf
  }
}
alias confaaway dialog -mdo aaway aaway
dialog aaway {
  title "Confirmación de Auto-Away"
  size -1 -1 400 100
  text "", 1, 20 10 360 50, center
  text "", 2, 20 70 150 22
  button "Away", 250, 170 70 100 25, ok default
  button "Cancelar", 249, 280 70 100 25, cancel
}
on *:dialog:aaway:init:*: {
  did -a aaway 1 Tu idle ha superado los $duration($diaw(idawayc)) $+ . Si no respondes en 20s serás puesto away automáticamente. Para evitarlo, pulsa Cancelar 
  did -a aaway 2 Auto away en $duration(20)
  set %aacuenta 20 
  .timeraacuenta 0 1 aacuenta
}
on *:dialog:aaway:sclick:250: aaway
on *:dialog:aaway:sclick:249: resetidle | .timeraacuenta off 
alias aacuenta dec %aacuenta | if (%aacuenta == 0) aaway | else did -ra aaway 2 Auto away en $duration(%aacuenta)
alias aaway dialog -x aaway | .timeraacuenta off | bataway -i
