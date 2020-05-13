;####################################;
;                                    ;
; BaT proyect by Fulg0re & Jimmy_RAY ;
;                                    ;
;     http://bat-proyect.da.ru       ;
;                                    ;
;                                    ;
;####################################;

on ^*:invite:*: if (($nick == CHaN) && (%baninv)) { unset %baninv | join #chan | haltdef } | set %f4 join $chan | display invite $chan $nick | haltdef 
on ^*:usermode:display mmode $1 | haltdef
on ^*:notify: display notify $nick $notify($nick).note | haltdef
on ^*:unotify: display unotify $nick | haltdef
on ^*:serverop: echo -ts serverop | if ($opnick != $me) cline $cnl(op) $chan $opnick
on ^*:serverdeop:{ if ($opnick != $me) { if ($opnick isvo $chan) { cline $cnl(voz) $chan $opnick } | else { cline $cnl(normal) $chan $opnick } } } 
on ^*:op:*:if ($opnick != $me) cline $cnl(op) $chan $opnick 
on ^*:deop:*:{ if ($opnick != $me) { if ($opnick isvo $chan) { cline $cnl(voz) $chan $opnick } | else { cline $cnl(normal) $chan $opnick } } }
on ^*:voice:*: if (($opnick !isop $chan) && ($opnick != $me)) cline $cnl(voz) $chan $opnick
on ^*:devoice:*: if (($opnick !isop $chan) && ($opnick != $me)) cline $cnl(normal) $chan $opnick
on ^*:join:*:{ if ($nick == $me) { inc %we | set %join.ticks. [ $+ [ $chan ] ] $ticks | .raw who $chan | display joinme $chan $nick $address } | else { jncalcclon $nick | display join $chan $nick $address | cline $cnl(normal) $chan $nick } | haltdef }
on ^*:part:*: display part $chan $nick $address $1- | haltdef
on ^*:quit: { set %ndc 1 | while ($chan(%ndc)) { if ($nick ison $chan(%ndc)) { display quit $chan(%ndc) $nick $1- } | inc %ndc } | unset %ndc | if ($query($nick)) display quit $query($nick) $nick $1- | haltdef }
on ^*:rawmode:#: display rawmode $chan $nick $1- | haltdef
on ^*:ban:#: { if $ialcalc($banmask) != nadie en el canal) { display baneado $chan $ialcalc($banmask) } | set %ub. [ $+ [ $chan ] ] $banmask }
on ^*:kick:#: display kick $chan $nick $knick $1- | haltdef
on ^*:topic:#:display topic $chan $nick $1- | haltdef
on ^*:nick: { set %ndc 1 | while ($chan(%ndc)) { if ($newnick ison $chan(%ndc)) { display nick $chan(%ndc) $nick $newnick } | inc %ndc } | unset %ndc | haltdef }
on *:open:?:{ display query $nick $address | if (($away == $false) || (($away) && (%flashaway))) flash Query $nick }
; msgs varios ;
on ^*:text:*:#: { 
  if (($active != $chan) && ($me isin $strip($1-))) { $brnn($chan,$nick,$1-) }
  if ($nick isop $chan) $brn(@,$chan,$nick,$1-)
  elseif ($nick isvo $chan) $brn(+,$chan,$nick,$1-)
  else $brn(!,$chan,$nick,$1-)
  haltdef
}
on ^*:text:*:?:{ $brn(!,$nick,$nick,$1-) | haltdef }
on ^*:chat:*: { $brn(!,=$nick,$nick,$1-) | haltdef }
on ^*:action:*:#: {
  if ($nick isop $chan) $actn(@,$chan,$nick,$1-)
  elseif ($nick isvo $chan) $actn(+,$chan,$nick,$1-)
  else $actn(!,$chan,$nick,$1-)
  haltdef
}
on ^*:action:*:?: { $actn(!,$nick,$nick,$1-) | haltdef }
on ^*:notice:*:*:{
  if (# != $null) { set %notice.chan $target | set %notice.where $target | if ($left($target,1) == @) { set %notice.where $right($target,-1) | set %notice.chan @ $+ %notice.where } | display notice %notice.where $nick %notice.chan $address $1- }
  else { display privnotice $nick $address $1- }
  unset %notice.chan %notice.where | haltdef
}
on *:input:*: {
  if ($left($active,1) == @) halt
  if ($left($1-,1) != / ) {
    if ($target == Status Window) { display informa -a No estás en ningún canal | haltdef }
    if (($active ischan) && ($1 ison $chan) && (%nk == On)) { if ($me isop $active) $brny(@,$chan,$me,$nc($1,%nk.num),$2-) | elseif ($me isvo $active) $brny(+,$chan,$me,$nc($1,%nk.num),$2-) | else $brny(!,$chan,$me,$nc($1,%nk.num),$2-) | .msg $active $nc($1,%nk.num) $2- }
    else { if ($me isop $active) $brny(@,$active,$me,$1-) | elseif ($me isvo $active) $brny(+,$active,$me,$1-) | else $brny(!,$active,$me,$1-) | .msg $active $1- }
    haltdef
  }
}
on *:dns: {
  If ($raddress == $null) { goto fallo }
  :dns | display dnsres $nick ( $+ $address $+ ) $raddress | goto end
  :fallo | display dnsfallo $nick ( $+ $address $+ )
  :end | haltdef
}
; raws ;
; raws ;
; raws ;
; raws ;
; raws ;
raw 1:*:haltdef
raw 2:*:{ set %arr.host $5 | set %arr.vers $8 | haltdef }
raw 3:*:{ set %arr.creat $7- | haltdef }
raw 4:*:{ set %arr.serv $2 | set %arr.mp $4 | set %arr.mc $5 | thrini }
raw 251:*: { %lus.user = $4 + $7 | %lus.norm = $4 | %lus.inv = $7 | %lus.serv = $10 | %lus.medser = %lus.user / $10 | haltdef }
raw 252:*: { %lus.op = $2 | %lus.usop = %lus.user / %lus.op | haltdef }
raw 253:*: { %lus.condes = $2 | haltdef }
raw 254:*: { %lus.can = $2 | %lus.userchan = %lus.user / %lus.can | haltdef }
raw 255:*: { %lus.client = $4 | %lus.servs = $7 | thlusers }
raw 301:*: wh.away $3- | haltdef
raw 305:*: display back | haltdef
raw 306:*: display away | haltdef
raw 307:*: wh.nprot | haltdef
raw 310:*: wh.oper | haltdef
raw 311:*: wh.nick $2  ( $+ $3 $+ @ $+ $4 $+ ) $6- | haltdef
raw 312:*: wh.server $3 $4- | haltdef
raw 313:*: wh.ircop | haltdef
raw 317:*: wh.idle $3 $4 | haltdef
raw 318:*: wh.end $2 | haltdef
raw 319:*: wh.canales $2 $3- | haltdef
raw 332:*: set %topic $3- | haltdef
raw 333:*: set %topic.por $3 | set %topic.dia $gettok($asctime($4),1-3,32) | set %topic.hora $gettok($asctime($4),4,32) | display settopic $2 %topic.por %topic.hora %topic.dia %topic | unset %topic %topic.por %topic.dia %topic.hora | haltdef
raw 341:*: display minvite $3 $2 | haltdef 
raw 353:*: display names $3 $4- | haltdef 
raw 366:*: display finnames | haltdef 
raw 372:*: display informa -s $2- | haltdef
raw 375:*: display informa -s MOTD ( $+ $server $+ ) | haltdef
raw 376:*: display informa -s MOTD ( $+ $server $+ ) | haltdef
raw 378:*: wh.dirvirt $5- | haltdef
raw 401:*: display noesta $2 | haltdef 
raw 404:*: display noenvtext $2 | haltdef
raw 421:*: display badcom $2 | haltdef
raw 422:*: display raw422 | haltdef
raw 471:*: display raw471 $2 | haltdef
raw 473:*: display raw473 $2 | haltdef
raw 474:*: set %baninv 1 | .msg chan invite $2 $me | display raw474 $2 | haltdef
raw 475:*: display raw475 $2 | haltdef

raw 352:*: {
  if (%we == 0) {
    if ($window(@who) == $null) { set %whotmpcont 0 | window -khl -t5,25,30,35,50,60 +e @Who -1 -1 650 400 @who | aline @who $chr(160) | aline @who Nick $+ $chr(9) $+ Dirección $+ $chr(9) $+ Away $+ $chr(9) $+ Ircop $+ $chr(9) $+ Servidor $+ $chr(9) $+ Comentario | aline @who $chr(160) }
    inc %whotmpcont | aline @who $6 $+ $chr(9) $+ $3 $+ 2@ $+ $4 $+ $chr(9) $iif(g isin $7,12Si,No) $+ $chr(9) $+ $iif(* isin $7,4Si,No) $+ $chr(9) $+ $5 ( $+ $8 hops) $+ $chr(9) $+ $replace($9-,$chr(32),$chr(160))
  }
  else {
    if (G isin $7) {  inc %aways. [ $+ [ $2 ] ] | set %naways. [ $+ [ $2 ] ] %naways. [ $+ [ $2 ] ] $6 }
    if (* isin $7) { cline $cnl(cop) $2 $6 | inc %cops. [ $+ [ $2 ] ] | set %ncops. [ $+ [ $2 ] ] %ncops. [ $+ [ $2 ] ] $6 | goto fin }
    if ($6 == $me) { cline $cnl(yo) $2 $6 } 
    elseif ($6 isop $2) { cline $cnl(op) $2 $6 } | elseif ($6 isvo $2) { cline $cnl(voz) $2 $6 } 
    else { cline $cnl(normal) $2 $6 }
    :fin
  }
  haltdef 
}
raw 315:*:{
  if (%we == 0) {
    window -arb @who
    titlebar @who Nicks totales: %whotmpcont
  }
  else {
    set %join.ticks $calc($calc($ticks - %join.ticks. [ $+ [ $2 ] ] ) / 1000) 
    if (%cops. [ $+ [ $2 ] ] != $null) set %ecjo-cop. [ $+ [ $2 ] ] [IRCops ( [ $+ [ %cops. [ $+ [ $2 ] ] ] $+ ] ): [ [ %ncops. [ $+ [ $2 ] ] ] $+ ] ]
    if (%aways. [ $+ [ $2 ] ] != $null) set %ecjo-away. [ $+ [ $2 ] ] [Aways ( [ $+ [ %aways. [ $+ [ $2 ] ] ] $+ ] ): [ [ %naways. [ $+ [ $2 ] ] ] $+ ] ]
    display jncomp $2 $t %join.ticks s. %ecjo-cop. [ $+ [ $2 ] ] %ecjo-away. [ $+ [ $2 ] ]
    unset %join.ticks %join.ticks. [ $+ [ $2 ] ] %ncops. [ $+ [ $2 ] ] %cops. [ $+ [ $2 ] ] %aways. [ $+ [ $2 ] ] %naways. [ $+ [ $2 ] ] %ecjo-cop. [ $+ [ $2 ] ] %ecjo-away. [ $+ [ $2 ] ] | dec %we 
  }
  haltdef
}
#baneados off
raw 367:*: {
  if ( %cwho == 0 ) || (%cwho == $null) { set %cwho 1 | display titulo $2 Lista de Bans | display informa2 $2  $+ %cwho $+ . $3 [puesto por $4 ( $+ $asctime($5) $+ )] | if ($4 == $me) set %banpormi 1 } 
  else {   inc %cwho 1 | display informa2 $2  $+ %cwho $+ . $3 [puesto por $4 ( $+ $asctime($5) $+ )] | if ($4 == $me) inc %banpormi }
  haltdef
}
raw 368:*: {
  if (%cwho == 0) { display informa $2 No se encontraron bans en $2 | unset %borraban %baneados | haltdef }
  display informa2 $2 Total: %cwho bans $iif(%banpormi, [ ( $+ [ %banpormi ] puestos por ti) ] ) | set %cwho 0 | display titulo $2 Lista de Bans
  .disable #baneados | unset %baneados %borrabanset %banpormi | .timer 1 3 set %listaban Off | haltdef
}
#baneados end
#bbm off
raw 367:*: { if ($4 == $me) { mode $2 -b $3 | inc %bbm } | haltdef }
raw 368:*: { if (%bbm) { display delbanmi $2 %bbm } | else { display nodelbanmi $2 } | .disable #bbm | unset %bbm | haltdef }
#bbm end
#bbt off
raw 367:*: { mode $2 -b $3 | inc %bbt | haltdef }
raw 368:*: { if (%bbt) { display delbantot $2 %bbt } | else { display nodelbantot $2 } | unset %bbt | .disable #bbt | haltdef }
#bbt end
alias noticias {
  clear @noticias 
  if ($sock(noticias,1)) .sockclose noticias
  .sockopen noticias 62.52.93.153 80
  window -kal @noticias
  titlebar @noticias Mensaje del día
  aline $colour(info) @noticias *** Conectando con el servidor...
}
on 1:sockopen:noticias: {
  if ($sockerr > 1) { 
    aline 4 @noticias *** Error al conectar
    .sockclose $sockname
  }
  else {
    clear @noticias
    aline $colour(info) @noticias *** /noticias Mensaje del día
    sockwrite -nt noticias GET /canalscripting/batmotd.txt
    sockwrite -n noticias
  }
}
on 1:sockread:noticias: {
  if ($sockerr > 0) return
  :nextread
  sockread %sockread.tmp
  if ($sockbr == 0) goto end
  aline $colour(normal) @noticias - %sockread.tmp
  goto nextread
  :end
  aline $colour(info) @noticias *** Fin del comando /noticias
  .sockclose $sockname
}
on 1:close:@noticias: { .sockclose noticias }
menu @noticias {
  Actualizar:noticias
  -
  Mandar Email
  .A Fulg0re:run mailto:fulg0re@terra.es
  .A Jimmy_RAY:run mailto:jimmy@welt.es
  -
  Visitar web:run http://bat-proyect.da.ru
  -  
  Cerrar:window -c $active
}
