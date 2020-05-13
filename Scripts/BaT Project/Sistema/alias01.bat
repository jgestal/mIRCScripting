;####################################;
;                                    ;
; BaT proyect by Fulg0re & Jimmy_RAY ;
;                                    ;
;     http://bat-proyect.da.ru       ;
;                                    ;
;                                    ;
;####################################;

q query $1-
bxreason { var %i | %i = $read dat\BitchX.txt | %i = $replace(%i,$0,$1) | return %i }
kick { if ($$2) { var %x = $3- | if (%x == $null) %x = $bxreason($2) | kick $$1 $$2 $lgfijo %x $kickcont } | unset %x }
kickcont { inc %kicks | return ~ %kicks }
who {
  if ($1- != $null) who $1- 
  elseif (($active ischan) || ($query($active))) who $active 
  else display informa -a error, usa /who #canal/nick/máscara
}
digral return $readini dat\conf.ini general $1
lgfijo return BaT
clones {
  if ($1 ischan) set %cscan $1 | else set %cscan $chan
  if (%cscan !ischan) { display aviso -a No has especificado un canal para el scan de clones | halt } 
  display informa %cscan Clon Scan ( $+ %cscan $+ )
  set %cstemp 1 
  while ($address($nick(%cscan,%cstemp,a),2)) { 
    set %csip $address($nick(%cscan,%cstemp,a),2)
    if (($ialchan(%csip,%cscan,2)) && ($istok(%csenc,%csip,32) == $false)) set %csenc %csenc %csip | inc %cstemp 
  }
  if (%csenc == $null) display informa %cscan No se han encontrado clones 
  :scan 
  set %cstemp3 1
  while (%cstemp3 <= $numtok(%csenc,32)) {
    set %cstemp2 1
    while (%cstemp2 <= $ialchan($gettok(%csenc,%cstemp3,32),%cscan,0)) { 
      set %csnicks %csnicks $ialchan($gettok(%csenc,%cstemp3,32),%cscan,%cstemp2).nick 
      inc %cstemp2
    }
    display informa2 -a %cstemp3 $+ . $gettok(%csenc,%cstemp3,32) $+ : %csnicks ( $+ $numtok(%csnicks,32) $+ )
    unset %csnicks 
    inc %cstemp3
  }
  display informa2 %cscan $t %lgsc Total: $numtok(%csenc,32) ips con clones
  display informa %cscan $t %lgs Clon Scan ( $+ %cscan $+ ) %lgs2
  unset %csenc %cscan %cstemp1 %cstemp2 %cstemp3 %csenc
}
idscan {
  set %canal $chan | set %total 0 | set %idvar 1
  if ($1 == $null) { set %idscan.ip $$?="Escribe una ID para el scan" } | else { set %idscan.id $1 } 
  display informa %canal ID Scan ( $+ %idscan.id / %canal $+ )
  :busqueda
  if ($nick(%canal,%idvar) == $null) goto fin
  set %idtemp $address($nick(%canal,%idvar),3)
  set %idtemp $gettok(%idtemp,1,64)
  set %idtemp $remove(%idtemp,*!*)
  if ((%idscan.id == %idtemp) || (%idscan.id isin %idtemp) || (%idscan.id iswm %idtemp)) { goto encontrado }
  else { inc %idvar | goto busqueda }
  :encontrado
  inc %total
  display informa2 %canal %total $+ . $nick(%canal,%idvar) ( $+ $address($nick(%canal,%idvar),1) $+ )
  inc %idvar | goto busqueda
  :fin
  if (%total == 0) { display informa %canal No se han encontrado coincidencias }
  else { display informa2 %canal Total: %total coincidencias }
  display informa %canal ID Scan ( $+ %idscan.id / %canal $+ ) 
  unset %idvar %total %idtemp %idscan.id
}
ipscan {
  set %canal $chan | set %total 0 | set %ipvar 1
  if ($1 == $null) { set %ipscan.ip $$?="Escribe una IP para el scan" } | else { set %ipscan.ip $1 } 
  display informa %canal IP Scan ( $+ %ipscan.ip / %canal $+ )
  :busqueda
  if ($nick(%canal,%ipvar) == $null) goto fin
  set %iptemp $address($nick(%canal,%ipvar),2)
  if ((%ipscan.ip == %iptemp) || (%ipscan.ip isin %iptemp) || (%ipscan.ip iswm %iptemp)) { goto encontrado }
  else { inc %ipvar | goto busqueda }
  :encontrado
  inc %total
  display informa2 %canal %lgsc %total $+ . $nick(%canal,%ipvar) ( $+ %iptemp $+ )
  inc %ipvar | goto busqueda
  :fin
  if (%total == 0) { display informa %canal No se han encontrado coincidencias }
  else { display informa2 %canal Total: %total coincidencias }
  display informa %canal IP Scan ( $+ %ipscan.ip / %canal $+ )
  unset %ipvar %total %iptemp %ipscan.ip
}
bbm { if ($me isop $1) { .disable #baneados | .enable #bbm | mode $1 +b } | else { display informa -a No tienes op } }
bbt { if ($me isop $1) { .disable #baneados | .enable #bbt | mode $1 +b } | else { display informa -a No tienes op } }
identify .msg nick@deep.space identify $1-
cycle %clavecanal = $chan(#).key | part # BaT:Cycle... | .raw join # %clavecanal | unset %clavecanal 
k { kick $chan $1 $2- }
kb {  mode $chan -o+b $1 $1 | kick $chan $1 $2- }
w whois $1
j join #$$1 $2-
dentify .msg nick@deep.space identify $1-
f1 kb $snick($chan,1)
f4 %f4 | unset %f4
f5 %f5 | unset %f5
f9 %f9 | unset %f9
f12 server %servidor
clock {
  if ( $1 == On ) { set %clock On | set %lag 0.00 | update }
  elseif ($1 == Off) {  .timerclock off | set %clock Off | titlebar & BaT: BrAvOs AsSaULt TeaM }
  else { display informa Utiliza /clock [On/Off] }
}
update {
  .timerclock off
  if ($server == $null) {
    titlebar & BaT Esperando conexión...
    .timer100 $nextsec 1 1 update 
  }
  else {
    set %barra.conecta.final $duration($calc($ctime - %time.conexion))
    set %barra.conecta.final $replace(%barra.conecta.final,mins,m,secs,s,sec,s,min,m,hrs,h,hr,h,days,dias)
    if ($away) {
      set %barra.away.final $duration($calc($ctime - %aw.inicio))
      set %barra.away.final $replace(%barra.away.final,mins,m,secs,s,sec,s,min,m,hrs,h,hr,h,days,dias)
    }
    if ($idle > 60) {
      set %barra.idle.final $duration($idle)
      set %barra.idle.final $replace(%barra.idle.final,mins,m,secs,s,sec,s,min,m,hrs,h,hr,h,days,dias)

      ;      set %barra.idle.min $int($calc($idle / 60))) | set %barra.idle.horas $int($calc(($idle / 60) / 60)) | set %barra.idle.min $calc(%barra.idle.min - (%barra.idle.horas * 60)) 
      ;      if (%barra.idle.min < 10) { set %barra.idle.min.cero 0 } | set %barra.idle.final %barra.idle.horas $+ h $+ %barra.idle.min.cero $+ %barra.idle.min $+ m | unset %barra.idle.min.cero

      if (($idle == $diaw(idawayc)) && ($away != $true) && ($diaw(idaway) == On)) { confaaway }

      if ($away) { set %pon.title $me $chr(91) $+ $usermode $+ /Away( $+ %barra.away.final $+ ) en $server $+ $chr(93) $chr(91) $+ Lag: %lag $+ /Idle: %barra.idle.final $+ $chr(93) }
      else { set %pon.title $chr(91) $+ $me ( $+ $usermode $+ ) en $server $+ $chr(93) $chr(91) $+ Lag: %lag $+ /Idle: %barra.idle.final $+ $chr(93) }
      if ($active == Status Window) set %pon.title %pon.title $chr(91) $+ Canales: $chan(0) $+ $chr(93) $chr(91) $+ Conectado: %barra.conecta.final $+ $chr(93)
      if ($active ischan) set %pon.title %pon.title $chr(91) $+ Op: $nick($active,0,o) $+ /Voz: $nick($active,0,v) $+ /Tot: $nick($active,0,a) $+ $chr(93) 
      titlebar %pon.title
      .timer100 $nextsec 1 1 update 
    }
    else {
      if ($away) { set %pon.title $chr(91) $+ $me ( $+ $usermode $+ /Away( $+ %barra.away.final $+ )) en $server $+ $chr(93) $chr(91) $+ Lag: %lag $+ $chr(93) }
      else { set %pon.title [[ $+ $me ( $+ $usermode $+ ) en $server $+ ]] [Lag: %lag $+ ]] }

      if ($active == Status Window) set %pon.title %pon.title [Canales: $chan(0) $+ ] [Conectado: %barra.conecta.final $+ ]
      if ($active ischan) set %pon.title %pon.title [Op: $nick($active,0,o) $+ /Voz: $nick($active,0,v) $+ /Tot: $nick($active,0,a) $+ ] 
      titlebar %pon.title
      unset %pon.title*
      .timer100 1 1 update
    }
  }
}

;----- --- --- -- - - Identificadores para BaT y para Dialogs - - -- --- ---- -----;
loadcombo { set -u %i 0 | :loop | inc %i | set -u %tmp.var $read -l %i $1 | if (%tmp.var) { did -a $2 $3 %tmp.var | goto loop } }
cdig { if ($dialog($2)) display informa -a El dialog $2 está actualmente en uso. | else dialog -m $1 $2 }
isintxt { set -u %i 0 | :loop | inc %i | set -u %tmp.var $read -l %i $1 | if (%tmp.var) { if ($2- == %tmp.var) return $true | goto loop } | return $false }
deline { set -u %i 0 | :loop | inc %i | set -u %tmp.var $read -l %i $1 | if (%tmp.var) { if ($2- == %tmp.var) write -dl $+ %i $1 | goto loop } }
red return %red
ng return  $+ $1- $+ 
sb return  $+ $1- $+ 
sbn return  $+ $1- 
jnl return
jnn return
comcan {
  unset %comunes %comcan
  if (($comchan($1,0) == $null) || ($comchan($1,0) == 0)) { return Ninguno | goto fin }
  set %comunes 0 | :inicio | inc %comunes | set %comcan %comcan $comchan($1,%comunes)
  if (%comunes ==  $comchan($1,0)) { } | else goto inicio
  unset %comunes | return %comcan | :fin
}
ctcp {
  if ($2 == $null) { echo -a $ts $lgf Uso: /ctcp <nick/canal> <ctcp> | return }
  ;  if ($2 == PING) { if (# isin $1-) { set %ctcp.ping.canal $1 | who ping $1 | goto end } | set %lag. [ $+ [ $1 ] ] $ticks }
  if ($2 == PING) { set %lag. [ $+ [ $1 ] ] $ticks }
  if ($show) { echo -ta -> 12[ctcp2( $+ $1 $+ 2)12] $upper($2) $3- }
  :end
  .ctcp $1-
  halt
}
dns .dns $1-
msg { if ($2) { if ($show) { display mmsg $$1- } | .msg $$1- } | else display informa -a Usa /msg nick msg }
notice { if ($show) display mnotice $1- | .notice $1- }
onotice { 
  if ($me !isop $chan) { echo -ta $lgn Debes tener op para utilizar el /onotice | halt }
  if ($1 == $chan) { if ($show) { display monotice $1- } | .onotice $1- }
  else { if ($show) { display monotice $chan $1- } | .onotice $chan $1- }
}
raw .raw $1- | if ($show) echo -a $ts -> 12[Servidor12] $1-
notify if ($1 != -r) { .notify $1- | if ($show) display informa -a Añadiendo a $1 a tu lista de Notify } | else { .notify $1- | if ($show) display informa -a Borrando a $2 de tu lista de notify }
;--
;--
jncalcclon {
  unset %jnclno %jnclni
  if (%ver.joinclones == Off) { halt }
  if $ial($address($$1,2),0) > 5 { if ($address($me,2) ==  $address($$1,2)) { set %jnclno $ial($address($$1,2),0) 2(Tu host2) } | else set %jnclno $ial($address($$1,2),0) }
  if $ial($address($$1,2),0) > 1 { 
    set %cont 2 | set %jnclon $ial($address($$1,2),1).nick
    :inicio | set %jnclon %jnclon $+ , $+ $ial($address($$1,2),%cont).nick | inc %cont 1 | if ( %cont <= $ial($address($$1,2),0) ) goto inicio
    if ($address($me,2) ==  $address($$1,2)) { set %jnclno $ial($address($$1,2),0) | set %jnclni %jnclon (Tu host) } | else { set %jnclno $ial($address($$1,2),0) | set %jnclni %jnclon }
  }
  :finito | unset %jnclon %cont
}
ialcalc {
  unset %ialcalc.* | set %ialcalc.total $ial($$1,0)
  :cont | inc %ialcalc.c 1 | set %ialcalc.fin %ialcalc.fin $ial($$1,%ialcalc.c).nick
  if (%ialcalc.c == %ialcalc.total) { return %ialcalc.fin } | if (%ialcalc.c > 50) { return Nadie en el canal }
  goto cont
}
massop {
  var %i, var %x
  unset %x
  %i = 1
  while ($nick($chan,%i)) {
    if ($nick($chan,%i) !isop $chan) %x = %x $nick($chan,%i)
    if ($gettok(%x,6,32)) { mode $chan oooooo %x | unset %x }
    inc %i
  }
  if (%x) mode $chan ooooo %x
  unset %i %x
}
massdeop {
  var %i, var %x
  unset %x
  %i = 1
  while ($nick($chan,%i)) {
    if ($nick($chan,%i) isop $chan) && ($nick($chan,%i) != $me) %x = %x $nick($chan,%i)
    if ($gettok(%x,6,32)) { mode $chan -oooooo %x | unset %x }
    inc %i
  }
  if (%x) mode $chan -ooooo %x
  unset %i %x
}
massvoice {
  var %i, var %x
  unset %x
  %i = 1
  while ($nick($chan,%i)) {
    if ($nick($chan,%i) !isvo $chan) %x = %x $nick($chan,%i)
    if ($gettok(%x,6,32)) { mode $chan vvvvvvv %x | unset %x }
    inc %i
  }
  if (%x) mode $chan vvvvv %x
  unset %i %x
}
massdevoice {
  var %i, var %x
  unset %x
  %i = 1
  while ($nick($chan,%i)) {
    if ($nick($chan,%i) isvo $chan) %x = %x $nick($chan,%i)
    if ($gettok(%x,6,32)) { mode $chan -vvvvvv %x | unset %x }
    inc %i
  }
  if (%x) mode $chan -vvvvv %x
  unset %i %x
}
masskick {
  darazon
  var %i
  %i = 1
  while ($nick($chan,%i)) {
    if ($nick($chan,%i) != $me) kick $chan $nick($chan,%i) %razond
    inc %i
  }
  unset %i 
}
masskickban {
  darazon
  var %i
  %i = 1
  while ($nick($chan,%i)) {
    if ($nick($chan,%i) != $me) { mode $chan -o+b $nick($chan,%i) $nick($chan,%i) | kick $chan $nick($chan,%i) %razond }
    inc %i
  }
  unset %i 
}
;
smassop {
  var %i, var %x
  unset %x
  %i = 1
  while ($snick($chan,%i)) {
    if ($snick($chan,%i) !isop $chan) %x = %x $snick($chan,%i)
    if ($gettok(%x,6,32)) { mode $chan oooooo %x | unset %x }
    inc %i
  }
  if (%x) mode $chan ooooo %x
  unset %i %x
}
smassdeop {
  var %i, var %x
  unset %x
  %i = 1
  while ($snick($chan,%i)) {
    if ($snick($chan,%i) isop $chan) %x = %x $snick($chan,%i)
    if ($gettok(%x,6,32)) { mode $chan -oooooo %x | unset %x }
    inc %i
  }
  if (%x) mode $chan -ooooo %x
  unset %i %x
}
smassvoice {
  var %i, var %x
  unset %x
  %i = 1
  while ($snick($chan,%i)) {
    if ($snick($chan,%i) !isvo $chan) %x = %x $snick($chan,%i)
    if ($gettok(%x,6,32)) { mode $chan vvvvvvv %x | unset %x }
    inc %i
  }
  if (%x) mode $chan vvvvv %x
  unset %i %x
}
smassdevoice {
  var %i, var %x
  unset %x
  %i = 1
  while ($snick($chan,%i)) {
    if ($snick($chan,%i) isvo $chan) %x = %x $snick($chan,%i)
    if ($gettok(%x,6,32)) { mode $chan -vvvvvv %x | unset %x }
    inc %i
  }
  if (%x) mode $chan -vvvvv %x
  unset %i %x
}
smasskick {
  darazon
  var %i
  %i = 1
  while ($snick($chan,%i)) {
    if ($snick($chan,%i) != $me) kick $chan $snick($chan,%i) %razond
    inc %i
  }
  unset %i 
}
smasskickban {
  darazon
  var %i
  %i = 1
  while ($snick($chan,%i)) {
    if ($snick($chan,%i) != $me) { mode $chan -o+b $snick($chan,%i) $snick($chan,%i) | kick $chan $snick($chan,%i) %razond }
    inc %i
  }
  unset %i 
}
; else { if ($me isop $active) $brny(@,$active,$me,$1-) | elseif ($me isvo $active) $brny(+,$active,$me,$1-) | else $brny(!,$active,$me,$1-) | .msg $active $1- }


stat {
  set %saytemp 2os[ $+ $dll(dll\moo.dll,osinfo,_) $+ ] 2uptime[ $+ $dll(dll\moo.dll,uptime,_) $+ ] 2cpu[ $+ $dll(dll\moo.dll,cpuinfo,_) $+ ] 2mem[ $+ $dll(dll\moo.dll,meminfo,_) $+ ]
  if ($me isop $active) $brny(@,$active,$me,%saytemp) | elseif ($me isvo $active) $brny(+,$active,$me,%saytemp) | else $brny(!,$active,$me,%saytemp)
  .msg $active 2os[ $+ $dll(dll\moo.dll,osinfo,_) $+ ] 2uptime[ $+ $dll(dll\moo.dll,uptime,_) $+ ] 2cpu[ $+ $dll(dll\moo.dll,cpuinfo,_) $+ ] 2mem[ $+ $dll(dll\moo.dll,meminfo,_) $+ ]
  unset %saytemp
}
uptime {
  set %saytemp :: $+ $dll(dll\moo.dll,osinfo,_) uptime - $dll(dll\moo.dll,uptime,_)
  if ($me isop $active) $brny(@,$active,$me,%saytemp) | elseif ($me isvo $active) $brny(+,$active,$me,%saytemp) | else $brny(!,$active,$me,%saytemp)
  .msg $active :: $+ $dll(dll\moo.dll,osinfo,_) uptime - $dll(dll\moo.dll,uptime,_)
  unset %saytemp
}
