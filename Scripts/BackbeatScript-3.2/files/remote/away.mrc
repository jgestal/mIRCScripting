;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; Sistema de away
;
;*************************************

alias away {
  if ($away == $true) && ($1 == $null) awayoff 
  else goaway $1-
}
alias awayconf makedialog -m awcnf
dialog awcnf {
  title "Configuración del sistema de away"
  option dbu
  size -1 -1 155 120
  icon icons\away.ico,index
  tab "General", 1, 2 2 150 95
  combo 2, 6 22 100 50, tab 1 drop edit
  button "Borrar", 3,110 22 30 10, tab 1
  box "Opciones generales", 4, 7 38 140 55, tab 1
  radio "Anunciar cada", 5, 11 47 50 10, tab 1 group
  edit "", 6, 61 47 30 10, tab 1 autohs center
  text "minutos", 7, 96 49 18 7, tab 1
  radio "Sólamente la primera vez", 8, 11 57 73 10, tab 1
  radio "No mostrar mensaje de away", 9, 11 67 82 10, tab 1

  tab "Mensajes", 10
  check "Canales exentos:", 11, 7 20 50 10, tab 10
  edit "", 12, 62 20 85 10, tab 10 autohs
  check "Mandar mensaje...", 13, 7 35 59 10, tab 10
  check "Si te nombran en un canal", 14, 17 50 76 10, tab 10
  check "Si te mandan un privado", 15, 17 65 71 10, tab 10
  check "Si te mandan un notice", 16, 17 80 69 10, tab 10

  tab "Log", 17
  check "Activar Log", 18, 7 20 50 10, tab 17
  check "Grabar privados, notices y ctcp", 19, 17 35 87 10, tab 17
  check "Nombramientos en canal", 20, 17 50 72 10, tab 17
  check "Kicks y bans", 21, 17 65 44 10, tab 17
  check "Lista de notificaciones", 22, 17 80 66 10, tab 17

  tab "Page", 23
  check "Activar pager", 24, 7 20 50 10, tab 23
  check "Reproducir sonido", 25, 17 35 56 10, tab 23 
  edit "", 26, 17 50 115 10, tab 23 autohs read
  button "!", 27, 137 50 10 10, tab 23

  tab "Misc", 28
  check "Cerrar privados", 29, 12 20 50 10, tab 28
  check "Nick de away:", 30, 12 35 50 10, tab 28
  edit "", 31, 62 35 60 10, tab 28 autohs
  check "Auto-deop en canales", 32, 12 50 66 10, tab 28
  check "Autoaway a los", 33, 12 65 49 10, tab 28
  edit "", 34, 62 65 25 10, tab 28 autohs center
  text "minutos", 35, 92 66 18 7, tab 28

  button "Away!", 36,10 100 40 15,ok default
  button "Volver", 37,55 100 40 15,ok
  button "Aceptar", 38,110 100 35 15,cancel
}
on 1:dialog:awcnf:*:*: { 
  did $iif($server,-e,-b) $dname 36
  if ($devent == init) _mdx.buttons_style 3 27 36 37 38
  if ($did == 3) { write -c dat\awayreasons.dat | did -r $dname 2 }
  if ($devent == init) || ($did == 3) {
    var %i 1
    makefile dat\awayreasons.dat
    loadbuf -o $dname 2 dat\awayreasons.dat
    did -c $dname $awr(radio) 
    %i = 1
    while ($gettok($awc,%i,46)) { did $iif($awr($gettok($awc,%i,46)) == on,-c,-u) $dname $gettok($awc,%i,46) | inc %i }
    %i = 1
    while ($gettok($awe,%i,46)) { did -ra $dname $gettok($awe,%i,46) $awr($gettok($awe,%i,46)) | inc %i }
  }
  if ($did == 5) || ($did == 8) || ($did == 9) aww radio $did
  if ($istok($awc,$did,46) == $true) aww $did $iif($awr($did) == on,off,on)
  if ($istok($awe,$did,46) == $true) aww $did $did($dname,$did)
  did $iif($awr(radio) == 5,-e,-b) $dname 6
  did $iif($awr(11) == on,-e,-b) $dname 12
  did $iif($awr(13) == on,-e,-b) $dname 14,15,16
  did $iif($awr(18) == on,-e,-b) $dname 19,20,21,22
  did $iif($awr(24) == on,-e,-b) $dname 25,27
  did $iif($awr(11) == on,-e,-b) $dname 12
  did $iif($awr(30) == on,-e,-b) $dname 31
  did $iif($awr(33) == on,-e,-b) $dname 34
  if ($did == 27) {
    aww 26 $remove($sfile($wavedir,Selecciona un archivo .wav o .mid o .mp3 para reproducir en la llegada del CTCP Page,Aceptar),$mircdir)
    did -ra $dname 26 $awr(26)
  }
  did $iif($away == $true,-e,-b) $dname 37
  if ($did == 36) { goaway $did($dname,2) | dialog -x $dname }
  if ($did == 37) { dialog -x $dname | awayoff }
}

alias awr return $ri(dat\awconf.ini,g,$$1)
alias aww wi dat\awconf.ini g $$1 $$2
alias awc return 11.13.14.15.16.18.19.20.21.22.24.25.29.30.32.33
alias awe return 6.12.26.31.34
alias awayoff {
  .timerawaymsg off
  awlog -e 
  if ($me != %aw.nick) && (%aw.nick) nick %aw.nick
  if ($awr(radio) != 9) awsmsg ...away<OFF $iif(%aw.reason,%aw.reason,has no reason)) ( $+ $duration($calc($ctime - %aw.ctime),2) $+ )
  .raw away
  unset %aw.*
  if ($awr(18) == on) awaylog
}
alias goaway {
  if ($1) && ($1 != auto-away) wifnot dat\awayreasons.dat 15 $1-
  %aw.reason = $1-
  %aw.ctime = $ctime

  if ($awr(radio) != 9) awsmsg ...away> $iif(%aw.reason,%aw.reason,has no reason)) [log: $+ $awr(18) $+ |page: $+ $awr(24) $+ ] 
  .raw away : $+ $iif(%aw.reason,%aw.reason,has no reason)
  awlog -i 
  if ($awr(radio) == 5) {
    if ($awr(6) !isnum) aww 6 120
    .timerawaymsg 0 $calc($awr(6) * 60) awsmsg $!awtmsg 
  }
  if ($awr(30) == on) && ($awr(31)) && ($awr(31) != $me) {
    set %aw.nick $me
    nick $awr(31)
  }
  if ($awr(32) == on) { var %i 1 | while ($chan(%i)) { if ($me isop $chan(%i)) mode $chan(%i) -o $me | inc %i } }
}

alias awsmsg { if ($server) { var %i 1 
    while ($chan(%i)) {  
      if ($istok($awr(12),$chan(%i),44) == $true) && ($awr(11) == on) { inc %i | continue }
      else { msg $chan(%i) $1- | inc %i }
} } }
alias awtmsg return ...away> $iif(%aw.reason,%aw.reason,has no reason)) [log: $+ $awr(18) $+ |page: $+ $awr(24) $+ ] ( $+ $duration($calc($ctime - %aw.ctime),2) $+ )
alias awlogw write dat\away.log $timestamp $strip($$1-)
alias awlog { if ($awr(18) == on) {
    if ($1 == -i) {
      awlogw ----------------------------------------
      awlogw Inicio de sesión ( $+ $date $+ )
      awlogw Motivo: %aw.reason
      awlogw ----------------------------------------
    }
    elseif ($1 == -q) && ($awr(19) == on) awlogw <Query: $+ $2 $+ > $3-
    elseif ($1 == -o) && ($awr(19) == on) awlogw -Notice: $+ $2 $+ > $3-
    elseif ($1 == -t) && ($awr(19) == on) awlogw >>Ctcp: $+ $2 $+ > $3-
    elseif ($1 == -c) && ($awr(20) == on) awlogw [Channel: $+ $2 $+ ]] $3 $+ > $4-
    elseif ($1 == -k) && ($awr(21) == on) awlogw [KiCK: $+ $2 $+ ]] $3 kicks $4 ( $+ $iif($5 == $3,has no reason,$5-) $+ )
    elseif ($1 == -b) && ($awr(21) == on) awlogw [BAN: $+ $2 $+ ]] $3 bans $4-
    elseif ($1 == -n) && ($awr(22) == on) awlogw -Notify- $2 $iif($3-,( $+ $3- $+ )) is on IRC
    elseif ($1 == -u) && ($awr(22) == on) awlogw -UnNotify- $2 $iif($3-,( $+ $3- $+ )) has left IRC
    elseif ($1 == -e) {
      awlogw ----------------------------------------
      awlogw Fín de sesión, Dejas de estar away.
      awlogw Away: $duration($calc($ctime - %aw.ctime),2)
      awlogw ----------------------------------------
    }
  }
}
on ^*:open:?: { if ($away == $true) { if ($awr(29) == on) { awlog -q $nick $1- | awresp -q $nick | haltdef } } }
on *:text:*:?: { if ($away == $true) { awlog -q $nick $1- | awresp -q $nick } }
on *:notice:*:?: { if ($away == $true) && ($1 != midelag) { awlog -o $nick $1- | awresp -o $nick } }
on *:text:*:#: { if ($away == $true) && ($me isin $strip($1-)) { awlog -c $chan $nick $1- | awresp -c $nick } }
ctcp *:*:?: { 
  if ($away == $true) awlog -t $nick $1-  
  if ($1 == PAGE) && ($awr(24) == on) {
    flash -wbr10 CTCP PAGE $nick
    if ($awr(25) == on) && ($isfile($awr(26))) {
      if ($right($awr(26),4) == .wav) .splay -w $awr(26)
      elseif ($right($awr(26),4) == .mp3) .splay -p $awr(26)
      elseif ($right($awr(26),4) == .mid) .splay -m $awr(26)
    }
  }
}
on *:kick:#: { if ($away == $true) awlog -k $chan $nick $knick $1- }
on *:ban:#: { if ($away == $true) awlog -b $chan $nick $banmask }
on *:notify: { if ($away == $true) awlog -n $nick $notify($nick).note }
on *:unotify: { if ($away == $true) awlog -u $nick $notify($nick).note }

alias awresp { if ($awr(13) == on) {
    if (!%aw.fl. [ $+ [ $wildsite ] ]) {
      if ($1 == -c) && ($awr(14) == on) || ($1 == -q) && ($awr(15) == on) || ($1 == -o) && ($awr(16) == on) {
        notice $nick ...away> $iif(%aw.reason,%aw.reason,has no reason)) [log: $+ $awr(18) $+ |page: $+ $awr(24) $+ ] ( $+ $duration($calc($ctime - %aw.ctime),2) $+ )
        set -u1200 %aw.fl. [ $+ [ $wildsite ] ] on
} } } }
on 1:start: { unset %aw.* | .timerawayidle 0 60 aw.checkidle }
alias aw.checkidle { if ($awr(33) == on) && ($away == $false) && ($server) && ($idle >= $calc($awr(34) *60)) goaway auto-away after $duration($calc($awr(34) * 60)) of idle }
menu @awaylog {
  &recargar:awaylog
  -
  &borrar:{ .remove dat\away.log | window -c $active }
  -
  &cerrar:window -c $active

}
alias awaylog {
  window -k @AwayLog
  makefile dat\away.log
  clear @awaylog
  loadbuf @awaylog dat\away.log
}
