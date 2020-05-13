;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; CTCP Version reply
; Usando DLL: mOTFv.dll v2.01 
; danielson@centurytel.net
;
;*************************************

alias vreply makedialog -m vreply vreply
dialog vreply {
  title "CTCP Version reply"
  option dbu
  size -1 -1 250 170
  icon icons\fversion.ico,main
  box "", 1, 5 5 240 160
  check "Por defecto", 2, 20 20 50 12, push
  check "Específica", 3, 100 20 50 12, push
  check "Aleatoria", 4, 180 20 50 12, push
  edit "", 5, 20 40 210 10, autohs
  list 6, 20 54 210 90, size vsbar hsbar extsel
  button "Editar", 7, 20 145 37 12
  button "Recargar", 8, 60 145 37 12
  button "Aceptar", 9, 193 145 37 12,ok,cancel
}
on 1:dialog:vreply:*:*: {
  if ($devent == init) { 
    _mdx.buttons_style 2 3 4 7 8 9
    loadbuf -o $dname 6 dat\vreply.dat
  }
  if ($did == 2) %vreply = <DEFAULT>
  if ($did == 3) %vreply = ""
  if ($did == 4) %vreply = <RANDOM>
  if ($did == 5) %vreply = $did($dname,5)
  if ($devent == dclick) && ($did == 6) { 
    %vreply = $did($dname,6,$did($dname,6).sel).text
    did -ra $dname 5 %vreply
  }
  if (%vreply == <DEFAULT>) {
    did -c $dname 2
    did -u $dname 3,4
    if ($did($dname,5) != <DEFAULT>) did -ra $dname 5 <DEFAULT>
    did -b $dname 5
  }
  if (%vreply == <RANDOM>) {
    did -c $dname 4
    did -u $dname 2,3
    if ($did($dname,5) != <RANDOM>) did -ra $dname 5 <RANDOM>
    did -b $dname 5
  }
  if (%vreply != <RANDOM>) && (%vreply != <DEFAULT>) {
    did -c $dname 3
    if ($devent == init) did -ra $dname 5 %vreply
    did -u $dname 2,4
    did -e $dname 5
  }
  if ($did == 7) run notepad.exe dat\vreply.dat
  if ($did == 8) { did -r $dname 6 | loadbuf -o $dname 6 dat\vreply.dat }
  if ($did == 9)  version $vrep
}
alias vrep { if (%vreply == <DEFAULT>) || (%vreply == $null) return $_rversion | elseif (%vreply == <RANDOM>) return $rr(dat\vreply.dat) | else return %vreply } 
alias version {
  %last.version = $1-
  var %result = $dll(dll\mOTFv.dll,SetVersion,$1-)
  if (($gettok(%result,1,32) == ERROR) && ($show != $false)) { echo $colour(highlight) -s %result }
  return %result
}
