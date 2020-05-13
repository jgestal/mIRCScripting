;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; Users list
;
;*************************************

alias ulist makedialog -m ulist
dialog ulist {
  title "Lista de usuarios remotos"
  size -1 -1 180 185
  icon icons\users.ico
  option dbu
  box "Lista de usuarios", 1, 5 5 100 100
  box "", 2, 110 5 65 100
  box "Opciones", 3, 5 105 170 55
  list 4, 10 15 90 85, size
  edit "", 5, 115 40 55 10, autohs
  button "Añadir máscara", 6, 115 55 55 15
  button "Borrar máscara", 7, 115 75 55 15
  check "Activar lista de usuarios", 8, 15 115 70 10
  check "Actuar sólo en éstos canales (separar por coma)", 9, 15 130 127 10
  edit "", 10, 25 145 145 10, autohs
  button "Cerrar", 11, 70 165 40 15,cancel
  icon 12,115 15 20 20,icons\users.ico
}
on 1:dialog:ulist:*:*: {
  if ($devent == init) {
    _mdx.buttons_style 6 7 11
    dll $mdx SetControlMDX $dname 4 listview rowselect grid showsel single flatsb labeltip headerdrag report > $views 
    did -i $dname 4 1 header @100,76 0 Máscara $chr(9) Nivel
    did $iif($group(#userlist) == on,-c,-u) $dname 8
    did $iif($ri(dat\conf.ini,ulist,9) == on,-c,-u) $dname 9
    did -a $dname 10 $ri(dat\conf.ini,ulist,10)
    var %i 1
    while ($rl(dat\users.dat,%i)) {
      did -a $dname 4 $replace($ifmatch,$chr(5),$chr(9))
      inc %i
    }
  }
  if ($devent == sclick) {
    if ($did == 8) $iif($group(#userlist) == on,.disable,.enable) #userlist
    if ($did == 6) { $adduser($did($dname,5)) }
    if ($did == 7) {
      write $+(-dl,$calc($did($dname,4).sel -1)) dat\users.dat
      did -d $dname 4 $did($dname,4).sel
      loadusers
    }
    if ($did == 9) wi dat\conf.ini ulist 9 $iif($ri(dat\conf.ini,ulist,9) == on,off,on)

    if ($did == 11) && ($dialog(ul)) dialog -x ul
  }
  if ($did == 10) wi dat\conf.ini ulist $did $did($dname,10)
  did $iif($did($dname,4).sel,-e,-b) $dname 7
  did $iif($did($dname,9).state == 1,-e,-b) $dname 10
  var %i 1
  while ($rl(dat\users.dat,%i)) {
    if ($gettok($ifmatch,1,5) == $did($dname,5)) { did -b $dname 6 | return }
    inc %i
  }
  did $iif($did($dname,5),-e,-b) $dname 6

}
alias adduser {
  set -u0 %tmp.ulevel ""
  $dialog(ul,ul,2)
  if (!%tmp.ulevel) return 
  write dat\users.dat $+($1,$chr(5),%tmp.ulevel)
  did -a ulist 4 $+($1,$chr(9),%tmp.ulevel)
  loadusers
}
dialog ul {
  title "Nivel de usuario"
  size -1 -1 84 40
  option dbu
  icon icons\users.ico
  combo 2, 5 5 75 50, size drop

  button "Aceptar", 3, 5 20 30 15,ok
  button "Cancelar", 4, 50 20 30 15,cancel
}
on 1:dialog:ul:*:*: {
  if ($devent == init) {
    var %i 1
    var %x AUTOOP,AUTOVOZ,PROTEGIDO,AUTOKICKBAN,BOT
    while ($gettok(%x,%i,44)) {
      did -a $dname 2 $ifmatch
      inc %i
    }
    did -c $dname 2 1
  }
  %tmp.ulevel = $did($dname,2)
  if ($did == 4) unset %tmp.ulevel
}
alias loadusers {
  if ($dialog(ulist)) did -r ulist 5
  var %i 1
  var %x AUTOOP,AUTOVOZ,PROTEGIDO,AUTOKICKBAN,BOT
  while ($gettok(%x,%i,44)) {
    .rlevel $ifmatch
    inc %i
  }
  %i = 1 
  while ($rl(dat\users.dat,%i)) {
    .auser $gettok($ifmatch,2,5) $gettok($ifmatch,1,5)
    inc %i
  }
}
alias -l ulist-state {
  if ($ri(dat\conf.ini,ulist,9) == off) return 1
  elseif ($istok($ri(dat\conf.ini,ulist,10),$chan,44) == $true) return 1
}
#userlist on

on @*!:join:#: { if ($ulist-state) {
    if ($level($nick) == AUTOVOICE) { 
      mode $chan v $nick
      notice $nick  $_lg $nick estás en mi lista de auto-voice
    }
    elseif ($level($nick) == AUTOOP) { 
      mode $chan o $nick
      notice $nick  $_lg $nick estás en mi lista de auto-op
    }
    elseif ($level($nick) == PROTEGIDO) { 
      mode $chan +ov $nick $nick
      notice $nick  $_lg $nick estás en mi lista de protegidos
    }
    elseif ($level($nick) == AUTOKICKBAN) { mode $chan b $nick | kick $chan $nick AutoShit list! } 
} }
on @*!:ban:#: { if ($ulist-state) {
    var %i 1
    var %x $nick($chan,0)
    var %nick
    while (%i <= %x) {
      %nick = $nick($chan,%i)
      if ($banmask iswm $address(%nick,5)) && ($level($address(%nick,5)) == PROTEGIDO) && ($nick != %nick) && (%nick != $me) {
        mode $chan $iif($level($nick) == PROTEGIDO,-b,-bo) $banmask $nick
        notice $nick $_lg %nick está en mi lista de protegidos
      }
inc %i } } }
on @*!:kick:#: { if ($ulist-state) && ($nick != $knick) {
    if ($level($knick) == PROTEGIDO) { invite $knick $chan
      if ($level($nick) != PROTEGIDO) { 
        mode $chan -o $nick
        notice $nick $_lg $knick está en mi lista de protegidos
} } } }

#userlist end
