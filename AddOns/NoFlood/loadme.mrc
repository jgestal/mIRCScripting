;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BaT No FLooD! 1.0
;; BAT (BravoS AssAulT TeaM)     
;;
;; Coded by Jimmy_RAY
;;
;; http://www.gra2.com/jimmyray
;; http://www.gra2.com/scripting
;;
;; Email: jimmy@welt.es
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

on 1:load: { if ($version < 5.8) { echo 4 -a Error: No Flood! only works in versions superiors than 5.8  | unload -rs $script }
  else {
    if ($findfile($mircdir,cc1,1)) && ($findfile($mircdir,cc2,1)) && ($findfile($mircdir,cc3,1)) && ($findfile($mircdir,cc4,1)) && ($findfile($mircdir,cc5,1)) {
      wpc      
      wpc.date 10 Making dirs...
      mkdir dat
      .mkdir dat\channels
      .mkdir sistema
      wpc.date 10 Copying files...
      .copy -o " $+ $findfile($mircdir,cc1,1) $+ " " $+ sistema\confchan.mrc $+ "
      wpc.date 15 Copying files...
      .copy -o " $+ $findfile($mircdir,cc2,1) $+ " " $+ sistema\confchan2.mrc $+ "
      wpc.date 20 Copying files...
      .copy -o " $+ $findfile($mircdir,cc3,1) $+ " " $+ dat\channels\general.conf $+ "
      wpc.date 25 Copying files...
      .copy -o " $+ $findfile($mircdir,cc4,1) $+ " " $+ sistema\chanconf.ini $+ "
      wpc.date 30 Copying files...
      .copy -o " $+ $findfile($mircdir,cc5,1) $+ " " $+ dat\kicks.txt $+ "
      wpc.date 40 Loading remotes...
      .load -rs sistema\confchan.mrc
      .load -rs sistema\confchan2.mrc
      wpc.date 50 Deleting innecesary files...
      .remove " $+ $findfile($mircdir,cc1,1) $+ "
      wpc.date 55 Deleting innecesary files...
      .remove " $+ $findfile($mircdir,cc2,1) $+ "
      wpc.date 60 Deleting innecesary files...
      .remove " $+ $findfile($mircdir,cc3,1) $+ "
      wpc.date 70 Deleting innecesary files...
      .remove " $+ $findfile($mircdir,cc4,1) $+ "
      wpc.date Deleting innecesary files...
      .remove " $+ $findfile($mircdir,cc5,1) $+ "
      wpc.date 75 Deleting innecesary files...
      .remove loadme.mrc
      wpc.date 80 Installation complete!
      wpc.date 100 Opening main dialog...
      noflood
      window -c @wpc
      .unload -rs $script
    }
    else {
      echo 4 -a Error: Some files are mising, try to uncompress all the files to $mircdir
      unload -rs $script
} } }
alias wpc {
  window -c @wpc
  window -oph +b @wpc 100 100 252 100 
  window -a @wpc  
  drawrect -f @wpc 15 10 0 0 400 400 200 200 200
  drawrect -f @wpc 0 1 5 40 240 25 200 200 200
  drawrect -f @wpc 1 10 0 0 400 15 200 200 200
  drawtext -bc @wpc 0 1 "lucida console" 12 5 2 290 20 Instalador CFP:
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
