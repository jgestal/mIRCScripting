;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; Teclas rápidas
;
;*************************************

alias fkeys makedialog -m fkeys

dialog fkeys {
  title "Teclas rápidas"
  size -1 -1 150 125
  option dbu
  icon icons\keysetup.ico
  box "Teclas", 1, 6 4 140 95
  list 2, 10 15 130 80, size
  button "Aceptar", 3, 55 105 40 15,ok
}
on 1:dialog:fkeys:*:*: {
  if ($devent == init) {
    _mdx.buttons_style 3
    dll $mdx SetControlMDX $dname 2 listview rowselect grid showsel single flatsb labeltip headerdrag report > $views 
    did -i $dname 2 1 header @60,180 0 Tecla $chr(9) Comando
    fkeys_loadlist 
  }
  elseif ($devent == dclick) && ($did == 2) {
    var %y $calc($did($dname,$did).sel -1)
    var %x $replace($_r(Introduce el nuevo comando),$,&)
    if (%x) { write $+(-l,%y) dat\fkeys.dat $+($gettok($rl(dat\fkeys.dat,%y),1,5),$chr(5),%x) | fkeys_setalias | fkeys_loadlist }  
  }
}
alias -l fkeys_loadlist {
  did -r $dname 2
  var %i 1
  var %x $lines(dat\fkeys.dat)
  while (%i <= %x) {
    did -a $dname 2 $replace($rl(dat\fkeys.dat,%i),$chr(5),$chr(9))
    inc %i
  }
}
alias fkeys_setalias {
  var %i 1
  var %i 1
  var %x $lines(dat\fkeys.dat)
  while (%i <= %x) {
    .alias $replace($rl(dat\fkeys.dat,%i),$chr(5),$chr(32),$chr(38),$chr(36)))
    inc %i
  }
}

;*************************************
; Lista de ignorados
;
;*************************************

alias iglist makedialog -m iglist
dialog iglist {
  title "Lista de ignorados"
  size -1 -1 205 150
  option dbu
  box "Lista de ignorados", 1, 5 5 150 100
  list 2, 10 15 140 85, size
  box "Opciones", 3, 5 110 150 35
  check "Limpiar los ignores al iniciar el script", 4, 15 125 97 10
  button "Añadir ignore", 5, 160 10 40 15
  button "Borrar ignore", 6, 160 30 40 15
  button "Borrar todos", 7, 160 50 40 15
  button "Cerrar", 8, 160 130 40 15,cancel
}

on 1:dialog:iglist:*:*: {
  if ($devent == init) { 
    _mdx.buttons_style 5 6 7 8
    dll $mdx SetControlMDX $dname 2 listview rowselect grid showsel single flatsb labeltip headerdrag report > $views 
    did -i $dname 2 1 header @120,300 0 Máscara $chr(9) Tipo
    iglist_loadignores
    did $iif($ri(dat\conf.ini,iglist,4) == on,-c,-u) $dname 4
  }
  if ($devent == sclick) {
    if ($did == 4) wi dat\conf.ini iglist $did $iif($ri(dat\conf.ini,iglist,4) == on,off,on)
    if ($did == 5) igadd $_r(Introduce el nick)
    if ($did == 6) { 
      .ignore -r $ignore($calc($did($dname,2).sel -1)) 
      did -d $dname 2 $did($dname,2).sel
    }
    if ($did == 7) {
      while ($ignore(1)) { ignore -r $ifmatch }
      did -r $dname 2
    }
  }
  did $iif($did($dname,2).sel,-e,-b) $dname 6
  did $iif($ignore(0),-e,-b) $dname 7
}
alias iglist_loadignores {
  did -r iglist 2
  var %i 1
  while ($ignore(%i)) {
    did -a iglist 2 $ifmatch $chr(9) $ignore($ifmatch).type
    inc %i
  }
}
alias igadd { set -u0 %tmp.ignick $$1 | makedialog -m igadd }
dialog igadd {
  title "Añadiendo ignore"
  size -1 -1 205 91
  option dbu
  box "Máscara de ignore", 1, 5 5 150 30
  box "Tipos de ignore", 2, 5 40 150 45
  combo 3, 10 15 140 100, size drop
  check "Privados", 4, 10 50 35 9
  check "Canales", 5, 10 60 34 10
  check "Notices", 6, 10 70 50 10
  check "CTCP", 7, 60 50 28 10
  check "Invitaciones", 8, 60 60 43 10
  check "Colores", 9, 60 70 33 10
  check "Todo", 10, 120 55 25 25, push
  button "Añadir", 11, 160 10 40 15, ok
  button "Listar ignores", 12, 160 40 40 15
  button "Cancelar", 13, 160 70 40 15, cancel
}
on 1:dialog:igadd:*:*: {
  if ($devent == init) {
    _mdx.buttons_style 10 11 12 13
    did -a $dname 3 %tmp.ignick
    did -c $dname 4,6
    if ($address(%tmp.ignick,2)) {
      var %i 1
      while (%i <= 9) {
        did -a $dname 3 $address(%tmp.ignick,%i)
        inc %i
      }
    }
    did -c $dname 3 1
  }
  if ($devent == sclick) {
    if ($did == 11) {
      var %x -
      %x = $+(%x,$iif($did($dname,4).state,p))
      %x = $+(%x,$iif($did($dname,5).state,c))
      %x = $+(%x,$iif($did($dname,6).state,n))
      %x = $+(%x,$iif($did($dname,7).state,t))
      %x = $+(%x,$iif($did($dname,8).state,i))
      %x = $+(%x,$iif($did($dname,9).state,k))
      if ($did($dname,10).state) var %x ""
      ignore %x $did($dname,3)
      if ($dialog(iglist)) iglist_loadignores
    }
    if ($did == 12) { iglist | dialog -x $dname }
  }
  if ($dialog($dname))  did $iif($did($dname,10).state,-b,-e) $dname 4,5,6,7,8,9
}


;*************************************
; Nick completion
;
;*************************************

alias nk { if ($dialog(nk)) dialog -v nk | else $dialog(nk,nk,2) }
dialog nk {
  title "Nick Completion"
  size -1 -1 120 70
  option dbu
  icon icons\nickcompletion.ico
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
  var %x 1 negrita;corchetes;llaves;negr/subr;corchetes 2;alegre;colores;subrayado;negrita;31337;deepjmon;reverse
  %i = 1
  while ($gettok(%x,%i,59)) {
    did -a nk 4 $gettok(%x,%i,59)
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
  :1 | return  $+ $left($1,1) $+  $+ $right($1,$calc($len($1)-1)) $+ :
  :2 | return [ [ $+ [ $1 ] $+ ] ]
  :3 | return 02{ $+ $left($1,1) $+  $+ $right($1,$calc($len($1)-1)) $+ 02}
  :4 | return  $+ $left($1,1) $+  $+ $right($1,$calc($len($1)-1)) $+ :
  :5 | return 02] $+ $1 $+ 02[
  :6 | return 03¡04¡ $+ $1 $+ 04!03!
  :7 | return $vcol($1)
  :8 | return $hsub($1)
  :9 | return $hneg($1)
  :10 | set %tmp.hn.txt $1 | set %tmp.hn.txt $replace(%tmp.hn.txt,a,4) | set %tmp.hn.txt $replace(%tmp.hn.txt,b,ß) | set %tmp.hn.txt $replace(%tmp.hn.txt,c,©) | set %tmp.hn.txt $replace(%tmp.hn.txt,d,Ð) | set %tmp.hn.txt $replace(%tmp.hn.txt,e,3)
  set %tmp.hn.txt $replace(%tmp.hn.txt,f,ƒ) | set %tmp.hn.txt $replace(%tmp.hn.txt,i,1) | set %tmp.hn.txt $replace(%tmp.hn.txt,l,£) | set %tmp.hn.txt $replace(%tmp.hn.txt,o,Ø) | set %tmp.hn.txt $replace(%tmp.hn.txt,p,Þ)
  set %tmp.hn.txt $replace(%tmp.hn.txt,q,¶) | set %tmp.hn.txt $replace(%tmp.hn.txt,r,®) | set %tmp.hn.txt $replace(%tmp.hn.txt,s,§) | set %tmp.hn.txt $replace(%tmp.hn.txt,t,†) | set %tmp.hn.txt $replace(%tmp.hn.txt,x,×)
  set %tmp.hn.txt $replace(%tmp.hn.txt,y,¥) | return %tmp.hn.txt
  ;dedicado a deepjmon :)
  :11 | return $iif($len($1) > 1,$+($left($1,1),,$right($1,-1),),$1) $+ :
  :12 | return $+(,$1,) 
}
alias vcol { unset %tmp.hn.* | set %i 1 | :loop | if ($mid($1,%i,1) != $null) { set %tmp.hn.cadena %tmp.hn.cadena $+  $+ $iif($rand(1,14) >= 10,$ifmatch,0 $+ $ifmatch) $+ $mid($1,%i,1) | inc %i | goto loop } | return %tmp.hn.cadena $+  }
alias hneg { 
  unset %tmp.hn.* | set %tmp.hn.cadena $1- | set %tmp.hn.rand $round($rand(0,10),0) | :sigue | inc %tmp.hn.c 1 | set %tmp.hn.la $mid(%tmp.hn.cadena,%tmp.hn.c,1) 
  if (%tmp.hn.la == $chr(32)) { set %tmp.hn.cadena1 %tmp.hn.cadena1 $+ ¤ | goto sigue }
  if (%tmp.hn.rand >= 5) { set %tmp.hn.cadena1 %tmp.hn.cadena1 $+ %tmp.hn.la $+  }
  if (%tmp.hn.rand < 5) { set %tmp.hn.cadena1 %tmp.hn.cadena1 $+  $+ %tmp.hn.la }
  if (%tmp.hn.la == $null) { if ($int($calc(%tmp.hn.c / 2)) != $calc(%tmp.hn.c / 2)) { set %tmp.hn.cadena1 %tmp.hn.cadena1 $+  } | goto end 
  }
  goto sigue | :end
  if (¤ isin %tmp.hn.cadena1) { set %tmp.hn.cadena1 $replace(%tmp.hn.cadena1,¤,$chr(32)) }
  return %tmp.hn.cadena1 
}
alias hsub { unset %tmp.hn.* | set %tmp.hn.cadena $1- | set %tmp.hn.rand $round($rand(0,10),0) | :sigue | inc %tmp.hn.c 1 | set %tmp.hn.la $mid(%tmp.hn.cadena,%tmp.hn.c,1)
  if (%tmp.hn.la == $chr(32)) { set %tmp.hn.cadena1 %tmp.hn.cadena1 $+ ¤ | goto sigue }
  if (%tmp.hn.rand >= 5) { set %tmp.hn.cadena1 %tmp.hn.cadena1 $+ %tmp.hn.la $+  }
  if (%tmp.hn.rand < 5) { set %tmp.hn.cadena1 %tmp.hn.cadena1 $+  $+ %tmp.hn.la }
  if (%tmp.hn.la == $null) { if ($int($calc(%tmp.hn.c / 2)) != $calc(%tmp.hn.c / 2)) { set %tmp.hn.cadena1 %tmp.hn.cadena1 $+  }
  goto end }
  goto sigue | :end
  if (¤ isin %tmp.hn.cadena1) { set %tmp.hn.cadena1 $replace(%tmp.hn.cadena1,¤,$chr(32)) }
  return %tmp.hn.cadena1
}


;*************************************
; Barra de título
;
;*************************************

alias tb makedialog -m tb
dialog tb {
  title "Titlebar"
  option dbu
  size -1 -1 210 150
  icon icons\titlebar.ico,index
  tab "Ventana de Status", 1, 5 5 200 120
  list 17, 15 35 90 80, tab 1 size
  combo 18, 120 35 75 100, tab 1 drop
  button "Añadir", 19, 140 70 35 12, tab 1
  button "Borrar", 20, 140 90 35 12, tab 1

  tab "Ventana de Canal", 2
  list 21, 15 35 90 80, tab 2 size
  combo 22, 120 35 75 100, tab 2 drop
  button "Añadir", 23, 140 70 35 12, tab 2
  button "Borrar", 24, 140 90 35 12, tab 2

  tab "Ventana de Privado", 3
  list 25, 15 35 90 80, tab 3 size
  combo 26, 120 35 75 100, tab 3 drop
  button "Añadir", 27, 140 70 35 12, tab 3
  button "Borrar", 28, 140 90 35 12, tab 3

  box "Mostrar", 4, 10 24 100 95
  box "Información", 5, 115 25 85 30
  button "Aceptar", 6, 10 130 40 15, ok
  button "Cancelar", 7, 160 130 40 15, cancel

}
on 1:dialog:tb:*:*: {
  if ($devent == init) { 
    _mdx.buttons_style 19 20 23 24 27 28 6  7

    var %i 1 | var %x $ri(dat\titlebar.ini,tb,s)
    while ($gettok(%x,%i,59)) { did -a $dname 17 $ifmatch | inc %i }
    %i = 1 | %x = $ri(dat\titlebar.ini,tb,c) 
    while ($gettok(%x,%i,59)) { did -a $dname 21 $ifmatch | inc %i }
    %i = 1 | %x = $ri(dat\titlebar.ini,tb,p) 
    while ($gettok(%x,%i,59)) { did -a $dname 25 $ifmatch | inc %i }

    %i = 1 | %x = $ri(files\tb.ini,tball,s)
    while ($gettok(%x,%i,59)) { did -a $dname 18 $ifmatch | inc %i }
    %i = 1 | %x = $ri(files\tb.ini,tball,c) 
    while ($gettok(%x,%i,59)) { did -a $dname 22 $ifmatch | inc %i }
    %i = 1 | %x = $ri(files\tb.ini,tball,p) 
    while ($gettok(%x,%i,59)) { did -a $dname 26 $ifmatch | inc %i }
    did -c $dname 18,22,26 1

  }
  if ($devent == sclick) {
    if ($did == 19) did -a $dname 17 $did($dname,18)
    elseif ($did == 20) did -d $dname 17 $did($dname,17).sel

    elseif ($did == 23) did -a $dname 21 $did($dname,22)
    elseif ($did == 24) did -d $dname 21 $did($dname,21).sel

    elseif ($did == 27) did -a $dname 25 $did($dname,26)
    elseif ($did == 28) did -d $dname 25 $did($dname,25).sel

    elseif ($did == 6) {
      var %x ""
      var %i 1
      while (%i <= $did($dname,17).lines) {
        %x = %x $+ ; $+ $did($dname,17,%i)
        inc %i
      }
      wi dat\titlebar.ini tb s $right(%x,-1)

      %i = 1
      %x = ""
      while (%i <= $did($dname,21).lines) {
        %x = %x $+ ; $+ $did($dname,21,%i)
        inc %i
      }
      wi dat\titlebar.ini tb c $right(%x,-1)

      %i = 1
      %x = ""
      while (%i <= $did($dname,25).lines) {
        %x = %x $+ ; $+ $did($dname,25,%i)
        inc %i
      }
      wi dat\titlebar.ini tb p $right(%x,-1)
      return
    }
  }
  did $iif($did($dname,17).sel,-e,-b) $dname 20
  did $iif($did($dname,21).sel,-e,-b) $dname 24
  did $iif($did($dname,25).sel,-e,-b) $dname 28

  did $iif($tb_isinlist(17,$did($dname,18)) == $false,-e,-b) $dname 19
  did $iif($tb_isinlist(21,$did($dname,22)) == $false,-e,-b) $dname 23
  did $iif($tb_isinlist(25,$did($dname,26)) == $false,-e,-b) $dname 27

}
alias tb_isinlist { var %i 1 | while (%i <= $did($dname,$1).lines) { if ($did($dname,$1,%i) == $2) return $true | inc %i } | return $false }
alias _titlebar titlebar $_tb $+ $str($chr(160),400)

alias _tb {
  barra_showlag $round(%lag,2)
  if ($server) {
    if ($active == Status Window) return $replace($ri(dat\titlebar.ini,tb,s),;,$chr(32),<LAG>,[lag: $lag $+ ]],<SERVER>,[server: $server $+ : $+ $port $+ ]],<NICK>,[nick: $me $+ ]],<HOST>,[host: $host $+ ]],<USERMODE>,[usermode: $usermode $+ ]],<TIME>,[time: $time $+ ]],<DATE>,[date: $date $+ ]],<IDLE>,[idle: $duration($idle,2) $+ ]])
    elseif ($active ischan) return $replace($ri(dat\titlebar.ini,tb,c),;,$chr(32),<NAME>,[[ $+ $active $+ ]],<USERS>,[[ $+ $nick($active,0) $+ ]],<MODES>,[[ $+ $chan($active).mode $+ ]],<STATS>,[+o: $+ $opnick($active,0) $+ \+v: $+ $vnick($active,0) $+ \n: $+ $calc($nick($active,0) - $vnick($active,0) - $opnick($active,0)) $+ ]],<TOPIC>,$strip($chan($active).topic),<LAG>,[lag: $lag $+ ]])
    elseif ($query($active)) return $active $replace($ri(dat\titlebar.ini,tb,p),;,$chr(32),<ADDRESS>,$iif($gettok($address($active,5),2,33),[[ $+ $ifmatch $+ ]],$chr(32)),<COMCHANNELS>,$iif($comchan($active,0),[[ $+ $replace($comchannels($active),$chr(32),$chr(44)) $+ ]],$chr(32)),<LEVEL>,$iif($level($active) != 1,[[ $+ $ifmatch $+ ]],$chr(32)),<LAG>,[lag: $lag $+ ]])
    return Running $_version & connected!
  }
  return Running $_version & waiting to connect!
}

;*************************************
; Créditos
;
;*************************************

alias about makedialog -m about about
dialog about {
  title ""
  option dbu
  size -1 -1 160 150
  icon icons\backbeat.ico,index
  icon 1, 5 4 19 19,icons\backbeat.ico
  text "", 2, 30 5 124 7
  text "", 3, 30 15 114 7
  box "Agradecimientos y Colaboraciones", 4, 5 29 150 70
  edit "" 5, 10 40 140 55, read vsbar return multi center
  box "", 6, 5 100 100 30
  link "", 7, 30 105 70 7
  link "", 8, 30 115 70 7
  button "Aceptar", 9, 120 110 30 15,ok
  edit "My code never has bugs, it just develops random features", 10, 5 135 150 10, read center
}
on 1:dialog:about:*:*: {
  if ($devent == init) {
    _mdx.buttons_style 9
    dialog -t $dname $_version por Jimmy_RAY
    loadbuf -o $dname 5 files\about.txt 
    did -a $dname 2 $_version por Jimmy_RAY
    did -a $dname 3 The BravoS AssAulT TeaM
    did -a $dname 7 $_web
    did -a $dname 8 $_email
  }
  else {
    if ($did == 7) run $_web
    elseif ($did == 8) run $_email
  }
}

;*************************************
; Modos de usuario
;
;*************************************

alias umode makedialog -m umode 
dialog umode {
  size -1 -1 160 70
  option dbu
  icon icons\user.ico,main
  title "Modos de usuario"
  box "Al conectar",1,2 2 60 64
  check "[+i] invisible",2,6 15 40 7
  check "[+w] wall op",3,6 25 40 7
  check "[+s] server notice",4,6 35 53 7
  edit "" ,5,6 45 53 10
  box "Actuales",6,61 2 60 64
  check "[+i] invisible",7,65 15 40 7
  check "[+w] wall op",8,65 25 40 7
  check "[+s] server notice",9,65 35 53 7
  edit "" ,10,65 45 53 10
  button "Aplicar",11,125 5 30 15,ok
  button "Cerrar",12,125 25 30 15,cancel
}
on 1:dialog:umode:*:*: {
  if ($devent == init) {
    _mdx.buttons_style 11 12
    did $iif($ri(dat\conf.ini,umode,2) == on,-c,-u) $dname 2
    did $iif($ri(dat\conf.ini,umode,3) == on,-c,-u) $dname 3
    did $iif($ri(dat\conf.ini,umode,4) == on,-c,-u) $dname 4
    did -a $dname 5 $ri(dat\conf.ini,umode,5)
    if (!$server) did -b $dname 7,8,9,10
    if ($server) {
      did $iif(i isin $usermode,-c,-u) $dname 7
      did $iif(w isin $usermode,-c,-u) $dname 8
      did $iif(s isin $usermode,-c,-u) $dname 9
      did -a $dname 10 $remove($usermode,+,i,w,s)
    }
  }
  if ($did == 11) {
    wi dat\conf.ini umode 2 $iif($did($dname,2).state == 1,on,off)
    wi dat\conf.ini umode 3 $iif($did($dname,3).state == 1,on,off)
    wi dat\conf.ini umode 4 $iif($did($dname,4).state == 1,on,off)
    wi dat\conf.ini umode 5 $did($dname,5)
    if ($server) {
      var %umode $iif($did($dname,7).state == 1,+i,-i) $+ $iif($did($dname,8).state == 1,+w,-w) $+ $iif($did($dname,9).state == 1,+s,-s)
      mode $me %umode
      mode $me $did($dname,10)
    }
  }
}


;*************************************
; Lista de servidores
;
;*************************************

alias srvlst { makedialog -m srvlst }

dialog srvlst {
  size -1 -1 480 200
  title "Redes y Servidores de IRC"
  icon icons\servers.ico
  box "Lista de Redes",1,10 10 150 180
  list 2,20 30 130 140
  box "Lista de Servidores",3,170 10 300 180
  list 4,180 30 180 140
  text "Puertos:",5,370 30 90 20
  combo 6,370 50 90 100,drop
  button "&Conectar",7,370 100 90 20,deafult
  button "&Cancelar",8,370 160 90 20,ok
  button "&Añadir",9,20 160 50 20
  button "&Borrar",10,100 160 50 20
  button "&Añadir",11,180 160 50 20
  button "&Borrar",12,310 160 50 20
  button "&Opciones",13,370 130 90 20,hide
}
on 1:dialog:srvlst:*:*: {
  if ($devent == init) { 
    _mdx.buttons_style 7 8 9 10 11 12 13
    srvlst_loadnetworks 
  }
  if ($devent == sclick) {
    if ($did == 7) server $did($dname,4,$did($dname,4).sel).text $did($dname,6)
    if ($did == 9) {
      var %x $+(dat\srv\,$_r(Introduce el nombre de la red),.txt)
      if (%x) {    
        if ($isfile(%x) == $true) return $_ok(Ya existe una red con ese nombre)
        else {
          write -c %x
          srvlst_loadnetworks 
        }
      }
    }
    if ($did == 10) { .remove " $+ $+(dat\srv\,$did($dname,2,$did($dname,2).sel).text,.txt) $+ " | srvlst_loadnetworks }
    if ($did == 11) {
      var %x $_r(Introduce el nombre del servidor)
      if (%x) { 
        %x = %x $iif($__r(Introduce los puertos disponibles (por defecto el 6667). Usa el espacio para separar los puertos),$ifmatch,6667)
        write " $+ $+(dat\srv\,$did($dname,2,$did($dname,2).sel).text,.txt) $+ " %x 
        srvlst_loadservers 
      }
    }
    if ($did == 12) {  write $+(-dl,$did($dname,4).sel) " $+ $+(dat\srv\,$did($dname,2,$did($dname,2).sel).text,.txt) $+ " | srvlst_loadservers }

    if ($did == 2) srvlst_loadservers
    if ($did == 4) {
      var %i 1
      while ($rl($+(dat\srv\,$did($dname,2,$did($dname,2).sel).text,.txt),%i)) {
        var %x $gettok($ifmatch,2-,32)
        if ($gettok($ifmatch,1,32) == $did($dname,4,$did($dname,4).sel).text) {
          var %i 1
          did -r $dname 6
          while ($gettok(%x,%i,32)) {
            did -a $dname 6 $ifmatch
            inc %i
          }
          did -c $dname 6 1
          break
        }
        inc %i
      }
    }
  }
  did $iif($did($dname,2).sel,-e,-b) $dname 10,11
  did $iif($did($dname,4).sel,-e,-b) $dname 12
  did $iif($did($dname,6),-e,-b) $dname 7

}
alias srvlst_loadnetworks {
  did -r $dname 2,4,6
  var %i 1
  while ($findfile(dat\srv\,*.txt,%i)) {
    did -a $dname 2 $left($nopath($ifmatch),-4)
    inc %i
  }
}
alias srvlst_loadservers {
  did -r $dname 4,6
  var %i 1
  while ($rl($+(dat\srv\,$did($dname,2,$did($dname,2).sel).text,.txt),%i)) {
    did -a $dname 4 $gettok($ifmatch,1,32)
    inc %i
  }
}

;*************************************
; Inputs
;
;*************************************

alias __r { var %inp.x | %inp.i = $1- | $dialog(_resp,_resp,2) | %inp.x = %inp.i | unset %inp.i | return %inp.x }
alias _r { var %inp.x | %inp.i = $1- | $dialog(_resp,_resp,2) | %inp.x = %inp.i | unset %inp.i | if (%inp.x) return %inp.x | halt }
dialog _resp {
  title ""
  option dbu
  size -1 -1 215 65
  icon icons\rueda.ico, index
  text "", 1, 25 5 180 14
  edit "", 2, 5 25 205 10, autohs
  button "Aceptar", 3, 125 45 40 15, default ok
  button "Cancelar", 4, 170 45 40 15, cancel
  icon 5,5 5 20 20,icons\rueda.ico
}
on 1:dialog:_resp:*:*: { if ($devent == init) { _mdx.buttons_style 3 4 | dialog -t $dname $_version | did -a $dname 1 %inp.i | unset %inp.i }
  elseif ($devent == edit) %inp.i = $did($dname,2)
elseif ($devent == sclick) { elseif ($did === 4) unset %inp.i } }
dialog _comb {
  title ""
  option dbu
  size -1 -1 215 65
  icon icons\rueda.ico, index
  text "", 1, 25 5 180 14
  combo 2, 5 25 205 50,drop edit
  button "Aceptar", 3, 125 45 40 15, default ok
  button "Cancelar", 4, 170 45 40 15, cancel
  icon 5,5 5 20 20,icons\rueda.ico
}
alias _c { var %inp.x | %inp.j =  $1 | %inp.i = $2- | $dialog(_comb,_comb,2) | %inp.x = %inp.i | unset %inp.i | if (%inp.x) return %inp.x | halt }
alias __c { var %inp.x | %inp.j =  $1 | %inp.i = $2- | $dialog(_comb,_comb,2) | %inp.x = %inp.i | unset %inp.i | return %inp.x }
on 1:dialog:_comb:*:*: { if ($devent == init) { _mdx.buttons_style 3 4 | dialog -t $dname $_version | did -a $dname 1 %inp.i | makefile %inp.j | loadbuf -o $dname 2 %inp.j | unset %inp.j %inp.i }
  elseif ($devent == edit) %inp.i = $did($dname,$did)
elseif ($devent == sclick) { if ($did == 2) %inp.i = $did($dname,$did) | elseif ($did == 4) unset %inp.i } }
alias _p { var %inp.x | set %inp.i $1- | $dialog(_preg,_preg,2) | %inp.x = $iif(%inp.i == $true,$true,$false) | unset %inp.i | return %inp.x }
dialog _preg {
  title ""
  option dbu
  size -1 -1 215 65
  icon icons\rueda.ico, index
  text "", 1, 25 5 180 14
  button "Aceptar", 2, 125 45 40 15, default ok
  button "Cancelar", 3, 170 45 40 15, cancel
  icon 4,5 5 20 20,icons\rueda.ico
}
on 1:dialog:_preg:*:*: { if ($devent == init) { _mdx.buttons_style 2 3 | did -a $dname 1 %inp.i | unset %inp.i | dialog -t $dname $_version }
elseif ($devent == sclick) { if ($did == 2) %inp.i = $true } }
dialog _ok {
  title ""
  option dbu
  size -1 -1 175 65
  icon icons\pregunta.ico,index
  text "", 1, 25 5 145 36
  button "Aceptar", 2, 130 45 40 15, default ok
  icon 3,5 5 20 20,icons\pregunta.ico
}
alias _ok { %inp.i = $1- | $dialog(_ok,_ok,2) }
on 1:dialog:_ok:init:*: {
  _mdx.buttons_style 2
  dialog -t $dname $_version
  did -a $dname 1 %inp.i
  unset %inp.i
}

;*************************************
; Panel de control
;
;*************************************

alias panel makedialog -m panel
dialog panel {
  title "Panel de configuración"
  option dbu
  icon icons\panel.ico
  size -1 -1 200 143
  list 1, 0 0 200 130,size,extsel
  edit "", 2, 0 130 200 12,read,autohs
  button "",3,1 1 1 1,default,hide
  button "",4,1 1 1 1,ok,hide
}
on 1:dialog:panel:init:*: { dll $mdx SetMircVersion $version | dll $mdx MarkDialog panel | dll $mdx SetControlMDX panel 1 listview autoarrange labeltip extsel icon single > $views | var %i 1 | var %x $read -l %i files\panel.conf | while (%x) { did -i $dname 1 1 seticon 0, $+ $icondir($gettok(%x,1,5)) | did -i $dname 1 2 %i $gettok(%x,2,5) | inc %i | %x = $read -l %i files\panel.conf } }
on 1:dialog:panel:sclick:1: { if ($did(panel,1).sel) { var %x $read -l $dll_pdidsel files\panel.conf | did -ra panel 2 $gettok(%x,4,5) } } 
on 1:dialog:panel:dclick:1: { if ($did(panel,1).sel) { var %x $read -l $dll_pdidsel files\panel.conf | $gettok(%x,3,5) } } 
alias dll_pdidsel return $calc($lines(files\panel.conf) - $calc($did(panel,1).sel - 2))

;*************************************
; Panel de utilidades
;
;*************************************

alias putils makedialog -m putils
dialog putils {
  title "Panel de utilidades"
  option dbu
  icon icons\utilidades.ico
  size -1 -1 200 143
  list 1, 0 0 200 130,size,extsel
  edit "", 2, 0 130 200 12,read,autohs
  button "",3,1 1 1 1,default,hide
  button "",4,1 1 1 1,ok,hide
}
on 1:dialog:putils:init:*: { dll $mdx SetMircVersion $version | dll $mdx MarkDialog putils | dll $mdx SetControlMDX putils 1 listview autoarrange labeltip extsel icon single > $views | var %i 1 | var %x $read -l %i files\utils.conf | while (%x) { did -i $dname 1 1 seticon 0, $+ $icondir($gettok(%x,1,5)) | did -i $dname 1 2 %i $gettok(%x,2,5) | inc %i | %x = $read -l %i files\utils.conf } }
on 1:dialog:putils:sclick:1: { if ($did(putils,1).sel) { var %x $read -l $dll_pdidselu files\utils.conf | did -ra putils 2 $gettok(%x,4,5) } } 
on 1:dialog:putils:dclick:1: { if ($did(putils,1).sel) { var %x $read -l $dll_pdidselu files\utils.conf | $gettok(%x,3,5) } } 
alias dll_pdidselu return $calc($lines(files\utils.conf) - $calc($did(putils,1).sel - 2))

;*************************************
; Mensaje del día
;
;*************************************

alias tips makedialog -m tips
dialog tips {
  title "Mensaje del día"
  option dbu
  size -1 -1 160 50
  icon icons\clipboard.ico,main
  icon 1, 4 4 20 20,icons\clipboard.ico
  check "", 2, 5 35 50 10
  text "" 3, 28 4 130 30
  button ">>", 4, 80 35 37 12
  button "Cerrar", 5, 120 35 37 12,cancel
}
on 1:dialog:tips:*:*: { if ($devent == init) || ($did == 4) { if ($devent == init) _mdx.buttons_style 4 5 | :init | var %i $rr(files\tips.txt) | if (%i != $did($dname,3)) did -ra $dname 3 %i | else goto init } | if ($devent == init) did $iif($ri(dat\conf.ini,tips,2) == on,-c,-u) $dname 2 | if ($did == 2) wi dat\conf.ini tips 2 $iif($ri(dat\conf.ini,tips,2) == on,off,on) }

;*************************************
; Downloads
;
;*************************************

alias downloads makedialog -md dw
dialog dw {
  option dbu 
  size -1 -1 240 180
  title "Cargando archivos..."
  icon icons\downloads.ico,main
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
  _mdx.buttons_style 2 3 4 5 6 7 10
  ;  dll $mdx SetMircVersion $version 
  ;  dll $mdx MarkDialog $dname 
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
  if ($_p(¿Estás seguro de borrar el archivo seleccionado en la lista?) == $true) {
    .remove " $+ $getdir $+ $right($gettok($did(dw,1,$did(dw,1).sel).text,1,9),-4) $+ "
    did -d dw 1 $did(dw,1).sel
    did -b dw 2,3,4
  }
}
alias dw_deleteall {
  if ($_p(¿Estás seguro de borrar todos los archivos del directorio?) == $true) {
    dw_none $findfile($getdir,*.*,0,0,.remove $1-)
    did -b dw 2,3,4
    did -r dw 1
    dialog -t dw Archivos descargados
  }
}

;*************************************
; Visor de imágenes
;
;*************************************

alias visor makedialog -md vs
dialog vs {
  title "Visor de imágenes para mIRC"
  option dbu  
  size -1 -1 300 180
  icon icons\visor.ico,main
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
alias vsdir { var %x $sdir="Selecciona el directorio" | if (%x) %vs.dir = %x | did -ra vs 3 %vs.dir | did -r vs 7 | did -b vs 8,9 | vslst }
alias vscopy { var %x $sdir="Selecciona el directorio para copiar $did(vs,7,$did(vs,7).sel).text " 
if (%x)  .copy -o " $+ %vs.dir $+ $did(vs,7,$did(vs,7).sel).text $+ " " $+ %x $+ " | $_ok(El archivo ha sido copiado satisfactoriamente) }
alias vsdel { if ($_p(Va a borrar el archivo $did(vs,7,$did(vs,7).sel).text $+ . Realmente está seguro?) == $true) {
.remove " $+ %vs.dir $+ $did(vs,7,$did(vs,7).sel).text $+ " | vslst | $_ok(El archivo ha sido borrado satisfactoriamente) } }

;*************************************
; Generador de DNI
;
;*************************************

alias dni makedialog -m dni
dialog dni {
  option dbu
  title "Dni"
  icon icons\dni.ico
  size -1 -1 65 40
  text "Dni:",1,5 5 10 10
  edit "",2,20 3 40 10,center
  text "Letra:",3,5 15 25 10
  edit "",4,20 13 10 10,read
  button "Copiar",5,35 13 25 10
  button "Cerrar",6,5 25 55 10,cancel
}
on 1:dialog:dni:init:*: { _mdx.buttons_style 5 6 }
on 1:dialog:dni:edit:*:{
  if ($len($did(dni,2)) == 8) dniletra $left($did(dni,2),8)
  elseif ($len($did(dni,2)) > 8) did -ra dni 2 $left($did(dni,2),8)
  else did -r dni 4
}
on 1:dialog:dni:sclick:5:clipboard $did(dni,2) $+ $did(dni,4)
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
;*************************************
; Calculadora by Quetzal 
;
;*************************************

dialog calc {
  size -1 -1 210 165
  title  "Calculadora"
  icon icons\calc.ico
  edit "",2,10 10 140 20, read,autohs
  button "off",1,210 70 40 20, cancel,hide
  button "0",3,10 135 40 20
  button ".",4,60 135 40 20
  button "=",5,110 135 40 20
  button "1",6,10 110 40 20
  button "2",7,60 110 40 20
  button "3",8,110 110 40 20
  button "4",9,10 85 40 20
  button "5",10,60 85 40 20
  button "6",11,110 85 40 20
  button "7",12,10 60 40 20
  button "8",13,60 60 40 20
  button "9",14,110 60 40 20
  button "MRC",15,10 35 40 20
  button "M-",16,60 35 40 20
  button "M+",17,110 35 40 20
  button "+",18,160 135 40 20
  button "/",19,160 110 40 20
  button "-",20,160 85 40 20
  button "x",21,160 60 40 20
  button "%",22,160 35 40 20
  button "CE",24,160 10 40 20
}
alias calc { unset %des.calc.v | dialog -md calc calc }
alias des.calc.eq { if (%des.calc.+= == yes) {
    set %des.calc.+2 %des.calc.v | set %des.calc.v $calc(%des.calc.+1 + %des.calc.+2)
  did -ar calc 2 %des.calc.v | unset %des.calc.+*  }
  if (%des.calc.-= == yes) { set %des.calc.-2 %des.calc.v | set %des.calc.v $calc(%des.calc.-1 - %des.calc.-2)
  did -ar calc 2 %des.calc.v | unset %des.calc.-* }
  if (%des.calc.x= == yes) { set %des.calc.x2 %des.calc.v  |  set %des.calc.v $calc(%des.calc.x1 * %des.calc.x2)
  did -ar calc 2 %des.calc.v | unset %des.calc.x* }
  if (%des.calc./= == yes) { set %des.calc./2 %des.calc.v | set %des.calc.v $calc(%des.calc./1 / %des.calc./2)
  did -ar calc 2 %des.calc.v | unset %des.calc./*  }
  if (%des.calc.%= == yes) { set %des.calc.%2 %des.calc.v | set %des.calc.v $calc(%des.calc.%1 / %des.calc.%2 * 100) | did -ar calc 2 %des.calc.v
unset %des.calc.%* } }
on *:dialog:calc:init:*: { did -ar calc 2 0 | set %des.calc.m+ 0 }

on *:dialog:calc:sclick:*: {
  if ($did == 1) { unset %des.calc* }
  if ($did == 3) { set %des.calc.v %des.calc.v $+ 0 | did -ar calc 2 %des.calc.v } 
  if ($did == 6) { set %des.calc.v %des.calc.v $+ 1 | did -ar calc 2 %des.calc.v } 
  if ($did == 7) { set %des.calc.v %des.calc.v $+ 2 | did -ar calc 2 %des.calc.v } 
  if ($did == 8) { set %des.calc.v %des.calc.v $+ 3 | did -ar calc 2 %des.calc.v } 
  if ($did == 9) { set %des.calc.v %des.calc.v $+ 4 | did -ar calc 2 %des.calc.v } 
  if ($did == 10) { set %des.calc.v %des.calc.v $+ 5 | did -ar calc 2 %des.calc.v } 
  if ($did == 11) { set %des.calc.v %des.calc.v $+ 6 | did -ar calc 2 %des.calc.v } 
  if ($did == 12) { set %des.calc.v %des.calc.v $+ 7 | did -ar calc 2 %des.calc.v } 
  if ($did == 13) { set %des.calc.v %des.calc.v $+ 8 | did -ar calc 2 %des.calc.v } 
  if ($did == 14) { set %des.calc.v %des.calc.v $+ 9 | did -ar calc 2 %des.calc.v } 
  if ($did == 4) { if (%des.calc.. == yes ) halt | else { set %des.calc.. yes | set %des.calc.v %des.calc.v $+ . | did -ar calc 2 %des.calc.v } }
  if ($did == 5) des.calc.eq
  if ($did == 15) { did -ar calc 2 %des.calc.m+ | set %des.calc.v %des.calc.m+ }
  if ($did == 16) { unset %des.calc.m+ | set %des.calc.m+ 0 }
  if ($did == 17) { set %des.calc.m+ %des.calc.v }
  if ($did == 18) { set %des.calc.+1 %des.calc.v | unset %des.calc.v | set %des.calc.+= yes }
  if ($did == 20) { set %des.calc.-1 %des.calc.v | unset %des.calc.v | set %des.calc.-= yes }
  if ($did == 21) { set %des.calc.x1 %des.calc.v | unset %des.calc.v | set %des.calc.x= yes }
  if ($did == 19) { set %des.calc./1 %des.calc.v | unset %des.calc.v | set %des.calc./= yes }
  if ($did == 22) { set %des.calc.%1 %des.calc.v | unset %des.calc.v | set %des.calc.%= yes }
  if ($did == 24) { unset %des.calc.* | did -ar calc 2 0 }
}
