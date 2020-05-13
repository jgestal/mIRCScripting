;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; Auto identificación
;
;*************************************

alias ai makedialog -m ai
dialog ai {
  title "Auto Identificación"
  size -1 -1 381 317
  icon icons\carpeta.ico
  tab "IRC Hispano", 1, 5 5 370 265
  box "Nicks registrados", 3, 15 45 200 140
  list 4, 25 65 180 110, tab 1 size
  box "", 5, 225 45 140 140, tab 1
  edit "", 7, 235 65 120 20, tab 1 autohs
  button "Añadir", 8, 235 95 120 25, tab 1
  button "Borrar", 9, 235 135 120 25, tab 1
  tab "Dal Net", 10
  list 12, 25 65 180 110, tab 10 size
  box "", 13, 225 45 140 140, tab 10
  edit "", 14, 235 65 120 20, tab 10 autohs
  button "Añadir", 15, 235 95 120 25, tab 10
  button "Borrar", 16, 235 135 120 25, tab 10
  button "Aceptar", 2, 150 280 80 30, default ok
  box "Enviar la contraseña...", 17, 15 195 350 60,tab 10
  radio "Al conectar al IRC", 18, 25 225 120 20,tab 10
  radio "Cuando el bot te la pida", 19, 165 225 150 20,tab 10
}
on 1:dialog:ai:*:*: {
  if ($devent == init) {
    _mdx.buttons_style 15 16 2 8 9
    dll $mdx SetControlMDX $dname 4 listview rowselect grid showsel single flatsb labeltip headerdrag report > $views 
    did -i $dname 4 1 header @85,80 0 Nick $chr(9) Clave
    dll $mdx SetControlMDX $dname 12 listview rowselect grid showsel single flatsb labeltip headerdrag report > $views 
    did -i $dname 12 1 header @85,80 0 Nick $chr(9) Clave
    did -c $dname $ri(dat\conf.ini,ai,rad1)
    mkdir dat\ai
    makefile dat\ai\hispano.dat
    makefile dat\ai\dalnet.dat
    var %i 1
    while ($rl(dat\ai\hispano.dat,%i)) {
      did -a $dname 4 $+($gettok($ifmatch,1,5),$chr(9),$str(*,$len($gettok($dll($crypt,decrypt,$gettok($ifmatch,2,5)),2,32))))
      inc %i
    }
    %i = 1
    while ($rl(dat\ai\dalnet.dat,%i)) {
      did -a $dname 12 $+($gettok($ifmatch,1,5),$chr(9),$str(*,$len($gettok($dll($crypt,decrypt,$gettok($ifmatch,2,5)),2,32))))
      inc %i
    }
  }
  if ($devent == sclick) {
    if ($did == 18) || ($did == 19) wi dat\conf.ini ai rad1 $did
    elseif ($did == 9) {
      write $+(-dl,$calc($did($dname,4).sel -1)) dat\ai\hispano.dat
      did -d $dname 4 $did($dname,4).sel
    }
    elseif ($did == 16) {
      write $+(-dl,$calc($did($dname,12).sel -1)) dat\ai\dalnet.dat
      did -d $dname 12 $did($dname,12).sel
    }
    elseif ($did == 8) {
      var %pass $$input(Introduce la clave,2,$_version)
      write dat\ai\hispano.dat $+($did($dname,7),$chr(5),$gettok($dll($crypt,crypt,%pass),2,32))
      var %x $rl(dat\ai\hispano.dat,$lines(dat\ai\hispano.dat))
      did -a $dname 4 $+($gettok(%x,1,5),$chr(9),$str(*,$len($gettok($dll($crypt,decrypt,$gettok(%x,2,5)),2,32))))
      did -r $dname 7
    }
    elseif ($did == 15) {
      var %pass $$input(Introduce la clave,2,$_version)
      write dat\ai\dalnet.dat $+($did($dname,14),$chr(5),$gettok($dll($crypt,crypt,%pass),2,32))
      var %x $rl(dat\ai\dalnet.dat,$lines(dat\ai\dalnet.dat))
      did -a $dname 12 $+($gettok(%x,1,5),$chr(9),$str(*,$len($gettok($dll($crypt,decrypt,$gettok(%x,2,5)),2,32))))
      did -r $dname 14
    }

  }
  did $iif($did($dname,7),-e,-b) $dname 8
  did $iif($did($dname,14),-e,-b) $dname 15
  did $iif($did($dname,4).sel,-e,-b) $dname 9
  did $iif($did($dname,12).sel,-e,-b) $dname 16

}
alias identificar {
  if (*.dal.net iswm $server) {
    if ($dalkey($me)) && ($ri(dat\conf.ini,ai,rad1) == 18) .msg NickServ@services.dal.net IDENTIFY $dalkey($me)
  }
}
alias hispakey {
  var %i 1
  while ($rl(dat\ai\hispano.dat,%i)) {
    var %x $ifmatch
    if ($gettok($ifmatch,1,5) == $$1) return $gettok($dll($crypt,decrypt,$gettok(%x,2,5)),2,32)
    inc %i
  }
}
alias dalkey {
  var %i 1
  while ($rl(dat\ai\dalnet.dat,%i)) {
    var %x $ifmatch
    if ($gettok($ifmatch,1,5) == $$1) return $gettok($dll($crypt,decrypt,$gettok(%x,2,5)),2,32)
    inc %i
  }
}
on 1:notice:*msg NickServ@services.dal.net IDENTIFY <password>*:?: {
  if ($nick == nickserv) && (*.dal.net iswm $server) && ($dalkey($me)) && ($ri(dat\conf.ini,ai,rad1) == 19) msg NickServ@services.dal.net IDENTIFY $dalkey($me) 
}

;*************************************
; Nicks registrados desde el servidor
;
;*************************************

alias nick {
  if (*.irc-hispano.org iswm $server) && (!$gettok($1,2,58)) && ($hispakey($1)) { nick $+($1,:,$hispakey($1)) | return }
  nick $1-
}
raw 433:*: { if (*.irc-hispano.org iswm $server) && ($hispakey($1)) && (!$timer(identify)) .timeridentify 1 2 nick $1 }
