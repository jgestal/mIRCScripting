;*************************************
;       BaCKBEAT by Jimmy_RAY
; 
; http://www.gestal.es
; 
; email: juan@gestal.es
;
;*************************************

;*************************************
; Popup DLL de la ventana de Status
;
;*************************************

alias status-menu {

  _popupdll.New channel_popup 16 16 

  _popupdll.icon channel_popup servidor.ico
  _popupdll.AddItem channel_popup end +D 1 &Conectar con un servidor $cr conectar
  _popupdll.icon channel_popup servers.ico
  _popupdll.AddItem channel_popup end 2 &Lista de redes y servidores $cr srvlst

  _popupdll.icon channel_popup d6.ico
  if ($server) {
    _popupdll.AddItem channel_popup end 3 &Reconectar con el servidor $cr server $server $port
  }
  _popupdll.AddItem channel_popup end 
  _popupdll.icon channel_popup user.ico
  _popupdll.AddItem channel_popup end 4 &Modos de usuario $cr Umode
  _popupdll.icon channel_popup pregunta.ico
  if ($server) {
    _popupdll.AddItem channel_popup end 5 &Lista de usuarios (Lusers) $cr Lusers
    _popupdll.AddItem channel_popup end 5 &Lista de canales $cr list
  }
  _popupdll.AddItem channel_popup end 
  _popupdll.icon channel_popup web.ico
  _popupdll.AddItem channel_popup end 6 &Visitar la web del script $cr run $_web
  _popupdll.icon channel_popup noticias.ico
  _popupdll.AddItem channel_popup end 7 &Leer las noticias del script $cr noticias

  _popupdll.do-popup channel_popup +cC $mouse.dx $mouse.dy 
}
alias conectar server $_r(Introduce servidor y puerto)

;*************************************
; Menús de nicklist y query
;
;*************************************

menu nicklist,query {
  &información
  .&whois normal:w $_($1)
  .&whois con idle:whois $_($1) $_($1)
  .&uwho (whois en dialogo):uwho $_($1)
  .&resolver su dns:dns $_($1)
  .&libro de direcciones:abook $_($1)
  -
  $iif(!$query($_($1)),&abrir privado):query $_($1)
  $iif(!$chat($_($1)),&abrir sesión chat):dcc chat $_($1)
  &enviar archivo:dcc send $_($1)
  $iif($notify($_($1)),&borrar de notify,&añadir a notify): { if ($notify($_($1))) notify -r $_($1) | else notify $_($1) $__r(Introduce el comentario (opcional)) }
  &ignorar:igadd $_($1) | closemsg $$1
  &mandar ctcp
  .&ctcp específico:ctcp $_($1) $_r(Introduce el CTCP)
  .-
  .&ping:ctcp $_($1) ping
  .&finger:ctcp $_($1) finger
  .&version:ctcp $_($1) version
  .&time:ctcp $_($1) time
  .&userinfo:ctcp $_($1) userinfo
  .&clientInfo:ctcp $_($1) clientinfo
}
menu status {
  &modos de usuario:umode
  &lista de usuarios:ulist
  &lista de ignorados:iglist
  &resolver una dns:dns $_r(¿A resolver?)
  $iif($server,&realizar un whois):whois $_r(Introduce el nick)
  -
  $iif($server,&entrar en un canal)
  .&canal específico:join # $+ $_r(Introduce el canal (clave opcional))
  .&ejecutar auto entrada:ae_entrar
  .-
  .$rl(dat\ucanales.dat,1):join $rl(dat\ucanales.dat,1)
  .$rl(dat\ucanales.dat,2):join $rl(dat\ucanales.dat,2)
  .$rl(dat\ucanales.dat,3):join $rl(dat\ucanales.dat,3)
  .$rl(dat\ucanales.dat,4):join $rl(dat\ucanales.dat,4)
  .$rl(dat\ucanales.dat,5):join $rl(dat\ucanales.dat,5)
  .$rl(dat\ucanales.dat,6):join $rl(dat\ucanales.dat,6)
  .$rl(dat\ucanales.dat,7):join $rl(dat\ucanales.dat,7)
  .$rl(dat\ucanales.dat,8):join $rl(dat\ucanales.dat,8)
  .$rl(dat\ucanales.dat,9):join $rl(dat\ucanales.dat,9)
  .$rl(dat\ucanales.dat,10):join $rl(dat\ucanales.dat,10)
  .$rl(dat\ucanales.dat,11):join $rl(dat\ucanales.dat,11)
  .$rl(dat\ucanales.dat,12):join $rl(dat\ucanales.dat,12)
  .$rl(dat\ucanales.dat,13):join $rl(dat\ucanales.dat,13)
  .$rl(dat\ucanales.dat,14):join $rl(dat\ucanales.dat,14)
  .$rl(dat\ucanales.dat,15):join $rl(dat\ucanales.dat,15)
  .-
  .$iif($lines(dat\ucanales.dat),&borrar lista):write -c dat\ucanales.dat
  $iif($chan(0) && $server,&partir de un canal)
  .$chan(1): part $chan(1) $__r(Introduce un mensaje (opcional))
  .$chan(2): part $chan(2) $__r(Introduce un mensaje (opcional))
  .$chan(3): part $chan(3) $__r(Introduce un mensaje (opcional))
  .$chan(4): part $chan(4) $__r(Introduce un mensaje (opcional))
  .$chan(5): part $chan(5) $__r(Introduce un mensaje (opcional))
  .$chan(6): part $chan(6) $__r(Introduce un mensaje (opcional))
  .$chan(7): part $chan(7) $__r(Introduce un mensaje (opcional))
  .$chan(8): part $chan(8) $__r(Introduce un mensaje (opcional))
  .$chan(9): part $chan(9) $__r(Introduce un mensaje (opcional))
  .$chan(10): part $chan(10) $__r(Introduce un mensaje (opcional))
  .-
  .$iif($chan(2),&partir de todos):partall $__r(Introduce un mensaje (opcional))
  -
  $iif($server,&desconectar)
  .&mensaje predeterminado:quit
  .con razón &específica:quit $_r(Introduce la razón)
  .introducir &razón:quit $_r(Introduce la razón)
  -
  &ventana
  .&limpiar ventana:clear -a
  .&logging
  ..&on:.log on | nota Log en $active activado.
  ..&off:.log off | nota Log en $active detenido.
  .&poner un fondo
  ..&selecciona la imagen:background -a $$dir="Elige la imagen" $mircdirimagenes\*.bmp
  ..-
  ..&quitar la imagen:background -ax 
  ..-
  ..&centro:background -ac
  ..&completo:background -af
  ..&normal:background -an
  ..&grande:background -ar 
  ..&mosaico:background -at 
  ..&esquina:background -ap
  .&cambiar la fuente:font

}

menu channel,query {
  &msg encriptado
  .$iif($ri(dat\crypt.ini,gen,$active),&con clave [kr]):kr $_r(Introduce el mensaje a encriptar)
  .&standard [cr]:cr $_r(Introduce el mensaje a encriptar) 
  .-
  .&configurar claves:msed

}

;*************************************
; addOn de ASCII
;
;*************************************

menu channel,nicklist,query {
  -
  &entretenimiento
  .&jugar al trivial:pstrivial
  .-
  .&contar chistes
  ..&clásicos:rc chistes
  ..&¿cómo se dice...?:rc comosedice
  ..&de lepe:rc lepe
  ..&de argentinos:rc argentinos
  ..&de windows:rc windows
  ..&verdes:rc guarros
  ..&mamá mamá:rc mama
  ..-
  ..&machistas:rc machistas
  ..&feministas:rc feministas
  ..-  
  ..-
  ..&ley de Murphy:rc murphy
  ..&frases famosas:rc frases
  ..&eres un adicto si...:say Eres un adicto si... $rr(etc\txt\adicto.txt)
  ..&anécdotas informáticas:rc informatica
  ..&tags graciosos:rc tags
  .-
  .$iif($active ischan,&dibujitos al canal)
  ..&payaso:payaso
  ..&mira el canal:miraelcanal
  ..&como pez en el agua:pezenelagua
  ..&¿y esas caras?:esascaras
  ..&a toda vela:atodavela
  ..&patitos mareados:patitosmareados
  ..&lluvia a mares:Lluviaamares
  ..&soltar globos:Globos
  ..&ya llegué!:Careto
  .&dibujos normales
  ..&pikachu:say 4,0^1(4,8o2,8`-´4,8o1,0)4,0^7/\/1 Pikaaaaaaaaaaaa !!!!!!!!
  ..&ranas:ranas
  ..&adicto al mIRC:adictoalmirc
  ..&cometa:cometa
  ..&tendido eléctrico:tendidoelectrico
  ..&¿y esas caras?:esascaras
  ..&me llaman por teléfono:Telefono
  ..&sonrisa:smiley
  .$iif($_($1),&dibujos para $_($1))
  ..&hola!:hola $_($1)
  ..&adios:adios $_($1)
  ..-
  ..&amorosos
  ...&multicolor:multicolor $_($1)
  ...&flechas multicolor:Flechasmulti $_($1)
  ...&eléctrico:Electrico $_($1)
  ...&estrellas:Estrellas $_($1)
  ...&arcoiris:ArcoIris $_($1)
  ...&flotando:Flotando $_($1)
  ...&peces:Peces $_($1)
  ...&olas:olas $_($1)
  ...&ositos:ositos $_($1)
  ...&dar una rosa:rosa $_($1)
  ...&cubrir de rosas:cubrirderosas $_($1)
  ...&regalar ramo de rosas:Ramorosas $_($1)
  ...&dar rosas amarillas:Rosasamarillas $_($1)
  ...&amor:Amor $_($1)
  ...&corazoncitos:Corazones $_($1)
  ...&dar un osito:Osito $_($1)
  ...&un par de besos:Besarmejillas $_($1)
  ...&besazo:Beso $_($1)
  ...&eres mi angel:Angel $_($1)
  ...&beso en los labios:Besolabios $_($1)
  ...&abrazo:Abrazo $_($1)
  ..&dar cosas 
  ...&viagra:viagra $_($1)
  ...&lacasitos:lacasitos $_($1)
  ...&donetes:donetes $_($1)
  ...&7UP:7UP $_($1)
  ...&pañuelos kleenex:Kleenex $_($1)
  ...&condones control:Control $_($1)
  ...&caja de bombones:Bombones $_($1)
  ...&gominolas:Gominolas $_($1)
  ...&birra:Birra $_($1)
  ...&capuchino:Capuchino $_($1)
  ...&ducados:ducados $_($1)
  ...&cigarro:cigarro $_($1)
  ...&tiritas:tiritas $_($1)
  ...&sidra:sidra $_($1)
  ...&orujo:orujo $_($1)
  ...&whisky:whisky $_($1)
  ...&mentos:mentolados $_($1)
  ...&pegamento:pegamento $_($1)
  ...&bufanda:bufanda $_($1)
  ...&chocolate:chocolate $_($1)
  ...&porro:porro $_($1)
  ..-
  ..&variados
  ...&meter gol:Golazo $_($1)
  ...&confetti:Confetti $_($1)
  ...&te buscan:Cochepasma $_($1)
  ...&peligro:Peligro $_($1)
  ...&cohetes:Cohetes $_($1)
  ...&en forma:Estasenforma $_($1)
  ...&universo:Universo $_($1)
  ...&música:Musica $_($1)
  ...&feliz cumpleaños:Cumpleaños $_($1)
  ...&dale marcha!:Dalemarcha $_($1)
  ...&estoy feliz:Feliz $_($1)
  ...&grises:grises $_($1)
  ...&se acabó el gas:Seacaboelgas $_($1)
  ...&mueve el culo:mueveelculo $_($1)
  ...&tigre:tigre $_($1)
  ...&pajaro:pajaro $_($1)
  ..&insultar 
  ...&rata:rata $_($1)
  ...&pescao:pescao $_($1)
  ...&gallina:cacarear $_($1)
  ...&que te den:Queteden $_($1)
  .&banderas de paises
  ..&Catalana:Banderacatalana
  ..&Argentina:Banderaargentina
  ..&EEUU:BanderaUSA
  .-
  .&ASCII
  ..&amorosos
  ...&abrazo:ap amorosos\abrazo
  ...&beso 1:ap amorosos\beso1
  ...&beso 2:ap amorosos\beso2
  ...&corazón:ap amorosos\corazon
  ...&cupido:ap amorosos\G-Cupido
  ...&sexy:ap amorosos\sexy
  ...&noche:ap amorosos\noche
  ..&animales
  ...&aguila:ap animales\AGUILA
  ...&araÑa:ap animales\ARAÑA
  ...&araÑa2:ap animales\ARAÑA2
  ...&cabamar:ap animales\CABAMAR
  ...&cerdo:ap animales\Cerdo
  ...&conejo:ap animales\CONEJO
  ...&delfin:ap animales\DELFIN
  ...&gato1:ap animales\GATO1
  ...&gato2:ap animales\GATO2
  ...&gaton:ap animales\GATON
  ...&lobo1:ap animales\LOBO1
  ...&lobo2:ap animales\LOBO2
  ...&murciela:ap animales\MURCIELA
  ...&perro:ap animales\perro
  ...&perro1:ap animales\PERRO1
  ...&perro2:ap animales\PERRO2
  ...&perro3:ap animales\PERRO3
  ...&perro4:ap animales\perro4
  ...&perrofoll:ap animales\perrofoll
  ...&rana:ap animales\rana
  ...&rana2:ap animales\rana2
  ...&raton:ap animales\Raton
  ...&unicorn1:ap animales\UNICORN1
  ...&vaca1:ap animales\VACA1
  ...&vaca2:ap animales\VACA2
  ..&armas
  ...&espada:ap armas\Espada
  ...&espada2:ap armas\espada2
  ...&pistola:ap armas\Pistola
  ...&pistola1:ap armas\PISTOLA1
  ...&pistola2:ap armas\PISTOLA2
  ...&pistola3:ap armas\PISTOLA3
  ...&tiopipa:ap armas\TIOPIPA
  ..&bichos
  ...&bigdrag:ap bichos\BIGDRAG
  ...&dino:ap bichos\DINO
  ...&drag-on:ap bichos\DRAG-ON
  ...&dragon1:ap bichos\DRAGON1
  ...&dragon2:ap bichos\DRAGON2
  ...&dragon3:ap bichos\DRAGON3
  ...&dragon4:ap bichos\DRAGON4
  ...&dragon5:ap bichos\DRAGON5
  ...&dragon6:ap bichos\DRAGON6
  ...&dragon7:ap bichos\DRAGON7
  ...&gargola:ap bichos\GARGOLA
  ..&caras
  ...&amigo:ap caras\amigo
  ...&argh:ap caras\argh
  ...&bella:ap caras\bella
  ...&guiño:ap caras\Guiño
  ...&hmmm:ap caras\hmmm
  ...&pallaso:ap caras\pallaso
  ...&pelao:ap caras\pelao
  ...&wuttup1:ap caras\wuttup1
  ...&zzz:ap caras\zzz
  ..&color
  ...&aguila:ap color\aguila
  ...&arbol:ap color\arbol
  ...&barra:ap color\barra
  ...&bomba:ap color\bomba
  ...&calavera:ap color\calavera
  ...&corazon:ap color\corazon
  ...&dragon:ap color\dragon
  ...&gato:ap color\gato
  ...&gladiador:ap color\gladiador
  ...&labios:ap color\labios
  ...&lobo:ap color\lobo
  ...&ok:ap color\ok
  ...&pony:ap color\pony
  ...&puente:ap color\puente
  ...&ramo:ap color\ramo
  ...&rosa:ap color\rosa
  ...&tiabuena:ap color\tiabuena
  ...&universo:ap color\universo
  ...&ventana:ap color\ventana
  ..&gente
  ...&alucina:ap gente\Alucina
  ...&angel:ap gente\Angel
  ...&chinos:ap gente\Chinos
  ...&enfermera:ap gente\Enfermera
  ...&flipada:ap gente\Flipada
  ...&k.o.:ap gente\K.O.
  ...&nenaculo:ap gente\Nenaculo
  ...&novata:ap gente\Novata
  ...&novato:ap gente\Novato
  ...&novato2:ap gente\Novato2
  ...&prostitu:ap gente\Prostitu
  ...&student:ap gente\student
  ...&tia1:ap gente\tia1
  ...&warrior2:ap gente\Warrior2
  ...&wizard:ap gente\Wizard
  ..&insultos
  ...&1dedo:ap insultos\1DEDO
  ...&2dedos:ap insultos\2DEDOS
  ...&bartculo:ap insultos\BARTCULO
  ...&caraculo:ap insultos\CARACULO
  ...&ktjodan:ap insultos\KTJODAN
  ...&nardo:ap insultos\NARDO
  ...&piss:ap insultos\PISS
  ...&polla:ap insultos\POLLA
  ...&toma!:ap insultos\TOMA!
  ...&tomaya:ap insultos\TOMAYA
  ...&tumadre:ap insultos\TUMADRE
  ..&raros
  ...&alien:ap raros\ALIEN
  ...&cara:ap raros\CARA
  ...&cazafan:ap raros\CAZAFAN
  ...&confused:ap raros\CONFUSED
  ...&dpanic:ap raros\DPANIC
  ...&globos:ap raros\GLOBOS
  ...&hola:ap raros\HOLA
  ...&knight:ap raros\KNIGHT
  ...&labios:ap raros\LABIOS
  ...&luna:ap raros\LUNA
  ...&muÑeco:ap raros\MUÑECO
  ...&phoenix:ap raros\PHOENIX
  ...&reloj:ap raros\RELOJ
  ...&tarta:ap raros\TARTA
  ...&woop:ap raros\WOOP
  ...&x:ap raros\X
  ..&rosas
  ...&2rosas:ap rosas\2ROSAS
  ...&amarilla:ap rosas\amarilla
  ...&bigrosas:ap rosas\BIGROSAS
  ...&roja:ap rosas\roja
  ...&rosarosa:ap rosas\rosarosa
  ...&rose2:ap rosas\ROSE2
  ...&rose3:ap rosas\ROSE3
  ...&roseguau:ap rosas\ROSEGUAU
  ...&rosita:ap rosas\ROSITA
  ...&superosa:ap rosas\SUPEROSA
  ..&sadicos
  ...&bigskull:ap sadicos\BIGSKULL
  ...&calav1:ap sadicos\CALAV1
  ...&calav2:ap sadicos\CALAV2
  ...&calavera:ap sadicos\CALAVERA
  ...&demon2:ap sadicos\DEMON2
  ...&demonio:ap sadicos\DEMONIO
  ...&dracula:ap sadicos\DRACULA
  ...&pentagra:ap sadicos\PENTAGRA
  ...&sadico:ap sadicos\SADICO
  ...&satanic1:ap sadicos\SATANIC1
  ...&supercal:ap sadicos\SUPERCAL
  ..&simpsons
  ...&bart:ap SIMPSONS\BART
  ...&doh:ap SIMPSONS\DOH
  ...&homer:ap SIMPSONS\HOMER
  ...&lisa:ap SIMPSONS\LISA
  ...&maggie:ap SIMPSONS\MAGGIE
  ...&marge:ap SIMPSONS\MARGE
  ...&simpson:ap SIMPSONS\SIMPSON
  ...&simpsons:ap SIMPSONS\Simpsons
  ..&transporte
  ...&bicis:ap transporte\Bicis
  ...&coche:ap transporte\COCHE
  ...&coche1:ap transporte\COCHE1
  ...&coche2:ap transporte\COCHE2
  ...&nave1:ap transporte\NAVE1
  ...&nave2:ap transporte\NAVE2
  ...&nave3:ap transporte\NAVE3
  ...&navenasa:ap transporte\NAVENASA
  ...&navetrek:ap transporte\NAVETREK
  ...&ovni:ap transporte\OVNI
  ...&police:ap transporte\police
  ...&tren:ap transporte\TREN
  ...&troncomov:ap transporte\Troncomov
  ...&x-wing:ap transporte\X-WING
}

alias -l rc say $rr($+(etc\txt\,$$1,.txt))
alias -l ap play $+(etc\ascii\,$$1,.txt) 1500
alias -l _ {
  if ($1 == query) return $active
  else return $1
}
