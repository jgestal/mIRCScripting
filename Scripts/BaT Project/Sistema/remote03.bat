alias floodconf dialog -m cch cch
dialog cch {
  title "BaT: Protecciones de flood en canales [/floodconf]"
  size -1 -1 240 195
  option dbu
  text "Configuración para el canal:",1,5 5 70 10

  combo 2,75 3 70 100,drop
  button "&Añadir",3,150 3 30 10
  button "&Borrar",4,185 3 30 10,disable
  box "",5,-10 15 290 155

  tab "Text Flood",6,5 20 230 145

  check "Flood de Texto:",7,10 40 50 10,tab 6
  combo 8,60 40 40 50,drop tab 6
  edit "",9,105 40 30 10,center tab 6
  text "caracteres en:",10,140 42 35 10,center tab 6
  edit "",11,180 40 30 10,center tab 6
  text "seg(s)",12,215 42 15 10,tab 6
  text "Castigo:",13,35 55 20 10,tab 6
  combo 14,60 55 60 50,drop tab 6
  text "de",15,125 57 10 10,tab 6
  edit "",16,135 55 30 10,center tab 6
  text "seg(s)",17,170 57 15 10,tab 6

  check "Flood de Lineas:",18,10 70 50 10,tab 6
  combo 19,60 70 40 50,drop tab 6
  edit "",20,105 70 30 10,center tab 6
  text "lineas en:",21,140 72 35 10,center tab 6
  edit "",22,180 70 30 10,center tab 6
  text "seg(s)",23,215 72 15 10,tab 6
  text "Castigo:",24,35 85 20 10,tab 6
  combo 25,60 85 60 50,drop tab 6
  text "de",26,125 87 10 10,tab 6
  edit "",27,135 85 30 10,center tab 6
  text "seg(s)",28,170 87 15 10,tab 6

  check "Flood de Reps:",29,10 100 50 10,tab 6
  combo 30,60 100 40 50,drop tab 6
  edit "",31,105 100 30 10,center tab 6
  text "reps en:",32,140 102 35 10,center tab 6
  edit "",33,180 100 30 10,center tab 6
  text "seg(s)",34,215 102 15 10,tab 6
  text "Castigo:",35,35 115 20 10,tab 6
  combo 36,60 115 60 50,drop tab 6
  text "de",37,125 117 10 10,tab 6
  edit "",38,135 115 30 10,center tab 6
  text "seg(s)",39,170 117 15 10,tab 6

  text "Inmunidad. No castigar por flood en los siguientes casos:",40,10 130 220 10,center tab 6
  check "Ops Inmunes", 41, 35 145 50 15, push tab 6 
  check "Voces Inmunes", 42, 155 145 50 15, push tab 6

  tab "Mode Flood",43

  check "Anti Mass-Deop:",44,10 40 50 10,tab 43
  combo 45,60 40 40 50,drop tab 43
  edit "",46,105 40 30 10,center tab 43
  text "deops en:",47,140 42 35 10,center tab 43
  edit "",48,180 40 30 10,center tab 43
  text "seg(s)",49,215 42 15 10,tab 43
  text "Castigo:",50,35 55 20 10,tab 43
  combo 51,60 55 60 50,drop tab 43
  text "de",52,125 57 10 10,tab 43
  edit "",53,135 55 30 10,center tab 43
  text "seg(s)",54,170 57 15 10,tab 43

  check "Anti Mass-Kick:",55,10 70 50 10,tab 43
  combo 56,60 70 40 50,drop tab 43
  edit "",57,105 70 30 10,center tab 43
  text "kicks en:",58,140 72 35 10,center tab 43
  edit "",59,180 70 30 10,center tab 43
  text "seg(s)",60,215 72 15 10,tab 43
  text "Castigo:",61,35 85 20 10,tab 43
  combo 62,60 85 60 50,drop tab 43
  text "de",63,125 87 10 10,tab 43
  edit "",64,135 85 30 10,center tab 43
  text "seg(s)",65,170 87 15 10,tab 43

  check "Anti Mass-Ban:",66,10 100 50 10,tab 43
  combo 67,60 100 40 50,drop tab 43
  edit "",68,105 100 30 10,center tab 43
  text "bans en:",69,140 102 35 10,center tab 43
  edit "",70,180 100 30 10,center tab 43
  text "seg(s)",71,215 102 15 10,tab 43
  text "Castigo:",72,35 115 20 10,tab 43
  combo 73,60 115 60 50,drop tab 43
  text "de",74,125 117 10 10,tab 43
  edit "",75,135 115 30 10,center tab 43
  text "seg(s)",76,170 117 15 10,tab 43

  check "Topic Flood:",77,10 130 50 10,tab 43
  combo 78,60 130 40 50,drop tab 43
  edit "",79,105 130 30 10,center tab 43
  text "topics en:",80,140 132 35 10,center tab 43
  edit "",81,180 130 30 10,center tab 43
  text "seg(s)",82,215 132 15 10,tab 43
  text "Castigo:",83,35 145 20 10,tab 43
  combo 84,60 145 60 50,drop tab 43
  text "de",85,125 147 10 10,tab 43
  edit "",86,135 145 30 10,center tab 43
  text "seg(s)",87,170 147 15 10,tab 43

  tab "Otros Flood",88

  check "Flood de Join:",89,10 40 50 10,tab 88
  combo 90,60 40 40 50,drop tab 88
  edit "",91,105 40 30 10,center tab 88
  text "entradas en:",92,140 42 35 10,center tab 88
  edit "",93,180 40 30 10,center tab 88
  text "seg(s)",94,215 42 15 10,tab 88
  text "Castigo:",95,35 55 20 10,tab 88
  combo 96,60 55 60 50,drop tab 88
  text "de",97,125 57 10 10,tab 88
  edit "",98,135 55 30 10,center tab 88
  text "seg(s)",99,170 57 15 10,tab 88

  check "Flood de Nicks:",100,10 70 50 10,tab 88
  combo 101,60 70 40 50,drop tab 88
  edit "",102,105 70 30 10,center tab 88
  text "nicks en:",103,140 72 35 10,center tab 88
  edit "",104,180 70 30 10,center tab 88
  text "seg(s)",105,215 72 15 10,tab 88
  text "Castigo:",106,35 85 20 10,tab 88
  combo 107,60 85 60 50,drop tab 88
  text "de",108,125 87 10 10,tab 88
  edit "",109,135 85 30 10,center tab 88
  text "seg(s)",110,170 87 15 10,tab 88

  check "Flood de CTCP:",111,10 100 50 10,tab 88
  combo 112,60 100 40 50,drop tab 88
  edit "",113,105 100 30 10,center tab 88
  text "ctcps en:",114,140 102 35 10,center tab 88
  edit "",115,180 100 30 10,center tab 88
  text "seg(s)",116,215 102 15 10,tab 88
  text "Castigo:",117,35 115 20 10,tab 88
  combo 118,60 115 60 50,drop tab 88
  text "de",119,125 117 10 10,tab 88
  edit "",120,135 115 30 10,center tab 88
  text "seg(s)",121,170 117 15 10,tab 88

  check "Otro Flood:",122,10 130 50 10,tab 88 hide
  combo 123,60 130 40 50,drop tab 88 hide
  edit "",124,105 130 30 10,center tab 88 hide
  text "notices en:",125,140 132 35 10,center tab 88 hide
  edit "",126,180 130 30 10,center tab 88 hide
  text "seg(s)",127,215 132 15 10,tab 88 hide
  text "Castigo:",128,35 145 20 10,tab 88 hide
  combo 129,60 145 60 50,drop tab 88 hide
  text "de",130,125 147 10 10,tab 88 hide
  edit "",131,135 145 30 10,center tab 88 hide
  text "seg(s)",132,170 147 15 10,tab 88 hide

  tab "KiCKs y Bans",133

  box "Razón de kick por Text Flood (En blanco razón aleatoria)",134,10 40 220 25,tab 133
  edit "",135,15 50 210 10,autohs tab 133

  box "Razón de kick por Mode Flood (En blanco razón aleatoria)",136,10 65 220 25,tab 133
  edit "",137,15 75 210 10,autohs tab 133 

  box "Razón de kick por Otros Flood (En blanco razón aleatoria)",138,10 90 220 25,tab 133 
  edit "",139,15 100 210 10,autohs tab 133 

  box "Mascara de ban por defecto",140,10 115 220 45,tab 133 

  text "Es la máscara que se baneará cuando un nick sobrepase el límite de flood permitido excepto en el join flood, que por razones obvias se baneará la ip.",141,15 125 200 15,tab 133
  combo 142,15 145 210 100,drop tab 133

  button "Desactivar Todas",143,10 175 70 15

  button "Activar Todas",144,85 175 70 15
  button "Aceptar",145,160 175 70 15,ok default
}
alias cch.read return $readini $cch.conf general $$1
alias cch.conf return $mircdirdat\channels\ $+ $did(cch,2,$did(cch,2).sel).text $+ .conf
alias cchw { 
  if ($1) writeini $cch.conf general $did $1-
  else remini $cch.conf general $did
}
alias cchw2 { 
  if ($2) writeini $cch.conf general $$1 $$2-
  else remini $cch.conf general $$1
}
on 1:dialog:cch:init:*: { %i = 1 | did -a cch 2 General
  while ($findfile(dat\channels\,#*.conf,%i)) { did -a cch 2 $remove($nopath($findfile(dat\channels\,#*.conf,%i)),.conf) | inc %i }
did -c cch 2 1 | cch.loadcombos_1 | cch.loadcombos_2 | cch.loadcombos_ban | cch.loadconf }
alias cch.delchan { if ($$?!="¿Estás seguro de querer borrar la configuración independiente del canal seleccionado en la lista?" == $true) {
    .remove " $+ $mircdirdat\channels\ $+ $cchac_compchan($did(cch,2,$did(cch,2).sel).text) $+ "
    did -r cch 2 | %i = 1 | did -a cch 2 General
    while ($findfile(dat\channels\,#*.conf,%i)) { did -a cch 2 $remove($nopath($findfile(dat\channels\,#*.conf,%i)),.conf) | inc %i }
did -c cch 2 1 | cch.loadconf } }
alias cch.putedits { %tmp.var = $readini dat\channels\chanconf.ini $did $did(cch,$did).sel
cchw $calc($did + 1) $gettok(%tmp.var,1,32) | cchw $calc($did + 1) $gettok(%tmp.var,2,32) }
on 1:dialog:cch:sclick:*: {
  if ($did == 2) cch.loadconf
  if ($did == 3) .timer -m 1 1 cchac
  if ($did == 4) .timer -m 1 1 cch.delchan
  if ($did == 143) { %i = 1
    while ($gettok($cch.checks,%i,32)) { cchw2 $gettok($cch.checks,%i,32) off
    inc %i }
  cch.loadconf }    
  if ($did == 144) { %i = 1
    while ($gettok($cch.checks,%i,32)) { cchw2 $gettok($cch.checks,%i,32) on | inc %i }
  cch.loadconf }    
  did $iif($did(cch,2).sel == 1,-b,-e) cch 4
  %i = 1
  while ($gettok($cch.checks,%i,32)) { if ($gettok($cch.combos_1,%i,32) == $did) && ($did(cch,$did).sel != 4) {
      %tmp.var = $readini $mircdirdat\channels\chanconf.ini $did $did(cch,$did).sel
      cchw2 $calc($did +1) $gettok(%tmp.var,1,32) | did -ra cch $calc($did +1) $gettok(%tmp.var,1,32)
      cchw2 $calc($did +3) $gettok(%tmp.var,2,32) | did -ra cch $calc($did +3) $gettok(%tmp.var,2,32)
    unset %tmp.var }
  inc %i }
  %i = 1
  while ($gettok($cch.checks,%i,32)) { if ($gettok($cch.checks,%i,32) == $did) cchw $iif($cch.read($did) == on,off,on)
  inc %i  }
  %i = 1
  while ($gettok($cch.combos_1,%i,32)) { if ($gettok($cch.combos_1,%i,32) == $did) cchw $did(cch,$did).sel
  inc %i }
  %i = 1
  while ($gettok($cch.combos_2,%i,32)) { if ($gettok($cch.combos_2,%i,32) == $did) cchw $did(cch,$did).sel
  inc %i }
  %i = 1 | cch.d_e | cch.combo_2_d_e 
  if ($did == 142) cchw $did(cch,$did).sel
}
alias cch.d_e { %i = 1
  while ($gettok($cch.d_e_c,%i,32)) { if ($cch.read($gettok($cch.d_e_c,%i,32)) == on) { did -e cch $cch.d_e_calcs($gettok($cch.d_e_c,%i,32)) | inc %i }
else { did -b cch $cch.d_e_calcs2($gettok($cch.d_e_c,%i,32)) | inc %i } } }
alias cch.c_2_d_edits return 16 27 38 53 64 75 86 98 109 120 131
alias cch.combo_2_d_e { %i = 1
  while ($gettok($cch.c_2_d_edits,%i,32)) {
    if ($cch.read($calc($gettok($cch.c_2_d_edits,%i,32) -9)) == on) { did $iif($cch.read($calc($gettok($cch.c_2_d_edits,%i,32) -2)) == 3,-e,-b) cch $calc($gettok($cch.c_2_d_edits,%i,32) -1) $+ , $+ $gettok($cch.c_2_d_edits,%i,32) $+ , $+ $calc($gettok($cch.c_2_d_edits,%i,32) +1)   }
inc %i } }
alias cch.d_e_calcs return $calc($1 +1) $+ , $+ $calc($1 +2) $+ , $+ $calc($1 +3) $+ , $+ $calc($1 +4) $+ , $+ $calc($1 +5) $+ , $+ $calc($1 +6) $+ , $+ $calc($1 +7) 
alias cch.d_e_calcs2 return $calc($1 +1) $+ , $+ $calc($1 +2) $+ , $+ $calc($1 +3) $+ , $+ $calc($1 +4) $+ , $+ $calc($1 +5) $+ , $+ $calc($1 +6) $+ , $+ $calc($1 +7) $+ , $+ $calc($1 +8) $+ , $+ $calc($1 +9) $+ , $+ $calc($1 +10)
alias cch.d_e_c return 7 18 29 44 55 66 77 89 100 111 122
on 1:dialog:cch:edit:*: { cch.edit $did | %i = 1
  while ($gettok($cch.e_1_,%i,32)) { if ($did == $gettok($cch.e_1_,%i,32)) { did -c cch $calc($did -1) 4 | cchw2 $calc($did -1) 4 }
  inc %i }
  %i = 1
  while ($gettok($cch.e_2_,%i,32)) { if ($did == $gettok($cch.e_2_,%i,32)) { did -c cch $calc($did -3) 4 | cchw2 $calc($did -3) 4 }
inc %i } }
;alias cchw2 writeini $cch.conf general $$1 $$2-
alias cch.e_1_ return 9 20 31 46 57 68 79 91 102 113 124
alias cch.e_2_ return 11 22 33 48 59 81 93 104 115 126
alias cch.edits return 9 11 16 20 22 27 31 33 38 46 48 53 57 59 64 68 70 75 79 81 86 91 93 98 102 104 109 113 115 120 124 126 131 135 137 139
alias cch.edit { %i = 1 | while ($gettok($cch.edits,%i,32)) { if ($1 == $gettok($cch.edits,%i,32)) cchw $did(cch,$1)
inc %i } }
alias cch.combos_1 return 8 19 30 45 56 67 78 90 101 112 123
alias cch.combos_2 return 14 25 36 51 62 73 84 96 107 118 129
alias cch.loadcombos_1 { %i = 1 
  while ($gettok($cch.combos_1,%i,32)) { did -a cch $gettok($cch.combos_1,%i,32) Baja | did -a cch $gettok($cch.combos_1,%i,32) Media
did -a cch $gettok($cch.combos_1,%i,32) Alta | did -a cch $gettok($cch.combos_1,%i,32) Personal | inc %i } }
alias cch.loadcombos_2 { %i = 1
  while ($gettok($cch.combos_2,%i,32)) { did -a cch $gettok($cch.combos_2,%i,32) KiCK | did -a cch $gettok($cch.combos_2,%i,32) KiCK&BAN
did -a cch $gettok($cch.combos_2,%i,32) KiCK&BAN Tmp | inc %i } }
alias cch.checks return 7 18 29 41 42 44 55 66 77 89 100 111 122
alias cch.loadconf { did $iif($did(cch,2).sel == 1,-b,-e) cch 4
  %i = 1
  while ($gettok($cch.checks,%i,32)) { did $iif($cch.read($gettok($cch.checks,%i,32))  == on,-c,-u) cch $gettok($cch.checks,%i,32) | inc %i }
  %i = 1
  while ($gettok($cch.edits,%i,32)) { did -ra cch $gettok($cch.edits,%i,32) $cch.read($gettok($cch.edits,%i,32)) |  inc %i }
  %i = 1
  while ($gettok($cch.combos_1,%i,32)) { did -c cch $gettok($cch.combos_1,%i,32) $cch.read($gettok($cch.combos_1,%i,32)) | inc %i }
  %i = 1
  while ($gettok($cch.combos_2,%i,32)) { did -c cch $gettok($cch.combos_2,%i,32) $cch.read($gettok($cch.combos_2,%i,32)) | inc %i }
  cch.d_e | cch.combo_2_d_e 
  did -c cch 142 $cch.read(142)
}
alias cch.loadcombos_ban { did -r cch 142
  did -a cch 142 Jimmy_RAY!*@* | did -a cch 142 *!*bat@20-CORU-X6.libre.retevision.es | did -a cch 142 *!*@20-CORU-X6.libre.retevision.es
  did -a cch 142 *!*bat@*.libre.retevision.es | did -a cch 142 *!*@*.libre.retevision.es | did -a cch 142 Jimmy_RAY!bat@20-CORU-X6.libre.retevision.es 
  did -a cch 142 Jimmy_RAY!*bat@20-CORU-X6.libre.retevision.es | did -a cch 142 Jimmy_RAY!*@20-CORU-X6.libre.retevision.es | did -a cch 142 Jimmy_RAY!*bat@*.libre.retevision.es
  did -a cch 142 Jimmy_RAY!*@*.libre.retevision.es | did -a cch 142 *!bat@??-CORU-X?.libre.retevision.es | did -a cch 142 *!*bat@??-CORU-X?.libre.retevision.es
  did -a cch 142 *!*@??-CORU-X?.libre.retevision.es | did -a cch 142 *!*bat@??-CORU-X?.libre.retevision.es | did -a cch 142 *!*@??-CORU-X?.libre.retevision.es
did -a cch 142 Jimmy_RAY!bat@??-CORU-X?.libre.retevision.es }
alias cchac $dialog(cchac,cchac,2)
dialog cchac {
  title "Añadir Canal..."
  size -1 -1 90 90
  option dbu
  text "Canal:",1,5 5 30 10
  edit "",2,5 15 80 10,autohs center
  list 3,5 30 80 50
  button "Añadir",4,5 75 30 10,disable ok
  button "Cancelar",5,55 75 30 10,cancel
}
on 1:dialog:cchac:init:*: { %i = 1
  while ($chan(%i)) { 
    if ($findfile($mircdirdat\channels,$cchac_compchan($chan(%i)),1) == $null) did -a cchac 3 $chan(%i) 
    inc %i 
} }
on 1:dialog:cchac:sclick:*: {
  if ($did == 3) did -ra cchac 2 $did(cchac,3,$did(cchac,3).sel).text 
  if ($findfile($mircdirdat\channels,$cchac_compchan($did(cchac,2)),1) != $null) { did -b cchac 4 | goto fin }
  did $iif($did(cchac,2),-e,-b) cchac 4 | :fin
  if ($did == 4) { .copy -ao " $+ $mircdirdat\channels\general.conf" " $+ $mircdirdat\channels\ $+ $cchac_compchan($did(cchac,2)) $+ "
    if ($dialog(cch)) { %i = 1 | did -r cch 2 | did -a cch 2 General | unset %fl_u
      while ($findfile(dat\channels\,#*.conf,%i)) { did -a cch 2 $remove($nopath($findfile(dat\channels\,#*.conf,%i)),.conf) 
        if ($remove($cchac_compchan($did(cchac,2)),.conf) ==  $remove($nopath($findfile(dat\channels\,#*.conf,%i)),.conf)) %fl_u = $calc(%i + 1)
      inc %i }
did -c cch 2 %fl_u | unset %fl_u | cch.loadconf } } }
alias cchac_compchan { if ($left($1,1) == $chr(35)) return $1 $+ .conf
else return $chr(35) $+ $1 $+ .conf }
on 1:dialog:cchac:edit:*: { if ($findfile($mircdirdat\channels,$cchac_compchan($did(cchac,2)),1) != $null) { did -b cchac 4 | goto fin }
did $iif($did(cchac,2) == $null,-b,-e) cchac 4 | :fin }
alias thtot { return $thdat(nombre,$1) v $+ $thdat(version,$1) by $thdat(autor,$1) }
alias thdat {
  if ($1 == nombre) set %thbusca 2 | elseif ($1 == autor) set %thbusca 3 | elseif ($1 == version) set %thbusca 4 | elseif ($1 == comentario) set %thbusca 5 | elseif ($1 == sounds) set %thbusca 6 | elseif ($1 == bg) set %thbusca 7 | elseif ($1 == rep) set %thbusca 8
  set %fultmp2 [ [ $2 ] $+ ] .theme | if ($findfile(themes,%fultmp2,0) == 0) { return }
  set %fultmp $read -nl [ $+ [ %thbusca ] ] $findfile(themes,%fultmp2,1)
  set %fultmp $gettok(%fultmp,4-,32) | return %fultmp | unset %fultmp*
}
alias thcarfont {
  writeini mirc.ini fonts fchannel [ [ $th.font ] $+ ] , [ $+ [ $th.fontsize ] $+ ] ,1
  writeini mirc.ini fonts fquery [ [ $th.font ] $+ ] , [ $+ [ $th.fontsize ] $+ ] ,1
  writeini mirc.ini fonts fstatus [ [ $th.font ] $+ ] , [ $+ [ $th.fontsize ] $+ ] ,1
  %i = 1 | while ($chan(%i)) { font $chan(%i) $th.fontsize $th.font | inc %i }
  %i = 1 | while ($query(%i)) { font $query(%i) $th.fontsize $th.font | inc %i }
  %i = 1 | while ($chat(%i)) { font $chat(%i) $th.fontsize $th.font | inc %i }
  font -s $th.fontsize $th.font

  var %i,%x
  %i = 1
  %x = $read -l %i mirc.ini
  while (%i <= $lines(mirc.ini)) {
    if ($left($gettok(%x,1,32),2) == f#) {
      write -dl $+ %i mirc.ini
      %x = $read -l %i mirc.ini
      continue
    }
    inc %i
    %x = $read -l %i mirc.ini
  }
  unset %i %x
}
alias theme {
  if ($dialog(th)) dialog -v th
  else dialog -m th th
}
dialog th {
  title BaT: Escoge un theme...
  size -1 -1 265 130 
  option dbu
  box "Escoge theme:", 1, 5 5 70 100
  list 2, 10 15 60 75, vsbar
  button "Cargar", 3, 10 90 60 10, ok
  box "Descripción:", 11, 80 5 180 100
  text "", 12, 85 15 80 10
  text "", 13, 85 30 80 50
  text "Vista previa:", 20, 200 15 45 10
  icon 21, 175 20 80 80

  button "Aceptar",250, 220 110 40 15, ok
}
on *:dialog:th:init:*:{
  set -u %tpth 1 | while ($findfile(themes,*.theme,%tpth)) { did -a th 2 $thdat(nombre,$gettok($nopath($findfile(themes,*.theme,%tpth)),1,46)) | inc %tpth }
  did -c th 2 1 | did -ra th 12 $thtot($did(2,1).text) | did -ra th 13 $thdat(comentario,$did(2,1).text) | if ($did(2,1).text == $digral(theme)) did -b th 3
  did -g th 21 themes\ $+ $did(2,$did(2).sel).text $+ \preview.png
}
on *:dialog:th:sclick:*:{
  if ($did == 2) { 
    if ($did(2,$did($did).sel).text != $digral(theme)) did -e th 3 | else did -b th 3
    did -ra th 12 $thtot($did(2,$did($did).sel).text)
    did -ra th 13 $thdat(comentario,$did(2,$did($did).sel).text)
    did -g th 21 themes\ $+ $did($did,$did($did).sel).text $+ \preview.png
  }
  if ($did == 3) {
    .load -rs themes\ [ $+ [ $did(2,$did(2).sel).text ] $+ ] \ [ $+ [ $did(2,$did(2).sel).text ] $+ ] .theme
    .unload -rs [ [ $digral(theme) ] $+ ] .theme
    writeini dat\conf.ini general theme $did(2,$did(2).sel).text
    setcolors | thcarfont
    %i = 1 | while ($chan(%i)) { echo -e $chan(%i) $avisoinit | inc %i } | echo -es $avisoinit
  }
}
alias dalev { return $readini dat\users.ini $1 nivel }
alias dacan { return $readini dat\users.ini $1 canales }
on ^*:JOIN:#:{
  if (%aw.ulist) halt
  if (($me isop $chan) && ($nick != $me) && (%levels == On)) {
    if ($dalev($nick) == 200) { mode $chan +ov $nick $nick | .notice $nick $lg Lista de Proteción ( $+ $chan $+ ) }
    elseif ($dalev($nick) == 150) { mode $chan +ov $nick $nick | .notice $nick $lg Lista de AutoOp ( $+ $chan $+ ) }
    elseif ($dalev($nick) == 100) { mode $chan +v $nick | .notice $nick $lg Lista de AutoVoz ( $+ $chan $+ ) }
    elseif ($dalev($nick) == 75) { .notice $nick $lg Lista de Peligro/No op ( $+ $chan $+ ) }
    elseif ($dalev($nick) == 50) { mode $chan -o+b $nick $nick | kick $chan $nick ShiT LisT }
  }
}
on *:op:#: {
  if (%aw.ulist) halt
  if ((%levels == On) && ($me isop $chan) && ($opnick != $me) && ($level($nick) != bot)) {
    if (($nick == $me) || ($nick == $opnick)) goto noproteg
    if (($dalev($opnick) == 75) && ($chan isin $dacan($opnick))) {
      if ($level($nick) != Bot) { mode $chan -o $opnick | .notice $nick $lg Usuario Peligroso, no Op ( $+ $opnick $+ / $+ $chan $+ ) } | else mode $chan -o $opnick
      display aviso -s Op ( $+ $opnick $+ /Usuario Peligroso) en $chan por $nick 
    }
  }
  :noproteg
}
on *:deop:*: {
  if (($opnick == $me) && ($level($nick) != Bot) && ($nick != $me)) { .msg chan deop $chan $nick | .msg chan op $chan $me | return }
  if (%aw.ulist) halt
  if ((%levels == On) && ($me isop $chan) && ($opnick != $me) && ($level($nick) != bot)) {
    if (($nick == $me) || ($nick == $opnick)) goto noproteg
    if (($dalev($opnick) == 200) && (($chan isin $dacan($opnick)) || $dacan($opnick) == Todos)) { goto proteg } | else { goto noproteg }
    :proteg
    if (($dalev($nick) == 200) && (($chan isin $dacan($nick)) || $dacan($nick) == Todos)) { goto noproteg } | else { mode $chan -o+o $nick $opnick | .notice $nick $lg Usuario Protegido ( $+ $opnick / $chan $+ ) |  display aviso -s Deop ( $+ $opnick $+ /Usuario Protegido) en $chan por $nick }
    :noproteg | return
  }
}
on ^*:kick:*: {
  if (%aw.ulist) halt
  if ((%levels == On) && ($me isop $chan) && ($knick != $me) && ($level($nick) != bot)) {
    if (($nick == $me) || ($nick == $knick)) goto noproteg
    if (($dalev($knick) == 200) && (($chan isin $dacan($knick)) || $dacan($knick) == Todos)) { goto proteg } | else { goto noproteg }
    :proteg
    if (($dalev($nick) == 200) && (($chan isin $dacan($nick)) || $dacan($nick) == Todos)) { goto noproteg } | else { kick $chan $nick Usuario Protegido ( $+ $knick $+ / $+ $chan $+ ) | .notice $nick $lg Usuario Protegido ( $+ $knick / $chan $+ ) | if ($nick !ison $chan) invite $knick $chan |  display aviso -s  Kick ( $+ $opnick $+ /Usuario Protegido) en $chan por $nick ( $+ $1- $+ ) }
    :noproteg | return
  }
}
on ^*:BAN:#: {
  if (%aw.ulist) halt
  if ((%levels == On) && ($me isop $chan) && ($nick != $me) && ($me !isin $ialcalc($banmask)) && ($level($nick) != bot)) {
    set %ul.afecta $ialcalc($banmask)
    if (($dalev(%ul.afecta) == 200) && (($chan isin $dacan(%ul.afecta)) || $dacan(%ul.afecta) == Todos)) { goto proteg } | else { goto noproteg }
    :proteg
    if (($dalev($nick) == 200) && (($chan isin $dacan($nick)) || $dacan($nick) == Todos)) { goto noproteg } | else { kick $chan $nick Usuario Protegido ( $+ $banmask $+ / $+ $chan $+ ) | .notice $nick $lg Usuario Protegido ( $+ $banmask / $chan $+ ) |  display aviso -s  Kick ( $+ $banmask $+ /Usuario Protegido) en $chan por $nick ( $+ $1- $+ ) }
    :noproteg | return
  }
}
alias dul.existe { $dialog(dne,dne,2) }
;
dialog dne {
  size -1 -1 300 100 
  title "BaT: Usuario Existente"
  box "", 100, -10 50 500 800
  text "", 1, 10 10 280 15, center
  text "¿Deseas modificarlo?", 2, 10 30 280 15, center
  button "Cancelar", 248, 170 70 120 25, cancel
  button "Editar", 250, 10 70 120 25, ok
}
on *:dialog:dne:init:*:{ did -f dne 250 | did -ra dne 1 El usuario %ul.nick ya existe en tu lista de Usuarios Remotos }
on *:dialog:dne:sclick:*:{ if ($did == 250) { .timer 1 0 dialog -m dul dul } }
;
;
;
alias adduser { set %ul.nick $1 | set %ul.canal $2 | set %ul.lev $3 | if ($readini $mircdirdat\users.ini %ul.nick nivel) dul.existe | else dialog -m dul dul }
alias deluser { 
  set %tempdu $readini dat\users.ini Usuarios_registrados users
  if ($istok(%tempdu,$1,32)) { set -u %duvar 1 | unset %nuevosuser | :init | if ($gettok(%tempdu,%duvar,32)) { if ($gettok(%tempdu,%duvar,32) == $1) { inc %duvar | goto init } | else { set %nuevosuser %nuevosuser $gettok(%tempdu,%duvar,32) | inc %duvar | goto init } } }
  writeini dat\users.ini Usuarios_registrados users %nuevosuser | remini dat\users.ini $1
  unset %tempdu %nuevosuser | display informa -a $1 borrado de tu lista de usuarios
}


dialog dul {
  title "BaT: Lista de Usuarios Remotos y Dcc"
  size -1 -1 210 175 
  option dbu
  tab "Usuarios Remotos",1, 5 5 200 150
  text "Nick:", 11, 15 25 30 10, tab 1
  edit "", 12, 30 23 40 10, tab 1
  text "Nivel:", 13, 80 25 30 10, tab 1
  combo 14, 100 23 45 40, drop tab 1
  check "Comprobar la IP:", 15, 15 40 50 10, tab 1
  edit "", 16, 70 40 75 10, tab 1 disable
  check "Mandar Notice de aviso", 17, 15 55 75 10, tab 1
  list 31, 150 23 45 60, tab 1
  text "Canales en los que aplicar la configuración:", 32, 15 80 120 10, tab 1
  radio "En todos los canales (excepto exentos)", 33, 25 90 105 10, tab 1
  radio "Solo en estos canales (separados por espacios):", 34, 25 100 125 10, tab 1
  edit "", 35, 15 110 180 10, tab 1 disable
  button "Borrar", 36, 153 80 40 10, ok tab 1 disable
  text "Canales Exentos de la aplicación de la lista de Usuarios Remotos:", 41, 15 130 160 10, tab 1
  edit "", 42, 15 140 180 10, tab 1
  button "Cancelar", 249, 110 160 90 12, cancel
  button "Aceptar", 250, 10 160 90 12, ok
}
on *:dialog:dul:init:*:{
  if (%ul.nick) { did -ra dul 12 %ul.nick } | else { did -b dul 250 } | did -a dul 14 shit (no join) | did -a dul 14 no op (-o) | did -a dul 14 auto voz (+v) | did -a dul 14 auto op (+o) | did -a dul 14 protegido
  set -u %dulvar $readini dat\users.ini usuarios_registrados users | set -u %dulvar2 1
  while ($gettok(%dulvar,%dulvar2,32)) { did -a dul 31 $gettok(%dulvar,%dulvar2,32) | inc %dulvar2 }
  did -a dul 42 $readini dat\users.ini canales_exentos canales
  if ($readini dat\users.ini %ul.nick nivel) {
    if ($readini dat\users.ini %ul.nick canales == Todos) { did -b dul 35 | did -c dul 33 } | else { did -c dul 34 | did -e dul 35 | did -a dul 35 $readini dat\users.ini %ul.nick canales }
    if ($readini dat\users.ini %ul.nick CheckIp == Si) { did -c dul 15 | did -a dul 16 $readini dat\users.ini %ul.nick Ip | did -e dul 16 }
    set %ul.nivel $readini dat\users.ini %ul.nick Nivel | if (%ul.nivel == 200) did -c dul 14 5 | elseif (%ul.nivel == 150) did -c dul 14 4 | elseif (%ul.nivel == 100) did -c dul 14 3 | elseif (%ul.nivel == 75) did -c dul 14 2 | else did -c dul 14 1
    if ($readini dat\users.ini %ul.nick Notice == Si) did -c dul 17 | if ($readini dat\users.ini %ul.nick ip) { did -a dul 16 $readini dat\users.ini %ul.nick ip } | else { did -a dul 16 $address(%ul.nick,2) }
  }
  else { did -c dul 33 | did -ra dul 12 %ul.nick | did -a dul 35 %ul.canal | did -c dul 14 3 | did -a dul 16 $address(%ul.nick,2) | did -c dul 17 }
}
on *:dialog:dul:sclick:*: {
  if ($did == 15) { if ($did(15).state == 1) did -e dul 16 | else did -b dul 16 }
  if ($did == 33) { did -b dul 35 | did -e dul 250 } | if ($did == 34) { did -e dul 35 | if ($did(35)) { did -e dul 250 } | else { did -b dul 250 } } | if ($did == 31) did -e dul 36
  if ($did == 36) { deluser $did(dul,31,$did(dul,31).sel).text | did -r dul 31 | set -u %dulvar $readini dat\users.ini usuarios_registrados users | set -u %dulvar2 1 | while ($gettok(%dulvar,%dulvar2,32)) { did -a dul 31 $gettok(%dulvar,%dulvar2,32) | inc %dulvar2 } }
  if ($did == 250) {
    if ($readini dat\users.ini $did(12).text canales) { display informa -a Datos para $did(12) actualizados en tu lista de usuarios }
    else { set -u %parvtemp $readini dat\users.ini usuarios_registrados users | set -u %parvtemp %parvtemp $did(12) | writeini dat\users.ini usuarios_registrados users %parvtemp | display informa -a $did(12) añadido a tu lista de usuarios }
    if ($did(33).state == 1) { writeini dat\users.ini $did(12).text Canales Todos } | else { writeini dat\users.ini $did(12).text Canales $did(35).text }
    if ($did(14).sel == 1) writeini dat\users.ini $did(12) nivel 50 | set %ul.nivel Shit (no join) | if ($did(14).sel == 2) writeini dat\users.ini $did(12) nivel 75 | set %ul.nivel No op (-o) | if ($did(14).sel == 3) writeini dat\users.ini $did(12) nivel 100 | set %ul.nivel Auto voz (+v) | if ($did(14).sel == 4) writeini dat\users.ini $did(12) nivel 150 | set %ul.nivel Auto op (+o) | if ($did(14).sel == 5) writeini dat\users.ini $did(12) nivel 200 | set %ul.nivel Protegido (+o-b)
    if ($did(15).state == 1) writeini dat\users.ini $did(12) CheckIp Si | else writeini dat\users.ini $did(12) CheckIp No | if ($did(16).text) { writeini dat\users.ini $did(12) Ip $did(16).text } | else writeini dat\users.ini $did(12) Ip No determinada
    if ($did(17).state == 1) writeini dat\users.ini $did(12) Notice Si | else writeini dat\users.ini $did(12) Notice No
  }
}
on *:dialog:dul:edit:*: { 
  if ($did == 12) { if ($did(12)) did -e dul 250 | else did -b dul 250 }
  if ($did == 35) { if ($did(35)) did -e dul 250 | else did -b dul 250 }
}
alias ulista dialog -m ul ul
dialog ul {
  title BaT: User List
  size -1 -1 100 100
  option dbu
  box "", 10, -10 75 200 200
  list 1, 50 5 45 60
  button "Nuevo usuario", 11, 5 62 45 10, ok
  text "Usuarios remotos Para ver las propiedades haz doble-click en la lista sobre el que quieras ver.", 50, 5 5 41 40, center
  button "Borrar", 100, 51 62 44 10, ok
  button "Aceptar", 250, 10 83 80 15, ok
}
on *:dialog:ul:init:*: { did -b ul 100 | set -u %dulvar $readini dat\users.ini usuarios_registrados users | set -u %dulvar2 1 | while ($gettok(%dulvar,%dulvar2,32)) { did -a ul 1 $gettok(%dulvar,%dulvar2,32) | inc %dulvar2 } }
on *:dialog:ul:sclick:*:{ if ($did == 1) did -e ul 100 | if ($did == 11) { adduser | .timer 1 1 dialog -x ul } | if ($did == 100) { deluser $did(ul,1,$did(ul,1).sel).text | did -r ul 1 | set -u %dulvar $readini dat\users.ini usuarios_registrados users | set -u %dulvar2 1 | while ($gettok(%dulvar,%dulvar2,32)) { did -a ul 1 $gettok(%dulvar,%dulvar2,32) | inc %dulvar2 } } }
on *:dialog:ul:dclick:1:{ .timer 1 2 dialog -x ul | set %ul.nick $did(ul,1,$did(ul,1).sel).text | dialog -m dul dul }
