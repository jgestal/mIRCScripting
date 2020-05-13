;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; Alias del aIRC prestadas por tabo
; para trabajar mejor con las DLL
; http://www.aircscript.com
;
;*************************************

mdx return dll\mdx.dll
views return dll\views.mdx
icondir return icons\ $+ $1 
clientedge mdx SetBorderStyle $dname $1 $cfg(flewd,b)
_mdx.buttons_style { _mdx.MarkDialog | _mdx.SetControlMDX | var %i 1 | while ($gettok($1-,%i,32)) { _mdx.SetBorderStyle $dname $gettok($1-,%i,32) clientedge | inc %i } }


;;
;
; -( mdx.dll v0.90 by DragonZap )-
;
;;

_mdx.init {
  var %d = $dname
  _mdx.MarkDialog %d
  if ($_not($_getsetup(script,_dicon)))  { _mdx.SetDialog %d icon $iif(*.ico iswm $1,$1,$_aircicon) }
  if ($2- != $null) { _mdx.SetDialog %d style $2-  }
}
; _mdx.SetMircVersion
_mdx.SetMircVersion { return $dll(dll\mdx.dll,SetMircVersion,$version) }

; _mdx.MarkDialog [dname]
_mdx.MarkDialog { return $dll(dll\mdx.dll,MarkDialog,$iif($1 != $null,$1,$dname)) }

; _mdx.SetControlMDX <plugin> <dialog name> <ID> <control> [styles]
_mdx.SetControlMDX {
  var %parms = $2- > dll\ $+ $1
  return $dll(dll\mdx.dll,SetControlMDX,%parms)
}

; _mdx.SetMDXStyle <dialog> <ID> <styles>
_mdx.SetMDXStyle { return $dll(dll\mdx.dll,SetMDXStyle,$1-) }

; _mdx.SetBorderStyle <dialog> <ID> <styles>
_mdx.SetBorderStyle { return $dll(dll\mdx.dll,SetBorderStyle,$1-) }

; _mdx.GetFont <dialog> <ID>
_mdx.GetFont { return $dll(dll\mdx.dll,GetFont,$1-) }

; _dialogfonts <dialog> <ids>
_dialogfonts {
  if ($_getsetup(dialogfont,enabled)) {
    var %weight = $_getsetup(dialogfont,weight),%flags = $_getsetup(dialogfont,flags),%charset = $_getsetup(dialogfont,charset),%size = $_getsetup(dialogfont,size),%font = $_getsetup(dialogfont,font),%tmp
    if ($istok(400 700,%weight,32) == $false) { %weight = 400 }
    if (+* !iswm %flags) { %flags = + }
    if (%charset == $null) { %charset = default }
    if (%size !isnum) || (%font == $null) { return }
    _mdx.SetFont $1-2 %flags %charset %size %weight %font
  }
}

; _mdx.SetFont <dialog> <ID[,ID,ID,...]> [+flags] [charset] <size> <weight> <font>
_mdx.SetFont {
  var %dialog = $1,%ids = $2,%parms = $3-,%tmp,%z,%i = 1,%p,%k = 10,%p = %i $+ - $+ $calc(%i + %k)
  while ($gettok(%ids,%p,44) != $null) {
    %z = %dialog $ifmatch %parms
    %tmp = $dll(dll\mdx.dll,SetFont,%z)
    inc %i %k
    inc %i
    %p = %i $+ - $+ $calc(%i + %k)
  }
}

; _mdx.SetDialog <dialog> <property> <value>
_mdx.SetDialog { return $dll(dll\mdx.dll,SetDialog,$1-) }

; _mdx.SetColor <dialog> <ID> <attrib> <RGB value>
_mdx.SetColor { return $dll(dll\mdx.dll,SetColor,$1-) }

; _mdx.MoveControl <dialog> <ID> [x] [y] [w] [h]
_mdx.MoveControl { return $dll(dll\mdx.dll,MoveControl,$1-) }

; _mdx.Remove
_mdx.Remove { return $dll(dll\mdx.dll,Remove,-) }

; _mdx.DLLInfo
_mdx.DLLInfo { return $dll(dll\mdx.dll,DLLInfo,-) }

;;
;
; -( popups.dll v1.00pre1 by DragonZap )-
;
;;

;
_popupdll.icon { _popupdll.menu LoadImg $1 icon small icons\ $+ $2- }

_popupdll.do-popup {
  var %click = $_popupdll.menu(Popup,$1-)
  if (%click != $null) $gettok(%click,3-,32)
  return
}
_popupdll.menu {
  var %result
  if ( $2 == $null ) set %result $dll(dll\popups.dll,$1,.)
  else set %result $dll(dll\popups.dll,$1,$2-)
  if ( $gettok(%result,1,32) == OK ) return $gettok(%result,2-,32)
}

; _popupdll.New <menu> <icon width> <icon height>
_popupdll.New {
  tokenize 32 $1-
  if ($dll(dll\Popups.dll,GetProperty, [ $1 ] imgsize) != $null) { var %tmp = $dll(dll\Popups.dll,Destroy,$1) }
  return $dll(dll\Popups.dll,New,$1-)
}

; _popupdll.Destroy <menu>
_popupdll.Destroy { return $dll(dll\Popups.dll,Destroy,$1-) }

; _popupdll.AddItem <menu> <pos> [+flags] [unsel#] [sel#] [trans] [text]{cr}[info]
_popupdll.AddItem { return $dll(dll\Popups.dll,AddItem,$1-) }

; _popupdll.RemoveItem <menu> <pos>
_popupdll.RemoveItem { return $dll(dll\Popups.dll,RemoveItem,$1-) }

; _popupdll.LoadImg <menu> [index] <type> [trans] <[resource#,]filename>
_popupdll.LoadImg { return $dll(dll\Popups.dll,LoadImg,$1-) }

; _popupdll.SetStyle <menu> [style] [style] ...
_popupdll.SetStyle { return $dll(dll\Popups.dll,SetStyle,$1-) }

; _popupdll.SetMetrics <menu> [name [w] [h]] [name [w] [h]] ..
_popupdll.SetMetrics { return $dll(dll\Popups.dll,SetMetrics,$1-) }

; _popupdll.GetProperty <menu> [item] <property>
_popupdll.GetProperty { return $dll(dll\Popups.dll,GetProperty,$1-) }

; _popupdll.SetProperty <menu> <item> <property> <value>
_popupdll.SetProperty { return $dll(dll\Popups.dll,SetProperty,$1-) }

; _popupdll.Popup <menu> [+flags] <x> <y> [x y w h]
_popupdll.Popup { return $dll(dll\Popups.dll,Popup,$1-) }

; _popupdll.Remove
_popupdll.Remove { return $dll(dll\Popups.dll,Remove,-) }

; _popupdll.DLLInfo
_popupdll.DLLInfo { return $dll(dll\Popups.dll,DLLInfo,-) }
