;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Visor de imágenes para mIRC
; Autor: Jimmy_RAY
; e-mail: jimmy@welt.es
; Visita http://backbeat.welt.es
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
menu nicklist,status,menubar,channel { 
  -
  &Visor de imágenes
  .&Visor de imágenes:vs
  .-
  .&Créditos: { 
    echo 2 -a ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    echo 2 -a *** Visor de Imágenes 1.0
    echo 2 -a *** AddOn escrito por Jimmy_RAY
    echo 2 -a *** http://backbeat.welt.es
    echo 2 -a *** email: jimmy@welt.es
    echo 2 -a ~~~~~~~~~~~~~~~~~~~~~~~~~~~
} }
on 1:start: { if (%vs.dir == $null) %vs.dir = $left($mircdir,3)
  echo 2 -s *** Visor de imágenes 1.0 por Jimmy_RAY: teclea /vs }
alias vs { if ($dialog(vs) == $null) dialog -md vs vs
  else echo 2 *** El visor de imágenes está actualmente en uso. }
dialog vs {
  title "Visor de imágenes para mIRC - Jimmy_RAY -"
  option dbu  
  size -1 -1 300 180

  box "&Lista de archivos",1,5 5 100 170,left
  text "&Directorio:",2,10 15 25 10
  edit "",3,10 25 80 10,read
  button "!",4,90 25 10 10

  button "&Listar",5,10 35 25 10,drop
  combo 6,35 35 65 50,drop
  list 7,10 45 90 120

  button "&Copiar",8,10 160 45 10,default,disable
  button "&Borrar",9,55 160 45 10,disable

  button "&Cerrar",10,55 160 45 10,ok,hide
  icon 11,110 5 185 150,
}
on 1:dialog:vs:init:*: { did -a vs 3 %vs.dir | did -a vs 6 Todos | did -a vs 6 *.jpg
  did -a vs 6 *.bmp | did -a vs 6 *.ico | did -c vs 6 1 | vslst }
on 1:dialog:vs:sclick:*:{ if ($did == 4) .timer -m 1 1 vsdir
  if ($did == 5) vslst
  if ($did == 7) { did -g vs 11 " $+ %vs.dir $+ $did(vs,7,$did(vs,7).sel).text $+ " | did -e vs 8,9 }
  if ($did == 8) .timer -m 1 1 vscopy
  if ($did == 9) .timer -m 1 1 vsdel }
alias vslst { did -b vs 8,9 | did -r vs 7
  if ($did(vs,6,$did(vs,6).sel).text == Todos) { %i = 1
    while ($findfile(%vs.dir,*.*,%i,1)) { 
      if ($right($findfile(%vs.dir,*.*,%i,1),4) == .jpg) did -a vs 7 $nopath($findfile(%vs.dir,*.*,%i,1))
      if ($right($findfile(%vs.dir,*.*,%i,1),4) == .bmp) did -a vs 7 $nopath($findfile(%vs.dir,*.*,%i,1)) 
      if ($right($findfile(%vs.dir,*.*,%i,1),4) == .ico) did -a vs 7 $nopath($findfile(%vs.dir,*.*,%i,1)) 
      inc %i } }
  elseif ($did(vs,6,$did(vs,6).sel).text == *.jpg) { %i = 1
  while ($findfile(%vs.dir,*.jpg,%i,1)) { did -a vs 7 $nopath($findfile(%vs.dir,*.jpg,%i,1)) | inc %i } } 
  elseif ($did(vs,6,$did(vs,6).sel).text == *.bmp) { %i = 1
  while ($findfile(%vs.dir,*.bmp,%i,1)) { did -a vs 7 $nopath($findfile(%vs.dir,*.bmp,%i,1)) | inc %i } } 
  elseif ($did(vs,6,$did(vs,6).sel).text == *.ico) { %i = 1
  while ($findfile(%vs.dir,*.ico,%i,1)) { did -a vs 7 $nopath($findfile(%vs.dir,*.ico,%i,1)) | inc %i } } }
alias vsdir { %tmp.var = $sdir="Selecciona el directorio" | if (%tmp.var) %vs.dir = %tmp.var | unset %tmp.var | did -ra vs 3 %vs.dir | did -r vs 7 | did -b vs 8,9 | vslst }
alias vscopy { set -u %tmp.var $sdir="Selecciona el directorio para copiar $did(vs,7,$did(vs,7).sel).text " 
if (%tmp.var)  .copy -o " $+ %vs.dir $+ $did(vs,7,$did(vs,7).sel).text $+ " " $+ %tmp.var $+ " | vscopiado }
alias vsdel { if ($$?!="Va a borrar el archivo $did(vs,7,$did(vs,7).sel).text $+ . Realmente está seguro?" == $true) {
    .remove " $+ %vs.dir $+ $did(vs,7,$did(vs,7).sel).text $+ " | vslst | vsborrado } }
alias vscopiado $dialog(vscopiado,vscopiado,2)
dialog vscopiado {
  title "Información:"
  size -1 -1 120 30
  option dbu
  text "El archivo se ha copiado satisfactoriamente",1,0 5 120 10,center
  button "OK",2,70 15 40 10,ok,default
}
alias vsborrado $dialog(vsborrado,vsborrado,2)
dialog vsborrado {
  title "Información:"
  size -1 -1 100 30
  option dbu
  text "El archivo ha sido borrado",1,0 5 100 10,center
  button "OK",2,50 15 40 10,ok,default
}
