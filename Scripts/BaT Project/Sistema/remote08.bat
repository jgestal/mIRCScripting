;####################################;
;                                    ;
; BaT proyect by Fulg0re & Jimmy_RAY ;
;                                    ;
;     http://bat-proyect.da.ru       ;
;                                    ;
;                                    ;
;####################################;

alias chc {
  if ($dialog(chc)) dialog -v chc
  else dialog -m chc chc
}
dialog chc {
  title "BaT: Protección personal [/chc]"
  size -1 -1 265 225
  option dbu
  tab "Protección de Flood",1,5 0 255 200 

  check "Activar la protección de ctcp flood",2,20 15 100 10,tab 1
  combo 3,25 30 50 50,drop,tab 1
  edit "",4,80 30 20 10, center,tab 1
  text "ctcps en",5,100 32 30 10,center,tab 1
  edit "",6,130 30 20 10, center ,tab 1
  text "seg(s)",7,155 32 15 10,tab 1
  text "Ignorar por",8,175 32 30 10,tab 1
  edit "",9,205 30 20 10, center ,tab 1
  text "seg(s)",10,230 32 15 10,tab 1

  check "Activar la protección de msg flood",11,20 45 100 10,tab 1
  combo 12,25 60 50 50,drop,tab 1
  edit "",13,80 60 20 10, center,tab 1
  text "msgs en",14,100 62 30 10,center,tab 1
  edit "",15,130 60 20 10, center ,tab 1
  text "seg(s)",16,155 62 15 10,tab 1
  text "Ignorar por",17,175 62 30 10,tab 1
  edit "",18,205 60 20 10, center ,tab 1
  text "seg(s)",19,230 62 15 10,tab 1

  check "Activar la protección de query flood",20,20 75 100 10,tab 1
  combo 21,25 90 50 50,drop,tab 1
  edit "",22,80 90 20 10, center,tab 1
  text "querys en",23,100 92 30 10,center,tab 1
  edit "",24,130 90 20 10, center ,tab 1
  text "seg(s)",25,155 92 15 10,tab 1
  text "Ignorar por",26,175 92 30 10,tab 1
  edit "",27,205 90 20 10, center ,tab 1
  text "seg(s)",28,230 92 15 10,tab 1

  check "Activar la protección de notice flood",29,20 105 100 10,tab 1
  combo 30,25 120 50 50,drop,tab 1
  edit "",31,80 120 20 10, center,tab 1
  text "notices en",32,100 122 30 10,center,tab 1
  edit "",33,130 120 20 10, center ,tab 1
  text "seg(s)",34,155 122 15 10,tab 1
  text "Ignorar por",35,175 122 30 10,tab 1
  edit "",36,205 120 20 10, center ,tab 1
  text "seg(s)",37,230 122 15 10,tab 1

  check "Activar la protección de invite flood",38,20 135 100 10,tab 1
  combo 39,25 150 50 50,drop,tab 1
  edit "",40,80 150 20 10, center,tab 1
  text "invites en",41,100 152 30 10,center,tab 1
  edit "",42,130 150 20 10, center ,tab 1
  text "seg(s)",43,155 152 15 10,tab 1
  text "Ignorar por",44,175 152 30 10,tab 1
  edit "",45,205 150 20 10, center ,tab 1
  text "seg(s)",46,230 152 15 10,tab 1

  check "Activar la protección de dcc flood",47,20 165 100 10,tab 1
  combo 48,25 180 50 50,drop,tab 1
  edit "",49,80 180 20 10, center,tab 1
  text "dccs en",50,100 182 30 10,center,tab 1
  edit "",51,130 180 20 10, center,tab 1
  text "seg(s)",52,155 182 15 10,tab 1
  text "Ignorar por",53,175 182 30 10,tab 1
  edit "",54,205 180 20 10, center,tab 1
  text "seg(s)",55,230 183 15 10,tab 1
  button "Activar todas",100,5 205 65 15
  button "Desactivar todas",101,75 205 65 15
  button "Aceptar",102,195 205 65 15,default,ok
}
alias chc_combos1 return 3 12 21 30 39 48
alias chc_checks1 return 2 11 20 29 38 47
alias chc_edits1 return 4 6 9 13 15 18 22 24 27 31 33 36 40 42 45 49 51 54
alias chc_editsgrp1 return 4 13 22 31 40 49 
alias chc_editsgrp2 return 6 15 24 33 42 51
alias chc_editsgrp3 return 9 18 27 36 45 54
on 1:dialog:chc:init:*: { chc_loadconfig }
alias chc_loadconfig { %i = 1
  while ($gettok($chc_combos1,%i,32)) { did -r chc $gettok($chc_combos1,%i,32) | did -a chc $gettok($chc_combos1,%i,32) Baja | did -a chc $gettok($chc_combos1,%i,32) Media | did -a chc $gettok($chc_combos1,%i,32) Alta | did -a chc $gettok($chc_combos1,%i,32) Personal | did -c chc $gettok($chc_combos1,%i,32) $chc_readini($gettok($chc_combos1,%i,32)) | inc %i } 
  %i = 1
  while ($gettok($chc_checks1,%i,32)) { did $iif($chc_readini($gettok($chc_checks1,%i,32)) == on,-c,-u) chc $gettok($chc_checks1,%i,32) | did $iif($chc_readini($gettok($chc_checks1,%i,32)) == on,-e,-b) chc $calc($gettok($chc_checks1,%i,32) +1) $+ , $+ $calc($gettok($chc_checks1,%i,32) +2) $+ , $+ $calc($gettok($chc_checks1,%i,32) +3) $+ , $+ $calc($gettok($chc_checks1,%i,32) +4) $+ , $+ $calc($gettok($chc_checks1,%i,32) +5) $+ , $+ $calc($gettok($chc_checks1,%i,32) +6) $+ , $+ $calc($gettok($chc_checks1,%i,32) +7) $+ , $+ $calc($gettok($chc_checks1,%i,32) +8) | inc %i }
  %i = 1
while ($gettok($chc_edits1,%i,32)) { if ($chc_readini($gettok($chc_edits1,%i,32))) did -ra chc $gettok($chc_edits1,%i,32) $chc_readini($gettok($chc_edits1,%i,32)) | inc %i } }
on 1:dialog:chc:edit:*: { chc_writeini $did(chc,$did) | %i = 1
  while ($gettok($chc_editsgrp1,%i,32)) { if ($gettok($chc_editsgrp1,%i,32) == $did) { did -c chc $calc($did -1) 4 | chc_writeini2 $calc($did -1) 4 | goto end }
  inc %i }
  %i = 1
  while ($gettok($chc_editsgrp2,%i,32)) { if ($gettok($chc_editsgrp2,%i,32) == $did) { did -c chc $calc($did -3) 4 | chc_writeini2 $calc($did -3) 4 | goto end }
  inc %i }
  %i = 1
  while ($gettok($chc_editsgrp3,%i,32)) { if ($gettok($chc_editsgrp3,%i,32) == $did) { did -c chc $calc($did -6) 4 | chc_writeini2 $calc($did -6) 4 }
  inc %i }
  :end
}
on 1:dialog:chc:sclick:*: { if ($did == 100) { %i = 1
    while ($gettok($chc_checks1,%i,32)) { chc_writeini2 $gettok($chc_checks1,%i,32) on | inc %i }
  chc_loadconfig }
  if ($did == 101) { %i = 1
    while ($gettok($chc_checks1,%i,32)) { chc_writeini2 $gettok($chc_checks1,%i,32) | inc %i }
  chc_loadconfig }
  %i = 1 
  while ($gettok($chc_checks1,%i,32)) { if ($gettok($chc_checks1,%i,32) == $did) {
      if ($chc_readini($gettok($chc_checks1,%i,32)) == on) { chc_writeini | did -b chc $calc($did +1) $+ , $+ $calc($did +2) $+ , $+ $calc($did +3) $+ , $+ $calc($did +4) $+ , $+ $calc($did +5) $+ , $+ $calc($did +6) $+ , $+ $calc($did +7) $+ , $+ $calc($did +8) | break }
    elseif ($chc_readini($gettok($chc_checks1,%i,32)) != on) { chc_writeini on | did -e chc $calc($did +1) $+ , $+ $calc($did +2) $+ , $+ $calc($did +3) $+ , $+ $calc($did +4) $+ , $+ $calc($did +5) $+ , $+ $calc($did +6) $+ , $+ $calc($did +7) $+ , $+ $calc($did +8) | break } }
  inc %i }
  %i = 1
  while ($gettok($chc_combos1,%i,32)) { if ($gettok($chc_combos1,%i,32) == $did) { chc_writeini $did(chc,$did).sel | chc_changecombo1 | break }
inc %i } }
alias chc_readini { %tmp.var = $readini $mircdirdat\chc.ini general $$1 
if (%tmp.var) return %tmp.var }
alias chc_writeini { if ($1) writeini $mircdirdat\chc.ini general $did $1
else remini $mircdirdat\chc.ini general $did }
alias chc_writeini2 { if ($2) writeini $mircdirdat\chc.ini general $1 $2
else remini $mircdirdat\chc.ini general $1 }
alias chc_changecombo1 { if ($did(chc,$did).sel != 4) { set -u %tmp.var $readini $mircdirsistema\chcconf.ini $did $did(chc,$did).sel | did -ra chc $calc($did +1) $gettok(%tmp.var,1,32) | chc_writeini2 $calc($did +1) $gettok(%tmp.var,1,32) | did -ra chc $calc($did +3) $gettok(%tmp.var,2,32) | chc_writeini2 $calc($did +3) $gettok(%tmp.var,2,32) | did -ra chc $calc($did +6) $gettok(%tmp.var,3,32) | chc_writeini2 $calc($did +6) $gettok(%tmp.var,3,32) } }
alias _chc { return $readini $mircdirdat\chc.ini general $$1 }

;Formato de las variables: %pp_

ctcp ^*!:*:*: {
  if ($1 $2 == DCC SEND) {
    if ($_chc(47) == on) {
      if (%pp_dcc [ $+ [ $nick ] ] != $null) inc %pp_dcc [ $+ [ $nick ] ]
      if (%pp_dcc [ $+ [ $nick ] ] == $null) { 
        set -u $+ [ $_chc(51) ] %pp_dcctime_ [ $+ [ $nick ] ] $ticks
        set -u $+ [ $_chc(51) ] %pp_dcc [ $+ [ $nick ] ] 1
      }
      if (%pp_dcc [ $+ [ $nick ] ] >= $_chc(49)) {
        display informa -s DCC SEND FLOOD detectado $_chc(49) $+ dccsends/ $+ $round($calc(($ticks - %pp_dcctime_ [ $+ [ $nick ] ] ) /1000),2) $+ seg (Ignorando por $duration($_chc(36)) los envíos de $nick $+ )
        ignore -tu [ $+ [ $_chc(54) ] ] $nick
        haltdef
      }
    }
  }
  elseif ($1 $2 != DCC SEND) {
    if ($_chc(2) == on) {
      if (%pp_ctcp_ [ $+ [ $wildsite ] ] != $null) inc %pp_ctcp_ [ $+ [ $wildsite ] ]
      if (%pp_ctcp_ [ $+ [ $wildsite ] ] == $null) { 
        set -u $+ [ $_chc(6) ] %pp_ctcp_time_ [ $+ [ $wildsite ] ] $ticks
        set -u $+ [ $_chc(6) ] %pp_ctcp_ [ $+ [ $wildsite ] ] 1
      }
      if (%pp_ctcp_ [ $+ [ $wildsite ] ] >= $_chc(4)) {
        display informa -s CtcP Flood detectado $_chc(4) $+ ctcps/ $+ $round($calc(($ticks - %pp_ctcp_time_ [ $+ [ $wildsite ] ] ) /1000),2) $+ seg (Ignorando por $duration($_chc(9)) los ctcps de $wildsite $+ )
        ignore -tu [ $+ [ $_chc(9) ] ] $wildsite
        haltdef
      }
    }
  }
}
on ^1:text:*:?: {
  if ($_chc(11) == on) {
    if (%pp_msg [ $+ [ $nick ] ] != $null) inc %pp_msg [ $+ [ $nick ] ]
    if (%pp_msg [ $+ [ $nick ] ] == $null) { 
      set -u $+ [ $_chc(15) ] %pp_msgtime_ [ $+ [ $nick ] ] $ticks
      set -u $+ [ $_chc(15) ] %pp_msg [ $+ [ $nick ] ] 1
    }
    if (%pp_msg [ $+ [ $nick ] ] >= $_chc(13)) {
      display informa -s Privmsg detectado $_chc(13) $+ privmsgs/ $+ $round($calc(($ticks - %pp_msgtime_ [ $+ [ $nick ] ] ) /1000),2) $+ seg (Ignorando por $duration($_chc(18)) los msgs de $nick $+ )
      ignore -pu [ $+ [ $_chc(18) ] ] $nick
      haltdef
    }
  }
}
on ^1:open:?: {
  if ($_chc(20) == on) {
    if (%pp_query [ $+ [ $wildsite ] ] != $null) inc %pp_query [ $+ [ $wildsite ] ]
    if (%pp_query [ $+ [ $wildsite ] ] == $null) { 
      set -u $+ [ $_chc(24) ] %pp_querytime_ [ $+ [ $wildsite ] ] $ticks
      set -u $+ [ $_chc(24) ] %pp_query [ $+ [ $wildsite ] ] 1
    }
    if (%pp_query [ $+ [ $wildsite ] ] >= $_chc(22)) {
      display informa -s Query Flood detectado $_chc(22) $+ querys/ $+ $round($calc(($ticks - %pp_querytime_ [ $+ [ $wildsite ] ] ) /1000),2) $+ seg (Ignorando por $duration($_chc(27)) los querys de $wildsite $+ )
      ignore -pu [ $+ [ $_chc(27) ] ] $wildsite
      haltdef
    }
  }
}
on ^1:notice:*:*: {
  if ($_chc(29) == on) {
    if (%pp_not [ $+ [ $nick ] ] != $null) inc %pp_not [ $+ [ $nick ] ]
    if (%pp_not [ $+ [ $nick ] ] == $null) { 
      set -u $+ [ $_chc(33) ] %pp_nottime_ [ $+ [ $nick ] ] $ticks
      set -u $+ [ $_chc(33) ] %pp_not [ $+ [ $nick ] ] 1
    }
    if (%pp_not [ $+ [ $nick ] ] >= $_chc(31)) {
      display informa -s Notice Flood detectado $_chc(31) $+ notices/ $+ $round($calc(($ticks - %pp_nottime_ [ $+ [ $nick ] ] ) /1000),2) $+ seg (Ignorando por $duration($_chc(36)) los notices de $nick $+ )
      ignore -nu [ $+ [ $_chc(36) ] ] $nick
      haltdef
    }
  }
}
on ^1:invite:#: {
  if ($_chc(38) == on) {
    if (%pp_inv [ $+ [ $nick ] ] != $null) inc %pp_inv [ $+ [ $nick ] ]
    if (%pp_inv [ $+ [ $nick ] ] == $null) { 
      set -u $+ [ $_chc(42) ] %pp_invtime_ [ $+ [ $nick ] ] $ticks
      set -u $+ [ $_chc(42) ] %pp_inv [ $+ [ $nick ] ] 1
    }
    if (%pp_inv [ $+ [ $nick ] ] >= $_chc(40)) {
      display informa -s Invite Flood detectado $_chc(40) $+ invitaciones/ $+ $round($calc(($ticks - %pp_invtime_ [ $+ [ $nick ] ] ) /1000),2) $+ seg (Ignorando por $duration($_chc(36)) las invitaciones de $nick $+ )
      ignore -iu [ $+ [ $_chc(45) ] ] $nick
      haltdef
    }
  }
}
