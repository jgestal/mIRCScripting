;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; Encriptación de texto standard
; dll crypt.dll de ais (ais@pobox.com)
;
;*************************************

alias msed makedialog -m msed msed
dialog msed {
  title "Encriptación de texto"
  size -1 -1 206 141
  option dbu
  icon icons\cript.ico
  box "Ventana (privado, dcc o canal)", 1, 5 5 100 30
  combo 2, 10 15 89 50, size drop
  box "Datos", 3, 5 40 100 95
  text "Ventana:", 4, 10 55 22 8
  edit "" 5, 40 53 60 10, autohs 
  text "Clave 1:", 6, 10 75 22 7 
  edit "", 7, 40 73 60 10, autohs pass
  text "Clave 2:", 8, 10 95 22 8
  edit "", 9, 40 93 60 10, autohs pass
  button "Añadir", 10, 10 115 40 15
  button "Borrar", 11, 60 115 40 15
  box "Información", 12, 110 5 91 110
  text "Método standard para la encriptación de texto. Consta de dos claves y las dos deben de ser números comprendidos entre 1 y 65535. ", 13, 115 15 80 35
  text "DLL crypt.dll programada por ais (ais@pobox.com)", 14, 115 50 80 14
  text "Nota: Para añadir una ventana de chat usa: @nick. Por ejemplo, para añadir un chat que tienes con Jimmy_RAY añadirías: @Jimmy_RAY", 15, 115 65 80 35


  button "Cerrar", 100, 135 120 40 15, ok
}
on 1:dialog:msed:*:*: {
  if ($devent == init) {
    _mdx.buttons_style 10 11 100
    msed_loadlist 
  }
  if ($did == 2) msed_putinfo
  if ($did == 10) { wi dat\crypt.ini gen $did($dname,5) $+($did($dname,7),$chr(44),$did($dname,9)) | msed_loadlist }
  if ($did == 11) { wi dat\crypt.ini gen $did($dname,2) | msed_loadlist }
  did $iif($did($dname,5) && $did($dname,7) && $did($dname,9),-e,-b) $dname 10
  did $iif($did($dname,2),-e,-b) $dname 11
}
alias msed_loadlist {
  var %i 2
  did -r $dname 2
  while ($rl(dat\crypt.ini,%i)) {
    did -a $dname 2 $gettok($ifmatch,1,61)
    inc %i
  }
  did -c $dname 2 $calc(%i -2)
  msed_putinfo
}
alias msed_putinfo {
  did -r $dname 5,7,9
  var %x $did($dname,2)
  did -a $dname 5 %x
  did -a $dname 7 $gettok($ri(dat\crypt.ini,gen,%x),1,44)
  did -a $dname 9 $gettok($ri(dat\crypt.ini,gen,%x),2,44)
}
alias crypt return dll\crypt.dll
alias cr say $ms_en_cr($1-)
alias ms_en_cr return $dll($crypt,crypt,$1)
alias ms_de_cr { 
  var %x $dll($crypt,decrypt,$1)
  if ($gettok(%x,1,32) == OK:) return $gettok(%x,2-,32)
  return (error desencriptando) $gettok(%x,2-,32) 
}

;$1 = clave 1,$2 = clave 2,$3 = texto;

alias kr {
  if ($$1) {
    var %x $ri(dat\crypt.ini,gen,$active)
    var %p1 $gettok(%x,1,44)
    var %p2 $gettok(%x,2,44)
    if (!%p1) || (!%p2) display error No tienes configuradas claves
    say $ms_en_kr(%p1,%p2,$1-)
  }
}
alias ms_en_kr { 
  dll $crypt setkey $1
  dll $crypt setskip $2
  return $dll($crypt,krypt,$3)
}
alias ms_de_kr { 
  dll $crypt setkey $1
  dll $crypt setskip $2
  var %x $dll($crypt,dekrypt,$$3)
  if ($gettok(%x,1,32) == OK:) return [kr] $gettok(%x,2-,32)
  return (error desencriptando) $2-
}
alias _cript { 
  var %x $gettok($1,1,32) 
  tokenize 32 $2-
  if ($strip($1) == [cr]) && ($2) { 
    return [cr] $ms_de_cr($2-)
  }
  elseif ($strip($1) == [kr]) && ($2) { 
    return $ms_de_kr($_cryptpass(%x,1),$_cryptpass(%x,2),$2-)
  }
  else return $1-
}
alias _cryptpass {
  var %x $1
  if ($left(%x,1) == $chr(61)) %x = $+($chr(64),$right(%x,-1))
  var %y 
  %y = $ri(dat\crypt.ini,gen,%x)
  return $gettok(%y,$2,44)
}
