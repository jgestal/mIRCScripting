;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; Protecciones de flood en canales
;
;*************************************

alias floodconf makedialog -m cch
dialog cch {
  title "Protecciones de flood para canales"
  size -1 -1 240 195
  option dbu
  icon icons\noflood.ico
  text "Configuración para el canal:",1,5 5 70 10
  combo 2,75 3 70 100,drop
  button "&Añadir",3,150 3 30 10
  button "&Borrar",4,185 3 30 10,disable
  box "",5,-10 15 290 155

  tab "Text Flood",6,5 20 230 145

  check "Flood de Texto:",7,10 40 50 10,tab 6
  combo 8,60 40 40 50,drop,tab 6
  edit "",9,105 40 30 10,center,tab 6
  text "caracteres en:",10,140 42 35 10,center,tab 6
  edit "",11,180 40 30 10,center,tab 6
  text "seg(s)",12,215 42 15 10,tab 6
  text "Castigo:",13,35 55 20 10,tab 6
  combo 14,60 55 60 50,drop,tab 6
  text "de",15,125 57 10 10,tab 6
  edit "",16,135 55 30 10,center,tab 6
  text "seg(s)",17,170 57 15 10,tab 6

  check "Flood de Lineas:",18,10 70 50 10,tab 6
  combo 19,60 70 40 50,drop,tab 6
  edit "",20,105 70 30 10,center,tab 6
  text "lineas en:",21,140 72 35 10,center,tab 6
  edit "",22,180 70 30 10,center,tab 6
  text "seg(s)",23,215 72 15 10,tab 6
  text "Castigo:",24,35 85 20 10,tab 6
  combo 25,60 85 60 50,drop,tab 6
  text "de",26,125 87 10 10,tab 6
  edit "",27,135 85 30 10,center,tab 6
  text "seg(s)",28,170 87 15 10,tab 6

  check "Flood de Reps:",29,10 100 50 10,tab 6
  combo 30,60 100 40 50,drop,tab 6
  edit "",31,105 100 30 10,center,tab 6
  text "reps en:",32,140 102 35 10,center,tab 6
  edit "",33,180 100 30 10,center,tab 6
  text "seg(s)",34,215 102 15 10,tab 6
  text "Castigo:",35,35 115 20 10,tab 6
  combo 36,60 115 60 50,drop,tab 6
  text "de",37,125 117 10 10,tab 6
  edit "",38,135 115 30 10,center,tab 6
  text "seg(s)",39,170 117 15 10,tab 6

  text "Inmunidad. No castigar por flood en los siguientes casos:",40,10 130 220 10,center,tab 6
  check "Ops Inmunes", 41, 35 145 50 15, push,tab 6 
  check "Voces Inmunes", 42, 155 145 50 15, push,tab 6

  tab "Mode Flood",43

  check "Anti Mass-Deop:",44,10 40 50 10,tab 43
  combo 45,60 40 40 50,drop,tab 43
  edit "",46,105 40 30 10,center,tab 43
  text "deops en:",47,140 42 35 10,center,tab 43
  edit "",48,180 40 30 10,center,tab 43
  text "seg(s)",49,215 42 15 10,tab 43
  text "Castigo:",50,35 55 20 10,tab 43
  combo 51,60 55 60 50,drop,tab 43
  text "de",52,125 57 10 10,tab 43
  edit "",53,135 55 30 10,center,tab 43
  text "seg(s)",54,170 57 15 10,tab 43

  check "Anti Mass-Kick:",55,10 70 50 10,tab 43
  combo 56,60 70 40 50,drop,tab 43
  edit "",57,105 70 30 10,center,tab 43
  text "kicks en:",58,140 72 35 10,center,tab 43
  edit "",59,180 70 30 10,center,tab 43
  text "seg(s)",60,215 72 15 10,tab 43
  text "Castigo:",61,35 85 20 10,tab 43
  combo 62,60 85 60 50,drop,tab 43
  text "de",63,125 87 10 10,tab 43
  edit "",64,135 85 30 10,center,tab 43
  text "seg(s)",65,170 87 15 10,tab 43

  check "Anti Mass-Ban:",66,10 100 50 10,tab 43
  combo 67,60 100 40 50,drop,tab 43
  edit "",68,105 100 30 10,center,tab 43
  text "bans en:",69,140 102 35 10,center,tab 43
  edit "",70,180 100 30 10,center,tab 43
  text "seg(s)",71,215 102 15 10,tab 43
  text "Castigo:",72,35 115 20 10,tab 43
  combo 73,60 115 60 50,drop,tab 43
  text "de",74,125 117 10 10,tab 43
  edit "",75,135 115 30 10,center,tab 43
  text "seg(s)",76,170 117 15 10,tab 43

  check "Topic Flood:",77,10 130 50 10,tab 43
  combo 78,60 130 40 50,drop,tab 43
  edit "",79,105 130 30 10,center,tab 43
  text "topics en:",80,140 132 35 10,center,tab 43
  edit "",81,180 130 30 10,center,tab 43
  text "seg(s)",82,215 132 15 10,tab 43
  text "Castigo:",83,35 145 20 10,tab 43
  combo 84,60 145 60 50,drop,tab 43
  text "de",85,125 147 10 10,tab 43
  edit "",86,135 145 30 10,center,tab 43
  text "seg(s)",87,170 147 15 10,tab 43

  tab "Otros Flood",88

  check "Flood de Join:",89,10 40 50 10,tab 88
  combo 90,60 40 40 50,drop,tab 88
  edit "",91,105 40 30 10,center,tab 88
  text "entradas en:",92,140 42 35 10,center,tab 88
  edit "",93,180 40 30 10,center,tab 88
  text "seg(s)",94,215 42 15 10,tab 88
  text "Castigo:",95,35 55 20 10,tab 88
  combo 96,60 55 60 50,drop,tab 88
  text "de",97,125 57 10 10,tab 88
  edit "",98,135 55 30 10,center,tab 88
  text "seg(s)",99,170 57 15 10,tab 88

  check "Flood de Nicks:",100,10 70 50 10,tab 88
  combo 101,60 70 40 50,drop tab 88
  edit "",102,105 70 30 10,center,tab 88
  text "nicks en:",103,140 72 35 10,center,tab 88
  edit "",104,180 70 30 10,center tab 88
  text "seg(s)",105,215 72 15 10,tab 88
  text "Castigo:",106,35 85 20 10,tab 88
  combo 107,60 85 60 50,drop,tab 88
  text "de",108,125 87 10 10,tab 88
  edit "",109,135 85 30 10,center,tab 88
  text "seg(s)",110,170 87 15 10,tab 88

  check "Flood de CTCP:",111,10 100 50 10,tab 88
  combo 112,60 100 40 50,drop,tab 88
  edit "",113,105 100 30 10,center,tab 88
  text "ctcps en:",114,140 102 35 10,center,tab 88
  edit "",115,180 100 30 10,center,tab 88
  text "seg(s)",116,215 102 15 10,tab 88
  text "Castigo:",117,35 115 20 10,tab 88
  combo 118,60 115 60 50,drop,tab 88
  text "de",119,125 117 10 10,tab 88
  edit "",120,135 115 30 10,center,tab 88
  text "seg(s)",121,170 117 15 10,tab 88

  check "Otro Flood:",122,10 130 50 10,tab 88,hide
  combo 123,60 130 40 50,drop,tab 88,hide
  edit "",124,105 130 30 10,center,tab 88,hide
  text "notices en:",125,140 132 35 10,center,tab 88,hide
  edit "",126,180 130 30 10,center tab 88,hide
  text "seg(s)",127,215 132 15 10,tab 88,hide
  text "Castigo:",128,35 145 20 10,tab 88,hide
  combo 129,60 145 60 50,drop tab 88,hide
  text "de",130,125 147 10 10,tab 88,hide
  edit "",131,135 145 30 10,center tab 88,hide
  text "seg(s)",132,170 147 15 10,tab 88,hide

  tab "KiCKs y Bans",133

  box "Razón de kick por Text Flood (En blanco razón aleatoria)",134,10 40 220 25,tab 133
  edit "",135,15 50 210 10,autohs,tab 133

  box "Razón de kick por Mode Flood (En blanco razón aleatoria)",136,10 65 220 25,tab 133
  edit "",137,15 75 210 10,autohs,tab 133 

  box "Razón de kick por Otros Flood (En blanco razón aleatoria)",138,10 90 220 25,tab 133 
  edit "",139,15 100 210 10,autohs,tab 133 

  box "Mascara de ban por defecto",140,10 115 220 45,tab 133 

  text "Es la máscara que se baneará cuando un nick sobrepase el límite de flood permitido excepto en el join flood, que por razones obvias se baneará la ip.",141,15 125 200 15,tab 133
  combo 142,15 145 210 100,drop,tab 133

  button "Desactivar Todas",143,10 175 70 15

  button "Activar Todas",144,85 175 70 15
  button "Aceptar",145,160 175 70 15,ok,default
}
alias cch.read return $readini $cch.conf general $$1
alias cch.conf return dat\channels\ $+ $did(cch,2,$did(cch,2).sel).text $+ .conf
alias cchw { 
  if ($1) writeini $cch.conf general $did $1-
  else remini $cch.conf general $did
}
alias cchw2 { 
  if ($2) writeini $cch.conf general $$1 $$2-
  else remini $cch.conf general $$1
}
on 1:dialog:cch:init:*: {
  _mdx.buttons_style 3 4 41 42 143 144 145
  var %i 1 | did -a cch 2 General
  while ($findfile(dat\channels\,#*.conf,%i)) { did -a cch 2 $remove($nopath($findfile(dat\channels\,#*.conf,%i)),.conf) | inc %i }
did -c cch 2 1 | cch.loadcombos_1 | cch.loadcombos_2 | cch.loadcombos_ban | cch.loadconf }
alias cch.delchan { if ($_p(¿Estás seguro de querer borrar la configuración independiente del canal seleccionado en la lista?)" == $true) {
    .remove " $+ dat\channels\ $+ $cchac_compchan($did(cch,2,$did(cch,2).sel).text) $+ "
    did -r cch 2 | var %i 1 | did -a cch 2 General
    while ($findfile(dat\channels\,#*.conf,%i)) { did -a cch 2 $remove($nopath($findfile(dat\channels\,#*.conf,%i)),.conf) | inc %i }
did -c cch 2 1 | cch.loadconf } }
alias cch.putedits { var %x $readini files\chanconf.ini $did $did(cch,$did).sel
cchw $calc($did + 1) $gettok(%x,1,32) | cchw $calc($did + 1) $gettok(%x,2,32) }
on 1:dialog:cch:sclick:*: {
  if ($did == 2) cch.loadconf | if ($did == 3) .timer -m 1 1 cchac | if ($did == 4) .timer -m 1 1 cch.delchan
  if ($did == 143) { var %i 1 | while ($gettok($cch.checks,%i,32)) { cchw2 $gettok($cch.checks,%i,32) off | inc %i } | cch.loadconf }    
  if ($did == 144) { var %i 1 | while ($gettok($cch.checks,%i,32)) { cchw2 $gettok($cch.checks,%i,32) on | inc %i } | cch.loadconf }    
  did $iif($did(cch,2).sel == 1,-b,-e) cch 4 | var %i 1
  while ($gettok($cch.checks,%i,32)) { if ($gettok($cch.combos_1,%i,32) == $did) && ($did(cch,$did).sel != 4) {
      var %x $readini files\chanconf.ini $did $did(cch,$did).sel
      cchw2 $calc($did +1) $gettok(%x,1,32) | did -ra cch $calc($did +1) $gettok(%x,1,32)
  cchw2 $calc($did +3) $gettok(%x,2,32) | did -ra cch $calc($did +3) $gettok(%x,2,32) } | inc %i }
  var %i 1
  while ($gettok($cch.checks,%i,32)) { if ($gettok($cch.checks,%i,32) == $did) cchw $iif($cch.read($did) == on,off,on)
  inc %i  }
  var %i 1
  while ($gettok($cch.combos_1,%i,32)) { if ($gettok($cch.combos_1,%i,32) == $did) cchw $did(cch,$did).sel
  inc %i }
  var %i 1
  while ($gettok($cch.combos_2,%i,32)) { if ($gettok($cch.combos_2,%i,32) == $did) cchw $did(cch,$did).sel
  inc %i }
  var %i 1 | cch.d_e | cch.combo_2_d_e 
  if ($did == 142) cchw $did(cch,$did).sel
}
alias cch.d_e { var %i 1
  while ($gettok($cch.d_e_c,%i,32)) { if ($cch.read($gettok($cch.d_e_c,%i,32)) == on) { did -e cch $cch.d_e_calcs($gettok($cch.d_e_c,%i,32)) | inc %i }
else { did -b cch $cch.d_e_calcs2($gettok($cch.d_e_c,%i,32)) | inc %i } } }
alias cch.c_2_d_edits return 16 27 38 53 64 75 86 98 109 120 131
alias cch.combo_2_d_e { var %i 1
  while ($gettok($cch.c_2_d_edits,%i,32)) {
    if ($cch.read($calc($gettok($cch.c_2_d_edits,%i,32) -9)) == on) { did $iif($cch.read($calc($gettok($cch.c_2_d_edits,%i,32) -2)) == 3,-e,-b) cch $calc($gettok($cch.c_2_d_edits,%i,32) -1) $+ , $+ $gettok($cch.c_2_d_edits,%i,32) $+ , $+ $calc($gettok($cch.c_2_d_edits,%i,32) +1)   }
inc %i } }
alias cch.d_e_calcs return $calc($1 +1) $+ , $+ $calc($1 +2) $+ , $+ $calc($1 +3) $+ , $+ $calc($1 +4) $+ , $+ $calc($1 +5) $+ , $+ $calc($1 +6) $+ , $+ $calc($1 +7) 
alias cch.d_e_calcs2 return $calc($1 +1) $+ , $+ $calc($1 +2) $+ , $+ $calc($1 +3) $+ , $+ $calc($1 +4) $+ , $+ $calc($1 +5) $+ , $+ $calc($1 +6) $+ , $+ $calc($1 +7) $+ , $+ $calc($1 +8) $+ , $+ $calc($1 +9) $+ , $+ $calc($1 +10)
alias cch.d_e_c return 7 18 29 44 55 66 77 89 100 111 122
on 1:dialog:cch:edit:*: { cch.edit $did | var %i 1
  while ($gettok($cch.e_1_,%i,32)) { if ($did == $gettok($cch.e_1_,%i,32)) { did -c cch $calc($did -1) 4 | cchw2 $calc($did -1) 4 }
  inc %i }
  var %i 1
  while ($gettok($cch.e_2_,%i,32)) { if ($did == $gettok($cch.e_2_,%i,32)) { did -c cch $calc($did -3) 4 | cchw2 $calc($did -3) 4 }
inc %i } }
;alias cchw2 writeini $cch.conf general $$1 $$2-
alias cch.e_1_ return 9 20 31 46 57 68 79 91 102 113 124
alias cch.e_2_ return 11 22 33 48 59 81 93 104 115 126
alias cch.edits return 9 11 16 20 22 27 31 33 38 46 48 53 57 59 64 68 70 75 79 81 86 91 93 98 102 104 109 113 115 120 124 126 131 135 137 139
alias cch.edit { var %i 1 | while ($gettok($cch.edits,%i,32)) { if ($1 == $gettok($cch.edits,%i,32)) cchw $did(cch,$1)
inc %i } }
alias cch.combos_1 return 8 19 30 45 56 67 78 90 101 112 123
alias cch.combos_2 return 14 25 36 51 62 73 84 96 107 118 129
alias cch.loadcombos_1 { var %i 1 
  while ($gettok($cch.combos_1,%i,32)) { did -a cch $gettok($cch.combos_1,%i,32) Baja | did -a cch $gettok($cch.combos_1,%i,32) Media
did -a cch $gettok($cch.combos_1,%i,32) Alta | did -a cch $gettok($cch.combos_1,%i,32) Personal | inc %i } }
alias cch.loadcombos_2 { var %i 1
  while ($gettok($cch.combos_2,%i,32)) { did -a cch $gettok($cch.combos_2,%i,32) KiCK | did -a cch $gettok($cch.combos_2,%i,32) KiCK&BAN
did -a cch $gettok($cch.combos_2,%i,32) KiCK&BAN Tmp | inc %i } }
alias cch.checks return 7 18 29 41 42 44 55 66 77 89 100 111 122
alias cch.loadconf { did $iif($did(cch,2).sel == 1,-b,-e) cch 4
  var %i 1
  while ($gettok($cch.checks,%i,32)) { did $iif($cch.read($gettok($cch.checks,%i,32))  == on,-c,-u) cch $gettok($cch.checks,%i,32) | inc %i }
  var %i 1
  while ($gettok($cch.edits,%i,32)) { did -ra cch $gettok($cch.edits,%i,32) $cch.read($gettok($cch.edits,%i,32)) |  inc %i }
  var %i 1
  while ($gettok($cch.combos_1,%i,32)) { did -c cch $gettok($cch.combos_1,%i,32) $cch.read($gettok($cch.combos_1,%i,32)) | inc %i }
  var %i 1
  while ($gettok($cch.combos_2,%i,32)) { did -c cch $gettok($cch.combos_2,%i,32) $cch.read($gettok($cch.combos_2,%i,32)) | inc %i }
  cch.d_e | cch.combo_2_d_e 
  did -c cch 142 $cch.read(142)
}
alias cch.loadcombos_ban { did -r cch 142
  did -a cch 142 Jimmy_RAY!*@* | did -a cch 142 *!*bt@20-CORU-X6.libre.retevision.es | did -a cch 142 *!*@20-CORU-X6.libre.retevision.es
  did -a cch 142 *!*bt@*.libre.retevision.es | did -a cch 142 *!*@*.libre.retevision.es | did -a cch 142 Jimmy_RAY!bt@20-CORU-X6.libre.retevision.es 
  did -a cch 142 Jimmy_RAY!*bt@20-CORU-X6.libre.retevision.es | did -a cch 142 Jimmy_RAY!*@20-CORU-X6.libre.retevision.es | did -a cch 142 Jimmy_RAY!*bt@*.libre.retevision.es
  did -a cch 142 Jimmy_RAY!*@*.libre.retevision.es | did -a cch 142 *!bt@??-CORU-X?.libre.retevision.es | did -a cch 142 *!*bt@??-CORU-X?.libre.retevision.es
  did -a cch 142 *!*@??-CORU-X?.libre.retevision.es | did -a cch 142 *!*bt@??-CORU-X?.libre.retevision.es | did -a cch 142 *!*@??-CORU-X?.libre.retevision.es
did -a cch 142 Jimmy_RAY!bt@??-CORU-X?.libre.retevision.es }
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
on 1:dialog:cchac:init:*: { _mdx.buttons_style 4 5 | var %i 1
  while ($chan(%i)) { 
    if ($findfile(dat\channels,$cchac_compchan($chan(%i)),1) == $null) did -a cchac 3 $chan(%i) 
    inc %i 
} }
on 1:dialog:cchac:sclick:*: {
  if ($did == 3) did -ra cchac 2 $did(cchac,3,$did(cchac,3).sel).text 
  if ($findfile(dat\channels,$cchac_compchan($did(cchac,2)),1)) { did -b cchac 4 | goto fin }
  did $iif($did(cchac,2),-e,-b) cchac 4 | :fin
  if ($did == 4) { .copy -ao " $+ dat\channels\general.conf" " $+ dat\channels\ $+ $cchac_compchan($did(cchac,2)) $+ "
    if ($dialog(cch)) { var %i 1 | did -r cch 2 | did -a cch 2 General | unset %fl_u
      while ($findfile(dat\channels\,#*.conf,%i)) { did -a cch 2 $remove($nopath($findfile(dat\channels\,#*.conf,%i)),.conf) 
        if ($remove($cchac_compchan($did(cchac,2)),.conf) ==  $remove($nopath($findfile(dat\channels\,#*.conf,%i)),.conf)) %fl_u = $calc(%i + 1)
      inc %i }
did -c cch 2 %fl_u | unset %fl_u | cch.loadconf } } }
alias cchac_compchan { if ($left($1,1) == $chr(35)) return $1 $+ .conf
else return $chr(35) $+ $1 $+ .conf }
on 1:dialog:cchac:edit:*: { if ($findfile(dat\channels,$cchac_compchan($did(cchac,2)),1)) { did -b cchac 4 | goto fin }
did $iif($did(cchac,2) == $null,-b,-e) cchac 4 | :fin }



alias fc { if ($findfile($mircdirdat\channels,$cchac_compchan($chan),1)) return $readini dat\channels\ $+ $cchac_compchan($chan) general $$1
else return $readini dat\channels\general.conf general $$1 }
alias cchbanaddress { if ($fc(142) == 1) return $1
else return $address($1,$calc($fc(142) +1)) }

alias fc.castigo {
  if ($cchbanaddress($nick) != $cchbanaddress($me)) {
    unset %x | goto $$1
    :3 | .timer 1 $$2 _unbantmp $chan $cchbanaddress($nick) | set %x [tmpban: $+ $duration($$2) $+ ]
    :2 | mode $chan -o+b $nick $cchbanaddress($nick)
    :1 | kick $chan $nick  $$3 - $$4- %x 
    unset %x
  }
}
alias fc.castigoip {
  if ($address($nick,2) != $address($me,2)) {
    unset %x | goto $$1
    :3 | .timer 1 $$2 _unbantmp $chan $address($nick,2) | set %x [tmpban: $+ $duration($$2) $+ ]
    :2 | mode $chan -o+b $nick $address($nick,2)
    :1 | kick $chan $nick  $$3 - $$4- %x 
    unset %x
  } 
}
alias fc.msg {
  if ($findfile($mircdirdat\channels,$cchac_compchan($chan),1)) { 
    set -u %x $readini $mircdirdat\channels\ $+ $cchac_compchan($chan) general $$1
  }
  if ($findfile($mircdirdat\channels,$cchac_compchan($chan),1) == $null) {
    set -u %x $readini $mircdirdat\channels\general.conf general $$1
  }
  if (!%x) set -u %x $read $mircdirdat\kicks.txt
  return %x
}
alias fc.cont return ( $+ $1 $+  $+ $2 $+ /  $+ $round($3,2) $+   $+ $4 $+ )
alias _unbantmp { if ($me isop $$1) mode $$1 -b $$2 }
alias fc.castigonick {
  unset %x | goto $$1
  :3 | .timer 1 $fc.chan($comchan($newnick,%i),109) _unbantmp $comchan($newnick,%i) $newnick | set %x [tmpban: $+ $duration($fc.chan($comchan($newnick,%i),109)) $+ ] 
  :2 | mode $comchan($newnick,%i) -o+b $newnick $cchbanaddress($newnick)
  :1 | kick $comchan($newnick,%i) $newnick $$2 - $$3- %x 
  unset %x
}
alias fc.msgnick {
  if ($findfile($mircdirdat\channels,$cchac_compchan($comchan($newnick,%i)),1)) { 
    set -u %x $readini $mircdirdat\channels\ $+ $cchac_compchan($comchan($newnick,%i)) general $$1
  }
  if ($findfile($mircdirdat\channels,$cchac_compchan($comchan($newnick,%i)),1) == $null) {
    set -u %x $readini $mircdirdat\channels\general.conf general $$1
  }
  if (!%x) set -u %x $read $mircdirdat\kicks.txt
  return %x
}
alias fc.chan { if ($findfile($mircdirdat\channels,$cchac_compchan($$1),1)) return $readini dat\channels\ $+ $cchac_compchan($$1) general $$2
else return $readini dat\channels\general.conf general $$2 }
on @1:text:*:#: {
  if ($level($nick) == BOT) return
  ;Flood de caracteres
  if ($fc(7) == on) {
    if ([ %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ] != $null) inc %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ]  $len($1-)   
    if ([ %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ] == $null) { 
      set -u [ $+ [ $fc(11) ] ]  [ %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ] $len($1-)
      set -u [ $+ [ $fc(11) ] ]  [ %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ] $ticks  
    }
    if ([ %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ] >= $fc(9)) { 
      if ($nick isop $chan) && ($fc(41) == on) goto end1
      if ($nick isvo $chan) && ($fc(42) == on) goto end1
      fc.castigo $fc(14) $fc(16) $fc.cont( %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ,caracteres,$calc(($ticks - %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ) /1000),s)) $fc.msg(135)
      :end1
      unset %fl_lnf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ]
      goto _end   
    }
  }
  ;Flood de lineas
  if ($fc(18) == on) {
    if ([ %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] == $null) { 
      set -u [ $+ [ $fc(22) ] ]  [ %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] 1
      set -u [ $+ [ $fc(22) ] ]  [ %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ] $ticks  
    }
    elseif ([ %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] != $null) {
      inc %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ]  1
      if ([ %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] == $fc(20)) { 
        if ($nick isop $chan) && ($fc(41) == on) goto end2
        if ($nick isvo $chan) && ($fc(42) == on) goto end2
        fc.castigo $fc(25) $fc(27) $fc.cont($fc(20),ln,$calc(($ticks - %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ) /1000),s)) $fc.msg(135)
        :end2
        unset %fl_lnf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ]
        goto _end   
      }
    }
  }
  ;Flood de repeticiones
  if ($fc(29) == on) {
    if ([ %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] == $null) { 
      set -u [ $+ [ $fc(33) ] ]  [ %fl_repf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] ] $1-
      set -u [ $+ [ $fc(33) ] ]  [ %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] 1
      set -u [ $+ [ $fc(33) ] ]  [ %fl_repf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ] $ticks  
    }
    elseif ([ %fl_repf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] ] == $1-) { 
      inc %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ]  1
      if ([ %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] == $fc(31)) { 
        if ($nick isop $chan) && ($fc(41) == on) goto end3
        if ($nick isvo $chan) && ($fc(42) == on) goto end3
        fc.castigo $fc(36) $fc(38) $fc.cont($fc(31),reps,$calc(($ticks - %fl_repf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ) /1000),s)) $fc.msg(135)
        :end3
        unset %fl_repf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ] %fl_repf.ticks. [ $+ [ $chan ] $+ [ $nick ] ]
      }
    }
  }
  :_end
}
on @1:Action:*:#: {
  if ($level($nick) == BOT) return
  ;Flood de caracteres
  if ($fc(7) == on) {
    if ([ %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ] != $null) inc %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ]  $len($1-)   
    if ([ %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ] == $null) { 
      set -u [ $+ [ $fc(11) ] ]  [ %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ] $len($1-)
      set -u [ $+ [ $fc(11) ] ]  [ %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ] $ticks  
    }
    if ([ %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ] >= $fc(9)) { 
      if ($nick isop $chan) && ($fc(41) == on) goto end1
      if ($nick isvo $chan) && ($fc(42) == on) goto end1
      fc.castigo $fc(14) $fc(16) $fc.cont( %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ,caracteres,$calc(($ticks - %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ) /1000),s)) $fc.msg(135)
      :end1
      unset %fl_lnf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ]
      goto _end   
    }
  }
  ;Flood de lineas
  if ($fc(18) == on) {
    if ([ %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] == $null) { 
      set -u [ $+ [ $fc(22) ] ]  [ %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] 1
      set -u [ $+ [ $fc(22) ] ]  [ %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ] $ticks  
    }
    elseif ([ %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] != $null) {
      inc %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ]  1
      if ([ %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] == $fc(20)) { 
        if ($nick isop $chan) && ($fc(41) == on) goto end2
        if ($nick isvo $chan) && ($fc(42) == on) goto end2
        fc.castigo $fc(25) $fc(27) $fc.cont($fc(20),ln,$calc(($ticks - %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ) /1000),s)) $fc.msg(135)
        :end2
        unset %fl_lnf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ]
        goto _end   
      }
    }
  }
  ;Flood de repeticiones
  if ($fc(29) == on) {
    if ([ %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] == $null) { 
      set -u [ $+ [ $fc(33) ] ]  [ %fl_repf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] ] $1-
      set -u [ $+ [ $fc(33) ] ]  [ %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] 1
      set -u [ $+ [ $fc(33) ] ]  [ %fl_repf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ] $ticks  
    }
    elseif ([ %fl_repf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] ] == $1-) { 
      inc %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ]  1
      if ([ %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] == $fc(31)) { 
        if ($nick isop $chan) && ($fc(41) == on) goto end3
        if ($nick isvo $chan) && ($fc(42) == on) goto end3
        fc.castigo $fc(36) $fc(38) $fc.cont($fc(31),reps,$calc(($ticks - %fl_repf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ) /1000),s)) $fc.msg(135)
        :end3
        unset %fl_repf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ] %fl_repf.ticks. [ $+ [ $chan ] $+ [ $nick ] ]
      }
    }
  }
  :_end
}

on @1:Notice:*:#: {
  if ($level($nick) == BOT) return

  ;Flood de caracteres
  if ($fc(7) == on) {
    if ([ %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ] != $null) inc %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ]  $len($1-)   
    if ([ %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ] == $null) { 
      set -u [ $+ [ $fc(11) ] ]  [ %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ] $len($1-)
      set -u [ $+ [ $fc(11) ] ]  [ %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ] $ticks  
    }
    if ([ %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ] >= $fc(9)) { 
      if ($nick isop $chan) && ($fc(41) == on) goto end1
      if ($nick isvo $chan) && ($fc(42) == on) goto end1
      fc.castigo $fc(14) $fc(16) $fc.cont( %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] ,caracteres,$calc(($ticks - %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ) /1000),s)) $fc.msg(135)
      :end1
      unset %fl_lnf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] %fl_carac. [ $+ [ $chan ] $+ [ $nick ] ] %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ]
      goto _end   
    }
  }
  ;Flood de lineas
  if ($fc(18) == on) {
    if ([ %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] == $null) { 
      set -u [ $+ [ $fc(22) ] ]  [ %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] 1
      set -u [ $+ [ $fc(22) ] ]  [ %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ] $ticks  
    }
    elseif ([ %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] != $null) {
      inc %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ]  1
      if ([ %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] == $fc(20)) { 
        if ($nick isop $chan) && ($fc(41) == on) goto end2
        if ($nick isvo $chan) && ($fc(42) == on) goto end2
        fc.castigo $fc(25) $fc(27) $fc.cont($fc(20),ln,$calc(($ticks - %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ) /1000),s)) $fc.msg(135)
        :end2
        unset %fl_lnf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] %fl_lnf.rep. [ $+ [ $chan ] $+ [ $nick ] ] %fl_lnf.ticks. [ $+ [ $chan ] $+ [ $nick ] ]
        goto _end   
      }
    }
  }
  ;Flood de repeticiones
  if ($fc(29) == on) {
    if ([ %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] == $null) { 
      set -u [ $+ [ $fc(33) ] ]  [ %fl_repf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] ] $1-
      set -u [ $+ [ $fc(33) ] ]  [ %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] 1
      set -u [ $+ [ $fc(33) ] ]  [ %fl_repf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ] $ticks  
    }
    elseif ([ %fl_repf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] ] == $1-) { 
      inc %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ]  1
      if ([ %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ] ] == $fc(31)) { 
        if ($nick isop $chan) && ($fc(41) == on) goto end3
        if ($nick isvo $chan) && ($fc(42) == on) goto end3
        fc.castigo $fc(36) $fc(38) $fc.cont($fc(31),reps,$calc(($ticks - %fl_repf.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ) /1000),s)) $fc.msg(135)
        :end3
        unset %fl_repf.chan.txt. [ $+ [ $chan ] $+ [ $nick ] ] %fl_repf.rep. [ $+ [ $chan ] $+ [ $nick ] ] %fl_repf.ticks. [ $+ [ $chan ] $+ [ $nick ] ]
      }
    }
  }
  :_end
}

;Otros Flood
On @*!:deop:#: {
  if ($level($nick) == BOT) return

  if ($fc(44) == on) {
    if ( %fl_deop.mass [ $+ [ $chan ] $+ [ $nick ] ] != $null ) { 
      inc %fl_deop.mass [ $+ [ $chan ] $+ [ $nick ] ] 
    }    
    if ( %fl_deop.mass [ $+ [ $chan ] $+ [ $nick ] ] == $null ) { 
      set -u [ $+ [ $fc(48) ] ] %fl_deop.mass [ $+ [ $chan ] $+ [ $nick ] ] 1
      set -u [ $+ [ $fc(48) ] ]  [ %fl_deopmass.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ] $ticks  
    }
    if ( %fl_deop.mass [ $+ [ $chan ] $+ [ $nick ] ]  >= $fc(57)) { 
      fc.castigo $fc(51) $fc(53) $fc.cont($fc(46),deops,$calc(($ticks - %fl_deopmass.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ) /1000),s)) $fc.msg(137)
      unset  %fl_deop.mass [ $+ [ $chan ] $+ [ $nick ] ] 
    }
  }
}
On @*!:kick:#: {
  if ($level($nick) == BOT) return

  if ($fc(55) == on) {
    if ( %fl_kick.mass [ $+ [ $chan ] $+ [ $nick ] ] != $null ) { 
      inc %fl_kick.mass [ $+ [ $chan ] $+ [ $nick ] ] 
    }    
    if ( %fl_kick.mass [ $+ [ $chan ] $+ [ $nick ] ] == $null ) { 
      set -u [ $+ [ $fc(59) ] ] %fl_kick.mass [ $+ [ $chan ] $+ [ $nick ] ] 1
      set -u [ $+ [ $fc(59) ] ]  [ %fl_kickmass.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ] $ticks  
    }
    if ( %fl_kick.mass [ $+ [ $chan ] $+ [ $nick ] ]  >= $fc(57)) { 
      fc.castigo $fc(62) $fc(64) $fc.cont($fc(57),kicks,$calc(($ticks - %fl_kickmass.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ) /1000),s)) $fc.msg(137)
      unset  %fl_kick.mass [ $+ [ $chan ] $+ [ $nick ] ] 
    }
  }
}
On @*!:ban:#: {
  if ($level($nick) == BOT) return

  if ($fc(66) == on) {
    if ( %fl_ban.mass [ $+ [ $chan ] $+ [ $nick ] ] != $null ) { 
      inc %fl_ban.mass [ $+ [ $chan ] $+ [ $nick ] ] 
    }    
    if ( %fl_ban.mass [ $+ [ $chan ] $+ [ $nick ] ] == $null ) { 
      set -u [ $+ [ $fc(70) ] ] %fl_ban.mass [ $+ [ $chan ] $+ [ $nick ] ] 1
      set -u [ $+ [ $fc(70) ] ]  [ %fl_banmass.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ] $ticks  
    }
    if ( %fl_ban.mass [ $+ [ $chan ] $+ [ $nick ] ]  >= $fc(68)) { 
      fc.castigo $fc(73) $fc(75) $fc.cont($fc(68),bans,$calc(($ticks - %fl_banmass.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ) /1000),s)) $fc.msg(137)
      unset  %fl_ban.mass [ $+ [ $chan ] $+ [ $nick ] ] 
    }
  }
}
On @*!:topic:#: {
  if ($level($nick) == BOT) return
  if ($fc(77) == on) {
    if ( %fl_topic.mass [ $+ [ $chan ] $+ [ $nick ] ] != $null ) { 
      inc %fl_topic.mass [ $+ [ $chan ] $+ [ $nick ] ] 
    }    
    if ( %fl_topic.mass [ $+ [ $chan ] $+ [ $nick ] ] == $null ) { 
      set -u [ $+ [ $fc(81) ] ] %fl_topic.mass [ $+ [ $chan ] $+ [ $nick ] ] 1
      set -u [ $+ [ $fc(81) ] ]  [ %fl_topicmass.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ] $ticks  
    }
    if ( %fl_topic.mass [ $+ [ $chan ] $+ [ $nick ] ]  >= $fc(79)) { 
      fc.castigo $fc(84) $fc(86) $fc.cont($fc(79),topics,$calc(($ticks - %fl_topicmass.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ) /1000),s)) $fc.msg(137)
      unset  %fl_topic.mass [ $+ [ $chan ] $+ [ $nick ] ] 
    }
  }
}
On @*!:join:#: {
  if ($level($nick) == BOT) return
  if ($fc(89) == on) {
    if ( %fl_join.mass [ $+ [ $chan ] $+ [ $wildsite ] ] != $null ) { 
      inc %fl_join.mass [ $+ [ $chan ] $+ [ $wildsite ] ] 
    }    
    if ( %fl_join.mass [ $+ [ $chan ] $+ [ $wildsite ] ] == $null ) { 
      set -u [ $+ [ $fc(93) ] ] %fl_join.mass [ $+ [ $chan ] $+ [ $wildsite ] ] 1
      set -u [ $+ [ $fc(93) ] ]  [ %fl_joinmass.ticks. [ $+ [ $chan ] $+ [ $wildsite ] ] ] $ticks  
    }
    if ( %fl_join.mass [ $+ [ $chan ] $+ [ $wildsite ] ]  >= $fc(91)) { 
      fc.castigoip $fc(96) $fc(98) $fc.cont($fc(91),joins,$calc(($ticks - %fl_joinmass.ticks. [ $+ [ $chan ] $+ [ $wildsite ] ] ) /1000),s)) $fc.msg(137)
      unset  %fl_join.mass [ $+ [ $chan ] $+ [ $wildsite ] ] 
    }
  }
}
on *!:nick: {
  if ($level($nick) == BOT) return
  %i = 1
  while ($comchan($newnick,%i)) {
    if ($me isop $comchan($newnick,%i)) && ($fc.chan($comchan($newnick,%i),100) == on) {   
      if ( %fl_nick.flood [ $+ [ $comchan($newnick,%i) ] $+ [ $nick ] ] == $null ) { 
        set -u [ $+ [ $fc.chan($comchan($newnick,%i),104) ] ] %fl_nick.flood [ $+ [ $comchan($newnick,%i) ] $+ [ $newnick ] ] 1
        set -u [ $+ [ $fc.chan($comchan($newnick,%i),104) ] ] %fl_nick.ticks [ $+ [ $comchan($newnick,%i) ] $+ [ $newnick ] ] $ticks
      }
      if ( %fl_nick.flood [ $+ [ $comchan($newnick,%i) ] $+ [ $nick ] ] != $null ) {
        set -u [ $+ [ $calc($fc.chan($comchan($newnick,%i),104) - ($ticks - %fl_nick.ticks [ $+ [ $comchan($newnick,%i) ] $+ [ $nick ] ] ) /1000)) ] ] %fl_nick.flood [ $+ [ $comchan($newnick,%i) ] $+ [ $newnick ] ] $calc(%fl_nick.flood [ $+ [ $comchan($newnick,%i) ] $+ [ $nick ] ] +1)
        set -u [ $+ [ $calc($fc.chan($comchan($newnick,%i),104) - ($ticks - %fl_nick.ticks [ $+ [ $comchan($newnick,%i) ] $+ [ $nick ] ] ) /1000)) ] ] %fl_nick.ticks [ $+ [ $comchan($newnick,%i) ] $+ [ $newnick ] ] %fl_nick.ticks [ $+ [ $comchan($newnick,%i) ] $+ [ $nick ] ]

        unset %fl_nick.flood [ $+ [ $comchan($newnick,%i) ] $+ [ $nick ] ] %fl_nick.ticks [ $+ [ $comchan($newnick,%i) ] $+ [ $nick ] ]
      }
      if (%fl_nick.flood [ $+ [ $comchan($newnick,%i) ] $+ [ $newnick ] ] >= $fc.chan($comchan($newnick,%i),102)) {
        fc.castigonick $fc.chan($comchan($newnick,%i),107) $fc.cont($fc.chan($comchan($newnick,%i),102),nicks,$round($calc(($ticks - %fl_nick.ticks [ $+ [ $comchan($newnick,%i) ] $+ [ $newnick ] ] ) / 1000),2),s) $fc.msgnick(139) 
        unset %fl_nick.flood [ $+ [ $comchan($newnick,%i) ] $+ [ $newnick ] ] %fl_nick.ticks [ $+ [ $comchan($newnick,%i) ] $+ [ $newnick ] ]
      }
    }
    inc %i
  }
}
ctcp @*!:*:#: {
  if ($level($nick) == BOT) return
  if ($fc(111) == on) {
    if ( %fl_ctcp.flood [ $+ [ $chan ] $+ [ $nick ] ] != $null ) { 
      inc %fl_ctcp.flood [ $+ [ $chan ] $+ [ $nick ] ] 
    }    
    if ( %fl_ctcp.flood [ $+ [ $chan ] $+ [ $nick ] ] == $null ) { 
      set -u [ $+ [ $fc(115) ] ] %fl_ctcp.flood [ $+ [ $chan ] $+ [ $nick ] ] 1
      set -u [ $+ [ $fc(115) ] ]  [ %fl_ctcpflood.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ] $ticks  
    }
    if ( %fl_ctcp.flood [ $+ [ $chan ] $+ [ $nick ] ]  >= $fc(113)) { 
      fc.castigo $fc(118) $fc(120) $fc.cont($fc(113),ctcps,$calc(($ticks - %fl_ctcpflood.ticks. [ $+ [ $chan ] $+ [ $nick ] ] ) /1000),s)) $fc.msg(137)
      unset  %fl_ctcp.flood [ $+ [ $chan ] $+ [ $nick ] ] 
    }
  }
}
