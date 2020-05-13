;*************************************
; PS-Trivial adaptado al backbeat
;
; Cedido por ^MoRpH-x^ (dasoul@iname.com) 
;
;     - http://www.kalendas.net -
;
;*************************************

alias -l ps.rc { return $replace($1-,^!B,,^!U,,^!K,,^!O,,^!R,) }
alias -l ps.wc { return $replace($1-,,^!B,,^!U,,^!K,,^!O,,^!R) }
alias -l _ps.rini { var %psrc = $readini($+(",$mircdirPstrivial\config.ini,"),n,cfg,$1) | return $ps.rc(%psrc) }
alias -l _ps.wini { writeini $+(",$mircdirPstrivial\config.ini,") cfg $1 $ps.wc($2-) }

alias pstrivial {
  if ($dialog(pstrivial)) { dialog -v pstrivial }
  else {
    if (!$isdir($+(",$mircdirPstrivial,"))) { .mkdir $+(",$mircdirPstrivial,") }
    if (!$isfile($+(",$mircdirPstrivial\config.ini,"))) { ps.decfg | if ($isfile($+(",$scriptdir\general.txt,"))) { .rename $+(",$scriptdir\general.txt,") $+(",$mircdirPstrivial\general.txt,") } }
    dialog -md pstrivial pstrivial | did -a pstrivial 2 #
  }
}

alias -l ps.decfg {
  _ps.wini publi 0,6 PS-Trivial  Va a comenzar una partida de Trivial en #canal y estais todos invitados!
  _ps.wini publidd 1
  _ps.wini dir $mircdirPstrivial\
  _ps.wini mezcla 1
  _ps.wini set general.txt
  _ps.wini preguntas 30
  _ps.wini puntos 20
  _ps.wini pistas 1
  _ps.wini nonstop 0
  _ps.wini ban 0
  _ps.wini reset 1
  _ps.wini time 25
  _ps.wini 1 0,2 PS-Trivial  Ha comenzado la partida. El límite de preguntas es 02+limite+. Se gana al alcanzar 02+puntos+ puntos. Tiempo entre preguntas: 02+tiempo+ segs.
  _ps.wini 2 2PS-Trivial Se acabó la partida. Clasificación: +clasific+
  _ps.wini 3 5Pregunta> +pregunta+ 5(+palabras+ pal.)
  _ps.wini 4 5Se acabó el tiempo!. La respuesta era: +respuesta+
  _ps.wini 5 02+nick+ acertó y gana +gana+ puntos. La respuesta era: +respuesta+
  _ps.wini 6 Clasificación actual: +clasific+
  _ps.wini 7 5Una PISTA: +pista+
  _ps.wini 8 1,1 0,14 PS-Trivial Pregunta nº: +num+/+limite+ - Tema: +tema+ - Autor: +autor+ 1,1 
}

dialog pstrivial {
  title PS-Trivial v1.0 by ^MoRpH-x^
  size -1 -1 150 165
  option dbu
  box "", 111, -3 -3 200 4
  tab "Activar", 100, 5 5 140 135
  tab "Configurar", 200
  tab "Theme", 300
  tab "Top 6", 400
  text "Canal:", 1, 15 32 15 10, tab 100
  edit "" 2, 34 30 55 11, autohs, drop tab 100
  check "Activar", 3, 92 30 32 11, push, tab 100
  check "P", 53, 124 30 10 11, push, disable, tab 100
  check "Partida contínua (al acabar una empieza otra)", 4, 15 45 120 8, tab 100
  check "Resetear clasificacion al empezar la partida", 52, 15 56 120 8, tab 100
  box "", 5, 10 20 130 51, tab 100
  text "Mensaje del botón Anunciar:", 6, 15 98 70 7, tab 100
  edit "", 7, 15 105 120 11, autohs, tab 100
  text "Banear del Trivial los nicks (separa con espacios):", 50, 15 77 120 7, tab 100
  edit "", 51, 15 84 120 11, autohs, tab 100
  radio "A todos los canales", 60, 20 118 60 15, tab 100
  radio "Al canal activo", 61, 85 118 50 15, tab 100
  ;
  box "Sets de preguntas", 8, 15 26 120 40, tab 200
  edit "", 9, 20 35 60 11, read, autohs, tab 200
  button "dir", 10, 80 35 15 11, tab 200
  combo 11, 21 48 74 60, sort, drop, tab 200
  check "Hacer", 12, 99 35 30 10, tab 200
  text "preguntas de todos los sets", 13, 99 43 40 40, tab 200
  box "Acabar Trivial al llegar a alguno de estos limites", 14, 15 69 120 25, tab 200
  text "Preguntas:", 15, 30 81 25 10, tab 200
  edit "", 16, 58 79 14 11, limit 3, tab 200
  text "Puntos:", 17, 82 81 20 10, tab 200
  edit "", 18, 103 79 14 11, limit 3, tab 200
  text "Pistas:", 19, 20 100 15 10, tab 200
  radio "Nivel 0", 20, 42 99 30 10, tab 200
  radio "Nivel 1", 21, 72 99 30 10, tab 200
  radio "Nivel 2", 22, 102 99 30 10, tab 200
  box "", 23, 15 90 120 24, tab 200
  box "", 24, 15 110 120 20, tab 200
  text "Tiempo para responder, en segs:", 25, 20 118 90 10, tab 200
  edit "", 26, 103 116 14 11, limit 2, tab 200
  ;
  text "Comienzo:", 30, 15 30 25 10, right, tab 300
  edit "", 31, 42 28 92 11, autohs, tab 300
  text "Fin:", 32, 15 40 25 10, right, tab 300
  edit "", 33, 42 38 92 11, autohs, tab 300
  text "Pregunta:", 34, 15 50 25 10, right, tab 300
  edit "", 35, 42 48 92 11, autohs, tab 300
  text "Tiempo!:", 36, 15 60 25 10, right, tab 300
  edit "", 37, 42 58 92 11, autohs, tab 300
  text "Acierto:", 38, 15 70 25 10, right, tab 300
  edit "", 39, 42 68 92 11, autohs, tab 300
  text "Clasifica:", 40, 15 80 25 10, right, tab 300
  edit "", 41, 42 78 92 11, autohs, tab 300
  text "Pista:", 42, 15 90 25 10, right, tab 300
  edit "", 43, 42 88 92 11, autohs, tab 300
  text "Estado:", 44, 15 100 25 10, right, tab 300
  edit "", 45, 42 98 92 11, autohs, tab 300
  box "", 46, 15 110 120 20, tab 300
  button "Restaurar", 47, 19 116 35 11, tab 300
  button "Cargar", 48, 57 116 35 11, tab 300
  button "Guardar", 49, 95 116 35 11, tab 300
  ;
  text "Posición             Nick                   Puntos", 64, 20 35 120 10, tab 400
  text "-1-", 65, 26 48 15 11, tab 400
  text "-2-", 66, 26 60 15 11, tab 400
  text "-3-", 67, 26 72 15 11, tab 400
  text "-4-", 68, 26 84 15 11, tab 400
  text "-5-", 69, 26 96 15 11, tab 400
  text "-6-", 70, 26 108 15 11, tab 400
  text "-", 71, 48 48 35 11, center, tab 400
  text "0", 72, 90 48 35 11, center, tab 400
  text "-", 73, 48 60 35 11, center, tab 400
  text "0", 74, 90 60 35 11, center, tab 400
  text "-", 75, 48 72 35 11, center, tab 400
  text "0", 76, 90 72 35 11, center, tab 400
  text "-", 77, 48 84 35 11, center, tab 400
  text "0", 78, 90 84 35 11, center, tab 400
  text "-", 79, 48 96 35 11, center, tab 400
  text "0", 80, 90 96 35 11, center, tab 400
  text "-", 81, 48 108 35 11, center, tab 400
  text "0", 82, 90 108 35 11, center, tab 400
  button "Resetear", 85, 15 121 120 11, tab 400
  ;
  ;
  box "", 90, 10 20 130 115
  button "Anunciar", 91, 10 145 40 12
  button "Cerrar", 92, 100 145 40 12, cancel
  text "<Preguntas>", 93, 60 144 32 10
  text "0/0", 94, 60 152 30 10, center
}

on *:dialog:pstrivial:*:*: {
  if ($devent == init) {
    if ($_ps.rini(publi)) { did -a pstrivial 7 $ifmatch }
    if ($_ps.rini(publidd) == 1) { did -c pstrivial 60 } | else { did -c pstrivial 61 }
    if ($_ps.rini(ban)) { did -a pstrivial 51 $ifmatch }
    if ($_ps.rini(dir)) { did -a pstrivial 9 $ifmatch } | else { did -a pstrivial 9 $mircdirPstrivial\ }
    did $iif($_ps.rini(mezcla) == 1,-c,-u) pstrivial 12 | ps.ponsets $+(",$did(9),") | did $iif($_ps.rini(nonstop) == 1,-c,-u) pstrivial 4 | did $iif($_ps.rini(reset) == 1,-c,-u) pstrivial 52
    did -c pstrivial 11 $didwm(pstrivial,11,$_ps.rini(set)) | if (!$did(11)) { did -c pstrivial 11 1 } | ps.ponlines
    if ($_ps.rini(preguntas)) { did -o pstrivial 16 1 $ifmatch } | if ($_ps.rini(puntos)) { did -o pstrivial 18 1 $ifmatch }
    did -c pstrivial $iif(!$calc(20 + $_ps.rini(pistas)),20,$calc(20 + $_ps.rini(pistas)))
    if ($_ps.rini(time)) { did -a pstrivial 26 $ifmatch } | else { did -a pstrivial 26 25 }
    if ($_ps.rini(1)) { did -a pstrivial 31 $ifmatch } | if ($_ps.rini(2)) { did -a pstrivial 33 $ifmatch } | if ($_ps.rini(3)) { did -a pstrivial 35 $ifmatch } | if ($_ps.rini(4)) { did -a pstrivial 37 $ifmatch }
    if ($_ps.rini(5)) { did -a pstrivial 39 $ifmatch } | if ($_ps.rini(6)) { did -a pstrivial 41 $ifmatch } | if ($_ps.rini(7)) { did -a pstrivial 43 $ifmatch } | if ($_ps.rini(8)) { did -a pstrivial 45 $ifmatch }
    ps.pontop
  }
  if (($devent == edit) && ($did == 51)) { _ps.wini ban $iif($did(51),$ifmatch,0) | unset %_pst.ban.* }
  if ($devent == sclick) {
    if (($did == 3) && ($did(2) ischan)) { if ($did(3).state == 0) { pstrivi -off | did -o pstrivial 3 1 Activar } | else { pstrivi -on $did(2) | did -o pstrivial 3 1 Desactivar } }
    if ($did == 4) { _ps.wini nonstop $iif($did(4).state == 1,1,0) }
    if ($did == 52) { _ps.wini reset $iif($did(52).state == 1,1,0) }
    if ($did isnum 20-22) { if ($did(20).state == 1) { _ps.wini pistas 0 } | if ($did(21).state == 1) { _ps.wini pistas 1 } | if ($did(22).state == 1) { _ps.wini pistas 2 } }
    if ($did == 10) { did -o pstrivial 9 1 $$sdir($did(9),¿Directorio conteniendo los SETS de preguntas?) | ps.ponsets $did(9) }
    if ($did == 11) { ps.ponlines }
    if ($did == 47) { ps.theme.def }
    if ($did == 48) { ps.theme.load $$sfile(*.pst,Escoge el theme,Cargar) }
    if ($did == 49) { ps.theme.save $$sfile(*.pst,Escribe un nombre para el theme,Guardar) }
    if ($did == 53) { if ($did(53).state == 1) { ps.timerspr -p } | else { ps.timerspr -r } }
    if ($did == 85) { remini $+(",$mircdirPstrivial\config.ini,") top | if ($window(@pst++)) { window -c @pst++ } | ps.pontop }
    if (($did == 91) && ($did(7))) {
      if ($did(60).state == 1) { amsg $replace($did(7),&canal,$did($dname,2)) }
      else { if ($active ischan) { msg $active $did(7) } }
    }
    if ($did == 92) { pstrivi -off }
  }
}

alias -l ps.savedata {
  if ($did(pstrivial,7)) { _ps.wini publi $ifmatch } | _ps.wini publidd $iif($did(pstrivial,60).state == 1,1,2) | _ps.wini ban $iif($did(pstrivial,51),$ifmatch,0) | unset %_pst.ban.* | if ($did(pstrivial,26)) { _ps.wini time $ifmatch }
  if ($did(pstrivial,9)) { _ps.wini dir $remove($ifmatch,$chr(32)) } | if ($did(pstrivial,11)) { _ps.wini set $ifmatch }
  _ps.wini mezcla $iif($did(pstrivial,12).state == 1,1,0) | _ps.wini nonstop $iif($did(pstrivial,4).state == 1,1,0) | _ps.wini reset $iif($did(pstrivial,52).state == 1,1,0)
  if ($did(pstrivial,16)) { _ps.wini preguntas $ifmatch } | if ($did(pstrivial,18)) { _ps.wini puntos $ifmatch }
  if ($did(pstrivial,20).state == 1) { _ps.wini pistas 0 } | if ($did(pstrivial,21).state == 1) { _ps.wini pistas 1 } | if ($did(pstrivial,22).state == 1) { _ps.wini pistas 2 }
  if ($did(pstrivial,31)) { _ps.wini 1 $ifmatch } | if ($did(pstrivial,33)) { _ps.wini 2 $ifmatch } | if ($did(pstrivial,35)) { _ps.wini 3 $ifmatch } | if ($did(pstrivial,37)) { _ps.wini 4 $ifmatch }
  if ($did(pstrivial,39)) { _ps.wini 5 $ifmatch } | if ($did(pstrivial,41)) { _ps.wini 6 $ifmatch } | if ($did(pstrivial,43)) { _ps.wini 7 $ifmatch } | if ($did(pstrivial,45)) { _ps.wini 8 $ifmatch }
}

alias -l ps.timerspr {
  var %q = $1 | .timer_PST %q | .timer_PSTR %q | .timer_PSTN %q | .timer_PSTP %q | .timer_PSTS %q
  if (%q == -p) { .disable #pstrivial | msg %_pst.chan Trivial pausado! | if ($ps.top(1)) { msg %_pst.chan $^ttheme(6) } }
  if (%q == -r) { .enable #pstrivial | msg %_pst.chan Trivial reactivado }
}

alias -l ps.ponlines { did -o pstrivial 94 1 $iif(($lines( [ [ $did(pstrivial,9) ] $+ [ $did(pstrivial,11) ] ] ) == $null),0,$lines( [ [ $did(pstrivial,9) ] $+ [ $did(pstrivial,11) ] ] )) $+ / $+ %_psetsl }
alias -l ps.ponsets {
  did -r pstrivial 11 | var %i = 1 | set %_psetsl 0
  while ($findfile($1-,*.txt,%i,1,var %qtxt = $1-)) { did -a pstrivial 11 $nopath(%qtxt) | inc %_psetsl $lines(%qtxt) | inc %i }
  if (!$did(pstrivial,11)) { did -c pstrivial 11 1 }
  if ($did(pstrivial,11).lines < 2) { did -u pstrivial 12 | did -b pstrivial 12 } | else { did -e pstrivial 12 }
  ps.ponlines
}
alias -l ps.pontop {
  if (!$ini($+(",$mircdirPstrivial\config.ini,"),top)) { %id = 71 | while (%id < 82) { did -o pstrivial %id 1 - | did -o pstrivial $calc(%id + 1) 1 0 | inc %id 2 } }
  var %i = 1, %id = 71 | while ($readini($+(",$mircdirPstrivial\config.ini,"),n,top,%i)) { var %ifm = $ifmatch | did -o pstrivial %id 1 $gettok(%ifm,2,44) | did -o pstrivial $calc(%id + 1) 1 $gettok(%ifm,1,44) | inc %i | inc %id 2 }
}
alias ps.top { if (!$1) { return } | var %pt = $readini($+(",$mircdirPstrivial\config.ini,"),n,top,$1) | if (%pt) { return $gettok(%pt,2,44) $+ ( $+ $gettok(%pt,1,44) $+ ) } }

alias _psort {
  if ($gettok($1,1,44) > $gettok($2,1,44)) { return -1 }
  if ($gettok($1,1,44) < $gettok($2,1,44)) { return 1 }
  else { return 0 }
}
alias ps.points {
  if (!$window(@pst++)) { window -hl @pst++ | var %i = 1 | while ($readini($+(",$mircdirPstrivial\config.ini,"),n,top,%i)) { aline -l @pst++ $ifmatch | inc %i } } | if ($1 == -x) { return }
  var %i = 1 | while ($line(@pst++,%i)) { if ($gettok($ifmatch,2,44) == $1) { var %pstl = $line(@pst++,%i) | dline @pst++ %i | aline -l @pst++ $calc($gettok(%pstl,1,44) + $2) $+ , $+ $1 | break } | inc %i }
  if (!%pstl) { aline -l @pst++ $2 $+ , $+ $1 } | filter -awwclL @pst++ @pst++ _psort *
  var %i = 1 | while ($line(@pst++,%i)) { writeini $+(",$mircdirPstrivial\config.ini,") top %i $ifmatch | inc %i | if (%i > 6) { break } }
  ps.pontop
}

alias -l ps.theme.def {
  did -o pstrivial 31 1 BACKBEAT-Trivial Ha comenzado la partida. El límite de preguntas es +limite+. Se gana al alcanzar +puntos+ puntos. Tiempo entre preguntas: +tiempo+ segs.
  did -o pstrivial 33 1 BACKBEAT-Trivial Se acabó la partida. Clasificación: +clasific+
  did -o pstrivial 35 1 Pregunta> +pregunta+ (+palabras+ pal.)
  did -o pstrivial 37 1 Se acabó el tiempo!. La respuesta era: +respuesta+
  did -o pstrivial 39 1 +nick+ acertó y gana +gana+ puntos. La respuesta era: +respuesta+
  did -o pstrivial 41 1 Clasificación actual: +clasific+
  did -o pstrivial 43 1 Una PISTA: +pista+
  did -o pstrivial 45 1 BACKBEAT - Trivial Pregunta nº: +num+/+limite+ - Tema: +tema+ - Autor: +autor+
}
alias -l ps.theme.load {
  var %tfile = $shortfn($1-), %i = 1, %n = 31
  if (!$ini(%tfile,theme)) { echo $color(kick) -at > Este no parece ser un archivo theme para el Trivial. | return }
  while ($readini(%tfile,n,theme,%i)) { did -o pstrivial %n 1 $ps.rc($ifmatch) | inc %i | inc %n 2 }
}
alias -l ps.theme.save {
  var %tfile = " $+ $1- $+ ", %i = 1, %n = 31
  while ($did(pstrivial,%n)) { writeini %tfile theme %i $ps.wc($ifmatch) | if (%n == 45) { break } | inc %i | inc %n 2 }
  echo $color(info) -at > Theme correctamente guardado a $1-
}
alias -l ^ttheme {
  var %xtx = $_ps.rini($1) | goto $1
  :1 | return $replace(%xtx,+limite+,$_ps.rini(preguntas),+puntos+,$_ps.rini(puntos),+tiempo+,$_ps.rini(time))
  :2 | return $replace(%xtx,+clasific+,$iif($ps.top(1),$ifmatch,-ninguna-) $ps.top(2) $ps.top(3) $ps.top(4) $ps.top(5) $ps.top(6))
  :3 | return $replace(%xtx,+pregunta+,$2,+palabras+,$3)
  :4 | return $replace(%xtx,+respuesta+,$2)
  :5 | return $replace(%xtx,+nick+,$2,+gana+,$3,+respuesta+,$4)
  :6 | return $replace(%xtx,+clasific+,$ps.top(1) $ps.top(2) $ps.top(3) $ps.top(4))
  :7 | return $replace(%xtx,+pista+,$2)
  :8 | inc %_pst.n | return $replace(%xtx,+num+,%_pst.n,+limite+,$_ps.rini(preguntas),+tema+,$2,+autor+,$3)
}

alias -l pstrivi {
  if ($1 == -on) {
    ps.savedata | .enable #pstrivial | set %_pst.chan $2 | unset %_pst.n | did -e pstrivial 53 | did -u pstrivial 53
    if ($_ps.rini(reset) == 1) { remini $+(",$mircdirPstrivial\config.ini,") top | ps.pontop }
    window -c @pst++ | var %i = $window(@pst-*,0) | while ($window(@pst-*,%i)) { window -c $ifmatch | dec %i }
    if ($_ps.rini(mezcla) == 1) { var %i = 1 | while ($did(pstrivial,11,%i).text) { var %ifmb = " $+ $_ps.rini(dir) $+ $ifmatch $+ " | var %ifmw = @pst- $+ $remove($nopath(%ifmb),$chr(32)) | window -hls %ifmw | loadbuf %ifmw %ifmb | inc %i } }
    else { var %ifmb = " $+ $_ps.rini(dir) $+ $did(pstrivial,11).seltext $+ " | var %ifmw = @pst- $+ $remove($nopath(%ifmb),$chr(32)) | window -hls %ifmw | loadbuf %ifmw %ifmb | if ($line(%ifmw,0) < $_ps.rini(preguntas)) { did -o pstrivial 16 1 $line(%ifmw,0) | _ps.wini preguntas $line(%ifmw,0) } }
    msg %_pst.chan $^ttheme(1) | ps.points -x | ps.pregunta
  }
  if ($1 == -off) {
    ps.savedata | .disable #pstrivial
    if (%_pst.chan ischan) { msg %_pst.chan $^ttheme(2) } | unset %_pst.* %_psetsl | did -b pstrivial 53 | did -u pstrivial 53
    var %i = $window(@pst-*,0) | while ($window(@pst-*,%i)) { window -c $ifmatch | dec %i }
    window -c @pst++ | .timer_PST* off
  }
}

alias -l ps.pregunta {
  if ($me !ison %_pst.chan) { echo $color(kick) -a [?] No te encuentras en el canal %_pst.chan y el trivial no puede continuar. Esperando a que reentres o desactives el trivial... | .timer_PSTR -o 1 5 ps.pregunta | return }
  if ((%_pst.n >= $_ps.rini(preguntas)) || ($gettok($line(@pst++,1),1,44) >= $_ps.rini(puntos))) {
    pstrivi -off | did -u pstrivial 3 | did -o pstrivial 3 1 Activar
    if ($_ps.rini(nonstop) == 1) { .timer_PSTN 1 $calc($_ps.rini(time) + 5) pstrivi -on $did(pstrivial,2) | did -c pstrivial 3 | did -o pstrivial 3 1 Desactivar }
    return
  }
  if ($_ps.rini(mezcla) == 1) {
    var %ri = 1 | :pw | var %pstw = $window(@pst-*,$rand(1,$window(@pst-*,0)))
    if ($line(%pstw,0) < 1) {
      if (%ri > 5) {
        pstrivi -off | did -u pstrivial 3 | did -o pstrivial 3 1 Activar
        if ($_ps.rini(nonstop) == 1) { .timer_PSTN 1 $calc($_ps.rini(time) + 5) pstrivi -on $did(pstrivial,2) | did -c pstrivial 3 | did -o pstrivial 3 1 Desactivar }
        return
      }
      inc %ri | goto pw
    }
  }
  else { var %pstw = $window(@pst-*,1) }
  var %pstr = $rand(1,$line(%pstw,0)), %pstl = $line(%pstw,%pstr) | dline %pstw %pstr | set %_pst.resp $gettok(%pstl,2,42)
  var %pstq = $gettok($gettok(%pstl,1,42),2,171) | if ($right(%pstq,1) != ?) { var %pstq = %pstq $+ ? }
  unset %_pst.pista | msg %_pst.chan $^ttheme(8,$gettok(%pstl,1,169),$gettok($gettok(%pstl,1,171),2,169)) | msg %_pst.chan $^ttheme(3,%pstq,$numtok(%_pst.resp,32))
  if ($_ps.rini(pistas) isnum 1-2) { .timer_PSTP 1 $calc(($_ps.rini(time) / 3) * 2) ps.pista $_ps.rini(pistas) }
  .timer_PSTS 1 $_ps.rini(time) ps.respuesta
  .timer_PST 1 $calc($_ps.rini(time) + 8) ps.pregunta
}

alias -l ps.pista {
  set %_pst.pista @ | goto $1
  :1 | var %i = 1
  while ($gettok(%_pst.resp,%i,32)) { var %ifm = $ifmatch, %pstp = %pstp $+ $left(%ifm,1) $str( _ ,$len($right(%ifm,-1))) $iif($gettok(%_pst.resp,$calc(%i + 1),32),   ) | inc %i }
  msg %_pst.chan $^ttheme(7,%pstp) | return
  :2 | var %i = 1
  while ($gettok(%_pst.resp,%i,32)) {
    var %ifm = $ifmatch, %pstp = $left(%ifm,1), %pstt = $right(%ifm,-1), %ii = 1, %pstot
    while ($mid(%pstt,%ii,1)) { var %pstl = $ifmatch | if (!$istok(a.e.i.o.u,%pstl,46)) { var %pstot = %pstot $+  _  } | else { var %pstot = %pstot $+ %pstl $+   } | inc %ii }
    var %pstotal = %pstotal $+ %pstp %pstot $+ $iif($gettok(%_pst.resp,$calc(%i + 1),32),   )
    inc %i
  }
  msg %_pst.chan $^ttheme(7,%pstotal)
}

alias -l ps.respuesta {
  msg %_pst.chan $^ttheme(4,%_pst.resp) | unset %_pst.resp %_pst.pista
  if ($ps.top(1)) { msg %_pst.chan $^ttheme(6) }
}

#pstrivial off
on *:TEXT:*:%_pst.chan: {
  if (($len(%_pst.resp)) && ($replace(%_pst.resp,á,a,Á,a,é,e,É,e,í,i,Í,i,ó,o,Ó,o,ú,u,Ú,u) isin $replace($strip($1-),á,a,Á,a,é,e,É,e,í,i,Í,i,ó,o,Ó,o,ú,u,Ú,u))) {
    if ($istok($_ps.rini(ban),$nick,32)) { if ([ !%_pst.ban. [ $+ [ $nick ] ] ]) { set -u30 %_pst.ban. [ $+ [ $nick ] ] @ | .notice $nick 4Lo siento $nick $+ , estás baneado de mi Trivial. } | return }
    .timer_PSTP off | .timer_PSTS off | .timer_PST off | ps.points $nick $iif(%_pst.pista,2,3)
    msg %_pst.chan $^ttheme(5,$nick,$iif(%_pst.pista,2,3),%_pst.resp) | msg %_pst.chan $^ttheme(6)
    unset %_pst.resp %_pst.pista | .timer_PST 1 8 ps.pregunta
  }
}

on *:INPUT:%_pst.chan: {
  if (($len(%_pst.resp)) && ($replace(%_pst.resp,á,a,Á,a,é,e,É,e,í,i,Í,i,ó,o,Ó,o,ú,u,Ú,u) isin $replace($strip($1-),á,a,Á,a,é,e,É,e,í,i,Í,i,ó,o,Ó,o,ú,u,Ú,u))) {
    .timer_PSTP off | .timer_PSTS off | .timer_PST off | ps.points $me $iif(%_pst.pista,2,3) | if (!$halted) { msg %_pst.chan $1- }
    .timer -m 1 300 msg %_pst.chan $^ttheme(5,$me,$iif(%_pst.pista,2,3),%_pst.resp) | .timer -m 1 350 msg %_pst.chan $^ttheme(6)
    unset %_pst.resp %_pst.pista | .timer_PST 1 8 ps.pregunta | halt
  }
}
#pstrivial end




on *:start: { _ps.wini dir $mircdirPstrivial\ }
