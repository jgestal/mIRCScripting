;########################
;# Protección Antiban v1.0
;# Script por Jimmy_RAY
;# http://jimmy.welt.es http://backbeat.welt.es
;# email jimmy@welt.es
;########################
on 1:start: {
  echo -s Protección Antiban v1.0 por Jimmy_RAY
  echo -s Escribe /antiban en cualquier ventana para ver la configuración.
}
MENU MenuBar {
  -
  Protección Antiban:antiban
}
alias antiban dialog -m antiban antiban 
dialog antiban {
  size -1 -1 350 310
  title "Protección antiban"
  tab "Configuración",1,5 5 340 270
  tab "Créditos",2
  check "&Activar protección.",3,15 30 110 20,tab 1
  box "Si eres op en el canal...",4,25 50 130 90,tab 1
  check "&Deopear al nick.",5,35 70 100 20,tab 1
  check "&Banear al nick.",6,35 90 100 20,tab 1
  box "Si no eres op...",7,175 50 150 90,tab 1
  check "&Op a ti por CHaN.",8,185 70 100 20,tab 1
  check "D&eop al nick por CHaN.",9,185 90 130  20,tab 1
  check "&Unban por CHaN",10,185 110 130  20,tab 1
  box "Frase de kick",11,25 155 300 90,tab 1
  edit "",12,35 180 280 20,tab 1
  button "Cerrar",13,265 280 60 20,ok,default
  text "Ejemplo de protección antiban. Puedes añadir éste addOn a tu script y distribuirlo libremente sin modificar el código. Cualquier duda mándame un email.",14,15 35 300 50,tab2
  box "",15,25 80 300 170,tab2
  button "&jimmy@welt.es",16,60 100 110 20,tab2
  button "http://jimmy.welt.es",17,170 100 120 20,tab2
  button "http://backbeat.welt.es",18,60 120 230 20,tab2
}
on 1:dialog:antiban:init:*: {
  did $iif(%bp.estado == on,-c,-u) antiban 3
  bp.ed
  did $iif(%bp.deop.al.nick == on,-c,-u) antiban 5
  did $iif(%bp.banear.al.nick == on,-c,-u) antiban 6
  did $iif(%bp.op.por.chan == on,-c,-u) antiban 8
  did $iif(%bp.deop.por.chan == on,-c,-u) antiban 9
  did $iif(%bp.unban.por.chan == on,-c,-u) antiban 10
  did -a antiban 12 %bp.razon.del.kick
}
alias bp.ed {  if (%bp.estado != on) { did -b antiban 4 | did -b antiban 5 | did -b antiban 6 | did -b antiban 7 | did -b antiban 8 |  did -b antiban 9 | did -b antiban 10 | did -b antiban 11 | did -b antiban 12 }
else { did -e antiban 4 | did -e antiban 5 | did -e antiban 6 | did -e antiban 7 | did -e antiban 8 | did -e antiban 9 | did -e antiban 10 | did -e antiban 11 | did -e antiban 12  } }
on 1:dialog:antiban:sclick:*: {
  if ($did == 3) {
    if (%bp.estado == on) unset %bp.estado
    else set %bp.estado on
    bp.ed
  }
  if ($did == 5)  {
    if (%bp.deop.al.nick == on) unset %bp.deop.al.nick
    else set %bp.deop.al.nick on
  }
  if ($did == 6)  {
    if (%bp.banear.al.nick == on) unset %bp.banear.al.nick
    else set %bp.banear.al.nick on
  }
  if ($did == 8) {
    if (%bp.op.por.chan == on) unset %bp.op.por.chan
    else set %bp.op.por.chan on
  }
  if ($did == 9) {
    if (%bp.deop.por.chan == on) unset %bp.deop.por.chan
    else set %bp.deop.por.chan on
  }
  if ($did == 10) { 
    if (%bp.unban.por.chan == on) unset %bp.unban.por.chan
    else set %bp.unban.por.chan on
  }
  if ($did == 16) run mailto:jimmy@welt.es
  if ($did == 17) run http://jimmy.welt.es
  if ($did == 18) run http://backbeat.welt.es
}
on 1:dialog:antiban:edit:12: { set %bp.razon.del.kick $did(antiban,12) }
on 1:connect:/.ial on
on *!:ban:#: {
  if (($banmask iswm $address($me,5)) && (%bp.estado == on)) {
    echo -s 3*** $nick te banea en $chan con la mascara $banmask
    if ($me isop $chan) {
      if ((%bp.deop.al.nick != on) && (%bp.banear.al.nick != on)) mode $chan -b $banmask
      if ((%bp.deop.al.nick == on) && (%bp.banear.al.nick != on)) mode $chan -bo $banmask $nick
      if ((%bp.deop.al.nick == on) && (%bp.banear.al.nick == on)) {
        mode $chan -bo+b $banmask $nick $nick 
        if (%bp.razon.del.kick) kick $chan $nick %bp.razon.del.kick 
        elseif (%bp.razon.del.kick == $null) kick $chan $nick Protección antiban
    } }
    else {
      if (%bp.deop.por.chan) {
        .msg chan deop $chan $me
        echo -s $timestamp Antiban -> CHaN deop $chan $nick
      }
      if (%bp.unban.por.chan) {
        .msg chan unban $chan
        echo -s $timestamp Antiban -> CHaN unban $chan
      }
      if (%bp.op.por.chan) { 
        .msg chan op $chan $me
        echo -s $timestamp Antiban -> CHaN op $chan $me
} } } }
