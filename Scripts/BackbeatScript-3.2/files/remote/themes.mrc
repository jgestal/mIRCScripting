;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; Theme manager
;
;*************************************

alias thm makedialog -m thm 
dialog thm {
  title "Theme manager"
  size -1 -1 135 195
  option dbu
  icon icons\themes.ico
  box "Themes disponibles", 1, 5 5 125 25
  combo 2, 10 15 85 50, size drop
  button "Cargar", 3, 100 15 25 10,ok
  box "Datos del theme", 4, 5 35 125 35
  text "", 5, 10 45 115 8
  text "", 6, 10 55 117 8
  box "Vista previa", 7, 5 70 125 120
  icon 8, 10 80 115 100,
}
on 1:dialog:thm:*:*: {
  if ($devent == init) {
    _mdx.buttons_style 3
    var %i 1
    while ($findfile(themes\,*.theme,%i)) {
      did -a $dname 2 $left($nopath($ifmatch),-6)
      inc %i
    }
    did -c $dname 2 1
  }
  var %file $findfile(themes,$did($dname,2) $+ .theme,1)
  var %dir $remove(%file,$nopath(%file))
  if ($devent == init) || ($did == 2) {
    did -ra $dname 5 Autor: $iif($ri(%file,info,author),$ifmatch,Desconocido)
    did -ra $dname 6 Versión: $iif($ri(%file,info,version),$ifmatch,Desconocido)
    did -g $dname 8 " $+ %dir $+ preview.png $+ "
  }
  if ($did == 3) .timer -m 1 1 loadtheme %file
}

;*************************************
; Cargando themes...
;
;*************************************

alias loadtheme {
  wpc 
  wpc.date 5 Descargando themes...
  var %i 1
  while ($script(%i)) {
    if ($right($script(%i),6) == .theme) { .unload -rs " $+ $script(%i) $+ " }
    inc %i
  }
  wpc.date 10 Cargando theme...
  .load -rs " $+ $$1- $+ "
  wpc.date 20 Cargando colores...
  setcolors
  wpc.date 50 Cargando fuentes...
  setfont
  wpc.date 80 Cargando fondos...
  setbackground
  wpc.date 90 Fijando colores...
  cline.allchannel
  wpc.date 100 Finalizada la carga
  window -c @wpc
  if ($_p(Si quieres limpiar todas las ventanas pulsa aceptar) == $true) clearall
  display start
}

alias -l setcolors {
  color ACTION $th_color(ACTION)
  color CTCP $th_color(CTCP)
  color HIGHLIGHT $th_color(HIGHLIGHT)
  color INFO $th_color(INFO)
  color INFO2 $th_color(INFO2)
  color INVITE $th_color(INVITE)
  color JOIN $th_color(JOIN)
  color KICK $th_color(KICK)
  color MODE $th_color(MODE)
  color NICK $th_color(NICK)
  color NORMAL $th_color(NORMAL)
  color EDITBOX $th_color(EDITBOX)
  color EDITBOX TEXT $th_color(EDITBOX TEXT)
  color NOTICE $th_color(NOTICE)
  color NOTIFY $th_color(NOTIFY)
  color OTHER $th_color(OTHER)
  color OWN $th_color(OWN)
  color PART $th_color(PART)
  color QUIT $th_color(QUIT)
  color TOPIC $th_color(TOPIC)
  color WALLOPS $th_color(WALLOPS)
  color WHOIS $th_color(WHOIS)
  color LISTBOX $th_color(LISTBOX)
  color LISTBOX TEXT $th_color(LISTBOX TEXT)
  color GRAYED $th_color(GRAYED)
  color BACKGROUND $th_color(BACKGROUND)
}
;/font [-asgbd|window] <fontsize> <fontname>

alias -l setfont {
  var %i
  var %x
  wi mirc.ini fonts fchannel $th.font $+ , $+ $th.fontsize $+ ,1
  wi mirc.ini fonts fquery $th.font $+ , $+ $th.fontsize $+ ,1
  wi mirc.ini fonts fstatus  $th.font $+ , $+ $th.fontsize $+ ,1
  wi mirc.ini fonts flinks $th.font $+ , $+ $th.fontsize $+ ,1
  wi mirc.ini fonts flist  $th.font $+ , $+ $th.fontsize $+ ,1
  wpc.date 60 Cargando fuentes...
  font -s $th.fontsize $th.font
  %i = 1 | while ($chan(%i)) { font $chan(%i) $th.fontsize $th.font | inc %i }
  %i = 1 | while ($query(%i)) { font $query(%i) $th.fontsize $th.font | inc %i }
  %i = 1 | while ($chat(%i)) { font $chat(%i) $th.fontsize $th.font | inc %i }
  %i = 1 
  wpc.date 70 Cargando fuentes...
  while ($lines(mirc.ini) > %i) {
    if ($left($rl(mirc.ini,%i),2) == f#) {
      write -dl $+ %i mirc.ini 
      continue 
    }
    inc %i
  }
}
alias -l setbackground {
  background -mt $iif($th.fondo,$th.fondo,themes\negro.jpg)
  background -h $iif($th.barra,$th.barra,themes\defaultbar.jpg)
  background -l $iif($th.menu,$th.menu,themes\defaultmenu.jpg)
}

alias cline.allchannel { var %i 1 | while ($chan(%i)) { cline.channel $comchan($me,%i) | inc %i } }

;*************************************
; Comandos
;
;*************************************

alias cline.channel { var %i 1 | while ($nick($1,%i)) { cline.nick $nick($1,%i) $1 | inc %i } }
alias cline.nick { if ($1 == $me)  cline $th.nc(m) $2 $me | elseif ($1 isop $2)  cline $th.nc(o) $2 $1 | elseif ($1 isvo $2)  cline $th.nc(v) $2 $1 | else cline $th.nc(n) $2 $1 }
alias besp return $str($chr(255),$1) 
alias align { if ($len($strip($2-)) > $1) return $left($2-,$calc($1 - 3)) $+ ... 
return $2- $+ $str($chr(255),$calc($1 - $len($strip($2-)))) }
alias center { return $str($chr(160),$calc($calc($1 - $len($2-)) /2)) $2- }

;*************************************
; Comandos modificados para el theme
;
;*************************************

alias msg { 
  if ($2 != $null) {
    .msg $1- 
    tokenize 32 $1 $_cript($1,$2-)
    if ($show) { if ($1 ischan) display inputchan $1 $me $2-
      elseif ($query($1)) display inputquery $1 $me $2-
      elseif ($left($1,1) == $chr(61)) && ($chat($right($1,-1))) display inputchat $1 $me $2-
      else display msg $1-
    }
  } 
  else display Error $th.error(msg) 
}
alias ctcp { if ($2 != $null) { .ctcp $1- | if ($show) { display ctcp $1- } } | else display Error $th.error(ctcp) }
alias ctcpreply { if ($2 != $null) { .ctcpreply $1- | if ($show) { display ctcpreply $1- } } | else display Error $th.error(ctcpreply) }
alias notice { if ($2 != $null) { .notice $1- | if ($show) { display notice $1- } } | else display Error $th.error(notice) }
alias amsg { if ($1) { .amsg $1- | if ($show) { var %i 1 | while ($chan(%i)) { display inputchan $chan(%i) $me $1- | inc %i } } } | else display Error $th.error(amsg) }
alias onotice { if ($1 == $null) || ($active !ischan) display error $th.error(onotice2) | elseif ($me !isop $chan) { display error $th.error(onotice1) } | elseif ($1 == $chan) { if ($show) { display onotice $1- } | .onotice $1- } | else { if ($show) { display onotice $chan $1- } | .onotice $chan $1- } }
alias omsg { if ($1 == $null) || ($active !ischan) display error $th.error(omsg2) | elseif ($me !isop $chan) { display error $th.error(omsg1) } | elseif ($1 == $chan) { if ($show) { display omsg $1- } | .omsg $1- } | else { if ($show) { display omsg $chan $1- } | .omsg $chan $1- } }
alias say if ($active != Status Window) && ($left($active,1) != @) msg $active $remove($1-,$chr(254))


;*************************************
; Eventos remotos
;
;*************************************
on ^*:open:?: {
  if ($spamtest($strip($1-)) == $true) && ($ri(Dat\conf.ini,gen,38)) && ($level($nick) != BOT) {
    antispam $nick /msg 
    haltdef
  }
}
on *:BAN:#: {
  if ($banmask iswm $address($me,5)) { 
    display banme $chan $nick $banmask
    if ($me isop $chan) && ($nick != $me) mode $chan -ob $nick $banmask
} }
on *:SERVEROP:#:{ cline.nick $opnick $chan }
on *:op:#: { cline.nick $opnick $chan }
on *:deop:#: { cline.nick $opnick $chan }
on *:voice:#: { cline.nick $vnick $chan }
on *:devoice:#: { cline.nick $vnick $chan }
on ^*:topic:#: { display topic $chan $nick $1- }
on ^*:start: { 
  if ($ri(dat\conf.ini,iglist,4) == on) { while ($ignore(1)) { .ignore -r $ifmatch } }
  write -c dat\nickanterior.ini 
  .timertb 0 1 _titlebar
  var %ld = $dll(dll\mOTFv.dll,Load,0) 
  if ($gettok(%ld,1,32) != ERROR) dll dll\mOTFv.dll Mark 0 
  unset %fl_* %tln %tmp*
  if (!%vs.dir) %vs.dir = $left($mircdir,3)
  display start 
  if ($ri(dat\conf.ini,tips,2) == on) tips
}
on *:connect: { 
  identificar
  %who = 0
  lag_init
  dll dll\mOTFv.dll Mark 0
  version $vrep
  display connect $server $port 
  wifnot dat\uservers.dat 15 $server $port
  var %umode $+(+,$iif($ri(dat\conf.ini,umode,2) == on,i),$iif($ri(dat\conf.ini,umode,3) == on,w),$iif($ri(dat\conf.ini,umode,4) == on,s))
  if (%umode != +) mode $me %umode
  if ($ri(dat\conf.ini,umode,5)) mode $me $ifmatch
}
on ^*:snotice:*: { haltdef | if ($snotices_filter($1-) == $false) display snotice $server $1- }
on ^*:rawmode:*: { display rawmode $chan $nick $1- }
on ^*:join:#: { 
  if ($nick == $me) {
    wifnot dat\ucanales.dat 15 $chan
    inc %who
    who #
  }
  if ($nick != $me) cline $th.nc(n) $chan $nick
  display $iif($nick == $me,joinme,join) $chan $nick $address 
}
on ^*:part:#: { 
  var %x $1-
  if ($spamtest($strip(%x)) == $true) && ($ri(dat\conf.ini,gen,41) == on) unset %x
  display part $chan $nick $address %x 
}
on ^*:kick:#: { display $iif($knick == $me,kickme,kick) $chan $nick $knick $1- }
on ^*:quit: {
  unset %z
  var %z $1-
  if ($spamtest($strip(%z)) == $true) && ($ri(dat\conf.ini,gen,40) == on) %z = ""
  var %i 1 | while ($comchan($nick,%i)) { display quit $comchan($nick,%i) $nick $address %z | inc %i } 
}
on ^*:nick: {
  wi dat\nickanterior.ini direcciones $address($newnick,2) $newnick
  var %i 1 
  while ($comchan($newnick,%i)) { display nick $comchan($newnick,%i) $nick $newnick 
    inc %i 
  }
}
ctcp ^*:*:#: { 
  display ctcpchan $chan $nick $address $1- 
  if ($1 == VERSION)  {
    haltdef
    if ($ri(dat\conf.ini,gen,6) == on) display ctcpreplyed $chan %last.version
    version $vrep 
  }
}
alias kickvirus {
  var %i 1
  while ($comchan($1,%i)) {
    if ($me isop $ifmatch) { 
      mode $comchan($1,%i) b $1
      kick $comchan($1,%i) $1 Tienes un virus, porfavor, desinféctate y deja de enviarlo!
    }
    inc %i
  }
}
ctcp ^*:*:?: { 
  if ($1 == DCC) && ($2 == SEND) && ($nick != $me) {
    if ($antivirus($3) == $true) && ($ri(dat\conf.ini,gen,60) == on) {
      if ($ri(dat\conf.ini,gen,61) == on) {
        .timer 1 5 kickvirus $nick
      }
      display echo Antivirus: $nick te ha enviado un virus: $3 y se ha rechazado

      halt
    }
  }
  if ($1 != DCC) display ctcpnick $nick $address $1- 
  if ($1 == VERSION)  {
    if ($ri(dat\conf.ini,gen,6) == on) display ctcpreplyed $nick %last.version
    version $vrep 
  }
}
on *:ctcpreply:*: { display ctcpreply $nick $address $upper($1) $2- }
on ^*:text:*:#: { 
  tokenize 32 $_cript($chan,$1-)
  display textchan $chan $nick $1- 
}
on ^*:text:*:?: { 
  tokenize 32 $_cript($nick,$1-)
  display textquery $nick $1- 
}
on ^*:action:*:#: { display actionchan $chan $nick $1- }
on ^*:action:*:?: { display actionquery $nick $1- }
on *:input:#: { 
  if (%nk == on) && ($1 ison $chan) tokenize 32 $iif($1 ison $chan,$nc($1,%nk.num),$1) $2-
  if ($ctrlenter && ($left($1-,/) != /)) {
    say $1-
    halt
  }
  elseif ($left($1,1) != /) { 
    display inputchan $chan $me $remove($1-,$chr(254))
    .say $remove($1-,$chr(254))
  } 
}

on *:input:=*: { 
  if ($ctrlenter && ($left($1-,/) != /)) {
    say $1-
    halt
  }
  elseif ($left($1-,1) != /)  { display inputchat $target $me $1- | .say $1- } 
}
on *:input:?: { 
  if ($ctrlenter && ($left($1-,/) != /)) {
    say $1-
    halt
  }
  if ($left($1-,1) != /)  {
    display inputquery $target $me $1- | .say $1- 
  } 
}
on ^*:notice:*:#: { display noticechan $chan $target $nick $1- }
on ^*:notice:*:?: { 
  if ($nick == $me) && ($1 == MIDELAG) {
    haltdef
    %lag = $calc(($ticks - $2)/1000)
    if (%lag > 20) && ($ri(dat\conf.ini,lag,6) == on) && (%lag >= $ri(dat\conf.ini,lag,7)) display echo El lag es superior a $ri(dat\conf.ini,lag,7) segundos: %lag $+ . Se recomienda cambiar de servidor.
    if ($ri(dat\conf.ini,lag,7) == on) display lag $lag
    .timerlag_2 off
    .timerlag_3 off
  }
  elseif ($spamtest($strip($1-)) == $true) && ($ri(dat\conf.ini,gen,39)) && ($level($nick) != BOT) {
    antispam $nick /notice
    haltdef
    return
  }
  else display noticequery $nick $1- 
}
on ^*:notify: { display notify $nick $notify($nick).note }
on ^*:unotify: { display unotify $nick $notify($nick).note }
on ^*:invite:#: { display invite $chan $nick }
on ^*:usermode: { display usermode $me $usermode $1- }
on ^*:wallops:*: { display wallops $nick $1- }
on ^*:chat:*: { display chat $nick $_cript(=$nick,$1-) }
raw *:*: { 
  if ($numeric == 366) cline.channel $2 
  if ($numeric == 352) && (%who) { haltdef | return }
  if ($numeric == 366) && (%who) { haltdef | return }
  if ($numeric == 353) && (%who) { haltdef | return }
  if ($numeric == 315) && (%who) { haltdef | dec %who | return }
  displayraw $numeric $1- 
}
