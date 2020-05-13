;####################################
; Cliente de SMS 1.0
;
; Por Jimmy_RAY
; Email: jimmy@welt.es
; Canales de soporte: #scripting y #ayuda_IRC
; http://www.gra2.com/Scripting
;####################################

on 1:start: { 
  echo 2 -ts BaT SmS Teclea /batsms para enviar mensajes (dudas o problemas en los canales #scripting y #ayuda_IRC)
  echo 2 -ts AddOn de SmS de Jimmy_RAY. Visita http://www.gra2.com/scripting para más actualizaciones.
}
on 1:load: {
  if ($version < 5.82) {
    echo -ts BaT SmS  Necesitas el mIRC 5.82 para usar éste addOn, descárgalo de www.mirc.com
    unload $script 
    halt
  }
  mkdir dat
  mkdir dat\sms
  write -c dat\sms\agenda.dat
  write -c dat\sms\servers.dat
  write dat\sms\servers.dat smtp.telepolis.com
  if ($findfile($scriptdir,batayuda.txt,1,0)) .copy " $+ $scriptdir\batayuda.txt $+ " " $+ $mircdirdat\sms\ayuda.txt $+ "
  echo 2 -ts BaT SmS La instalación ha sido satisfactoria
}
alias batsms {
  if ($dialog(batsms)) dialog -v batsms
  else dialog -md batsms batsms
}

dialog batsms {
  title "BaT SMS por Jimmy_RAY"
  size -1 -1 150 150
  option dbu

  menu "&Archivo",1
  ;item break,3
  ;item "&Salvar SMS",4
  ;item "&Cargar SMS",5
  ;item break,6
  item "&Ir a la Agenda",7
  item break,8
  item "&Servidores SMTP",9
  item break,10
  item "&Cerrar BaT SMS",11, ok
  menu "&Ayuda",12
  item "&Abrir la ayuda",13
  ;item "&Abrir el version.txt",14
  ;item break,15
  item "&Visitar la web",16
  item break,17
  item "&Créditos",18

  tab "Enviar" 19,5 0 140 135
  text "Servidor:" 20,10 22 25 10,tab 19
  combo 21,40 20 100 50,drop,edit,tab 19
  text "Tu email:" 22,10 37 25 10,tab 19
  edit "" 23,40 35 100 10,autohs,tab 19
  text "Numero:" 24,10 52 25 10,tab 19
  combo 25,40 50 100 50,drop,edit,tab 19
  edit "" 26,10 65 130 50,multi,return,vsbar,tab 19
  button "Enviar" 27,10 115 40 15,disable,default,tab 19
  button "Detener" 28,50 115 40 15,disable,tab 19
  edit "0/160" 29,100 115 30 10,read,center,tab 19
  button "->" 30,130 115 10 10,tab 19
  text "Debug:",31,150 5 30 10
  edit "" 32,150 15 125 120,read,multi,return,vsbar

  tab "Agenda" 33
  text "Nombre:" 34,10 22 25 10,tab 33
  edit "" 35,40 20 100 10,edit,tab 33
  text "Número:" 36,10 37 25 10,tab 33
  edit "" 37,40 35 100 10,autohs,tab 33
  list 38,10 50 130 70,vsbar,tab 33
  button "<<Añadir el número" 39,10 115 65 15,tab 33
  button "Borrar el número>>" 40,75 115 65 15,tab 33

  tab "Servidores SMTP" 41
  text "Servidor:" 42,10 22 25 10,tab 41
  edit "" 43,40 20 100 10,edit,tab 41
  list 44,10 35 130 80,vsbar,tab 41
  button "<<Añadir el servidor" 45,10 115 65 15,tab 41
  button "Borrar el servidor>>" 46,75 115 65 15,tab 41
}
on 1:dialog:batsms:*:*: {
  if ($devent == init) {
    unset %batsms.tmp
    .timerbatsms -m 0 10 batsms_timer
    mkdir dat
    mkdir dat\sms
    if ($findfile(dat\sms,agenda.dat,1) == $null) write -c dat\sms\agenda.dat
    if ($findfile(dat\sms,servers.dat,1) == $null) write -c dat\sms\servers.dat
    if ($findfile(dat\sms,config.dat,1) == $null) writeini dat\sms\config.dat conf email tu@email
    batsms_loadlists
    did -a $dname 23 %batsms.mimail
  }
  if ($devent == edit) && ($did == 26) batsmscuerposms
  if ($did == 7) did -f $dname 33
  if ($did == 9) did -f $dname 41
  if ($did == 2) did -f $dname 19
  %batsms.mimail = $did($dname,23)
  if ($did == 13) run $mircdirdat\sms\ayuda.txt
  if ($did == 16) run http://scripts.aztecaonline.net
  if ($did == 18) batsmsabout
  if ($did == 27) batsmssend
  if ($did == 28) batsmsstop
  if ($did == 30) {
    if ($did($dname,30) == <-) { dialog -s batsms -1 -1 300 300 | did -ra $dname 30 -> }
    else { dialog -s batsms -1 -1 555 300 | did -ra $dname 30 <- }
  }
  if ($did == 39) {
    write $mircdirdat\sms\agenda.dat $did($dname,37) $+ $chr(5) $+ $did($dname,35)
    did -r $dname 35,37
    batsms_loadlists
  } 
  if ($did == 40) {
    write -dl $+ $did($dname,38).sel $mircdirdat\sms\agenda.dat 
    batsms_loadlists
  }
  if ($did == 45) {
    write $mircdirdat\sms\servers.dat $did($dname,43)
    did -r $dname 43
    batsms_loadlists
  }  
  if ($did == 46) {
    write -dl $+ $did($dname,44).sel $mircdirdat\sms\servers.dat 
    batsms_loadlists
  }
  batsms_checkbt
  dialog -t $dname BaT SMS - $batsmscomp($did($dname,25))
}
alias batsms_checkbt {
  if ($did($dname,21)) && ($did($dname,23)) && ($batsmsvalnum($gettok($did($dname,25),1,32))) && ($len($batsmscuerposms) <= 135) && ($len($batsmscuerposms)) && ($sock(batsms,1) == $null) did -e $dname 27
  if ($did($dname,21) == $null) || ($did($dname,23) == $null) || ($batsmsvalnum($gettok($did($dname,25),1,32)) == $null) || ($len($batsmscuerposms) > 135) || ($len($batsmscuerposms) == 0) did -b $dname 27
  if ($sock(batsms,1)) {
    did -ra $dname 27 Enviando...
    did -b $dname 21,23,25,26,27
    did -e $dname 28
  } 
  if ($did($dname,35)) && ($did($dname,37)) did -e $dname 39
  if ($did($dname,35) == $null) || ($did($dname,37) == $null) did -b $dname 39
  did $iif($did($dname,38).sel,-e,-b) $dname 40
  did $iif($did($dname,43),-e,-b) $dname 45
  did $iif($did($dname,44).sel,-e,-b) $dname 46
}
alias batsms_loadlists {
  var %i, var %tmp.var
  %i = 1
  if ($findfile($mircdirdat\sms,agenda.dat,1) == $null) write -c $mircdirdat\sms\agenda.dat
  %tmp.var = $read -l1 $findfile($mircdirdat\sms,agenda.dat,1)
  did -r $dname 25,38
  while (%tmp.var) {
    did -a $dname 25 $gettok(%tmp.var,1,5) ( $+ $gettok(%tmp.var,2,5) $+ )
    did -a $dname 38 $gettok(%tmp.var,1,5) ( $+ $gettok(%tmp.var,2,5) $+ )
    inc %i
    %tmp.var = $read -l %i $findfile($mircdirdat\sms,agenda.dat,1)
  }
  %i = 1
  if ($findfile($mircdirdat\sms,servers.dat,1) == $null) write -c $mircdirdat\sms\servers.dat
  %tmp.var = $read -l1 $findfile($mircdirdat\sms,servers.dat,1)
  did -r $dname 21,44
  while (%tmp.var) {
    did -a $dname 21 %tmp.var
    did -a $dname 44 %tmp.var
    inc %i
    %tmp.var = $read -l %i $findfile($mircdirdat\sms,servers.dat,1)
  }
  did -c $dname 21 1
  unset %tmp.var %i
}
alias batsmscomp { 
  if ($1 == $null) || ($len($1) < 3)  return BaT SmS por Jimmy_RAY
  if ($istok(060.609.616.620.686.650.619.626.629.630.636.639.646.649.659.669.676.679.696.699.689.608,$left($1,3),46)) return Movistar
  elseif ($istok(651.652.653.654.655.656.657.658,$left($1,3),46)) return Amena
  else return Desconocido
}
alias batsmsmailcomp {
  if ($batsmscomp($1) == Movistar) return $1 $+ @ $+ correo.movistar.net
  if ($batsmscomp($1) == Amena) return $1 $+ @ $+ amena.com
}
alias batsmsvalnum { if ($1 isnum) && ($len($1) == 9) && ($batsmscomp($1) != Desconocido) return $true }
alias batsmscuerposms {
  unset %tmp.var
  %i = 1
  while (%i <= $did(batsms,26).lines) {
    %tmp.var = %tmp.var $did(batsms,26,%i)
    inc %i
  }
  did -ra batsms 29 $len(%tmp.var) $+ / $+ 135
  return %tmp.var
}
;sockets
alias batsms_timer batsmsclose
alias batsmsclose {
  if ($dialog(batsms) == $null) {
    .sockclose batsms
    unset %batsms.tmp 
    .timerbatsms off 
  } 
}

alias batsmssend {
  .sockclose batsms
  .sockopen batsms $did($dname,21) 25
  did -r $dname 32
  batsmsdebug -> Conectando con $did($dname,21) $+ ...

}
alias batsmsnone { }
alias batsmsdebug { if ($dialog(batsms)) did -o batsms 32 $did(batsms,32).lines $$1 $2- }
on 1:sockopen:batsms: {
  if ($sockerr) {
    batsmsdebug <- Error conectando con el servidor
    batsmsfin
    .timer -m 1 1 batsmsnone $?!="Error en la conexión con el servidor"
    return
  }
  %batsms.tmp = 1
  batsmsdebug :: Conectado! Enviando datos...
  sockwrite -nt $sockname HELO $ip
}
on 1:sockread:batsms: {
  sockread %batsms
  if ($gettok(%batsms,1,32) == 250) {
    if (%batsms.tmp == 1) {
      sockwrite -nt $sockname mail from: $gettok(%batsms.mimail,1,32)
      inc %batsms.tmp
      batsmsdebug :: Enviando datos de remitente...
      return
    }
    elseif (%batsms.tmp == 2) {
      sockwrite -nt $sockname rcpt to: $batsmsmailcomp($gettok($did(batsms,25),1,32))
      inc %batsms.tmp
      batsmsdebug :: Enviando datos de destino...
      return
    }
    elseif (%batsms.tmp == 3) {
      sockwrite -nt $sockname data
      batsmsdebug :: Datos enviados... procediendo a mandar el contenido del SmS
      inc %batsms.tmp
      return
    }
    elseif (%batsms.tmp == 5) {
      sockwrite -nt $sockname QUIT
      batsmsdebug [!] El SmS ha sido enviado al servidor correctamente :)
      .timer -m 1 1 batsmsnone $?!="El SmS ha sido enviado al servidor correctamente :)"
      batsmsfin
      return
    }
  }
  elseif ($gettok(%batsms,1,32) == 354) {
    batsmsdebug :: Mandando sms...
    sockwrite -nt $sockname From: $gettok($did(batsms,32),1,32)
    sockwrite -nt $sockname To: $batsmsmailcomp($gettok($did(batsms,25),1,32))
    sockwrite -nt $sockname Subject: 
    %i = 1
    while (%i <= $did(batsms,26).lines) {
      if ($did(batsms,26,%i) != .) sockwrite -nt $sockname $did(batsms,26,%i)
      inc %i
    }
    sockwrite -nt $sockname .
    inc %batsms.tmp
  }
  elseif ($gettok(%batsms,1,32) > 499) { 
    batsmsdebug :: [!] Error: %batsms
    .timer -m 1 1 batsmsnone $?!="Error: %batsms "
    batsmsfin
  }
}
alias batsmsfin {
  did -b batsms 28
  .sockclose batsms
  did -ra batsms 27 Enviar
  did -e batsms 21,23,25,26,27
}
alias batsmsstop {
  did -b $dname $did
  .sockclose batsms
  did -ra $dname 27 Enviar
  did -e $dname 21,23,25,26,27
  .timer -m 1 1 batsmsnone $?!="Envío de SmS cancelado"

  batsmsdebug [!] Error, envío de SmS cancelado
}
;créditos
alias batsmsabout {
  if ($dialog(batsmsabout)) dialog -v batsmsabout
  else dialog -m batsmsabout batsmsabout
}
dialog batsmsabout {
  title "Acerca de BaT SmS"
  size -1 -1 150 180
  option dbu 
  text "BaT SmS (Bravos Assault Team)", 100, 5 2 140 10, center
  text "por Jimmy_RAY",1,5 12 140 10,center
  box "",2,-5 20 160 135
  text "Visita la web para noticias, addons y actualizaciones:", 5, 5 27 140 8, center
  link "http://scripts.aztecaonline.net",6,40 35 145 15,center read
  text "Mis agradecimientos a:",7,10 45 130 10, center
  edit "",8,5 55 140 65,vsbar read multi return
  text "BaT: My software never has bugs. It just develops random features.",9, 5 120 140 15,center
  button "Copyright © 2001 Todos los derechos reservados",10,5 135 140 15,default
  button "Cerrar",11,55 160 40 15,ok 
}
on 1:dialog:batsmsabout:init:*: {
  did -o $dname 8 1 NoTsCaPe, Fulg0re, Quetzal,hPm Betatesters
  did -o $dname 8 2 hPm por su ayuda
  did -o $dname 8 3 Azrael-- por la lista de números 
  did -o $dname 8 4 la gente de los canales #fiesta, #scripting, #100scripts y #ayuda_IRC
}
on 1:dialog:batsmsabout:sclick:6: { run http://scripts.aztecaonline.net }
