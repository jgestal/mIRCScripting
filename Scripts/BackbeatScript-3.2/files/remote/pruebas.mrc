

;mOTFv.dll v2.01 Copyright©2000 danielson@centurytel.net, All Rights Reserved

on *:start: {
  var %ld = $dll($qte(dll\mOTFv.dll),Load,0) 
  if ($gettok(%ld,1,32) == ERROR) { 
    echo 4 -s %ld 
    .disable mOTFv ;Turn it off
  }
  else {
    dll $qte(dll\mOTFv.dll) Mark 0 | ;Mark the socket so mOTFv can do it's work, note Mark does an internal $server check, so we don't need to check
    .enable mOTFv | ;Bah, under normal circumstances, I'd give groups a snowball in hell's chance, but I don't want to do any hash table/window things 
    echo 5 -s mIRC On The Fly Version Changer v2.01
    echo 4 -s -------------------------------------
    echo 5 -s Copyright ©2000 danielson
    echo 5 -s All Rights Reserved
    echo 3 -s Type /Version <Text> to set your version
  }
}
ctcp ^*:VERSION*:*: { ctcpreply $nick VERSION sdasdasdas }
#mOTFv on

on *:connect: {
  dll dll\mOTFv.dll Mark 0 | ;Mark the socket (Must be remarked each time you reconnect)
}

;Note, Was going to put an unload event in ON EXIT, but nah, when mIRC exits
;the dll will clean itself up, anyways

alias version {
  var %result = $dll($qte(dll\mOTFv.dll),SetVersion,$1-)
  if (($gettok(%result,1,32) == ERROR) && ($show != $false)) { echo 4 -s %result }
  return %result
}

#mOTFv end
