;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BaT No Flood! v1.0
;; BAT (BravoS AssAulT TeaM)     
;;
;; Escrito por Jimmy_RAY
;;
;; http://jimmyray.da.ru
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

on 1:load: { .reload -rs2 $script }
alias fc { if ($findfile($mircdirdat\channels,$cchac_compchan($chan),1)) return $readini dat\channels\ $+ $cchac_compchan($chan) general $$1
else return $readini dat\channels\general.conf general $$1 }
alias cchbanaddress { if ($fc(142) == 1) return $1
else return $address($1,$calc($fc(142) +1)) }

alias fc.castigo {
  if ($cchbanaddress($nick) != $cchbanaddress($me)) {
    unset %tmp.var | goto $$1
    :3 | .timer 1 $$2 _unbantmp $chan $cchbanaddress($nick) | set %tmp.var [tmpban: $+ $duration($$2) $+ ]
    :2 | mode $chan -o+b $nick $cchbanaddress($nick)
    :1 | kick $chan $nick $lg $$3 - $$4- %tmp.var $kickcont
    unset %tmp.var
  }
}
alias fc.castigoip {
  if ($address($nick,2) != $address($me,2)) {
    unset %tmp.var | goto $$1
    :3 | .timer 1 $$2 _unbantmp $chan $address($nick,2) | set %tmp.var [tmpban: $+ $duration($$2) $+ ]
    :2 | mode $chan -o+b $nick $address($nick,2)
    :1 | kick $chan $nick $lg $$3 - $$4- %tmp.var $kickcont
    unset %tmp.var
  } 
}
alias kickcont { inc %kicks | return ~ %kicks }
alias fc.msg {
  if ($findfile($mircdirdat\channels,$cchac_compchan($chan),1)) { 
    set -u %tmp.var $readini $mircdirdat\channels\ $+ $cchac_compchan($chan) general $$1
  }
  if ($findfile($mircdirdat\channels,$cchac_compchan($chan),1) == $null) {
    set -u %tmp.var $readini $mircdirdat\channels\general.conf general $$1
  }
  if (%tmp.var == $null) set -u %tmp.var $read $mircdirdat\kicks.txt
  return %tmp.var
}
alias lg return BaT
alias fc.cont return ( $+ $1 $+  $+ $2 $+ /  $+ $round($3,2) $+   $+ $4 $+ )
alias _unbantmp { if ($me isop $$1) mode $$1 -b $$2 }
alias fc.castigonick {
  unset %tmp.var | goto $$1
  :3 | .timer 1 $fc.chan($comchan($newnick,%i),109) _unbantmp $comchan($newnick,%i) $newnick | set %tmp.var [tmpban: $+ $duration($fc.chan($comchan($newnick,%i),109)) $+ ] 
  :2 | mode $comchan($newnick,%i) -o+b $newnick $cchbanaddress($newnick)
  :1 | kick $comchan($newnick,%i) $newnick $lg $$2 - $$3- %tmp.var $kickcont
  unset %tmp.var
}
alias fc.msgnick {
  if ($findfile($mircdirdat\channels,$cchac_compchan($comchan($newnick,%i)),1)) { 
    set -u %tmp.var $readini $mircdirdat\channels\ $+ $cchac_compchan($comchan($newnick,%i)) general $$1
  }
  if ($findfile($mircdirdat\channels,$cchac_compchan($comchan($newnick,%i)),1) == $null) {
    set -u %tmp.var $readini $mircdirdat\channels\general.conf general $$1
  }
  if (%tmp.var == $null) set -u %tmp.var $read $mircdirdat\kicks.txt
  return %tmp.var
}
alias fc.chan { if ($findfile($mircdirdat\channels,$cchac_compchan($$1),1)) return $readini dat\channels\ $+ $cchac_compchan($$1) general $$2
else return $readini dat\channels\general.conf general $$2 }
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
