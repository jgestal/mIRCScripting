;*************************************
;       BaCKBEAT No Flood!
;
; Jimmy_RAY addONs
; 
; http://backbeat.da.ru
; http://jimmyray.da.ru
; 
; email: jimmy@welt.es
;
;*************************************
; NOTE: You can use this script in 
; your script but you cannot remove
; the credits and/or modify the code.
;*************************************

on 1:load: { .reload -rs1 " $+ $script $+ " }
on 1:start: { unset %fl_* }
alias noflood { dialog $iif($dialog(cch),-v,-m) cch cch }
dialog cch {
  title "BaCKBEAT No Flood! - Jimmy_RAY -"
  size -1 -1 240 195
  option dbu
  text "Channel configuration:",1,5 5 70 10

  combo 2,75 3 70 100,drop
  button "&Add",3,150 3 30 10
  button "&Delete",4,185 3 30 10,disable
  box "",5,-10 15 290 155

  tab "Text Flood",6,5 20 230 145

  check "Byte Flood:",7,10 40 50 10,tab 6
  combo 8,60 40 40 50,drop,tab 6
  edit "",9,105 40 30 10,center,tab 6
  text "bytes in:",10,140 42 35 10,center,tab 6
  edit "",11,180 40 30 10,center,tab 6
  text "sec(s)",12,215 42 15 10,tab 6
  text "Punishment:",13,25 55 30 10,tab 6
  combo 14,60 55 60 50,drop,tab 6
  text "of",15,125 57 10 10,tab 6
  edit "",16,135 55 30 10,center,tab 6
  text "sec(s)",17,170 57 15 10,tab 6

  check "Line Flood:",18,10 70 50 10,tab 6
  combo 19,60 70 40 50,drop,tab 6
  edit "",20,105 70 30 10,center,tab 6
  text "lines in:",21,140 72 35 10,center,tab 6
  edit "",22,180 70 30 10,center,tab 6
  text "sec(s)",23,215 72 15 10,tab 6
  text "Punishment:",24,25 85 30 10,tab 6
  combo 25,60 85 60 50,drop,tab 6
  text "of",26,125 87 10 10,tab 6
  edit "",27,135 85 30 10,center,tab 6
  text "sec(s)",28,170 87 15 10,tab 6

  check "Repetitions:",29,10 100 50 10,tab 6
  combo 30,60 100 40 50,drop,tab 6
  edit "",31,105 100 30 10,center,tab 6
  text "reps in:",32,140 102 35 10,center,tab 6
  edit "",33,180 100 30 10,center,tab 6
  text "sec(s)",34,215 102 15 10,tab 6
  text "Punishment:",35,25 115 30 10,tab 6
  combo 36,60 115 60 50,drop,tab 6
  text "of",37,125 117 10 10,tab 6
  edit "",38,135 115 30 10,center,tab 6
  text "sec(s)",39,170 117 15 10,tab 6

  text "Inmunity: the people who can´t be punished:",40,10 130 220 10,center,tab 6
  check "Ops (@)", 41, 35 145 50 15, push,tab 6 
  check "Voices (+)", 42, 155 145 50 15, push,tab 6

  tab "Mode Flood",43

  check "No Mass-Deop:",44,10 40 50 10,tab 43
  combo 45,60 40 40 50,drop,tab 43
  edit "",46,105 40 30 10,center,tab 43
  text "deops in:",47,140 42 35 10,center,tab 43
  edit "",48,180 40 30 10,center,tab 43
  text "sec(s)",49,215 42 15 10,tab 43
  text "Punishment:",50,25 55 30 10,tab 43
  combo 51,60 55 60 50,drop,tab 43
  text "of",52,125 57 10 10,tab 43
  edit "",53,135 55 30 10,center,tab 43
  text "sec(s)",54,170 57 15 10,tab 43

  check "No Mass-Kick:",55,10 70 50 10,tab 43
  combo 56,60 70 40 50,drop,tab 43
  edit "",57,105 70 30 10,center,tab 43
  text "kicks in:",58,140 72 35 10,center,tab 43
  edit "",59,180 70 30 10,center,tab 43
  text "sec(s)",60,215 72 15 10,tab 43
  text "Punishment:",61,25 85 30 10,tab 43
  combo 62,60 85 60 50,drop,tab 43
  text "of",63,125 87 10 10,tab 43
  edit "",64,135 85 30 10,center,tab 43
  text "sec(s)",65,170 87 15 10,tab 43

  check "No Mass-Ban:",66,10 100 50 10,tab 43
  combo 67,60 100 40 50,drop,tab 43
  edit "",68,105 100 30 10,center,tab 43
  text "bans in:",69,140 102 35 10,center,tab 43
  edit "",70,180 100 30 10,center,tab 43
  text "sec(s)",71,215 102 15 10,tab 43
  text "Punishment:",72,25 115 30 10,tab 43
  combo 73,60 115 60 50,drop,tab 43
  text "of",74,125 117 10 10,tab 43
  edit "",75,135 115 30 10,center,tab 43
  text "sec(s)",76,170 117 15 10,tab 43

  check "Topic Flood:",77,10 130 50 10,tab 43
  combo 78,60 130 40 50,drop,tab 43
  edit "",79,105 130 30 10,center,tab 43
  text "topics in:",80,140 132 35 10,center,tab 43
  edit "",81,180 130 30 10,center,tab 43
  text "sec(s)",82,215 132 15 10,tab 43
  text "Punishment:",83,25 145 30 10,tab 43
  combo 84,60 145 60 50,drop,tab 43
  text "of",85,125 147 10 10,tab 43
  edit "",86,135 145 30 10,center,tab 43
  text "sec(s)",87,170 147 15 10,tab 43


  tab "Others",88

  check "Join Flood:",89,10 40 50 10,tab 88
  combo 90,60 40 40 50,drop tab 88
  edit "",91,105 40 30 10,center tab 88
  text "joins in:",92,140 42 35 10,center tab 88
  edit "",93,180 40 30 10,center tab 88
  text "sec(s)",94,215 42 15 10,tab 88
  text "Punishment:",95,25 55 30 10,tab 88
  combo 96,60 55 60 50,drop tab 88
  text "of",97,125 57 10 10,tab 88
  edit "",98,135 55 30 10,center tab 88
  text "sec(s)",99,170 57 15 10,tab 88


  check "Flood de Nicks:",100,10 70 50 10,tab 88
  combo 101,60 70 40 50,drop tab 88
  edit "",102,105 70 30 10,center,tab 88
  text "nicks in:",103,140 72 35 10,center,tab 88
  edit "",104,180 70 30 10,center tab 88
  text "sec(s)",105,215 72 15 10,tab 88
  text "Punishment:",106,25 85 30 10,tab 88
  combo 107,60 85 60 50,drop,tab 88
  text "of",108,125 87 10 10,tab 88
  edit "",109,135 85 30 10,center,tab 88
  text "sec(s)",110,170 87 15 10,tab 88

  check "CTCP Flood:",111,10 100 50 10,tab 88
  combo 112,60 100 40 50,drop,tab 88
  edit "",113,105 100 30 10,center,tab 88
  text "ctcps in:",114,140 102 35 10,center,tab 88
  edit "",115,180 100 30 10,center,tab 88
  text "sec(s)",116,215 102 15 10,tab 88
  text "Punishment:",117,25 115 30 10,tab 88
  combo 118,60 115 60 50,drop,tab 88
  text "of",119,125 117 10 10,tab 88
  edit "",120,135 115 30 10,center,tab 88
  text "sec(s)",121,170 117 15 10,tab 88

  check "Other Flood:",122,10 130 50 10,tab 88,hide
  combo 123,60 130 40 50,drop,tab 88,hide
  edit "",124,105 130 30 10,center,tab 88,hide
  text "flood in:",125,140 132 35 10,center,tab 88,hide
  edit "",126,180 130 30 10,center tab 88,hide
  text "sec(s)",127,215 132 15 10,tab 88,hide
  text "Punishment:",128,25 145 30 10,tab 88,hide
  combo 129,60 145 60 50,drop tab 88,hide
  text "of",130,125 147 10 10,tab 88,hide
  edit "",131,135 145 30 10,center tab 88,hide
  text "sec(s)",132,170 147 15 10,tab 88,hide

  tab "KiCKs and Bans",133

  box "Kick reason for text flood (in blank random reasom)",134,10 40 220 25,tab 133
  edit "",135,15 50 210 10,autohs,tab 133

  box "Kick reason for mode flood (in blank random reasom)",136,10 65 220 25,tab 133
  edit "",137,15 75 210 10,autohs,tab 133 

  box "Kick reason for other flood (in blank random reasom)",138,10 90 220 25,tab 133 
  edit "",139,15 100 210 10,autohs,tab 133 

  box "Default ban mask:",140,10 115 220 45,tab 133 

  text "This is the mask you will ban except in join flood because you will ban the host.",141,15 125 200 15,tab 133
  combo 142,15 145 210 100,drop,tab 133

  button "Disable all",143,10 175 70 15

  button "Enable all",144,85 175 70 15
  button "OK",145,160 175 70 15,ok,default

  tab "About...",146
  box "El author",147,10 40 110 120,tab 146
  text "Author: Jimmy_RAY",148,15 50 100 10,center,tab 146
  text "Scripts: Beatlescript, BravoScript, BaCKBeaT y BAT (con Fulg0re)",149,15 60 100 20,center,tab 146
  text "My soft never has bugs, it just develops random features",159,15 80 100 20,center,tab 146
  link "email: jimmy@welt.es",160,40 100 60 15,center,tab 146
  link "http://jimmyray.da.ru",161,40 115 60 15,center,tab 146
  link "http://backbeat.da.ru",162,40 130 60 15,center,tab 146
  text "Greatements to:",163,125 45 50 10,tab 146
  edit "",164,125 55 105 90,vsbar read multi return,tab 146
  button "Copyright © 2001",165,125 150 105 10,tab 146
}
alias -l  cch.read return $readini $cch.conf Default $$1
alias -l  cch.conf return $scriptdir\channels\ $+ $did(cch,2,$did(cch,2).sel).text $+ .conf
alias -l  cchw { 
  if ($1) writeini $cch.conf Default $did $1-
  else remini $cch.conf Default $did
}
alias -l  cchw2 { 
  if ($2) writeini $cch.conf Default $$1 $$2-
  else remini $cch.conf Default $$1
}
on 1:dialog:cch:sclick:160: { run mailto:jimmy@welt.es }
on 1:dialog:cch:sclick:161: { run http://jimmyray.da.ru }
on 1:dialog:cch:sclick:162: { run http://backbeat.da.ru }
on 1:dialog:cch:sclick:165: {
  if ($dialog(about2)) dialog -x about2 
  else $dialog(about2,about2,2) 
}
dialog about2 { 
  title "Copyright © 2001 All rights reserved"
  size -1 -1 150 25
  option dbu
  text "Its not allowed to modify the source code of this script, you can use it in your script without remove the credits or modify the code.",1,5 5 140 40,center
  button "",2,1 1 1 1,ok,hide 
}
on 1:dialog:cch:init:*: { 
  did -o cch 164 1 ---------------------------------- | did -o cch 164 2 BETATESTERS | did -o cch 164 3 ----------------------------------
  did -o cch 164 4 Fulg0re | did -o cch 164 5 NoTsCaPe | did -o cch 164 6 ---------------------------------- | did -o cch 164 7 BravoS TeaM 
  did -o cch 164 8 ---------------------------------- | did -o cch 164 9 McNeill | did -o cch 164 10 chungo | did -o cch 164 11 BOOT | did -o cch 164 12 Hamm
  did -o cch 164 13 NoTsCaPe | did -o cch 164 14 Quetzal | did -o cch 164 15 Fulg0re | did -o cch 164 16 Txetox
  did -o cch 164 17 Jimmy_RAY | did -o cch 164 18 ---------------------------------- | did -o cch 164 19 More greatements | did -o cch 164 20 ----------------------------------
  did -o cch 164 21 Nazaret :** | did -o cch 164 22 Channels #scripting and #100scripts of irc.irc-hispano.org | %i = 1 | did -a cch 2 Default
  while ($findfile($scriptdir\channels\,#*.conf,%i)) { did -a cch 2 $remove($nopath($findfile($scriptdir\channels\,#*.conf,%i)),.conf) | inc %i }
did -c cch 2 1 | cch.loadcombos_1 | cch.loadcombos_2 | cch.loadcombos_ban | cch.loadconf }
alias -l  cch.delchan { if ($$?!="¿Are you sure?" == $true) {
    .remove " $+ $scriptdir\channels\ $+ $cchac_compchan($did(cch,2,$did(cch,2).sel).text) $+ "
    did -r cch 2 | %i = 1 | did -a cch 2 Default
    while ($findfile($scriptdir\channels\,#*.conf,%i)) { did -a cch 2 $remove($nopath($findfile($scriptdir\channels\,#*.conf,%i)),.conf) | inc %i }
did -c cch 2 1 | cch.loadconf } }
alias -l  cch.putedits { %tmp.var = $readini sistema\chanconf.ini $did $did(cch,$did).sel
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
alias -l  cch.d_e { %i = 1
  while ($gettok($cch.d_e_c,%i,32)) { if ($cch.read($gettok($cch.d_e_c,%i,32)) == on) { did -e cch $cch.d_e_calcs($gettok($cch.d_e_c,%i,32)) | inc %i }
else { did -b cch $cch.d_e_calcs2($gettok($cch.d_e_c,%i,32)) | inc %i } } }
alias -l  cch.c_2_d_edits return 16 27 38 53 64 75 86 98 109 120 131
alias -l  cch.combo_2_d_e { %i = 1
  while ($gettok($cch.c_2_d_edits,%i,32)) {
    if ($cch.read($calc($gettok($cch.c_2_d_edits,%i,32) -9)) == on) { did $iif($cch.read($calc($gettok($cch.c_2_d_edits,%i,32) -2)) == 3,-e,-b) cch $calc($gettok($cch.c_2_d_edits,%i,32) -1) $+ , $+ $gettok($cch.c_2_d_edits,%i,32) $+ , $+ $calc($gettok($cch.c_2_d_edits,%i,32) +1)   }
inc %i } }
alias -l  cch.d_e_calcs return $calc($1 +1) $+ , $+ $calc($1 +2) $+ , $+ $calc($1 +3) $+ , $+ $calc($1 +4) $+ , $+ $calc($1 +5) $+ , $+ $calc($1 +6) $+ , $+ $calc($1 +7) 
alias -l  cch.d_e_calcs2 return $calc($1 +1) $+ , $+ $calc($1 +2) $+ , $+ $calc($1 +3) $+ , $+ $calc($1 +4) $+ , $+ $calc($1 +5) $+ , $+ $calc($1 +6) $+ , $+ $calc($1 +7) $+ , $+ $calc($1 +8) $+ , $+ $calc($1 +9) $+ , $+ $calc($1 +10)
alias -l  cch.d_e_c return 7 18 29 44 55 66 77 89 100 111 122
on 1:dialog:cch:edit:*: { cch.edit $did | %i = 1
  while ($gettok($cch.e_1_,%i,32)) { if ($did == $gettok($cch.e_1_,%i,32)) { did -c cch $calc($did -1) 4 | cchw2 $calc($did -1) 4 }
  inc %i }
  %i = 1
  while ($gettok($cch.e_2_,%i,32)) { if ($did == $gettok($cch.e_2_,%i,32)) { did -c cch $calc($did -3) 4 | cchw2 $calc($did -3) 4 }
inc %i } }
;alias -l  cchw2 writeini $cch.conf Default $$1 $$2-
alias -l  cch.e_1_ return 9 20 31 46 57 68 79 91 102 113 124
alias -l  cch.e_2_ return 11 22 33 48 59 81 93 104 115 126
alias -l  cch.edits return 9 11 16 20 22 27 31 33 38 46 48 53 57 59 64 68 70 75 79 81 86 91 93 98 102 104 109 113 115 120 124 126 131 135 137 139
alias -l  cch.edit { %i = 1 | while ($gettok($cch.edits,%i,32)) { if ($1 == $gettok($cch.edits,%i,32)) cchw $did(cch,$1)
inc %i } }
alias -l  cch.combos_1 return 8 19 30 45 56 67 78 90 101 112 123
alias -l  cch.combos_2 return 14 25 36 51 62 73 84 96 107 118 129
alias -l  cch.loadcombos_1 { %i = 1 
  while ($gettok($cch.combos_1,%i,32)) { did -a cch $gettok($cch.combos_1,%i,32) Permisive | did -a cch $gettok($cch.combos_1,%i,32) Normal
did -a cch $gettok($cch.combos_1,%i,32) Strict | did -a cch $gettok($cch.combos_1,%i,32) Custom | inc %i } }
alias -l  cch.loadcombos_2 { %i = 1
  while ($gettok($cch.combos_2,%i,32)) { did -a cch $gettok($cch.combos_2,%i,32) KiCK | did -a cch $gettok($cch.combos_2,%i,32) KiCK&BAN
did -a cch $gettok($cch.combos_2,%i,32) KiCK&BAN Tmp | inc %i } }
alias -l  cch.checks return 7 18 29 41 42 44 55 66 77 89 100 111 122
alias -l  cch.loadconf { did $iif($did(cch,2).sel == 1,-b,-e) cch 4
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
alias -l  cch.loadcombos_ban { did -r cch 142
  did -a cch 142 Jimmy_RAY!*@* | did -a cch 142 *!*bat@20-CORU-X6.libre.retevision.es | did -a cch 142 *!*@20-CORU-X6.libre.retevision.es
  did -a cch 142 *!*bat@*.libre.retevision.es | did -a cch 142 *!*@*.libre.retevision.es | did -a cch 142 Jimmy_RAY!bat@20-CORU-X6.libre.retevision.es 
  did -a cch 142 Jimmy_RAY!*bat@20-CORU-X6.libre.retevision.es | did -a cch 142 Jimmy_RAY!*@20-CORU-X6.libre.retevision.es | did -a cch 142 Jimmy_RAY!*bat@*.libre.retevision.es
  did -a cch 142 Jimmy_RAY!*@*.libre.retevision.es | did -a cch 142 *!bat@??-CORU-X?.libre.retevision.es | did -a cch 142 *!*bat@??-CORU-X?.libre.retevision.es
  did -a cch 142 *!*@??-CORU-X?.libre.retevision.es | did -a cch 142 *!*bat@??-CORU-X?.libre.retevision.es | did -a cch 142 *!*@??-CORU-X?.libre.retevision.es
did -a cch 142 Jimmy_RAY!bat@??-CORU-X?.libre.retevision.es }
alias -l  cchac $dialog(cchac,cchac,2)
dialog cchac {
  title "Add channel..."
  size -1 -1 90 90
  option dbu
  text "Channel:",1,5 5 30 10
  edit "",2,5 15 80 10,autohs center
  list 3,5 30 80 50
  button "Add",4,5 75 30 10,disable ok
  button "Cancel",5,55 75 30 10,cancel
}
on 1:dialog:cchac:init:*: { %i = 1
  while ($chan(%i)) { 
    if ($findfile($scriptdir\channels,$cchac_compchan($chan(%i)),1) == $null) did -a cchac 3 $chan(%i) 
    inc %i 
} }
on 1:dialog:cchac:sclick:*: {
  if ($did == 3) did -ra cchac 2 $did(cchac,3,$did(cchac,3).sel).text 
  if ($findfile($scriptdir\channels,$cchac_compchan($did(cchac,2)),1) != $null) { did -b cchac 4 | goto fin }
  did $iif($did(cchac,2),-e,-b) cchac 4 | :fin
  if ($did == 4) { .copy -ao " $+ $scriptdir\channels\Default.conf" " $+ $scriptdir\channels\ $+ $cchac_compchan($did(cchac,2)) $+ "
    if ($dialog(cch)) { %i = 1 | did -r cch 2 | did -a cch 2 Default | unset %fl_u
      while ($findfile($scriptdir\channels\,#*.conf,%i)) { did -a cch 2 $remove($nopath($findfile($scriptdir\channels\,#*.conf,%i)),.conf) 
        if ($remove($cchac_compchan($did(cchac,2)),.conf) ==  $remove($nopath($findfile($scriptdir\channels\,#*.conf,%i)),.conf)) %fl_u = $calc(%i + 1)
      inc %i }
did -c cch 2 %fl_u | unset %fl_u | cch.loadconf } } }
alias -l  cchac_compchan { if ($left($1,1) == $chr(35)) return $1 $+ .conf
else return $chr(35) $+ $1 $+ .conf }
on 1:dialog:cchac:edit:*: { if ($findfile($scriptdir\channels,$cchac_compchan($did(cchac,2)),1) != $null) { did -b cchac 4 | goto fin }
did $iif($did(cchac,2) == $null,-b,-e) cchac 4 | :fin }
menu status,menubar,channel { 
  -
  &No Flood!:noflood
}
alias -l  fc { if ($findfile($scriptdir\channels,$cchac_compchan($chan),1)) return $readini $scriptdir\channels\ $+ $cchac_compchan($chan) general $$1
else return $readini $scriptdir\channels\general.conf general $$1 }
alias -l  cchbanaddress { if ($fc(142) == 1) return $1
else return $address($1,$calc($fc(142) +1)) }

alias -l  fc.castigo {
  if ($cchbanaddress($nick) != $cchbanaddress($me)) {
    unset %tmp.var | goto $$1
    :3 | .timer 1 $$2 _unbantmp $chan $cchbanaddress($nick) | set %tmp.var [tmpban: $+ $duration($$2) $+ ]
    :2 | mode $chan -o+b $nick $cchbanaddress($nick)
    :1 | kick $chan $nick $lg $$3 - $$4- %tmp.var $kickcont
    unset %tmp.var
  }
}
alias -l  fc.castigoip {
  if ($address($nick,2) != $address($me,2)) {
    unset %tmp.var | goto $$1
    :3 | .timer 1 $$2 _unbantmp $chan $address($nick,2) | set %tmp.var [tmpban: $+ $duration($$2) $+ ]
    :2 | mode $chan -o+b $nick $address($nick,2)
    :1 | kick $chan $nick $lg $$3 - $$4- %tmp.var $kickcont
    unset %tmp.var
  } 
}
alias -l  kickcont { inc %kicks | return ~ %kicks }
alias -l  fc.msg {
  if ($findfile($scriptdir\channels,$cchac_compchan($chan),1)) { 
    set -u %tmp.var $readini $scriptdir\channels\ $+ $cchac_compchan($chan) general $$1
  }
  if ($findfile($scriptdir\channels,$cchac_compchan($chan),1) == $null) {
    set -u %tmp.var $readini $scriptdir\channels\general.conf general $$1
  }
  if (%tmp.var == $null) set -u %tmp.var $read $scriptdir\kicks.txt
  %tmp.var = $replace(%tmp.var,$0,$nick)
  return %tmp.var
}
alias -l  lg return BaT
alias -l  fc.cont return ( $+ $1 $+  $+ $2 $+ /  $+ $round($3,2) $+   $+ $4 $+ )
alias -l  _unbantmp { if ($me isop $$1) mode $$1 -b $$2 }
alias -l  fc.castigonick {
  unset %tmp.var | goto $$1
  :3 | .timer 1 $fc.chan($comchan($newnick,%i),109) _unbantmp $comchan($newnick,%i) $newnick | set %tmp.var [tmpban: $+ $duration($fc.chan($comchan($newnick,%i),109)) $+ ] 
  :2 | mode $comchan($newnick,%i) -o+b $newnick $cchbanaddress($newnick)
  :1 | kick $comchan($newnick,%i) $newnick $lg $$2 - $$3- %tmp.var $kickcont
  unset %tmp.var
}
alias -l  fc.msgnick {
  if ($findfile($scriptdir\channels,$cchac_compchan($comchan($newnick,%i)),1)) { 
    set -u %tmp.var $readini $scriptdir\channels\ $+ $cchac_compchan($comchan($newnick,%i)) general $$1
  }
  if ($findfile($scriptdir\channels,$cchac_compchan($comchan($newnick,%i)),1) == $null) {
    set -u %tmp.var $readini $scriptdir\channels\general.conf general $$1
  }
  if (%tmp.var == $null) set -u %tmp.var $read $scriptdir\kicks.txt
  return %tmp.var
}
alias -l  fc.chan { if ($findfile($scriptdir\channels,$cchac_compchan($$1),1)) return $readini $scriptdir\channels\ $+ $cchac_compchan($$1) general $$2
else return $readini $scriptdir\channels\general.conf general $$2 }
on @1:text:*:#: {
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
On @*!:deop:#: {
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
on *!:nick: { %i = 1
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
