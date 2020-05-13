;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BaT No Flood! v1.0
;; BAT (BravoS AssAulT TeaM)     
;;
;; Escrito por Jimmy_RAY
;;
;; http://jimmyray.da.ru
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

on 1:load: { .reload -rs1 $script }
on 1:start: { unset %fl_* }
alias noflood { if ($dialog(cch) == $null) dialog -m cch cch }
dialog cch {
  title "BaT No Flood! - Jimmy_RAY -"
  size -1 -1 240 195
  option dbu
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

  tab "Acerca de...",146
  box "El autor",147,10 40 110 120,tab 146
  text "Autor: Jimmy_RAY",148,15 50 100 10,center,tab 146
  text "Scripts: Beatlescript, BravoScript, BaCKBeaT y BAT (con Fulg0re)",149,15 60 100 20,center,tab 146
  text "My soft never has bugs, it just develops random features",159,15 80 100 20,center,tab 146
  link "email: jimmy@welt.es",160,40 100 100 15,center,tab 146
  link "http://jimmyray.da.ru",161,35 115 120 15,center,tab 146
  link "canalscripting.cjb.net",162,35 130 120 15,center,tab 146
  text "Agradecimientos a:",163,125 45 50 10,tab 146
  edit "",164,125 55 105 90,vsbar read multi return,tab 146
  button "Copyright © 2001",165,125 150 105 10,tab 146
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
on 1:dialog:cch:sclick:160: { run mailto:jimmy@welt.es }
on 1:dialog:cch:sclick:161: { run http://jimmyray.da.ru }
on 1:dialog:cch:sclick:162: { run http://canalscripting.cjb.net }
on 1:dialog:cch:sclick:165: {
  if ($dialog(about2)) dialog -x about2 
  else $dialog(about2,about2,2) 
}
dialog about2 { 
  title "Copyright © 2001 Todos los derechos reservados"
  size -1 -1 150 25
  option dbu
  text "No está permitido copiar el código fuente de este addOn, tampoco incluirlo en ningún script sin permiso del author.",1,5 5 140 40,center
  button "",2,1 1 1 1,ok,hide 
}
on 1:dialog:cch:init:*: { 
  did -o cch 164 1 ---------------------------------- | did -o cch 164 2 BETATESTERS | did -o cch 164 3 ----------------------------------
  did -o cch 164 4 Fulg0re | did -o cch 164 5 NoTsCaPe | did -o cch 164 6 ---------------------------------- | did -o cch 164 7 BravoS TeaM 
  did -o cch 164 8 ---------------------------------- | did -o cch 164 9 McNeill | did -o cch 164 10 chungo | did -o cch 164 11 BOOT | did -o cch 164 12 Hamm
  did -o cch 164 13 NoTsCaPe | did -o cch 164 14 Quetzal | did -o cch 164 15 Fulg0re | did -o cch 164 16 Txetox
  did -o cch 164 17 Jimmy_RAY | did -o cch 164 18 ---------------------------------- | did -o cch 164 19 Más agradecimientos | did -o cch 164 20 ----------------------------------
  did -o cch 164 21 Nazaret wapa :** | did -o cch 164 22 Canales #scripting y #100scripts | %i = 1 | did -a cch 2 General
  while ($findfile(dat\channels\,#*.conf,%i)) { did -a cch 2 $remove($nopath($findfile(dat\channels\,#*.conf,%i)),.conf) | inc %i }
did -c cch 2 1 | cch.loadcombos_1 | cch.loadcombos_2 | cch.loadcombos_ban | cch.loadconf }
alias cch.delchan { if ($$?!="¿Estás seguro de querer borrar la configuración independiente del canal seleccionado en la lista?" == $true) {
    .remove " $+ $mircdirdat\channels\ $+ $cchac_compchan($did(cch,2,$did(cch,2).sel).text) $+ "
    did -r cch 2 | %i = 1 | did -a cch 2 General
    while ($findfile(dat\channels\,#*.conf,%i)) { did -a cch 2 $remove($nopath($findfile(dat\channels\,#*.conf,%i)),.conf) | inc %i }
did -c cch 2 1 | cch.loadconf } }
alias cch.putedits { %tmp.var = $readini sistema\chanconf.ini $did $did(cch,$did).sel
echo -s $did $did(cch,$did).sel | cchw $calc($did + 1) $gettok(%tmp.var,1,32) | cchw $calc($did + 1) $gettok(%tmp.var,2,32) }
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
      %tmp.var = $readini $mircdirsistema\chanconf.ini $did $did(cch,$did).sel
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
menu status,menubar,channel { 
  -
  &No Flood!:noflood
}
