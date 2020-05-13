;~~~~~~~~~~~~~~~~~~~~~~
; Lector de logs 1.0
; Autor: Jimmy_RAY
; e-mail: jimmy@welt.es
; Visita http://backbeat.welt.es
;~~~~~~~~~~~~~~~~~~~~~~
;Identificadores
;---------------
alias vlname return $left($nopath($1),$calc($len($nopath($1)) -4)) 
alias vlcomp return $1 $+ .log
;Comandos
;---------------
alias logs {
  window -akSl15 @vl
  vlt $findfile($logdir,*.log,0) logs en $logdir
  vlloadgen
}
alias vlt titlebar @vl $1-
alias vle echo @vl $1-
alias vlp return $calc($findfile($logdir,*.log,0) - $findfile($logdir,#*.log,0))
alias vlloadgen {
  clear -l @vl
  clear @vl
  set -u %tmp.logtime $ticks
  %i = 1
  while ($findfile($logdir,*.log,%i)) {
    if ($vlname($findfile($logdir,*.log,%i)) != $null) aline -l @vl $vlname($findfile($logdir,*.log,%i))
    vlt Cargando logs... $chr(91) $+ $int($calc((%i * 100) / $findfile($logdir,*.log,0))) $+ $chr(37) $+ $chr(93) $vlname($findfile($logdir,*.log,%i))
    inc %i
  }
  unset %i
  vlt $chr(91) $+ Logs totales: $findfile($logdir,*.log,0) $+ $chr(93) $chr(91) $+ Tiempo de carga: $duration($calc(($ticks - %tmp.logtime)/1000)) $+ $chr(93) $chr(91) $+ Directorio: $logdir $+ $chr(93) 
}
alias vlloadchan {
  clear -l @vl
  clear @vl
  set -u %tmp.logtime $ticks
  %i = 1
  while ($findfile($logdir,#*.log,%i)) {
    if ($vlname($findfile($logdir,#*.log,%i)) != $null) aline -l @vl $vlname($findfile($logdir,#*.log,%i))
    vlt Cargando logs... $chr(91) $+ $int($calc((%i * 100) / $findfile($logdir,#*.log,0))) $+ $chr(37) $+ $chr(93) $vlname($findfile($logdir,#*.log,%i))
    inc %i
  }
  unset %i
  vlt $chr(91) $+ Logs cargados: $findfile($logdir,#*.log,0) $+ / $+ $findfile($logdir,*.log,0) $+ $chr(93) $chr(91) $+ Tiempo de carga: $duration($calc(($ticks - %tmp.logtime)/1000)) $+ $chr(93) $chr(91) $+ Directorio: $logdir $+ $chr(93) 
}
alias vlloadpriv {
  clear -l @vl
  clear @vl
  set -u %tmp.logtime $ticks
  %i = 1
  %u = 1
  while ($findfile($logdir,*.log,%i)) {
    if ($left($nopath($findfile($logdir,*.log,%i)),1) != $chr(35)) {
      if ($vlname($findfile($logdir,*.log,%i)) != $null) aline -l @vl $vlname($findfile($logdir,*.log,%i))
      inc %u      
      vlt Cargando logs... $chr(91) $+ $int($calc((%u * 100) / $vlp)) $+ $chr(37) $+ $chr(93) $vlname($findfile($logdir,*.log,%i))
    }
    inc %i
  }
  unset %u %i
  vlt $chr(91) $+ Logs cargados: $vlp $+ / $+ $findfile($logdir,*.log,0) $+ $chr(93) $chr(91) $+ Tiempo de carga: $duration($calc(($ticks - %tmp.logtime)/1000)) $+ $chr(93) $chr(91) $+ Directorio: $logdir $+ $chr(93) 
}

;Menús
;---------------
menu @vl {
  dclick { vlmuestralog $logdir \ $+ $vlcomp($sline(@vl,1)) }
  &Cargar seleccionado:if ($sline(@vl,1)) vlmuestralog $logdir \ $+ $vlcomp($sline(@vl,1))
  -
  &Cargar todos:vlloadgen
  &Cargar #canales:vlloadchan 
  &Cargar privados:vlloadpriv

  -
  &Editar con el block: if ($sline(@vl,1)) run notepad.exe $logdir \ $+ $vlcomp($sline(@vl,1))
  -
  &Limpiar ventana:{ clear @vl | vlt Lector de Logs }

  -
  &Borrar selección: { if ($sline(@vl,1)) {
      clear @vl
      vlt Lector de Logs 
      if ($?!="¿Está seguro de que desea borrar los logs seleccionados?" == $true) {
        %i = 1
        while ($sline(@vl,1)) {
          .remove " $+ $logdir \ $+ $vlcomp($sline(@vl,1)) $+ "
          dline -l @vl $sline(@vl,1).ln
} } } } }
alias vlmuestralog {
  vlt Lector de Logs 
  clear @vl
  loadbuf @vl " $+ $1- $+ "
  vlt $chr(91) $+ Log Actual: $vlcomp($sline(@vl,1)) $+ $chr(93) $chr(91) $+ Lineas: $lines($1-) $+ $chr(93) $chr(91) $+ Tamaño $lof($1-) bytes $+ $chr(93) 
}
