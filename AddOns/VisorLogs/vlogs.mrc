;~~~~~~~~~~~~~~~~~~~~~~
; Lector de logs 2.0
; Autor: Jimmy_RAY
; e-mail: jimmy@welt.es
; Visita http://backbeat.welt.es
;~~~~~~~~~~~~~~~~~~~~~~
On 1:load:/Echo 2 -s *** Visor de logs 1.0 por Jimmy_RAY ha sido cargado.
alias logs {
  window -akSl15 @vl
  vlt $findfile($logdir,*.log,0) logs en $logdir
}
alias vlt titlebar @vl $1-
alias vle echo @vl $1-
alias vlp return $calc($findfile($logdir,*.log,0) - $findfile($logdir,#*.log,0))
alias vlname return $left($nopath($1),$calc($len($nopath($1)) -4)) 
alias vlcomp return $1 $+ .log
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
  dclick { vlmuestralog $logdir \ $+ $vlcomp($sline(@vl,1)) }
  $iif($sline(@vl,1),&Cargar seleccionado): vlmuestralog $logdir \ $+ $vlcomp($sline(@vl,1))
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

menu nicklist,status,menubar,channel { 
  -
  &Visor de logs
  .&Ver logs:logs
  .-
  .&Créditos: { 
    echo 2 -a ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    echo 2 -a *** Visor de logs 2.0
    echo 2 -a *** AddOn escrito por Jimmy_RAY
    echo 2 -a *** http://backbeat.welt.es
    echo 2 -a *** email: jimmy@welt.es
    echo 2 -a ~~~~~~~~~~~~~~~~~~~~~~~~~~~
} }
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
