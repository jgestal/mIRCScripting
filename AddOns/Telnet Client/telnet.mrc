;/------------------------------------------------------------/
; Cliente de Telnet 1.0 por Jimmy_RAY
; BAT (BravoS AssAulT TeaM)     
; http://backbeat.welt.es
; email: jimmy@welt.es
; Nota: Éste es un ejemplo sencillo del uso de varios sockets
;       No es un addOn muy difícil de hacer, lo sé, pero 
;       hay gente a la que le gusta aprender mirando ejemplos.
;/------------------------------------------------------------/
menu nicklist,status,menubar,channel { 
  -
  &Telnet
  .&Connectar:telnet $$?="Introduce la ip/host" $$?="Introduce el puerto (por defecto el 23)"
  .&Menú:tln
  .-
  .&Créditos: { 
    echo 2 -a ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    echo 2 -a (Telnet) *** Versión 1.0
    echo 2 -a (Telnet) *** AddOn escrito por Jimmy_RAY
    echo 2 -a (Telnet) *** http://backbeat.welt.es
    echo 2 -a (Telnet) *** email: jimmy@welt.es
    echo 2 -a ~~~~~~~~~~~~~~~~~~~~~~~~~~~
} }
on 1:start: { unset %tln | echo 2 -ts *** (Telnet) Escribe /tln para abrir el Telnet }
on 1:start: { unset %tln }
alias tln dialog -m tln tln
dialog tln {
  size -1 -1 130 125
  option dbu

  box "Conectar con: (ip/puerto)",1,5 5 120 35
  edit "",2,10 15 80 10,center autohs
  edit "23",3,90 15 30 10,center autohs
  button "&Conectar",4,10 25 40 10,default disable ok
  button "&Añadir a la Agenda",5,65 25 55 10,disable
  box "Agenda",6,5 40 120 80
  list 7,10 50 110 60
  button "&Borrar de la Agenda",8,10 105 55 10,disable
  button "Cerrar",9,80 105 40 10,cancel
}
on 1:dialog:tln:init:*: { dialog -t tln -[BAT]- Cliente de Telnet $tln.sesion | tln.loadlist }
on 1:dialog:tln:edit:*: { tln.buttons }
on 1:dialog:tln:sclick:*: {
  if ($did == 4) telnet $did(tln,2) $did(tln,3)
  if ($did == 5) {
    write -il1 $mircdirdat\telnet.txt $did(tln,2) $+ $chr(58) $+ $did(tln,3)
    tln.loadlist
  }
  if ($did == 7) { 
    did -e tln 8
    did -ra tln 2 $gettok($did(tln,7,$did(tln,7).sel).text,1,58)
    did -ra tln 3 $gettok($did(tln,7,$did(tln,7).sel).text,2,58)
  }
  if ($did == 8) {
    write -dl [ $+ [ $did(tln,7).sel ] ] $mircdirdat\telnet.txt
    did -b tln $did
    tln.loadlist
  }
  tln.buttons
}
alias tln.sesion return (Sesión $calc(%tln +1) $+ )
alias tln.buttons {
  if ($did(tln,2)) && ($did(tln,3)) did -e tln 4,5
  elseif ($did(tln,2) == $null)  did -b tln 4,5
  elseif ($did(tln,3) == $null)  did -b tln 4,5
}
alias tln.loadlist {
  did -r tln 7
  %i = 1
  if ($findfile($mircdirdat\,telnet.txt,1) == $null) {
    mkdir dat
    write -c $mircdirdat\telnet.txt
  }
  %tmp.var = $read -l %i $mircdirdat\telnet.txt
  while (%tmp.var) {
    did -a tln 7 %tmp.var
    inc %i
    %tmp.var = $read -l %i $mircdirdat\telnet.txt
} }
alias telnet {
  if ($2) && ($1) {
    inc %tln
    window  -ke @Telnet: [ $+ [ %tln ] ] 
    .sockclose telnet. [ $+ [ %tln ] ]
    .sockopen telnet. [ $+ [ %tln ] ] $1 $2 
    echo 2 -t @Telnet: [ $+ [ %tln ] ] ***  Conectando con $1 ( $+ $2 $+ )
  }
  else echo 4 -a *** Error: Usa "/Telnet ip puerto" para conectar
}
alias tln.id return $gettok($sockname,2,$asc(.))

on 1:sockopen:telnet.*: {
  if ($sockerr > 1) { 
    echo 2 -t @Telnet: [ $+ [ $tln.id ] ] *** Error al conectar
    .sockclose $sockname
  }
  else {
    echo 2 -t @Telnet: [ $+ [ $tln.id ] ] *** Conectado!
    titlebar @Telnet: [ $+ [ $tln.id ] ] Conectado a: $sock($sockname,1).ip ( $+ $sock($sockname,1).port $+ )
  }
}
on 1:sockread:telnet.*: { 
  :nextread
  sockread %sockread.tmp
  if ($sockbr == 0) return
  echo 1 -t @Telnet: [ $+ [ $tln.id ] ] %sockread.tmp
  goto nextread
}
on 1:sockclose:telnet.*: {
  echo 2 -t @Telnet: [ $+ [ $tln.id ] ] *** Desconectado
  titlebar @Telnet: [ $+ [ $tln.id ] ] $chr(160)
  .sockclose $sockname
}
alias tln.winsock return telnet. [ $+ [ $gettok($active,2,$asc(:)) ] ]
on 1:input:@telnet*: {
  if (/* !iswm $1) {
    if ($sock($tln.winsock)) { 
      sockwrite -nt $tln.winsock $1-
      echo 14 -t $target -> $1-
      halt 
    }
    else {
      echo 4 -t $target *** Error: No estás conectado
      halt 
    }
  }
}
alias tln.ag return & $+ $read -l [ $+ [ $$1 ] ] $mircdirdat\telnet.txt
menu @telnet* {
  &Conectar: {
    titlebar @Telnet: [ $+ [ $gettok($active,2,$asc(:)) ] ] $chr(160)
    if ($sock($tln.winsock)) {
      .sockclose $tln.winsock
      echo 2 -t @Telnet: [ $+ [ $gettok($active,2,$asc(:)) ] ] *** Desconectado
    }
    %tmp.var = telnet. [ $+ [ $gettok($active,2,$asc(:)) ] ] $$?="Introduce el servidor" $$?="Introduce el puerto (telnet 23)"
    .sockopen %tmp.var
    echo 2 -t @Telnet: [ $+ [ $gettok($active,2,$asc(:)) ] ] *** Conectando con $gettok(%tmp.var,2,32) ( $+ $gettok(%tmp.var,3,32) $+ )
    unset %tmp.var
  }
  &Desconectar: {
    if ($sock($tln.winsock)) {
      .sockclose $tln.winsock
      echo 2 -t @Telnet: [ $+ [ $gettok($active,2,$asc(:)) ] ] *** Desconectado
    }
    else echo 4 -t @telnet: [ $+ [ $gettok($active,2,$asc(:)) ] ] *** Error: No estas conectado a ningún servidor. 
  }
  -
  &Menú:tln
  -
  &Limpiar ventana: clear $active
  -
  &Cerrar: {
    if ($sock($tln.winsock)) {
      .sockclose $tln.winsock
      echo 2 -t @Telnet: [ $+ [ $gettok($active,2,$asc(:)) ] ] *** Desconectado
    }
    window -c $active
  }
}
on 1:close:@telnet*: {
  if ($sock(telnet. [ $+ [ $gettok($target,2,$asc(:)) ] ] ,1)) {
    .sockclose telnet. [ $+ [ $gettok($target,2,$asc(:)) ] ]
  }
}
