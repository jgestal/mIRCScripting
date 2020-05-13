;*************************************
; Snake 1.0 by Jimmy_RAY
;
; BravoS AssAulT TeaM!
;
; URL: jimmyray.da.ru
; email: jimmy@welt.es
;
;*************************************
on 1:load: { 
  if ($version < 5.8) {
    echo $colour(info) -s *** Error, Snake needs mIRC 5.8, download it from www.mirc.com
    unload $script
  }
  else {
    echo $colour(info) -s *** Snake ( $+ $snk.version $+ ) by Jimmy_RAY: Type /snake to play 
  }
}
menu menubar { 
  &snake
  .&play:snake
  .&info:snk.info
  .-
  .&unload:snk.unload
}
on 1:close:@snake: { .timersnk* off | unset %snk_* }
alias snk.version return 1.0
alias snk.cas return 7
alias snake {
  window -pktoa +betl @Snake 50 50 200 200
  window -r @snake
  titlebar @snake ( $+ $snk.version $+ ) by Jimmy_RAY
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
  drawtext -bc @snake 10 10 "terminal" 14 5 5 290 25 $str($chr(160),100)
  drawtext -bc @snake 1 10 "terminal" 14 10 5 290 25 $str(0,$calc(4- $len($$1))) $+ $$1
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
        drawtext -bc @snake 10 10 "terminal" 12 10 150 200 10 Game Paused! Press [P] to continue      
      }    
      else {
        .timersnk off 
        %snk_pause = on
        drawtext -bc @snake 1 10 "terminal" 12 10 150 200 10 Game Paused! Press [P] to continue
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
  drawtext -bc @snake 0 1 "terminal" 50 5 5 290 50 Snake
  drawtext -bc @snake 13 1 "terminal" 30 50 70 290 50 GAME OVER
  drawtext -bc @snake 11 1 "terminal" 15 60 120 290 50 %snk_points points $iif(%snk_points > %snk.maxs,record!!!)
  if (%snk_points > %snk.maxs) %snk.maxs = %snk_points

  .timersnkmenu 1 3 snk.intro
  unset %snk_game
}
alias snk.intro {
  clear @snake
  if (%snk.maxs == $null) %snk.maxs = 0
  drawrect -f @snake 1 10 0 0 400 400 200 200 200
  drawtext -bc @snake 0 1 "terminal" 50 5 5 290 50 Snake
  drawtext -bc @snake 11 1 "terminal" 20 15 70 290 50 Jimmy_RAY addOns
  drawtext -bc @snake 11 1 "terminal" 14 20 100 290 50 Option menu: right click
  drawtext -bc @snake 9 1 "terminal" 14 60 130 290 50 BravoS AssAulT TeaM (c)
  drawtext -bc @snake 0 1 "terminal" 14 60 150 290 50 Record: %snk.maxs points
  unset %snk_game
}
alias snk.controls {
  window -pkrtoa +betl @Snake.Controls 60 60 200 130
  window -r @Snake.Controls
  titlebar @snake.controls
  clear @snake.controls
  drawrect -f @snake.controls 1 10 0 0 400 400 200 200 200
  drawtext -bc @snake.controls 11 1 "terminal" 12 15 10 200 50 [N] -> New Game
  drawtext -bc @snake.controls 11 1 "terminal" 12 15 30 200 50 [P] -> Pause
  drawtext -bc @snake.controls 11 1 "terminal" 12 15 50 200 50 [E] -> Exit
  drawtext -bc @snake.controls 11 1 "terminal" 12 15 70 200 50 Use cursor keys to move the snake
}
menu @snake {
  &new game: {
    snk.newgame
  }
  &level [[ $+ $snk.level $+ ]]
  .[1] &lamer:set %snk.lev 250
  .[2] &very easy:set %snk.lev 225
  .[3] &easy:set %snk.lev 175
  .[4] &medium:set %snk.lev 125
  .[5] &hard:set %snk.lev 100
  .[6] &expert:set %snk.lev 75
  .[7] &master:set %snk.lev 50
  &controls:snk.controls
  -
  &about
  .&info:snk.info
  .-
  .&web:run http://jimmyray.da.ru
  .&email:run mailto:jimmy@welt.es
  -
  &unload:snk.unload
}
menu @snake.controls {
  sclick { window -c $active }
  rclick { window -c $active }
}
alias snk.level {
  if (%snk.lev == $null) { %snk.lev = 250 }
  if (%snk.lev == 250) return 1
  if (%snk.lev == 225) return 2
  if (%snk.lev == 175) return 3
  if (%snk.lev == 125) return 4
  if (%snk.lev == 100) return 5
  if (%snk.lev == 75) return 6
  if (%snk.lev == 50) return 7
}
alias snk.levpoints {
  if (%snk.lev == $null) { %snk.lev = 250 }
  if (%snk.lev == 250) return 3
  if (%snk.lev == 225) return 4
  if (%snk.lev == 175) return 5
  if (%snk.lev == 125) return 6
  if (%snk.lev == 100) return 7
  if (%snk.lev == 75) return 8
  if (%snk.lev == 50) return 9
}
alias snk.unload { if ($?!="Are you sure?" == $true) {
 unload -rs $script 
unset %snk*
}
}
alias snk.info {
  window -k @Snake.Info 100 100 500 200
  echo $colour(info) @Snake.info .: Snake ( $+ $snk.version $+ ) by Jimmy_RAY :.
  echo $colour(own) @Snake.info You can find more addOns & scripts at http://jimmyray.da.ru
  echo $colour(own) @Snake.info If you want to include this addOn in your mIRC Script please notify it to me by email (jimmy@welt.es)
  echo $colour(info2) @Snake.info BravoS AssAulT TeaM! ®
}
