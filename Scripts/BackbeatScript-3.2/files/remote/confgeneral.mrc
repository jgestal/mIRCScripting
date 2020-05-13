;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; Configuración general
;
;*************************************

alias confg makedialog -m confg
dialog confg {
  title "Configuración general"
  size -1 -1 220 165
  option dbu
  icon icons\confgen.ico
  tab "General", 3, 5 5 209 134
  check "Reentrar al ser kickeado", 4, 20 30 72 10, tab 3
  check "Aviso al ser nombrado", 5, 20 45 70 10, tab 3
  check "Mostrar CTCP Version reply", 6, 20 60 79 10, tab 3
  box "Al entrar mostrar", 7, 15 75 90 55, tab 3
  check "Nick anterior", 8, 20 85 48 10, tab 3
  check "Clones", 9, 20 100 33 10, tab 3
  check "Nivel en las listas de usuarios", 10, 20 115 82 10, tab 3 disabled
  box "Filtro de noticias de servidor", 11, 115 30 90 100, tab 3
  radio "Mostrar en status", 12, 120 40 55 10, tab 3
  radio "Mostrar en ventana aparte", 13, 120 50 76 10, tab 3
  text "No mostrar:", 16, 125 62 27 8, tab 3
  list 17, 120 75 55 50, tab 3 size
  button "Añadir", 18, 180 80 20 15, tab 3
  button "Borrar", 19, 180 105 20 15, tab 3
  tab "Autoentrada", 20
  box "Selecciona una red", 21, 15 30 90 30, tab 20
  combo 22, 20 41 80 70, tab 20 size drop
  radio "Auto entrar al conectar", 23, 20 65 69 10, tab 20
  text "Retrasar autoentrada en:", 24, 25 80 59 8, tab 20
  edit "", 25, 85 78 20 10, tab 20 autohs center
  radio "Preguntar si autoentrar", 26, 20 100 68 10, tab 20
  box "Canales", 27, 115 30 90 100, tab 20
  check "Activar autoentrada", 28, 120 40 60 8, tab 20
  edit "", 29, 120 50 80 10, tab 20 autohs
  list 30, 120 65 55 60, tab 20 size
  button "Añadir", 31, 180 75 20 15, tab 20
  button "Borrar", 32, 180 100 20 15, tab 20
  tab "Antispam", 33
  box "Actuar en...", 37, 15 30 90 40, tab 33
  check "Privado abierto", 38, 20 40 45 10, tab 33
  check "Notice", 39, 20 55 31 10, tab 33
  check "Quit", 40, 70 40 26 10, tab 33
  check "Part", 41, 70 55 29 10, tab 33
  check "Avisar del bloqueo del mensaje", 42, 20 75 88 10, tab 33
  text "Máximos avisos:", 43, 15 90 39 8, tab 33
  edit "", 44, 65 88 20 10, tab 33 autohs center
  text "Intervalo de tiempo:", 45, 15 105 47 8, tab 33
  edit "", 46, 65 102 20 10, tab 33 autohs center
  text "(protección de flood)", 47, 15 116 90 8, disable tab 33 center
  box "Máscaras de spam", 48, 115 30 90 95, tab 33
  edit "", 49, 120 40 80 10, tab 33 autohs
  list 50, 120 55 55 65, tab 33 size
  button "Añadir", 51, 180 64 20 15, tab 33
  button "Borrar", 52, 180 95 20 15, tab 33
  tab "DCC", 53
  button "Añadir a la lista", 56, 20 62 45 15, tab 53
  button "Borrar de la lista", 57, 20 95 45 15, tab 53
  edit "", 58, 75 40 85 10, tab 53 autohs
  list 59, 75 55 85 65, tab 53 size
  check "Rechazar virus:", 60, 20 30 50 10, tab 53
  check "Kickban en canales comunes a quien te envie un virus", 61, 20 125 145 10, tab 53
  button "Aceptar", 62, 30 145 40 15,ok default
  button "Créditos", 63, 150 145 40 15
}
on 1:dialog:confg:*:*: {
  if ($devent == init) { 
    _mdx.buttons_style 18 19 31 32 51 52 62 63
    var %i 1
    while ($gettok($confg_checks,%i,32)) {
      var %x $ifmatch
      did $iif($ri(dat\conf.ini,gen,%x) == on,-c,-u) $dname %x
      inc %i
    }
    %i = 1
    while ($gettok($confg_edits,%i,32)) {
      did -a $dname $ifmatch $ri(dat\conf.ini,gen,$ifmatch)
      inc %i
    }
    did -c $dname $ri(dat\conf.ini,gen,rad1)
    did -c $dname $ri(dat\conf.ini,gen,rad2)
    var %i 1
    while ($findfile(dat\autojoin,*.txt,%i)) {
      did -a $dname 22 $left($nopath($ifmatch),-4)
      inc %i
    }
    did -c $dname 22 1
    confg_loadlists
  }
  if ($devent == sclick) {
    if ($istok($confg_checks,$did,32) == $true) wi dat\conf.ini gen $did $iif($ri(dat\conf.ini,gen,$did) == on,off,on)
    if ($did == 12) || ($did == 13) wi dat\conf.ini gen rad1 $did
    if ($did == 23) || ($did == 26) wi dat\conf.ini gen rad2 $did
    if ($did == 22) confg_loadlists
    if ($did == 18) { write dat\snotices.txt $_R(Introduce la nueva máscara) | confg_loadlists }
    if ($did == 19) { write $+(-dl,$did($dname,17).sel) dat\snotices.txt | confg_loadlists }
    if ($did == 31) { write " $+ $+(dat\autojoin\,$did($dname,22),.txt) $+ " $did($dname,29) | did -r $dname 29 | confg_loadlists }
    if ($did == 32) { write $+(-dl,$did($dname,30).sel) " $+ $+(dat\autojoin\,$did($dname,22),.txt) $+ " | confg_loadlists } 
    if ($did == 51) { write dat\antispam.txt $did($dname,49) | did -r $dname 49 | confg_loadlists }
    if ($did == 52) { write $+(-dl,$did($dname,50).sel) dat\antispam.txt | confg_loadlists } 
    if ($did == 56) { write dat\virusdata.txt $did($dname,58) | did -r $dname 58 | confg_loadlists }
    if ($did == 57) { write $+(-dl,$did($dname,59).sel) dat\virusdata.txt | confg_loadlists } 
    if ($did == 62) antispam_timer
    if ($did == 63) about
  }
  if ($devent == edit) && ($istok($confg_edits,$did,32) == $true) { writeini dat\conf.ini gen $did $did($dname,$did) }
  did $iif($did($dname,29),-e,-b) $dname 31
  did $iif($did($dname,49),-e,-b) $dname 51
  did $iif($did($dname,58),-e,-b) $dname 56

  did $iif($did($dname,17).sel,-e,-b) $dname 19
  did $iif($did($dname,30).sel,-e,-b) $dname 32
  did $iif($did($dname,50).sel,-e,-b) $dname 52
  did $iif($did($dname,59).sel,-e,-b) $dname 57

}
alias confg_edits return 25 44 46
alias confg_checks return 4 5 6 8 9 10 28 38 39 40 41 42 60 61
alias confg_loadlists {
  did -r $dname 17,30,50,59
  loadbuf -o $dname 17 dat\snotices.txt
  loadbuf -o $dname 50 dat\antispam.txt
  loadbuf -o $dname 59 dat\virusdata.txt
  loadbuf -o $dname 30 " $+ $+(dat\autojoin\,$did($dname,22),.txt) $+ "
}

;*************************************
; Eventos y opciones
;
;*************************************
on 1:start: { antispam_timer }
alias antispam_timer {
  .timeraspam off
  .timeraspam 0 $ri(dat\conf.ini,gen,44) set %antispam 0

}
on 1:kick:#: { if ($me == $knick) && ($me != $nick) && ($ri(dat\conf.ini,gen,4) == on) join $chan }
on 1:text:*:#: { if ($istok($strip($1-),$me,32)) && ($chan != $active) { display nombrado $chan $nick $1- } }
alias snotices_window { if ($ri(dat\conf.ini,gen,rad1) == 12) return echo -ts | else { if (!$window(@snotices)) window @snotices | return echo -t @snotices } } 
alias snotices_filter {
  var %i 1
  var %x $strip($1-)
  while (%i <= $lines(dat\snotices.txt)) {
    if ($rl(dat\snotices.txt,%i) iswm %x) return $true
    inc %i
  }
  return $false
}
menu @snotices {
  &borrar:clear $active
  -
  &cerrar:window -c $active
}
on 1:connect: {
  if ($ri(dat\conf.ini,gen,28) == on) && ($right($ae_canales,-1)) {
    if ($ri(dat\conf.ini,gen,rad2) == 23)  {
      .timerae 1 $ri(dat\conf.ini,gen,25) ae_entrar
      display echo Autojoin: entrando en los canales: $right($ae_canales,-1) en $duration($ri(dat\conf.ini,gen,25)) $+ . Para evitarlo teclea /timerae off.
    }
    elseif ($_p(Deseas entrar en éstos canales: $right($ae_canales,-1)) == $true) ae_entrar 
  }
}
alias ae_entrar {
  if ($server) {
    var %i 1
    while ($gettok($right($ae_canales,-1),%i,44)) {
      join $ifmatch
      inc %i
    }
  }
}
alias ae_canales {
  var %i 1
  var %x
  if (*.irc-hispano.org iswm $server) {
    while (%i <= $lines(dat\autojoin\IRC Hispano.txt)) {
      %x = %x $+ , $+ $rl("dat\autojoin\IRC Hispano.txt",%i)
      inc %i
    }
    return %x
  }
  if (*.dal.net iswm $server) {
    while (%i <= $lines(dat\autojoin\Dal Net.txt)) {
      %x = %x $+ , $+ $rl("dat\autojoin\Dal Net.txt",%i)
      inc %i
    }
    return %x
  }
  if (*.undernet.org iswm $server) {
    while (%i <= $lines(dat\autojoin\Undernet.txt)) {
      %x = %x $+ , $+ $rl("dat\autojoin\Undernet.txt",%i)
      inc %i
    }
    return %x
  }
  if (*.anillo.adm iswm $server) {
    while (%i <= $lines(dat\autojoin\terra.txt)) {
      %x = %x $+ , $+ $rl("dat\autojoin\terra.txt",%i)
      inc %i
    }
    return %x
  }
  else {
    while (%i <= $lines(dat\autojoin\Default.txt)) {
      %x = %x $+ , $+ $rl("dat\autojoin\Default.txt",%i)
      inc %i
    }
    return %x
  }
}
alias antivirus {
  var %i 1
  while (%i <= $lines(dat\virusdata.txt)) {
    if ($rl(dat\virusdata.txt,%i) iswm $1) return $true
    inc %i
  }
  return $false
}
alias spamtest {
  var %i 1
  while (%i <= $lines(dat\antispam.txt)) {
    if ($rl(dat\antispam.txt,%i) iswm $1) return $true
    inc %i
  }
  return $false
}
alias antispam {
  display echo Antispam: bloqueado anuncio de $1 ( $+ $2 $+ )
  if (%antispam <= $ri(dat\conf.ini,gen,44)) && ($ri(dat\conf.ini,gen,42) == on) {
    .notice $1 $_version (antispam: tu publicidad ha sido bloqueada)  $+ $_web $+ 
  }
}
