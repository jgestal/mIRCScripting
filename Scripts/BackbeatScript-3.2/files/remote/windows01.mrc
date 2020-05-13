;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; Visor de Logs
;
;*************************************

alias logs {
  window -akSl15 @Visor
  echo $color(info) @Visor *** Visor de logs 2.0 por Jimmy_RAY
  echo $color(info) @Visor *** Para ver las opciones pulsa el botón derecho del ratón
  vlt $findfile($logdir,*.log,0) logs en $logdir
}
alias vlt titlebar @Visor de logs $1-
alias vle echo @Visor $1-
alias vlp return $calc($findfile($logdir,*.log,0) - $findfile($logdir,#*.log,0))
alias vlname return $left($nopath($1),$calc($len($nopath($1)) -4)) 
alias vlcomp return $1- $+ .log
alias vlloadgen {
  clear -l @Visor
  clear @Visor
  set -u %tmp.logtime $ticks
  %i = 1
  wpc
  while ($findfile($logdir,*.log,%i)) {
    if ($vlname($findfile($logdir,*.log,%i)) != $null) aline -l @Visor $vlname($findfile($logdir,*.log,%i))
    vlt Cargando logs...  $chr(91) $+ $int($calc((%i * 100) / $findfile($logdir,*.log,0))) $+ $chr(37) $chr(93) $chr(91) $+ Cargados: $vltcargados($findfile($logdir,*.log,0)) de un total de $findfile($logdir,*.log,0) logs
    wpc.date $int($calc((%i * 100) / $findfile($logdir,*.log,0))) Cargando logs...
    inc %i
  }
  window -c @wpc 
  unset %i
  vlt $chr(91) $+ Logs totales: $findfile($logdir,*.log,0) $+ $chr(93) $chr(91) $+ Tiempo de carga: $duration($calc(($ticks - %tmp.logtime)/1000)) $+ $chr(93) $chr(91) $+ Directorio: $logdir $+ $chr(93) 
}
alias vlloadchan {
  clear -l @Visor
  clear @Visor
  set -u %tmp.logtime $ticks
  %i = 1
  wpc

  while ($findfile($logdir,#*.log,%i)) {
    if ($vlname($findfile($logdir,#*.log,%i)) != $null) aline -l @Visor $vlname($findfile($logdir,#*.log,%i))
    vlt Cargando logs... $chr(91) $+ $int($calc((%i * 100) / $findfile($logdir,#*.log,0))) $+ $chr(37) $+ $chr(93) $vlname($findfile($logdir,#*.log,%i))
    wpc.date $int($calc((%i * 100) / $findfile($logdir,#*.log,0))) Cargando logs...
    inc %i
  }
  window -c @wpc
  unset %i
  vlt $chr(91) $+ Logs cargados: $findfile($logdir,#*.log,0) $+ / $+ $findfile($logdir,*.log,0) $+ $chr(93) $chr(91) $+ Tiempo de carga: $duration($calc(($ticks - %tmp.logtime)/1000)) $+ $chr(93) $chr(91) $+ Directorio: $logdir $+ $chr(93) 
}
alias vlloadpriv {
  clear -l @Visor
  clear @Visor
  set -u %tmp.logtime $ticks
  %i = 1
  %u = 1
  wpc
  while ($findfile($logdir,*.log,%i)) {
    if ($left($nopath($findfile($logdir,*.log,%i)),1) != $chr(35)) {
      if ($vlname($findfile($logdir,*.log,%i)) != $null) aline -l @Visor $vlname($findfile($logdir,*.log,%i))
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
menu @Visor {
  dclick { vlmuestralog $logdir $+ $vlcomp($sline(@Visor,1)) }
  $iif($sline(@Visor,1),&Cargar seleccionado): vlmuestralog $logdir $+ $vlcomp($sline(@Visor,1))
  -
  &Cargar todos:vlloadgen
  &Cargar #canales:vlloadchan 
  &Cargar privados:vlloadpriv

  -
  $iif($sline(@Visor,1),&Editar con el block): if ($sline(@Visor,1)) run notepad.exe $logdir \ $+ $vlcomp($sline(@Visor,1))
  -
  &Limpiar ventana:{ clear @Visor | vlt Lector de Logs }

  -
  $iif($sline(@Visor,1),&Borrar selección): {
    clear @Visor
    vlt Lector de Logs 
    if ($_p(¿Está seguro de que desea borrar los logs seleccionados?) == $true) {
      %i = 1
      while ($sline(@Visor,1)) {
        .remove " $+ $logdir \ $+ $vlcomp($sline(@Visor,1)) $+ "
        dline -l @Visor $sline(@Visor,1).ln
} } } } 
alias vlmuestralog {
  vlt Lector de Logs 
  clear @Visor
  loadbuf @Visor " $+ $$1- $+ "
  vlt $chr(91) $+ Log Actual: $vlcomp($sline(@Visor,1)) $+ $chr(93) $chr(91) $+ Lineas: $slines($1-) $+ $chr(93) $chr(91) $+ Tamaño $lof($1-) bytes $+ $chr(93) 
}

;*************************************
; Indicador de progreso
;
;*************************************

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

;*************************************
; Snake
;
;*************************************

alias snk.version return 1.0
alias snk.cas return 7
alias snake {
  window -pktoa +betl @Snake 50 50 200 200
  window -r @snake
  titlebar @snake ( $+ $snk.version $+ ) por Jimmy_RAY
  snk.intro
}
alias snk.newgame {
  .timersnk* off
  clear @snake 
  ;Colorea el fondo de verde
  drawrect -f @snake 10 10 0 0 400 400 200 200 200
  ;Tablero
  drawrect -f @snake 1 1 10 20 $calc($calc($snk.cas * 22)+14) $snk.cas
  drawrect -f @snake 1 1 15 30 $calc(($snk.cas * 22)+5) $snk.cas
  drawrect -f @snake 1 1 15 $calc(($snk.cas *11)+37) $calc(($snk.cas * 22)+5) $snk.cas
  drawrect -f @snake 1 1 10 30 $snk.cas $calc(($snk.cas * 12)+7)
  drawrect -f @snake 1 1 $calc(($snk.cas *22)+17) 30 $snk.cas $calc(($snk.cas * 12)+7)
  ;Marcador
  %snk_points = 0
  snk.scores 0
  %snk_serp = 5 5;6 5;7 5;8 5;9 5;10 5
  ;snk.pfr
  ;Fijo la dirección inicial de movimiento de la serpiente
  %snk_dir = r
  if (%snk.lev == $null) %snk.lev = 125
  .timersnk -m 0 %snk.lev snk.process 
  snk.apple 
  %snk_game = on
}
;Marcadores
alias snk.scores { 
  drawtext -bc @snake 10 10 "ms sherif" 14 5 5 290 25 $str($chr(160),100)
  drawtext -bc @snake 1 10 "ms sherif" 14 10 5 290 25 $str(0,$calc(4- $len($$1))) $+ $$1
}
alias snk.c { drawrect -f @snake $$1 1 $calc(10+($snk.cas * $$2)) $calc(30+($snk.cas * $$3)) $snk.cas $snk.cas }
alias snk.drawsnake { var %i 1 | while ($gettok(%snk_serp,%i,59)) { snk.c 0 $gettok(%snk_serp,%i,59) | inc %i } }
alias snk.lastpos return $gettok(%snk_serp,$calc($pos(%snk_serp,;,0) +1),59)
alias snk.process {
  if ($snk.freec == $false) {
    .timersnk off
    snk.gameover
    return
  }
  else { 
    %snk_cmov = 1
    if (%snk_eat == $null) {
      snk.c 10 $gettok(%snk_serp,1,59)    
      %snk_serp = $gettok(%snk_serp,2-,59)
    }
    if (%snk_eat) { 
      %snk_points = %snk_points + $snk.levpoints 
      snk.scores %snk_points
      %snk_serp = $gettok(%snk_serp,1-,59)
      unset %snk_eat
    }
    snk.mv
    snk.drawsnake
    if (%snk_apple == $snk.lastpos) {
      %snk_eat = on
      snk.apple
    }
  }
}
alias snk.mv {
  goto %snk_dir
  :r | %snk_serp = %snk_serp $+ $chr(59) $+ $calc($gettok($snk.lastpos,1,32) +1) $gettok($snk.lastpos,2,32) | return
  :l | %snk_serp = %snk_serp $+ $chr(59) $+ $calc($gettok($snk.lastpos,1,32) -1) $gettok($snk.lastpos,2,32) | return
  :u | %snk_serp = %snk_serp $+ $chr(59) $+ $gettok($snk.lastpos,1,32) $calc($gettok($snk.lastpos,2,32) -1) | return
  :d | %snk_serp = %snk_serp $+ $chr(59) $+ $gettok($snk.lastpos,1,32) $calc($gettok($snk.lastpos,2,32) +1) | return
}
on 1:KEYDOWN:@snake:*:{ 
  if ($keyval == 80) {
    if (%snk_game == on) {
      if (%snk_pause == on) {
        .timersnk -m 0 %snk.lev snk.process 
        unset %snk_pause
        drawtext -bc @snake 1 10 "ms sherif" 9 10 150 200 10 Game Paused! Press [P] to continue
      }    
      else {
        .timersnk off 
        %snk_pause = on
        drawtext -bc @snake 1 10 "ms sherif" 9 10 150 200 10 Game Paused! Press [P] to continue
      }
    }
  }
  if ($keyval == 78) snk.newgame
  if ($keyval == 69) window -c @snake
  if (%snk_cmov) {
    if ($keyval == 37) && (%snk_dir != r) { %snk_dir = l | %snk_cmov = 0 }
    elseif ($keyval == 39) && (%snk_dir != l) { %snk_dir = r | %snk_cmov = 0 }
    elseif ($keyval == 38) && (%snk_dir != d) { %snk_dir = u | %snk_cmov = 0 }
    elseif ($keyval == 40) && (%snk_dir != u) { %snk_dir = d | %snk_cmov = 0 }
  }
}
alias snk.freec {
  if (%snk_dir == r) {
    var %x $calc($gettok($snk.lastpos,1,32) +1) $gettok($snk.lastpos,2,32)
    if ($calc($gettok($snk.lastpos,1,32) +1) > 22) return $false
  }
  if (%snk_dir == l) {
    var %x $calc($gettok($snk.lastpos,1,32) -1) $gettok($snk.lastpos,2,32)
    if ($calc($gettok($snk.lastpos,1,32) -1) < 1) return $false
  }
  if (%snk_dir == u) {
    var %x $gettok($snk.lastpos,1,32) $calc($gettok($snk.lastpos,2,32) -1)
    if ($calc($gettok($snk.lastpos,2,32) -1) < 1) return $false
  }
  if (%snk_dir == d) {
    if ($calc($gettok($snk.lastpos,2,32) +1) > 11) return $false
    var %x $gettok($snk.lastpos,1,32) $calc($gettok($snk.lastpos,2,32) +1)
  }
  if ($istok(%snk_serp,%x,59) == $true) return $false
  return $true
}
alias snk.apple {
  :init
  var %x = $rand(1,22) $rand(1,11)
  if ($istok(%snk_serp,%x,59)) goto init
  snk.c 4 %x
  %snk_apple = %x
}
alias snk.gameover {
  clear @snake
  drawrect -f @snake 1 10 0 0 400 400 200 200 200
  drawtext -bc @snake 0 1 "ms sherif" 50 5 5 290 50 Snake
  drawtext -bc @snake 13 1 "ms sherif" 20 50 70 290 50 GAME OVER
  drawtext -bc @snake 11 1 "ms sherif" 15 60 120 290 50 %snk_points puntos $iif(%snk_points > %snk.maxs,record!!!)
  if (%snk_points > %snk.maxs) %snk.maxs = %snk_points

  .timersnkmenu 1 3 snk.intro
  unset %snk_game
}
alias snk.intro {
  clear @snake
  if (%snk.maxs == $null) %snk.maxs = 0
  if ($window(@snake)) {
    drawrect -f @snake 1 10 0 0 400 400 200 200 200
    drawtext -bc @snake 0 1 "ms sherif" 50 5 5 290 50 Snake
    drawtext -bc @snake 11 1 "ms sherif" 17 15 70 290 50 Jimmy_RAY AddOns
    drawtext -bc @snake 11 1 "ms sherif" 14 20 100 290 50 Opciones: boton derecho
    drawtext -bc @snake 9 1 "ms sherif" 14 30 130 290 50 BravoS AssAulT TeaM (c)
    drawtext -bc @snake 0 1 "ms sherif" 14 30 150 290 50 Record: %snk.maxs puntos
  }
  unset %snk_game
}
alias snk.controls {
  window -pkrtoa +betl @Snake.Controls 60 60 200 130
  window -r @Snake.Controls
  titlebar @snake.controls
  clear @snake.controls
  drawrect -f @snake.controls 1 10 0 0 400 400 200 200 200
  drawtext -bc @snake.controls 11 1 "ms sherif" 12 15 10 200 50 [N] -> Nuevo juego
  drawtext -bc @snake.controls 11 1 "ms sherif" 12 15 30 200 50 [P] -> Pausa
  drawtext -bc @snake.controls 11 1 "ms sherif" 12 15 50 200 50 [E] -> Salir
  drawtext -bc @snake.controls 11 1 "ms sherif" 12 15 70 200 50 Flechas -> Movimiento
}
menu @snake {
  &nueva partida: {
    snk.newgame
  }
  &nivel [[ $+ $snk.level $+ ]]
  .[1] &lamer:set %snk.lev 110
  .[2] &muy fácil:set %snk.lev 100
  .[3] &fácil:set %snk.lev 90
  .[4] &normal:set %snk.lev 80
  .[5] &difícil:set %snk.lev 70
  .[6] &experto:set %snk.lev 60
  .[7] &master:set %snk.lev 50
  &controles:snk.controls
  -
  &salir:snk.unload
}
menu @snake.controls {
  sclick { window -c $active }
  rclick { window -c $active }
}
alias snk.level {
  if (%snk.lev == $null) { %snk.lev = 90 }
  if (%snk.lev == 110) return 1
  if (%snk.lev == 100) return 2
  if (%snk.lev == 90) return 3
  if (%snk.lev == 80) return 4
  if (%snk.lev == 70) return 5
  if (%snk.lev == 60) return 6
  if (%snk.lev == 50) return 7
}
alias snk.levpoints {
  if (%snk.lev == $null) { %snk.lev = 90 }
  if (%snk.lev == 110) return 3
  if (%snk.lev == 100) return 4
  if (%snk.lev == 90) return 5
  if (%snk.lev == 80) return 6
  if (%snk.lev == 70) return 7
  if (%snk.lev == 60) return 8
  if (%snk.lev == 50) return 9
}
on 1:close:@snake: { unset %snk_* | .timersnk* off }
