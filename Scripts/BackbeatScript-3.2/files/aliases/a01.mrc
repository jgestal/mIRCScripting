;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; Alias de control general del script
;
;*************************************

makedialog { if ($dialog($2)) dialog -v $2 | else dialog - $+ $1 $2 $iif($3,$3,$2) }
comchannels {
  var %i 1
  var %x ""
  while ($comchan($$1,%i)) { %x = %x $comchan($$1,%i) | inc %i }
  return %x
}

dur { 
  if ($1 < 1) return $$1 $+ s
  else return $replace($remove($duration($$1),s,$chr(32)),ec,s,min,m,hr,h,day,d,wk,w)
}

;*************************************
; Manejo de datos en archivos
;
;*************************************

makefile { if ($isfile($1) == $false) write -c $1 }
ri return $readini $$1 $$2 $$3
wi { if ($4)  writeini $$1 $$2 $3 $4- | else remini $$1- }
rl return $read -l $$2 $$1
rr return $read $$1
cm return " $+ $$1- $+ "
remln { write -dl $+ $$2 $$1 } 
isln { var %i 1 | while ($rl($$1,%i)) { if ($rl($$1,%i) == $$2-) return $true | inc %i } | return $false }
delln { var %i 1 | while ($rl($$1,%i)) { if ($rl($$1,%i) == $$2-) write -dl [ $+ [ %i ] ] $$1 | inc %i } }
lastfile { makefile $1 | return $read -l $2 $1 }
wifnot { 
  makefile $$1 
  if ($isln($$1,$3-) == $true) return 
  write -il1 $$1 $$3- 
  if ($lines($$1) > $2) write -dl $+ $lines($$1) $$1 
}

;*************************************
; Datos acerca del script
; No los modifiques
;
;*************************************

_version return BaCKBEAT v3.2
_ver return $gettok($_version,2,32)
_web return http://www.gestal.es
_web.noticias return http://www.gestal.es
_email return juan@gestal.es
_lg return BaCKBEAT
_rversion return $_version - $rr(files\version.dat) - ( $+ $_web $+ ) by Jimmy_RAY
sv say $_rversion

;*************************************
; Comandos masivos
;
;*************************************

massop { var %i 1 | var %x "" | while ($nick($chan,%i)) { if ($nick($chan,%i) !isop $chan) %x = %x $nick($chan,%i) | if ($gettok(%x,6,32)) { mode $chan oooooo %x | unset %x } | inc %i } | if (%x) mode $chan ooooo %x } 
massdeop { var %i 1 | var %x "" | while ($nick($chan,%i)) { if ($nick($chan,%i) isop $chan) && ($nick($chan,%i) != $me) %x = %x $nick($chan,%i) | if ($gettok(%x,6,32)) { mode $chan -oooooo %x | unset %x } | inc %i } | if (%x) mode $chan -ooooo %x }
massvoice { var %i 1 | var %x "" | while ($nick($chan,%i)) { if ($nick($chan,%i) !isvo $chan) %x = %x $nick($chan,%i) | if ($gettok(%x,6,32)) { mode $chan vvvvvvv %x | unset %x } | inc %i } | if (%x) mode $chan vvvvv %x | unset %i %x } 
massdevoice { var %i 1 | var %x "" | while ($nick($chan,%i)) { if ($nick($chan,%i) isvo $chan) %x = %x $nick($chan,%i) | if ($gettok(%x,6,32)) { mode $chan -vvvvvv %x | unset %x } | inc %i } | if (%x) mode $chan -vvvvv %x }
masskick { var %x $__r(Introduce la razón de kick (en blanco aleatoria)) | var %i 1 | var %y $nick($chan,0) | while (%i <= %y) { if ($nick($chan,%i) != $me) kick $chan $nick($chan,%i) %x  | inc %i } }
masskickban { var %x $__r(Introduce la razón de kick (en blanco aleatoria)) | var %i 1 | var %y $nick($chan,0) | while (%i <= %y) { if ($nick($chan,%i) != $me) { mode $chan -o+b $nick($chan,%i) $nick($chan,%i) | kick $chan $nick($chan,%i) %x }  | inc %i } }
masskickbanip { var %x $__r(Introduce la razón de kick (en blanco aleatoria)) | var %i 1 | var %y $nick($chan,0) | while (%i <= %y) { if ($nick($chan,%i) != $me) { mode $chan -o+b $nick($chan,%i) $iif($address($nick($chan,%i),2),$address($nick($chan,%i),2),$nick($chan,%i)) | kick $chan $nick($chan,%i) %x }  | inc %i } }


;*************************************
; Control desde el nicklist
;
;*************************************

clickop { var %i 1 | var %x "" | while ($snick($chan,%i)) { if ($snick($chan,%i) !isop $chan) %x = %x $snick($chan,%i) | if ($gettok(%x,6,32)) { mode $chan oooooo %x | unset %x } | inc %i } | if (%x) mode $chan ooooo %x } 
clickdeop { var %i 1 | var %x "" | while ($snick($chan,%i)) { if ($snick($chan,%i) isop $chan) %x = %x $snick($chan,%i) | if ($gettok(%x,6,32)) { mode $chan -oooooo %x | unset %x } | inc %i } | if (%x) mode $chan -ooooo %x }
clickvoice { var %i 1 | var %x "" | while ($snick($chan,%i)) { if ($snick($chan,%i) !isvo $chan) %x = %x $snick($chan,%i) | if ($gettok(%x,6,32)) { mode $chan vvvvvvv %x | unset %x } | inc %i } | if (%x) mode $chan vvvvv %x | unset %i %x } 
clickdevoice { var %i 1 | var %x "" | while ($snick($chan,%i)) { if ($snick($chan,%i) isvo $chan) %x = %x $snick($chan,%i) | if ($gettok(%x,6,32)) { mode $chan -vvvvvv %x | unset %x } | inc %i } | if (%x) mode $chan -vvvvv %x }
clickkick { var %x $__r(Introduce la razón de kick (en blanco aleatoria)) | var %i 1 | var %y $snick($chan,0) | while (%i <= %y) { kick $chan $snick($chan,%i) %x | inc %i } }
clickkickban { var %x $__r(Introduce la razón de kick (en blanco aleatoria)) | var %i 1 | var %y $snick($chan,0) | while (%i <= %y) { mode $chan -o+b $snick($chan,%i) $snick($chan,%i) | kick $chan $snick($chan,%i) %x  | inc %i } }
clickkickbanip { var %x $__r(Introduce la razón de kick (en blanco aleatoria)) | var %i 1 | var %y $snick($chan,0) | while (%i <= %y) { mode $chan -o+b $snick($chan,%i) $iif($address($snick($chan,%i),2),$address($snick($chan,%i),2),$snick($chan,%i)) | kick $chan $snick($chan,%i) %x | inc %i } }

;*************************************
; Comandos básicos
;
;*************************************

j join #$$1 $2 
q query $$1 $2-
bxreason { var %i $read dat\kicks.txt | %i = $replace(%i,$0,$1) | return %i }
kick { if ($$2) { var %x $3- | if (%x == $null) %x = $bxreason($2) | kick $$1 $$2 $_lg %x $kickcont } }
kickcont { inc %kicks | return ~ %kicks }
http { if ($left($1,7) != http://) run http:// $+ $1 | else run $1 }
sr server $_r(Introduce el server (puerto opcional))
w whois $$1 $1
o onotice $chan $1-
clearall clearall | barra 

;*************************************
; $clones(echo,por,Tonic)
; (gyntonic@terra.es)
;
;*************************************

clones {
  if ($address($1,2) == $null) return
  if ($isid != $true) goto end
  var %jc.mask = $address($1,2)
  var %jc.tot = $ial(%jc.mask,0)
  var %jc.c = 0
  if (%jc.tot < 1) { goto end }
  :cont
  inc %jc.c
  if ($ial(%jc.mask,%jc.c).nick == $1) { $iif(%jc.c != %jc.tot,goto cont,goto devuelve) }
  var %jc.fin = %jc.fin $ial(%jc.mask,%jc.c).nick
  if (%jc.c == %jc.tot) { goto devuelve }
  goto cont
  :devuelve
  return %jc.tot %jc.mask %jc.fin 
  :end
}

;*************************************
; Resto del scan de clones
;
;*************************************

joinclon if ($ri(dat\conf.ini,gen,9) == on) return $1- 

;*************************************
; Nick anterior (el código no es muy 
; bueno porque lo copié del backbeat
; 2.1 :P)
;
;*************************************

nickant {
  var %nickant.tmp
  if ($lines(dat\nickanterior.ini) > 1500) { write -dl2 dat\nickanterior.ini }
  set %nickant.tmp $readini dat\nickanterior.ini direcciones $address($1,2)
  if (($1 != %nickant.tmp) && (%nickant.tmp != $null) && (%nickant.tmp !ison $chan)) {
    writeini dat\nickanterior.ini direcciones $address($1,2) $1
    return  %nickant.tmp 
  }
  writeini dat\nickanterior.ini direcciones $address($1,2) $1
}

;*************************************
; Fkeys: usa /fkeys para cambiarlas
; no las edites desde aquí! :P
;
;*************************************
f1 srvlst
f2 panel
f3 floodconf
f4 persconf
f5 thm
f6 mp3
f7 awayconf
f8 logs
f9 email
f10 portscan
f11 run files\jezzball\jezzball.exe
f12 snake
