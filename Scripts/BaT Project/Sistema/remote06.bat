;####################################;
;                                    ;
; BaT proyect by Fulg0re & Jimmy_RAY ;
;                                    ;
;     http://bat-proyect.da.ru       ;
;                                    ;
;                                    ;
;####################################;
 alias tablaascii {
 window -klpth +betl @tabla -1 -1 100 136
 window -a @tabla | clear @tabla
 titlebar @Tabla ascii
 set %a -1 | :ini | if (255 >= %a) { inc %a 1 | aline @tabla %a - $chr(%a) | goto ini }
 }

alias nk { if ($dialog(nk)) dialog -v nk | else $dialog(nk,nk,2) }
dialog nk {
  title "Nick Completion"
  size -1 -1 120 70
  option dbu
  check "Activar Nick Completion",1,5 5 100 10
  box "",2, -10 15 170 35
  text "Estilo de completion:",3,5 25 50 10
  combo 4,55 23 60 100,drop
  text "Vista previa:",5,5 40 30 10
  button "Aceptar",6,15 55 30 10,ok,default
  button "Cancelar",7,75 55 30 10,cancel
}
on 1:dialog:nk:init:*: {
  window -ohd +bL @nk $calc($dialog(nk).x + 80) $calc($dialog(nk).y + 95) 150 20
  window -a @nk
  .timernk -m 0 1 redrawnkwin
  did $iif(%nk,-c,-u) nk 1
  if (%nk.num == $null) %nk.num = 1
  %tmp.var = 1 negrita;corchetes;llaves;negr/subr;corchetes 2;alegre;colores;subrayado;negrita;l33t
  %i = 1
  while ($gettok(%tmp.var,%i,59)) {
    did -a nk 4 $gettok(%tmp.var,%i,59)
    inc %i
  }
  did -c nk 4 %nk.num
  nkdrawstyle
}
on 1:dialog:nk:sclick:*: { 
  if ($did == 4) nkdrawstyle 
  if ($did == 6) {
    $iif($did(nk,1).state == 1,set,unset) %nk on
    %nk.num = $did(nk,4).sel
  }
}
alias redrawnkwin { 
  if ($dialog(nk)) window @nk $calc($dialog(nk).x + 80) $calc($dialog(nk).y + 95) 150 20 
  else { window -c @nk | .timernk off }
}
alias nkdrawstyle { 
  clear @nk
  echo @nk $nc($me,$did(nk,4).sel)
}
alias nc {
  goto $$2
  :1 | return  $+ $left($1,1) $+  $+ $right($1,$calc($len($1)-1)) $+ : 
  :2 | return [ [ $+ [ $1 ] $+ ] ] 
  :3 | return 2{ $+ $left($1,1) $+  $+ $right($1,$calc($len($1)-1)) $+ 2} 
  :4 | return  $+ $left($1,1) $+  $+ $right($1,$calc($len($1)-1)) $+ : 
  :5 | return 2] $+ $1 $+ 2[
  :6 | return 3¡4¡ $+ $1 $+ 4!3! 
  :7 | return $vcol($1)
  :8 | return $hsub($1)
  :9 | return $hneg($1)
  :10 | set %hn.txt $1 | set %hn.txt $replace(%hn.txt,a,4) | set %hn.txt $replace(%hn.txt,b,ß) | set %hn.txt $replace(%hn.txt,c,©) | set %hn.txt $replace(%hn.txt,d,Ð) | set %hn.txt $replace(%hn.txt,e,3)
  set %hn.txt $replace(%hn.txt,f,ƒ) | set %hn.txt $replace(%hn.txt,i,1) | set %hn.txt $replace(%hn.txt,l,£) | set %hn.txt $replace(%hn.txt,o,Ø) | set %hn.txt $replace(%hn.txt,p,Þ)
  set %hn.txt $replace(%hn.txt,q,¶) | set %hn.txt $replace(%hn.txt,r,®) | set %hn.txt $replace(%hn.txt,s,§) | set %hn.txt $replace(%hn.txt,t,†) | set %hn.txt $replace(%hn.txt,x,×)
  set %hn.txt $replace(%hn.txt,y,¥) | return %hn.txt
}
alias vcol { unset %hn.* | set %i 1 | :loop | if ($mid($1,%i,1) != $null) { set %hn.cadena %hn.cadena $+  $+ $rand(1,14) $+ $mid($1,%i,1) | inc %i | goto loop } | return %hn.cadena $+  }
alias hneg { 
  unset %hn.* | set %hn.cadena $1- | set %hn.rand $round($rand(0,10),0) | :sigue | inc %hn.c 1 | set %hn.la $mid(%hn.cadena,%hn.c,1) 
  if (%hn.la == $chr(32)) { set %hn.cadena1 %hn.cadena1 $+ ¤ | goto sigue }
  if (%hn.rand >= 5) { set %hn.cadena1 %hn.cadena1 $+ %hn.la $+  }
  if (%hn.rand < 5) { set %hn.cadena1 %hn.cadena1 $+  $+ %hn.la }
  if (%hn.la == $null) { if ($int($calc(%hn.c / 2)) != $calc(%hn.c / 2)) { set %hn.cadena1 %hn.cadena1 $+  } | goto end 
  }
  goto sigue | :end
  if (¤ isin %hn.cadena1) { set %hn.cadena1 $replace(%hn.cadena1,¤,$chr(32)) }
  return %hn.cadena1 
}
alias hsub { unset %hn.* | set %hn.cadena $1- | set %hn.rand $round($rand(0,10),0) | :sigue | inc %hn.c 1 | set %hn.la $mid(%hn.cadena,%hn.c,1)
  if (%hn.la == $chr(32)) { set %hn.cadena1 %hn.cadena1 $+ ¤ | goto sigue }
  if (%hn.rand >= 5) { set %hn.cadena1 %hn.cadena1 $+ %hn.la $+  }
  if (%hn.rand < 5) { set %hn.cadena1 %hn.cadena1 $+  $+ %hn.la }
  if (%hn.la == $null) { if ($int($calc(%hn.c / 2)) != $calc(%hn.c / 2)) { set %hn.cadena1 %hn.cadena1 $+  }
  goto end }
  goto sigue | :end
  if (¤ isin %hn.cadena1) { set %hn.cadena1 $replace(%hn.cadena1,¤,$chr(32)) }
  return %hn.cadena1
}

;~~~~~~~~~~~~~~~~~~~~
;Lista de servidores
;/srvlst
;~~~~~~~~~~~~~~~~~~~~
alias srvlst { if ($dialog(srvlst) != $null) { dialog -x srvlst } 
dialog -m srvlst srvlst }
dialog srvlst {
  size -1 -1 270 110
  option dbu
  title "BaT: Redes y Servidores de IRC [/srvlst]"
  box "Lista de Redes",1,5 5 100 100
  list 2,10 15 90 80
  box "Lista de Servidores",3,110 5 155 100
  list 4,115 15 90 80
  combo 6,210 15 50 100,drop
  button "&Conectar",7,210 30 50 13,deafult
  button "&Cancelar",8,210 50 50 13,ok
  button "&Añadir",9,15 92 30 10
  button "&Borrar",10,65 92 30 10
  button "&Añadir",11,120 92 30 10
  button "&Borrar",12,170 92 30 10
}
on 1:dialog:srvlst:init:*: { cargaredes | did -b srvlst 12 | did -b srvlst 10 | did -b srvlst 7 | did -b srvlst 11 | did -b srvlst 6 }
on 1:dialog:srvlst:dclick:4: { srvconnect $read -l $did(srvlst,4).sel $findfile($mircdir\dat\srv\,*.txt,$did(srvlst,2).sel) }
on 1:dialog:srvlst:sclick:*: {
  if ($did == 2) { cargasrv | did -b srvlst 7 | did -e srvlst 10 | did -e srvlst 11 | did -rb srvlst 6  }
  if ($did == 4) { cargapuertos | did -e srvlst 7 | did -e srvlst 11 | did -e srvlst 12 | did -e srvlst 6 }
  if ($did == 7) { srvconnect $read -l $did(srvlst,4).sel $findfile($mircdir\dat\srv\,*.txt,$did(srvlst,2).sel) }
  if ($did == 9) { dialog -m addred addred }
  if ($did == 10) { .remove $findfile($mircdir\dat\srv\,*.txt,$did(srvlst,2).sel) | srvlst }
  if ($did == 11) { dialog -m addsrv addsrv }
  if ($did == 12) { write -dl $+ $did(srvlst,4).sel $findfile($mircdir\dat\srv\,*.txt,$did(srvlst,2).sel) | cargasrv }
  if ($did == 13) srvoptions
}
alias srvconnect { server $1 $did(srvlst,6) | dialog -x srvlst }
alias cargaredes { 
did -r srvlst 2 | did -b srvlst 11 | did -b srvlst 12 | set %i 0 | :inicio | inc %i 1 | if ($nopath($findfile($mircdir\dat\srv\,*.txt,%i)) != $null) { did -a srvlst 2 $remove($nopath($findfile($mircdir\dat\srv\,*.txt,%i)),.txt) | goto inicio } }
alias cargasrv { did -r srvlst 4 | set %i 0 | :inicio | inc %i 1 | if ($read -l %i $findfile($mircdir\dat\srv\,*.txt,$did(srvlst,2).sel) != $null) { cargaservname $read -l %i $findfile($mircdir\dat\srv\,*.txt,$did(srvlst,2).sel) | goto inicio } }
alias cargaservname { did -a srvlst 4 $1 }
alias cargapuertos { did -r srvlst 6 | cp2 $read -l $did(srvlst,4).sel $findfile($mircdir\dat\srv\,*.txt,$did(srvlst,2).sel) }
alias cp2 { cp3 $2- }
alias cp3 { if ($1 != $null) { did -a srvlst 6 $1 | cp2 $1- }
else did -c srvlst 6 1 }
dialog addred {
  title "BaT: Añadir red"
  size -1 -1 230 100
  text "Nombre de la red:",1,10 10 100 20
  edit "",2,10 30 210 20,autohs
  button "&Cancelar",3,120 70 100 20,cancel
  button "&Añadir",4,10 70 100 20,ok
}
on 1:dialog:addred:init:*: { did -b addred 4 }
on 1:dialog:addred:edit:2: { if ($did(addred,2) == $null) { did -b addred 4 } | else did -e addred 4 } 
on 1:dialog:addred:sclick:*: {
  if ($did == 4) { write dat\srv\ $+ [ $did(addred,2) ] $+ .txt | write -c dat\srv\ $+ [ $did(addred,2) ] $+ .txt | dialog -x addred | srvlst }
if ($di7d == 3) { dialog -x addred | srvlst } }
alias addsrv {
  set %tmp.numred $did(srvlst,2).sel 
  dialog -m addsrv addsrv
}
dialog addsrv {
  title "BaT: Añadir servidor"
  size -1 -1 230 150
  text "Nombre del servidor:",1,10 10 100 20
  edit "",2,10 30 210 20,autohs
  text "Puertos separados por un espacio:",3,10 70 200 20
  edit "",4,10 90 210 20,autohs
  button "&Cancelar",5,120 120 100 20,cancel
  button "&Añadir",6,10 120 100 20,disable,ok,default
}
on 1:dialog:addsrv:init:*: { set %tmp.numred $did(srvlst,2).sel }
on 1:dialog:addsrv:edit:*: { 
  if ($did == 2) { if ($did(addsrv,2) != $null) && ($did(addsrv,4) != $null) { did -e addsrv 6 }
  else did -b addsrv 6 }
  if ($did == 4) { if ($did(addsrv,2) != $null) && ($did(addsrv,4) != $null) { did -e addsrv 6 }
  else did -b addsrv 6 }
}
on 1:dialog:addsrv:sclick:*: {
  if ($did == 6) { 
    write $findfile($mircdir\dat\srv\,*.txt,%tmp.numred) $did(addsrv,2) $did(addsrv,4) 
    if ($dialog(srvlst) != $null) { cargasrv }
    else { srvlst }
  }
}
;~~~~~~~~~~~~~~~~~~~~
;Conectando al servidor...
;/_server
;~~~~~~~~~~~~~~~~~~~~

alias _server cdig _server _server
alias ultsrvmenu { set -u %tmp.var $read -l $1 dat\ultsrv.dat | if (%tmp.var) return & $+ $1 $read -l $1 dat\ultsrv.dat }
alias ultsrv { 
  set -u %tmp.var $read -l $1 dat\ultsrv.dat
if (%tmp.var) return $read -l $1 dat\ultsrv.dat }
dialog _server {
  title "BaT: Escoge servidor [/_server]"
  option dbu
  size -1 -1 195 45
  text "Introduce el servidor de IRC y el puerto:",1,15 5 165 10, center
  combo 2,10 15 175 50,drop,edit

  button "&Borrar lista", 3, 145 30 40 13 ,ok

  button "&Conectar", 4, 10 30 40 13 ,ok,disable,default
  button "&Cancelar", 5, 55 30 40 13 ,ok
}
on 1:dialog:_server:init:*: {
  loadcombo dat\ultsrv.dat _server 2 
  if ($lines(dat\ultsrv.dat) == 0) did -b _server 3
}
on 1:dialog:_server:edit:*: {
  if ($did(_server,2)) did -e _server 4
  if ($did(_server,2) == $null) did -b _server 4
}
on 1:dialog:_server:sclick:*: {
  if ($did(_server,2)) did -e _server 4
  if ($did(_server,2) == $null) did -b _server 4
  if ($did == 3) write -c dat\ultsrv.dat
  if ($lines(dat\ultsrv.dat) == 0) did -b _server 3
  if ($did == 4) { server $did(_server,2).sel).text | dialog -x _server }
} 
;~~~~~~~~~~~~~~~~~~~~
;Cambio de Topic
;& Block topics
;/_topic
;~~~~~~~~~~~~~~~~~~~~
alias btopic { 
  if ($isintxt(dat\btopics.dat,$chan($chan).topic) == $false) return &Añadir
  else return &Borrar
}
alias topic { if ($1 == $null) { _topic } | else { if ($1 ischan) { topic $1- } | else { topic $chan $1- } } }
alias _topic { 
  set %_topic.target $chan
  cdig _topic _topic
}
dialog _topic {
  title "BaT: Escoge un topic [/topic]"
  option dbu
  size -1 -1 210 45
  text "Introduce el nuevo topic:",1,10 5 190 10, center
  combo 2,10 15 190 50,drop,edit

  button "&Borrar lista",3, 160 30 40 13 ,ok
  button "&Cambiar topic", 4, 10 30 40 13 ,ok,default
  button "&Cancelar", 5, 55 30 40 13 ,ok
}
on 1:dialog:_topic:init:*: {
  loadcombo dat\btopics.dat _topic 2 
  if ($lines(dat\btopics.dat) == 0) did -b _topic 3
  did -a _topic 2 $chan(%_topic.target).topic
  did -c _topic 2 1
}
on 1:dialog:_topic:edit:*: {
  if ($did(_topic,2)) did -e _topic 4
  if ($did(_topic,2) == $null) || ($chan(%_topic.target).topic == $did(_topic,2)) { did -b _topic 4 }
}
on 1:dialog:_topic:sclick:*: {
  if ($did(_topic,2)) did -e _topic 4
  if ($did(_topic,2) == $null) did -b _topic 4
  if ($did == 3) write -c dat\btopics.dat
  if ($lines(dat\btopics.dat) == 0) did -b _topic 3
  if ($did == 4) { topic %_topic.target $did(_topic,2).sel).text | unset %_topic.target | dialog -x _topic } 
} 
alias btopic { if ($isintxt(dat\btopics.dat,$chan($chan).topic) == $false) return &añadir topic | else return &borrar topic }
alias btopic.window { clear @block | window -akl @block -1 -1 550 300 | loadbuf @block dat\btopics.dat | titlebar @block topics: usa el dobleclick para fijar el topic en $chan | set %btopic.target $chan }
menu @block { 
  dclick { 
    topic %btopic.target $read -l $sline(@block,1).ln dat\btopics.dat | window -c @block
  } 
  &Borrar: { write -dl $+ $sline(@block,1).ln dat\btopics.dat | clear @block | loadbuf @block dat\btopics.dat }
  -
  &Cerrar: window -c @block 
}
on 1:close:@block:/unset %btopic.target
alias about {
  if ($dialog(about)) dialog -x about
  dialog -m about about
}
dialog about {
  title "Acerca de BaT"
  size -1 -1 150 180
  option dbu 
  text "BaT ProyecT (Bravos Assault Team)", 100, 5 2 140 10, center
  text "por Fulg0re y Jimmy_RAY",1,5 12 140 10,center
  box "",2,-5 20 160 135
  text "Visita la web para noticias, addons y actualizaciones:", 5, 5 27 140 8, center
  link "http://bat-proyect.da.ru",6,45 35 140 15,center read
  text "Nuestros agradecimientos a:",7,10 45 130 10, center
  edit "",8,5 55 140 65,vsbar read multi return
  text "BaT: My software never has bugs. It just develops random features.",9, 5 120 140 15,center
  button "Copyright © 2001 Todos los derechos reservados",10,5 135 140 15,default
  button "Cerrar",11,55 160 40 15,ok 
}
on 1:dialog:about:init:*: {
  did -o about 8 1 hPm, Dranor, tabo y Teide (éste último es coña) por su ayuda
  did -o about 8 2 Spirou porque ésta vez no le robó a Fulg0re el script
  did -o about 8 3 A heijachi por ser rayante
  did -o about 8 4 NoTsCaPe y _kirk_ por ser nuestros betatesters
  did -o about 8 5 La madre de Fulg0re por hacer gran parte del código xD
  did -o about 8 6 Carrie y Nazaret por aguantarnos
  did -o about 8 7 A los canales #scripting y #BaT
  did -o about 8 8 A DragonZap por las dll
}
on 1:dialog:about:sclick:6: { run http://bat-proyect.da.ru }
on 1:dialog:about:sclick:10: {
  if ($dialog(about2)) dialog -x about2 
  else $dialog(about2,about2,2) 
}
dialog about2 {
  title "Copyright © 2001 Todos los derechos reservados"
  size -1 -1 150 50
  option dbu
  text "No está permitida la copia de ninguna parte del código del script, copiar alguna linea de código será considerado plagio. No permitimos la traducción del script a ningún idioma. Se permite la modificación del script para uso personal, no para su distribución. En ningún caso se podrán modificar el nombre del script ni los créditos.",1,5 5 140 40,center
  button "Aceptar",2,40 45 40 10,ok hide 
}
alias vl {
  window -akSl15 @vl
  vlt $findfile($logdir,*.log,0) logs en $logdir
}
alias vlt titlebar @vl $1-
alias vle echo @vl $1-
alias vlp return $calc($findfile($logdir,*.log,0) - $findfile($logdir,#*.log,0))
alias vlname return $left($nopath($1),$calc($len($nopath($1)) -4)) 
alias vlcomp return $1- $+ .log
alias vlloadgen {
  clear -l @vl
  clear @vl
  set -u %tmp.logtime $ticks
  %i = 1
  wpc
  while ($findfile($logdir,*.log,%i)) {
    if ($vlname($findfile($logdir,*.log,%i)) != $null) aline -l @vl $vlname($findfile($logdir,*.log,%i))
    vlt Cargando logs...  $chr(91) $+ $int($calc((%i * 100) / $findfile($logdir,*.log,0))) $+ $chr(37) $chr(93) $chr(91) $+ Cargados: $vltcargados($findfile($logdir,*.log,0)) de un total de $findfile($logdir,*.log,0) logs
    wpc.date $int($calc((%i * 100) / $findfile($logdir,*.log,0))) Cargando logs...
    inc %i
  }
  window -c @wpc 
  unset %i
  vlt $chr(91) $+ Logs totales: $findfile($logdir,*.log,0) $+ $chr(93) $chr(91) $+ Tiempo de carga: $duration($calc(($ticks - %tmp.logtime)/1000)) $+ $chr(93) $chr(91) $+ Directorio: $logdir $+ $chr(93) 
}
alias vlloadchan {
  clear -l @vl
  clear @vl
  set -u %tmp.logtime $ticks
  %i = 1
  wpc

  while ($findfile($logdir,#*.log,%i)) {
    if ($vlname($findfile($logdir,#*.log,%i)) != $null) aline -l @vl $vlname($findfile($logdir,#*.log,%i))
    vlt Cargando logs... $chr(91) $+ $int($calc((%i * 100) / $findfile($logdir,#*.log,0))) $+ $chr(37) $+ $chr(93) $vlname($findfile($logdir,#*.log,%i))
    wpc.date $int($calc((%i * 100) / $findfile($logdir,#*.log,0))) Cargando logs...
    inc %i
  }
  window -c @wpc
  unset %i
  vlt $chr(91) $+ Logs cargados: $findfile($logdir,#*.log,0) $+ / $+ $findfile($logdir,*.log,0) $+ $chr(93) $chr(91) $+ Tiempo de carga: $duration($calc(($ticks - %tmp.logtime)/1000)) $+ $chr(93) $chr(91) $+ Directorio: $logdir $+ $chr(93) 
}
alias vlloadpriv {
  clear -l @vl
  clear @vl
  set -u %tmp.logtime $ticks
  %i = 1
  %u = 1
  wpc
  while ($findfile($logdir,*.log,%i)) {
    if ($left($nopath($findfile($logdir,*.log,%i)),1) != $chr(35)) {
      if ($vlname($findfile($logdir,*.log,%i)) != $null) aline -l @vl $vlname($findfile($logdir,*.log,%i))
      inc %u      
      vlt Cargando logs... $chr(91) $+ $int($calc((%u * 100) / $vlp)) $+ $chr(37) $+ $chr(93) $vlname($findfile($logdir,*.log,%i))
      wpc.date $int($calc((%u * 100) / $vlp)) Cargando logs...
    }
    inc %i
  }
  window -c @wpc
  unset %u %i
  vlt $chr(91) $+ Logs cargados: $vlp $+ / $+ $findfile($logdir,*.log,0) $+ $chr(93) $chr(91) $+ Tiempo de carga: $duration($calc(($ticks - %tmp.logtime)/1000)) $+ $chr(93) $chr(91) $+ Directorio: $logdir $+ $chr(93) 
}



;Menús
;---------------

menu @vl {
  dclick { vlmuestralog $logdir $+ $vlcomp($sline(@vl,1)) }
  $iif($sline(@vl,1),&Cargar seleccionado): vlmuestralog $logdir $+ $vlcomp($sline(@vl,1))
  -
  &Cargar todos:vlloadgen
  &Cargar #canales:vlloadchan 
  &Cargar privados:vlloadpriv

  -
  $iif($sline(@vl,1),&Editar con el block): if ($sline(@vl,1)) run notepad.exe $logdir \ $+ $vlcomp($sline(@vl,1))
  -
  &Limpiar ventana:{ clear @vl | vlt Lector de Logs }

  -
  $iif($sline(@vl,1),&Borrar selección): {
    clear @vl
    vlt Lector de Logs 
    if ($?!="¿Está seguro de que desea borrar los logs seleccionados?" == $true) {
      %i = 1
      while ($sline(@vl,1)) {
        .remove " $+ $logdir \ $+ $vlcomp($sline(@vl,1)) $+ "
        dline -l @vl $sline(@vl,1).ln
} } } } 
alias vlmuestralog {
  vlt Lector de Logs 
  clear @vl
  loadbuf @vl " $+ $1- $+ "
  vlt $chr(91) $+ Log Actual: $vlcomp($sline(@vl,1)) $+ $chr(93) $chr(91) $+ Lineas: $slines($1-) $+ $chr(93) $chr(91) $+ Tamaño $lof($1-) bytes $+ $chr(93) 
}

alias wpc {
  window -c @wpc
  window -oph +b @wpc 100 100 252 100 
  window -a @wpc  
  drawrect -f @wpc 15 10 0 0 400 400 200 200 200
  drawrect -f @wpc 0 1 5 40 240 25 200 200 200
  drawrect -f @wpc 1 10 0 0 400 15 200 200 200
  drawtext -bc @wpc 0 1 "lucida console" 12 5 2 290 20 Indicador de progreso:
  drawtext -bc @wpc 1 15 "lucida console" 12 120 70 290 20 0%
}
alias wpc.date {
  if ($window(@wpc)) {
    window -a @wpc
    drawrect -f @wpc 2 1 5 40 $calc($$1 * 2.4) 25 200 200 20
    drawtext -bc @wpc 15 15 "lucida console" 11 120 70 290 20 $str($chr(160),100)
    drawtext -bc @wpc 1 15 "lucida console" 12 120 70 290 20 $1 $+ %
    drawtext -bc @wpc 15 15 "lucida console" 11 5 20 290 20 $str($chr(160),100)
    drawtext -bc @wpc 1 15 "lucida console" 12 5 20 290 20 $$2-
} }
on 1:start: { if (%vs.dir == $null) %vs.dir = $left($mircdir,3) }
alias vi { if ($dialog(vs) == $null) dialog -md vs vs | else display aviso -a El visor de imágenes está actualmente en uso. }
dialog vs {
  title "Visor de imágenes para mIRC"
  option dbu  
  size -1 -1 300 180

  box "&Lista de archivos",1,5 5 100 170,left
  text "&Directorio:",2,10 15 25 10
  edit "",3,10 25 80 10,read
  button "!",4,90 25 10 10

  button "&Listar",5,10 35 25 10,drop
  combo 6,35 35 65 50,drop
  list 7,10 45 90 120

  button "&Copiar",8,10 160 45 10,default,disable
  button "&Borrar",9,55 160 45 10,disable

  button "&Cerrar",10,55 160 45 10,ok,hide
  icon 11,110 5 185 150,
}
on 1:dialog:vs:init:*: { did -a vs 3 %vs.dir | did -a vs 6 Todos | did -a vs 6 *.jpg
did -a vs 6 *.bmp | did -a vs 6 *.ico | did -c vs 6 1 | vslst }
on 1:dialog:vs:sclick:*:{ if ($did == 4) .timer -m 1 1 vsdir
  if ($did == 5) vslst
  if ($did == 7) { did -g vs 11 " $+ %vs.dir $+ $did(vs,7,$did(vs,7).sel).text $+ " | did -e vs 8,9 }
  if ($did == 8) .timer -m 1 1 vscopy
if ($did == 9) .timer -m 1 1 vsdel }
alias vslst { did -b vs 8,9 | did -r vs 7
  if ($did(vs,6,$did(vs,6).sel).text == Todos) { %i = 1
    while ($findfile(%vs.dir,*.*,%i,1)) { 
      if ($right($findfile(%vs.dir,*.*,%i,1),4) == .jpg) did -a vs 7 $nopath($findfile(%vs.dir,*.*,%i,1))
      if ($right($findfile(%vs.dir,*.*,%i,1),4) == .bmp) did -a vs 7 $nopath($findfile(%vs.dir,*.*,%i,1)) 
      if ($right($findfile(%vs.dir,*.*,%i,1),4) == .ico) did -a vs 7 $nopath($findfile(%vs.dir,*.*,%i,1)) 
  inc %i } }
  elseif ($did(vs,6,$did(vs,6).sel).text == *.jpg) { %i = 1
  while ($findfile(%vs.dir,*.jpg,%i,1)) { did -a vs 7 $nopath($findfile(%vs.dir,*.jpg,%i,1)) | inc %i } } 
  elseif ($did(vs,6,$did(vs,6).sel).text == *.bmp) { %i = 1
  while ($findfile(%vs.dir,*.bmp,%i,1)) { did -a vs 7 $nopath($findfile(%vs.dir,*.bmp,%i,1)) | inc %i } } 
  elseif ($did(vs,6,$did(vs,6).sel).text == *.ico) { %i = 1
while ($findfile(%vs.dir,*.ico,%i,1)) { did -a vs 7 $nopath($findfile(%vs.dir,*.ico,%i,1)) | inc %i } } }
alias vsdir { %tmp.var = $sdir="Selecciona el directorio" | if (%tmp.var) %vs.dir = %tmp.var | unset %tmp.var | did -ra vs 3 %vs.dir | did -r vs 7 | did -b vs 8,9 | vslst }
alias vscopy { set -u %tmp.var $sdir="Selecciona el directorio para copiar $did(vs,7,$did(vs,7).sel).text " 
if (%tmp.var)  .copy -o " $+ %vs.dir $+ $did(vs,7,$did(vs,7).sel).text $+ " " $+ %tmp.var $+ " | vscopiado }
alias vsdel { if ($$?!="Va a borrar el archivo $did(vs,7,$did(vs,7).sel).text $+ . Realmente está seguro?" == $true) {
.remove " $+ %vs.dir $+ $did(vs,7,$did(vs,7).sel).text $+ " | vslst | vsborrado } }
alias vscopiado $dialog(vscopiado,vscopiado,2)
dialog vscopiado {
  title "Información:"
  size -1 -1 120 30
  option dbu
  text "El archivo se ha copiado satisfactoriamente",1,0 5 120 10,center
  button "OK",2,70 15 40 10,ok,default
}
alias vsborrado $dialog(vsborrado,vsborrado,2)
dialog vsborrado {
  title "Información:"
  size -1 -1 100 30
  option dbu
  text "El archivo ha sido borrado",1,0 5 100 10,center
  button "OK",2,50 15 40 10,ok,default
}
alias darazon $dialog(dr,dr,2)
;
dialog dr {
  title "Escribe la razón, déjalo en blanco para una razón aleatoria"
  size -1 -1 450 20
  edit "", 1, 0 0 450 20
  button "Cancelar", 249, 125 170 200 25, cancel
  button "Aceptar", 250, 125 170 200 25, ok
}
on *:dialog:dr:sclick:250:{
  if ($did(1) == $null) set %razond $read $mircdirdat\bitchx.txt
  else set %razond $did(1)
}
alias dni dialog -m dni dni
dialog dni {
  option dbu
  title "BaT: Dni"
  size -1 -1 65 40
  text "Dni:",1,5 5 10 10
  edit "",2,20 3 40 10,center
  text "Letra:",3,5 15 25 10
  edit "",4,20 13 10 10,read
  button "Copiar",5,35 13 25 10
  button "Cerrar",6,5 25 55 10,cancel
}
on 1:dialog:dni:edit:*:{
  if ($len($did(dni,2)) == 8) dniletra $left($did(dni,2),8)
  elseif ($len($did(dni,2)) > 8) did -ra dni 2 $left($did(dni,2),8)
  else did -r dni 4
}
on 1:dialog:dni:sclick:5:/clipboard $did(dni,2) $+ $did(dni,4)
alias dniletra {
  if ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 0 )  did -ra dni 4 T 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 1)  did -ra dni 4 R  
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 2)  did -ra dni 4 W  
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 3)  did -ra dni 4 A 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 4)  did -ra dni 4 G  
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 5)  did -ra dni 4 M 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 6)  did -ra dni 4 Y  
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 7)  did -ra dni 4 F 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 8)  did -ra dni 4 P 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 9)  did -ra dni 4 D 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 10)  did -ra dni 4 X  
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 11)  did -ra dni 4 B 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 12)  did -ra dni 4 N 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 13)  did -ra dni 4 J  
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 14)  did -ra dni 4 Z 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 15)  did -ra dni 4 S 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 16)  did -ra dni 4 Q 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 17)  did -ra dni 4 V 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 18)  did -ra dni 4 H 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 19)  did -ra dni 4 L 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 20)  did -ra dni 4 C 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 21)  did -ra dni 4 K 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 22)  did -ra dni 4 E 
  elseif ($calc($1 - $calc($int($calc($1 / 23)) * 23)) == 23) did -ra dni 4 T 
}
;~~~~~~~~~~~~~~~~~~~~
;Panel de Configuración
;/panel
;~~~~~~~~~~~~~~~~~~~~
alias panel {
  if ($dialog(cg)) dialog -v cg
  else dialog -md cg cg
}
dialog cg {
  title "Panel de configuración"
  option dbu
  size -1 -1 200 143
  list 1, 0 0 200 130,size,extsel
  edit "", 2, 0 130 200 12,read,autohs
  button "",3,1 1 1 1,default,hide
  button "",4,1 1 1 1,ok,hide
}
on 1:dialog:cg:init:*: {
  dll $mdx SetMircVersion $version 
  dll $mdx MarkDialog cg 
  dll $mdx SetControlMDX cg 1 listview autoarrange labeltip extsel icon single > $views
  %i = 1
  %tmp.var = $read -l %i sistema\panel.conf
  while (%tmp.var) {
    did -i $dname 1 1 seticon 0, $+ $icondir($gettok(%tmp.var,1,5))
    did -i $dname 1 2 %i $gettok(%tmp.var,2,5)
    inc %i
    %tmp.var = $read -l %i sistema\panel.conf
  }
}
on 1:dialog:cg:sclick:1: { 
  if ($did(cg,1).sel) {
    %tmp.var = $read -l $dll_didsel sistema\panel.conf
    did -ra cg 2 $gettok(%tmp.var,4,5)
  }
} 
on 1:dialog:cg:dclick:1: {
  if ($did(cg,1).sel) {
    %tmp.var = $read -l $dll_didsel sistema\panel.conf
    $gettok(%tmp.var,3,5)
  }
} 
;~~~~~~~~~~~~~~~~~~~~
;Control DLL
;~~~~~~~~~~~~~~~~~~~~
alias dll_didsel return $calc($lines(sistema\panel.conf) - $calc($did(cg,1).sel - 2))
alias mdx return $mircdirdll\mdx.dll
alias views return $mircdirdll\views.mdx
alias icondir return $mircdirsistema\icons\ $+ $1 
;~~~~~~~~~~~~~~~~~~~~
;Control DLL
; /dw
;~~~~~~~~~~~~~~~~~~~~
alias dw { 
  if ($dialog(dw)) dialog -v dw
  else dialog -md dw dw
}
dialog dw {
  option dbu 
  size -1 -1 240 180
  title "Cargando archivos..."
  list 1,5 5 195 170, size,tab 3
  button "Ejecutar" 2,205 5 30 15,default,disable
  button "Copiar" 3,205 25 30 15,disable
  button "Borrar" 4,205 45 30 15,disable
  button "Limpiar" 5,205 65 30 15

  button "Refrescar" 6,205 85 30 15
  button "Abrir dir" 7,205 105 30 15

  button "Cerrar",10,205 160 30 15,ok
}
on 1:dialog:dw:init:*: {
  dll $mdx SetMircVersion $version 
  dll $mdx MarkDialog $dname 
  dll $mdx SetControlMDX $dname 1 listview rowselect grid showsel single flatsb labeltip headerdrag report > $views 
  did -i $dname 1 1 header @180,80,90 0 Nombre del archivo $chr(9) $+ Tamaño (kb) $chr(9) $+ Creado
  dll $mdx SetControlMDX $dname 12 listview rowselect grid showsel single flatsb labeltip headerdrag report > $views 
  .timer -m 1 1 dw_loadfiles
}
alias dw_loadfiles {
  if ($dialog(dw)) {  did -r dw 1
    dw_none $findfile($getdir,*.*,0,0,did -a dw 1 $nopath($1-) $+ $chr(9) $round($calc($file($1-).size / 1024),2) $chr(9) $date($file($1-).ctime))
    dialog -t dw Encontrados $findfile($getdir,*.*,0) archivos en $getdir
} }
alias dw_none { }
on 1:dialog:dw:*:*: {
  did $iif($did(dw,1).sel,-e,-b) dw 2,3,4
  if ($did == 2) run " $+ $getdir $+ $right($gettok($did($dname,1,$did($dname,1).sel).text,1,9),-4) $+ "
  if ($did == 3) .timer -m 1 1 dw_copyfile
  if ($did == 4) { .timer -m 1 1 dw_delete $did($dname,1).sel }
  if ($did == 5) .timer -m 1 1 dw_deleteall 
  if ($did == 6) dw_loadfiles
  if ($did == 7) run $getdir
}
alias dw_copyfile {
  var %d, var %f,var %n
  %f = " $+ $getdir $+ $right($gettok($did(dw,1,$did(dw,1).sel).text,1,9),-4) $+ "
  %d = $$sdir="Selecciona el directorio de destino"
  %n = $right($gettok($did(dw,1,$did(dw,1).sel).text,1,9),-4)
  %n = $?="Nuevo nombre para el archivo (opcional)"
  .copy -o %f " $+ %d $+ %n $+ "
  unset %f %d %n
}
alias dw_delete {
  if ($?!="¿Estás seguro de borrar el archivo seleccionado en la lista?" == $true) {
    .remove " $+ $getdir $+ $right($gettok($did(dw,1,$did(dw,1).sel).text,1,9),-4) $+ "
    did -d dw 1 $did(dw,1).sel
    did -b dw 2,3,4
  }
}
alias dw_deleteall {
  if ($?!="¿Estás seguro de borrar todos los archivos del directorio?" == $true) {
    dw_none $findfile($getdir,*.*,0,0,.remove $1-)
    did -b dw 2,3,4
    did -r dw 1
  }
}
