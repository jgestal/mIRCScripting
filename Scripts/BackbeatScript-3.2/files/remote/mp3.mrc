;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; MP3 player by Tig0ti
;
;*************************************

on *:mp3end:{
  mp3.stop
  .timermp3* off
}
alias mp3 { makedialog -md mp3 | .timermp3check 0 1 mp3.check }
dialog mp3 {
  title "mp3 player"
  size -1 -1 300 342
  icon icons\sonido.ico
  icon 1, 33 88 22 18, files\im\mp3rw.bmp
  icon 2, 65 88 22 18, files\im\mp3play.bmp
  icon 3, 97 88 22 18, files\im\mp3ps.bmp
  icon 4, 129 87 22 18, files\im\mp3st.bmp
  icon 5, 161 87 22 18, files\im\mp3fw.bmp
  edit "", 6, 6 8 224 21, read autohs
  edit "", 7, 236 8 54 21, read autohs center
  edit "", 8, 7 36 37 21, read autohs center
  text "kbps", 9, 48 39 23 16, disable
  edit "", 10, 76 36 30 21, read autohs center
  text "kHz", 11, 110 39 19 16, disable 
  check "PL", 12, 264 36 25 20, push
  text "stereo", 16, 208 88 29 16, disable
  text "mono", 17, 246 88 26 16, disable
  button "sucka", 18, 302 115 75 25, hide ok
  scroll "", 19, 7 62 288 16, range 100 horizontal bottom 
  scroll "", 20, 136 36 121 16, range 65535 horizontal bottom 
  button "&File +", 21, 2 320 39 20
  button "&File -", 22, 45 320 39 20
  box "", 23, 91 314 2 26
  button "&Dir +", 24, 100 320 39 20
  button "&Dir -", 25, 143 320 39 20
  box "", 26, 189 314 2 26
  button "&Clear", 27, 197 320 39 20
  list 28, 4 118 292 193, size
  text "??? files", 29, 247 323 41 16
}
alias m.rfiles {
  if ($dialog(mp3)) { did -ra mp3 29 $iif($lines($plist),$lines($plist),0) files }
}
on *:dialog:mp3:dclick:28:{ mp3.play $right($gettok($did(mp3,28).seltext,1,9),-4) }
on *:dialog:mp3:scroll:*:{
  if ($did == 20) { vol -v $calc(65535 - $did(mp3,20).sel) }
  if ($did == 19) { if ($inmp3) splay seek $round($calc($calc($did(mp3,19).sel / 100) * $inmp3.length),0)  }
}
on *:dialog:mp3:sclick:*:{
  if ($did == 21) { %mp3.temp = $file="Selecciona un archivo" $mircdir\*.mp3 | write $plist %mp3.temp $+ $chr(9) $durz($calc($mp3(%mp3.temp).length / 1000),&&m:&&s)) | loadbuf -ro $dname 28 $plist | m.rfiles }
  if ($did == 24) { set %dir $sdir="Selecciona un directorio" | write $plist $findfile(%dir,*.mp3,0,write $plist $1- $+ $chr(9) $durz($calc($mp3($1-).length / 1000),&&m:&&s)) | loadbuf -ro $dname 28 $plist | unset %dir | m.rfiles }
  if ($did == 22) { 
    set %mz $did(28).seltext
    write -ds $+ " $+ $right($gettok(%mz,1,9),-4) $+ $chr(9) $right($gettok(%mz,2,9),-3) $+ " $plist | loadbuf -ro $dname 28 $plist | m.rfiles
  }
  if ($did == 27) { write -c $plist | loadbuf -ro $dname 28 $plist | m.rfiles }
  if ($did == 2) { mp3.play $file="Selecciona un archivo" $mircdir\*.mp3 }
  if ($did == 1) { mp3.rw }
  if ($did == 3) { mp3.pause }
  if ($did == 4) { mp3.stop }
  if ($did == 5) { mp3.fw }
  if ($did == 12) { mp3.plist }
}
alias mp3.pause {
  if (%mp3.pause == on) { splay resume | set %mp3.pause }
  else  { splay pause | set %mp3.pause on }
}
alias mp3.plist {
  if ($did(mp3,12).state == 0)  dialog -s mp3 -1 -1 300 118
  else dialog -s mp3 -1 -1 300 342
}
alias mp3.play {
  if ($1) && ($dialog(mp3)) {
    did -b mp3 17
    did -b mp3 16
    writeini dat\conf.ini mp3 file $1-
    did -ra mp3 6 $nopath($1-)
    .timermp3time 0 1 mp3.time
    .timermp3check 0 1 mp3.check
    did -ra mp3 8 $mp3($1-).bitrate
    did -ra mp3 10 $round($calc($mp3($1-).sample / 1000),0)
    $iif(stereo isin $mp3($1-).mode,did -e mp3 16,did -e mp3 17)
    splay " $+ $1- $+ "
  }
}
alias plist { return dat\plist.txt }
on *:dialog:mp3:init:*:{
  did -c mp3 20 $calc(65535 - $vol(master))
  if ($isfile($plist) == $true) { 
    dll $mdx SetMircVersion $version
    dll  $mdx MarkDialog $dname
    dll $mdx SetControlMDX $dname 28 listview rowselect grid showsel single flatsb headerdrag labeltip report > $views 
    did -i $dname 28 1 header @349,55 0 Filename $chr(9) $+ Length
    loadbuf -ro $dname 28 $plist 
    did -c $dname 12
    set %plist on
  }
}
alias mp3.check {
  if ($dialog(mp3) == $null) { splay stop  | .timermp3* off }
}
alias mp3.mvol { vol -v $calc($vol($inmp3) + 2000) }
alias mp3.rvol { vol -v $calc($vol($inmp3) - 2000) }
alias mp3.fw { splay seek $calc($inmp3.pos + 2000) }
alias mp3.rw { splay seek $calc($inmp3.pos - 2000) }
alias mp3.stop { 
  splay stop 
  did -ra mp3 6
  did -ra mp3 7
  did -ra mp3 8
  did -ra mp3 10
  did -b mp3 17
  did -b mp3 16
}
alias mp3.time {
  if ($dialog(mp3)) {
    did -ra mp3 7 $durz($calc($inmp3.pos / 1000),&&m:&&s)
    did -c mp3 19 $calc($calc($inmp3.pos / $inmp3.length) * 100) 
  }
}
alias durz {
  ;alias from http://www.mircscripts.org 
  ;author: fubar
  var %day = $int($calc($1 / 86400)),%hour = $int($calc($1 / 3600)),%min = $int($calc($1 / 60)),%sec = $1
  if ((&d isin $2) || ($2 == $null)) { %hour = $int($calc(($1 % 86400) /3600)) | %min = $int($calc(($1 % 86400) /60)) | %sec = $calc($1 % 86400) }
  if ((&h isin $2) || ($2 == $null)) { %min = $int($calc(($1 % 3600) /60)) | %sec = $calc($1 % 3600) }
  if ((&m isin $2) || ($2 == $null)) %sec = $calc($1 % 60)
  if ($2) return $replace($2,&&d,$base(%day,10,10,2),&&h,$base(%hour,10,10,2),&&m,$base(%min,10,10,2),&&s,$base(%sec,10,10,2),&d,%day,&h,%hour,&m,%min,&s,%sec)
  else return $iif(%day, [ %day $+ d ] ) $iif(%hour, [ %hour $+ h ] ) $iif(%min, [ %min $+ m ] ) $iif(%sec, [ %sec $+ s ] )
}
