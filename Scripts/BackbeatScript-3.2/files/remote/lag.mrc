;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************



;*************************************
; Medidor de lag
;
;*************************************

alias mlag makedialog -m mlag
dialog mlag {
  title "Medidor de lag"
  option dbu
  size -1 -1 106 105
  icon icons\clock.ico
  check "Activar medidor de lag", 1, 4 4 67 10
  box "", 2, -4 18 150 61
  text "Medir lag cada:", 3, 4 32 37 7
  edit "", 4, 44 30 30 10, center
  text "segundos", 5, 77 32 23 7
  check "Avisar si el lag es mayor que:", 6, 4 48 80 10
  edit "" ,7,85 48 20 10,center
  check "Mostrar lag en status", 8, 4 60 63 9
  button "Aceptar", 9, 4 82 40 20, default ok
  button "Cancelar", 10, 62 82 40 20,cancel
}
on 1:dialog:mlag:*:*: {
  if ($devent == init) {
    _mdx.buttons_style 9 10
    did $iif($ri(dat\conf.ini,lag,1) == on,-c,-u) $dname 1
    did -a $dname 4 $ri(dat\conf.ini,lag,4)
    did $iif($ri(dat\conf.ini,lag,6) == on,-c,-u) $dname 6
    did -a $dname 7 $ri(dat\conf.ini,lag,7)
    did $iif($ri(dat\conf.ini,lag,8) == on,-c,-u) $dname 8
  }
  elseif ($devent == sclick) && ($did == 9) {
    wi dat\conf.ini lag 1 $iif($did($dname,1).state == 1,on,off)
    wi dat\conf.ini lag 4 $iif($did($dname,4),$ifmatch,30)
    wi dat\conf.ini lag 6 $iif($did($dname,6).state == 1,on,off)
    wi dat\conf.ini lag 7 $iif($did($dname,7),$ifmatch,20)
    wi dat\conf.ini lag 8 $iif($did($dname,8).state == 1,on,off)
  }
}
on 1:start:{ unset %lag* }
on 1:connect: { lag_init }
on 1:disconnect: { unset %lag* | .timerlag* off }

alias lag_mide { 
  if ($ri(dat\conf.ini,lag,1) == off) { unset %lag* | .timerlag* off | return }
  .notice $me MIDELAG $ticks
  .timerlag_1 1 $ri(dat\conf.ini,lag,4) lag_mide
  .timerlag_2 1 $int($calc(%lag +1)) lag_inc
}
alias lag {
  if (!%lag) return ???
  elseif ($1 > 59) return $duration(%lag)
  else return %lag $+ secs
}
alias lag_init {
  lag_mide
  .timerlag_1 1 $ri(dat\conf.ini,lag,4) lag_mide
}
alias lag_inc {
  inc %lag 
  .timerlag_3 1 1 lag_inc
}
