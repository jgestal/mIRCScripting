;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; Barra del script
;
;*************************************

on 1:start: {
  barra
}
alias barra {
  if ($ri(dat\conf.ini,toolbar,state) == on) {
    window -c @barra
    window -kprh +d @barra 0 0 945 42
    window -a @barra
    drawpic -c @barra 0 0 files\im\barra.png
  }
  else {
    window -c @barra
    window -kprh +d @barra 0 0 15 42
    window -a @barra
    drawpic -c @barra 0 0 files\im\barra2.png
  }
}
menu @barra {
  sclick {
    if ($mouse.y > 6) && ($mouse.y < 38) {
      if ($mouse.x > 25) && ($mouse.x < 48) barra_conectar
      elseif ($mouse.x > 68) && ($mouse.x < 101) barra_panel
      elseif ($mouse.x > 104) && ($mouse.x < 136) barra_utils 
      elseif ($mouse.x > 147) && ($mouse.x < 181) barra_programas 
      elseif ($mouse.x > 191) && ($mouse.x < 216) barra_users
      elseif ($mouse.x > 216) && ($mouse.x < 261) barra_theme
      elseif ($mouse.x > 292) && ($mouse.x < 326) run $_web
      elseif ($mouse.x > 334) && ($mouse.x < 358) noticias
      elseif ($mouse.x > 367) && ($mouse.x < 400) email
      elseif ($mouse.x > 408) && ($mouse.x < 440) logs
      elseif ($mouse.x > 449) && ($mouse.x < 477) batsms
      elseif ($mouse.x > 500) && ($mouse.x < 530) mlag
      elseif ($mouse.x > 602) && ($mouse.x < 628) awayconf
      elseif ($mouse.x > 642) && ($mouse.x < 751) about
    }
    if ($mouse.x < 15) {
      wi dat\conf.ini toolbar state $iif($ri(dat\conf.ini,toolbar,state) == on,off,on)
      barra
    }
  }

}
menu @barraz {
  sclick {
    if ($mouse.y > 7) && ($mouse.y < 37) {
      if ($mouse.x > 14) && ($mouse.x < 43) barra_conectar
      elseif ($mouse.x > 62) && ($mouse.x < 95) barra_panel
      elseif ($mouse.x > 111) && ($mouse.x < 144) noticias
      elseif ($mouse.x > 161) && ($mouse.x < 191) barra_utils
      elseif ($mouse.x > 212) && ($mouse.x < 245) barra_theme
      elseif ($mouse.x > 265) && ($mouse.x < 292) return bots
      elseif ($mouse.x > 315) && ($mouse.x < 340) return users
      elseif ($mouse.x > 361) && ($mouse.x < 396) barra_programas 
      elseif ($mouse.x > 420) && ($mouse.x < 451) awayconf
    }
  }
}
alias barra_conectar {
  init-barra_conectar-menu
  _popupdll.do-popup barra_conectar +cC $mouse.dx $mouse.dy 
}
alias init-barra_conectar-menu {
  _popupdll.New barra_conectar 16 16 

  _popupdll.icon barra_conectar connect.ico
  _popupdll.AddItem barra_conectar end +> 1 &Conectar al IRC $cr barra_conectar.connect

  ;.Conectar al IRC
  _popupdll.New barra_conectar.connect 16 16
  _popupdll.icon barra_conectar.connect servers.ico
  _popupdll.icon barra_conectar.connect servidor.ico
  _popupdll.icon barra_conectar.connect rueda.ico
  _popupdll.icon barra_conectar.connect error.ico
  _popupdll.icon barra_conectar.connect d6.ico
  _popupdll.icon barra_conectar.connect quit.ico

  _popupdll.AddItem barra_conectar.connect end 1 &Lista de servidores $cr srvlst
  _popupdll.AddItem barra_conectar.connect end +> 1 &Aleatorios $cr barra_conectar.connect.randomservers
  ;random servers
  _popupdll.New barra_conectar.connect.randomservers 16 16
  _popupdll.icon barra_conectar.connect.randomservers servidor.ico
  _popupdll.icon barra_conectar.connect.randomservers ex.ico
  _popupdll.icon barra_conectar.connect.randomservers error.ico
  var %i 1
  while ($rl(dat\random.conf,%i)) {
    _popupdll.AddItem barra_conectar.connect.randomservers end  1 $rl(dat\random.conf,%i) $cr server $rl(dat\random.conf,%i)
    inc %i
  }
  if (%i > 1)  _popupdll.AddItem barra_conectar.connect.randomservers end 
  _popupdll.AddItem barra_conectar.connect.randomservers end 2 &Añadir servidor aleatorio $cr barra_addserverrand
  _popupdll.AddItem barra_conectar.connect.randomservers end +> 3 &Borrar servidor aleatorio $cr barra_conectar.connect.randomservers.del
  _popupdll.New barra_conectar.connect.randomservers.del 16 16
  _popupdll.icon barra_conectar.connect.randomservers.del servidor.ico
  var %i 1
  while ($rl(dat\random.conf,%i)) {
    _popupdll.AddItem barra_conectar.connect.randomservers.del end  1 $rl(dat\random.conf,%i) $cr write -dl $+ %i dat\random.conf 
    inc %i
  }
  ;
  _popupdll.AddItem barra_conectar.connect end 2 &Servidor específico $cr sr
  if ($rl(dat\uservers.dat,1)) { 
    _popupdll.AddItem barra_conectar.connect end 
    var %i 1
    while ($rl(dat\uservers.dat,%i)) {
      _popupdll.AddItem barra_conectar.connect end 3 $rl(dat\uservers.dat,%i) $cr server $rl(dat\uservers.dat,%i)
      inc %i
    }
    _popupdll.AddItem barra_conectar.connect end 
    _popupdll.AddItem barra_conectar.connect end 4 &Borrar últimos servidores $cr write -c dat\uservers.dat
  }
  if ($server) {
    _popupdll.AddItem barra_conectar.connect end
    _popupdll.AddItem barra_conectar.connect end 5 &Reconectar $cr server $server $port
    _popupdll.AddItem barra_conectar.connect end 6 &Desconectar $cr quit
  }
}
alias barra_addserverrand write dat\random.conf $_r(Introduce el servidor y el puerto)
;;;;
alias barra_utils {
  init-barra_utils-menu
  _popupdll.do-popup barra_utils +cC $mouse.dx $mouse.dy 
}
alias init-barra_utils-menu {
  _popupdll.New barra_utils 16 16 

  _popupdll.icon barra_utils utilidades.ico
  _popupdll.AddItem barra_utils end +> 1 &Utilidades $cr barra_utils.utils
  _popupdll.New barra_utils.utils 16 16
  var %i 1
  while ($rl(files\utils.conf,%i)) {
    _popupdll.icon barra_utils.utils $gettok($rl(files\utils.conf,%i),1,5)
    _popupdll.AddItem barra_utils.utils end %i & $+ $gettok($rl(files\utils.conf,%i),2,5) $cr $gettok($rl(files\utils.conf,%i),3,5)
    inc %i
  }
}

alias barra_panel {
  init-barra_panel-menu
  _popupdll.do-popup barra_panel +cC $mouse.dx $mouse.dy 
}
alias init-barra_panel-menu {
  _popupdll.New barra_panel 16 16 

  _popupdll.icon barra_panel panel.ico
  _popupdll.AddItem barra_panel end +> 1 &Panel $cr barra_panel.panel
  _popupdll.New barra_panel.panel 16 16
  var %i 1
  while ($rl(files\panel.conf,%i)) {
    _popupdll.icon barra_panel.panel $gettok($rl(files\panel.conf,%i),1,5)
    _popupdll.AddItem barra_panel.panel end %i & $+ $gettok($rl(files\panel.conf,%i),2,5) $cr $gettok($rl(files\panel.conf,%i),3,5)
    inc %i
  }
}

alias barra_theme {
  init-barra_theme-menu
  _popupdll.do-popup barra_theme +cC $mouse.dx $mouse.dy 
}
alias init-barra_theme-menu {
  _popupdll.New barra_theme 16 16 

  _popupdll.icon barra_theme themes.ico
  _popupdll.AddItem barra_theme end +> 1 &Cargar theme $cr barra_theme.theme
  _popupdll.New barra_theme.theme 16 16
  var %i 1
  while ($findfile(themes,*.theme,%i)) {

    _popupdll.icon barra_theme.theme paleta.ico
    _popupdll.AddItem barra_theme.theme end %i & $+ $left($nopath($findfile(themes,*.theme,%i)),-6) $cr loadtheme $findfile(themes,*.theme,%i)
    inc %i
  }
}
alias barra_programas {
  init-barra_programas-menu
  _popupdll.do-popup barra_programas +cC $mouse.dx $mouse.dy 
}
alias init-barra_programas-menu {
  _popupdll.New barra_programas 16 16 
  _popupdll.icon barra_programas programs.ico
  _popupdll.AddItem barra_programas end +> 1 &Programas $cr barra_programas.programs
  _popupdll.New barra_programas.programs 16 16
  _popupdll.icon barra_programas.programs program.ico
  var %i 1
  makefile dat\programs.dat
  while ($rl(dat\programs.dat,%i)) {
    _popupdll.AddItem barra_programas.programs end 1 & $+ $gettok($rl(dat\programs.dat,%i),1,5) $cr run $gettok($rl(dat\programs.dat,%i),2,5)
    inc %i
  }
  if (%i > 1)  _popupdll.AddItem barra_programas.programs end 
  _popupdll.icon barra_programas.programs ex.ico
  _popupdll.AddItem barra_programas.programs end 2 &Añadir programa $cr barra_addprogram
  _popupdll.icon barra_programas.programs error.ico
  _popupdll.AddItem barra_programas.programs end +> 3 &Borrar programa $cr barra_programas.del
  _popupdll.New barra_programas.del 16 16 
  _popupdll.icon barra_programas.del program.ico
  _popupdll.icon barra_programas.del 
  var %i 1
  while ($rl(dat\programs.dat,%i)) {
    _popupdll.AddItem barra_programas.del end 1 & $+ $gettok($rl(dat\programs.dat,%i),1,5) $cr write -dl $+ %i dat\programs.dat
    inc %i
  }
}
alias barra_addprogram {
  var %x = $_r(Introduce el nombre del programa)
  var %y = $$sfile($mircdir,Selecciona el archivo a ejecutar,Aceptar)
  write dat\programs.dat %x $+ $chr(5) $+ %y
}
alias barra_showlag { if ($window(@barra)) drawtext -bc @barra 1 0 "ms sherif" 12 540 15 50 20 $iif($1,$dur($1),???) $str($chr(160),30) }

alias barra_users {
  init-barra_users-menu
  _popupdll.do-popup barra_users +cC $mouse.dx $mouse.dy 
}
alias init-barra_users-menu {
  _popupdll.New barra_users 16 16 
  _popupdll.icon barra_users users.ico
  _popupdll.AddItem barra_users end +> 1 &Users $cr barra_users.ulist
  _popupdll.New barra_users.ulist 16 16
  _popupdll.icon barra_users.ulist users.ico
  _popupdll.icon barra_users.ulist error.ico
  _popupdll.AddItem barra_users.ulist end 1 &Lista de usuarios $cr ulist
  if ($lines(dat\users.dat)) {
    _popupdll.AddItem barra_users.ulist end 
    _popupdll.AddItem barra_users.ulist end +> 2 &Borrar usuario $cr barra_users.ulist.del
    _popupdll.New barra_users.ulist.del 16 16
    _popupdll.icon barra_users.ulist.del user.ico
    var %i 1
    var %x $lines(dat\users.dat)
    while (%i <= %x) {
      var %y 
      %y = $rl(dat\users.dat,%i)
      _popupdll.AddItem barra_users.ulist.del end 1 & $+ $gettok(%y,1,5) ( $+ $gettok(%y,2,5) $+ ) $cr barra-delete-user %i
      inc %i
    }
  }
}
alias barra-delete-user {
  write $+(-dl,$1) dat\users.dat
  loadusers
}
