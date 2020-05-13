on *:TEXT:**:#: {
  set -u15 %addfrase9 %addfrase8
  set -u15 %addfrase8 %addfrase7
  set -u15 %addfrase7 %addfrase6
  set -u15 %addfrase6 %addfrase5
  set -u15 %addfrase5 %addfrase4
  set -u15 %addfrase4 %addfrase3
  set -u15 %addfrase3 %addfrase2
  set -u15 %addfrase2 %addfrase1
  set -u15 %addfrase1 $right($1-,9),32)

  set -u15 %cnafrase9 %cnafrase8
  set -u15 %cnafrase8 %cnafrase7
  set -u15 %cnafrase7 %cnafrase6
  set -u15 %cnafrase6 %cnafrase5
  set -u15 %cnafrase5 %cnafrase4
  set -u15 %cnafrase4 %cnafrase3
  set -u15 %cnafrase3 %cnafrase2
  set -u15 %cnafrase2 %cnafrase1
  set -u15 %cnafrase1 $chan
}

alias dicebott {
  if ($1 == 1) { set %addon.bot NiCK }
  if ($1 == 2) { set %addon.bot CHaN }
  if ($1 == 3) { set %addon.bot MeMo }
  if ($1 == 4) { set %addon.bot CReG }
}
alias testoci { if ( %testoc == $null ) { set %testoc Para usar este comando debes estar registrado en dicho canal }
  if ( %opcionaddon == $null ) { set %opcionaddon Canal }
  if ( %add.noreg == $null ) { set %add.noreg 0 ( | set %add.noide 1 ( | set %add.susp 4 ( }
}
alias cn1 {
  if (( $istok( %addfrase9, $left(%clalinea,5),32) == $true ) && ( $chan == %cnafrase9 )) || (( $istok( %addfrase8, $left(%clalinea,5),32) == $true ) && ( $chan == %cnafrase8 )) || (( $istok( %addfrase7, $left(%clalinea,5),32) == $true ) && ( $chan == %cnafrase7 )) || (( $istok( %addfrase6, $left(%clalinea,5),32) == $true ) && ( $chan == %cnafrase6 )) || (( $istok( %addfrase5, $left(%clalinea,5),32) == $true ) && ( $chan == %cnafrase5 )) || (( $istok( %addfrase4, $left(%clalinea,5),32) == $true ) && ( $chan == %cnafrase4 )) || (( $istok( %addfrase3, $left(%clalinea,5),32) == $true ) && ( $chan == %cnafrase3 )) || (( $istok( %addfrase2, $left(%clalinea,5),32) == $true ) && ( $chan == %cnafrase2 )) || (( $istok( %addfrase1, $left(%clalinea,5),32) == $true ) && ( $chan == %cnafrase1 )) {
    echo Mensaje abortado para evitar repeticiones
    unset %addfrase* %cnafrase*
    halt
  }
  if ($1 ison $chan) { set %cn 12[ $1 12] } | if (%cn == $null) { set %cn2 <nick> }
  else { set %cn2  $1 }
}
alias ucn { unset %cn %cn2 %clalinea %niquery }
alias gestorgrupo { .disable #mirastatus
if $group(#BOTS) == off { .enable #BOTS } }
alias stanic {
  unset %niquery %canaladdo %accadd %opensi %nick.destado
  if $group(#GRUPOISON) == off { .enable #GRUPOISON }
  if ( %opcionaddon != OFF ) {
    set %nick.destado $1
    if ( %opcionaddon == Canal ) {
      if ( $chan == $null ) { set %niquery $1 } 
    set %accadd msg $chan %niquery }
    if ( %opcionaddon == Notice ) {
      if ($1 != $null ) { unset %accadd }
      else { set %niquery $1
    set %accadd notice %niquery } }
    if (%addon.bot != $null) { ISON %addon.bot }
    halt
  }
}
#GRUPOISON off
if $group(#BOTS) == off { .enable #BOTS }
raw 303:*: { if ( $2 == $null ) { %accadd Ahora el bot %addon.bot no esta en el irc por lo que no podras ejecutar ese comando } 
  else {
    if (%nomestado != 1 ) {
      if (%nick.destado != $null ) {
        .msg nick status %nick.destado
        if $group(#BOTS) == on { .disable #BOTS }
        .enable #mirastatus
      }
    }
  }
unset %addon.bot %nomestado | .disable #GRUPOISON | halt }
#GRUPOISON end

menu menubar,query,channel,nicklist {
  Ayuda Bots
  .Ayuda de NiCK
  ..Identificarse:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Para identificarte ante el bot 0,2NiCK como dueño del nick debes poner /msg NiCK IDENTIFY <password>, no pongas esto en ningun canal ya que si escribes algo mal puedes dejar ver a todo el canal tu password %clalinea | ucn | set %controla1 10 | stanic $1
  ..Accesos
  ...Añadir:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Puedes añadir una mascara que permita el acceso a tu nick con  /msg NiCK ACCESS ADD <mascara>, eso realmente solo es util si tu ips es fija %clalinea | ucn | set %controla1 1 | stanic $1
  ...Borrar:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Para borrar una mascara asociada a un nick debes poner  /msg NiCK ACCESS DEL <mascara> %clalinea | ucn | set %controla1 1 | stanic $1
  ...Listar:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Si quieres ver la lista de mascaras con acceso a tu nick pon /msg NiCK ACCESS LIST %clalinea | ucn | set %controla1 1 | stanic $1
  ..Ajustar opciones (Set)
  ...Cambiar el password: { dicebott 1 | cn1 $1 | set %clalinea  
    if (( %cn == $null ) || ( %opcionaddon == OFF )) { set %mennik Para que funcione debes estar identificado ante 0,2NiCK }
  say %cn Para cambiar la clave de tu nick debes poner /msg NiCK SET PASSWORD <nuevo_password> %mennik %clalinea | ucn | unset %mennik | set %controla1 1 | stanic $1 }
  ...Lenguaje:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Es posible cambiar el lenguaje del bot con /msg NiCK SET LENGUAGE <número> El número para el español es el 14 6 %clalinea | ucn
  ...Activar/Desactivar kill:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Usa el comando KILL para proteger tu nick /msg NiCK SET KILL <ON | QUICK | OFF> Con el KILL dejas 60 segundos para identificarte como dueño del nick y si pones el QUICK sólo dispondras de 20 segundos. %clalinea | ucn | set %controla1 1 | stanic $1
  ...Asociar direccion:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Asocia una URL a tu nick poniendo /msg NiCK SET URL <tupaginaweb> 
  ...Seguridad:dicebott 1 | set %clalinea   | cn1 $1 | say %cn /msg NiCK SET SECURE <ON | OFF> Para activar o descativar la seguridad del nick %clalinea | ucn | set %controla1 1 | stanic $1
  ...Privado:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Para que tu nick no salga cuando alguien usa el NICK LIST debes poner /msg NiCK SET PRIVATE <ON | OFF> %clalinea | ucn | set %controla1 1 | stanic $1
  ...Esconder datos del nick:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Existe la posibilidad de esconder ciertos datos de tu nick /msg NiCK SET HIDE <EMAIL | USERMASK | QUIT> <ON | OFF> El email, la mascará y el ultimo quit respectivamente. %clalinea | ucn | set %controla1 1 | stanic $1
  ..Desregistrar un nick:set %clalinea   | cn1 $1 | say %cn Para desregistrar un nick debes hablar con un Ircop o un Oper, los encontraras en #opers_help o poniendo /msg chan Ircops %clalinea | ucn
  ..Recuperar tu nick:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Cuando otro esta usando nuestro nick podemos cerrarle la conexion con el comando /msg NiCK RECOVER <elnick> <password> Este comando tarda un minuto en desconectar al otro usuario. %clalinea | ucn | set %nomestado 1 | stanic $1
  ..Evitar tiempo de espera:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Para evitar el minuto que debes esperar a quel el bot 0,6NiCK desconecte a un usuario que tiene tu nick debes poner /msg NiCK RELEASE <elnick> <password> %clalinea | ucn | set %nomestado 1 | stanic $1
  ..Echar Fantasma:dicebott 1 | set %clalinea   | cn1 $1 | say %cn A veces la conexion con el IRC se queda activa cuando, por ejemplo, se nos cuelga el ordenador, aunque realmente no estamos, el IRC cree que si estamos, para sacar ese nick pon /msg NiCK GHOST <elnick> <password> %clalinea | ucn | set %nomestado 1 | stanic $1
  ..Info nick:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Podemos saber informacion de un nick con la orden /msg NiCK INFO <nick> %clalinea | ucn | set %nomestado 1 | stanic $1
  ..Lista nicks:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Puedes ver los nicks registrados por un determinado patron poniendo /msg NiCK LIST <nick!user@host> %clalinea | ucn | set %nomestado 1 | stanic $1
  ..Estado del nick:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Se puede saber si un nick esta identificado, si esta conectado...para ello poner el comando /msg NiCK STATUS <nick> <nick2> asi hasta 16 nicks, el resto serán ignorados. %clalinea | ucn | set %nomestado 1 | stanic $1
  .Ayuda de CHaN
  ..Iden como fundador:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Para identificarte como fundador de un canal debes poner /msg CHaN IDENTIFY <#canal> <password>. El password es el mismo que pusiste cuando registraste el canal ante 0,2CReG %clalinea | ucn | set %controla1 7 | stanic $1
  ..Opciones del canal
  ...Cambiar Founder:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Es posible cambiar el fundador de un canal poniendo /msg CHaN SET <#canal> FOUNDER  <nick> %clalinea | ucn | set %controla1 7 | stanic $1
  ...Cambiar pass de Founder:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Si quieres cambiar la pass del fundador del canal debes poner /msg CHaN SET <#canal> PASSWORD <nuevopassword> Para usar este comando debes estar identificado ante 0,2CHaN como el fundador del canal. %clalinea | ucn | set %controla1 7 | stanic $1
  ...Descripcion canal:dicebott 2 | set %clalinea   | cn1 $1 | say %cn La descripcion del canal se cambia poniendo /msg CHaN SET <#canal>  DESC <descripción> %clalinea | ucn | set %controla1 7 | stanic $1
  ...URL canal:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Si quieres puedes poner una URL asociada al canal, para fijarla pon /msg CHaN SET <#canal> URL <direcciondelaWEB> %clalinea | ucn | set %controla1 7 | stanic $1
  ...E-mail canal:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Si quieres poner un email de contacto en las propiedades del canal pon  /msg CHaN SET <#canal> EMAIL <email> %clalinea | ucn | set %controla1 7 | stanic $1
  ...MSG de bienvenida:dicebott 2 | set %clalinea   | cn1 $1 | say %cn El mensaje de bienvenida es algo importante y para cambiarlo basta poner /msg CHaN SET <#canal> ENTRYMSG <mensaje> %clalinea | ucn | set %controla1 7 | stanic $1
  ...Topic canal:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Cuando esta activado el KEEPTOPIC y se vacia el canal, CHaN restaura en el canal el topic puesto con /msg CHaN SET <#canal> TOPIC <topic> %clalinea | ucn | set %controla1 7 | stanic $1
  ...Recuerdo Topic:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Cuando el canal se queda vacio se queda sin topic a menos que especifiques uno por chan y tengas el KEEPTOPIC activado /msg CHaN SET <#canal> KEEPTOPIC <ON | OFF> %clalinea | ucn | set %controla1 7 | stanic $1
  ; ...No modificacion topic:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Poniendo /msg CHaN SET <#canal> TOPICLOCK  <ON | OFF> Conseguimos que no se pueda cambiar topic si no es con el comando set. %clalinea | ucn | set %controla1 7 | stanic $1
  ...Candado de modos:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Si quieres fijar unos modos para el canal, de forma que nadie los pueda cambiar pon /msg CHaN SET <#canal> MLOCK +/- <i,k,l,m,n,p,s,t>. Algo recomendable es +nt -pilks %clalinea | ucn | set %controla1 7 | stanic $1
  ...Esconder canal:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Si no quieres que tu canal salga en la lista de canales pon /msg CHaN SET <#canal> PRIVATE <ON | OFF> %clalinea | ucn | set %controla1 7 | stanic $1
  ...Prohibicion de entrada:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Restringe la entrada al canal a los usuarios  /msg CHaN SET <#canal> RESTRICTED <ON | OFF> %clalinea | ucn | set %controla1 7 | stanic $1
  ...Seguridad canal:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Puedes hacer que sólo puedan entrar al canal los usuarios que se hayan identificado ante 0,2NiCK y esten en la lista de acceso del canal, para ello pon /msg CHaN SET <#canal> SECURE <ON | OFF> %clalinea | ucn | set %controla1 7 | stanic $1
  ...Secure OPs:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Si quieres que solo las personas registradas en el canal puedan tener @ pon /msg CHaN SET <#canal> SECUREOPS <ON | OFF> %clalinea | ucn
  ..Registros del canal
  ...Añadir/subir nivel nick:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Para añadir a alguien a la lista de registros de tu canal debes poner /msg CHaN ACCESS <#canal> ADD <nick> <level> El nivel que se da debe ser menor al tuyo. Esta orden tambien se usa para subir el nivel de otro usuario ya registrado. %clalinea | ucn | set %controla1 7 | stanic $1
  ...Borrar nick:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Se puede borrar el registro de un usuario en un canal segun su nick o su posicion en la lista de registros, para ello pon /msg CHaN ACCESS <#canal> DEL <nick | nºregistro> %clalinea | ucn | set %controla1 7 | stanic $1
  ...Ver lista:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Si quieres ver la lista de usuarios registrados en un canal pon /msg CHaN ACCESS <#canal> LIST, para ello debes tener un cierto nivel en ese canal (varia segun el canal). %clalinea | ucn
  ..Niveles 
  ...Niveles defecto:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Es posible resetear los niveles de un canal y dejar unos que vienen por defecto, usa /msg CHaN LEVELS <#canal> RESET %clalinea | ucn | set %controla1 9 | stanic $1
  ...Mirar niveles canal:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Para ver los niveles que tiene puesto un canal pon /msg CHaN LEVELS <#canal> LIST %clalinea | ucn
  ...Deshabilitar:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Para deshabilitar cualquier tipo de nivel debes poner /msg CHaN LEVELS <#canal> DIS <tipodenivel>. El tipo de nivel es por ejemplo AUTOOP o NOJOIN. %clalinea | ucn | set %controla1 9 | stanic $1
  ...Descripcion niveles:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Si quieres saber que funcion tiene cada uno de los niveles de un canal pon /msg CHaN HELP LEVELS DESC %clalinea | ucn
  ...Auto OP:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Para cambiar el nivel a partir del cual 0,2CHaN da Op automaticamente al entrar pon /msg CHaN LEVELS <#canal> SET AUTOOP <level> %clalinea | ucn | set %controla1 9 | stanic $1
  ...Auto DEOP:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Para cambiar el nivel para el que 0,2CHaN quita el OP pon /msg CHaN LEVELS <#canal> SET AUTODEOP <level>. Todos los usuarios que tengan el nivel establecido o menor no podran tener Op en el canal. %clalinea | ucn | set %controla1 9 | stanic $1
  ...Auto voz:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Si quieres cambiar el nivel a partir del cual 0,2CHaN da voz (+) al entrar, pon /msg CHaN LEVELS <#canal> SET AUTOVOICE <level> %clalinea | ucn | set %controla1 9 | stanic $1
  ...Solo registrados:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Puedes cambiar el nivel para el que un usuario no pueda entrar al canal si esta en modo Restringido y su nivel es igual o inferior al fijado para el NOJOIN, para ello pon /msg CHaN LEVELS <#canal> SET NOJOIN <level> %clalinea | ucn | set %controla1 9 | stanic $1
  ...AutoInvitar:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Se puede cambiar el nivel a partir del cual un usuario puede autoinvitarse al canal usando /msg CHaN LEVELS <#canal> SET INVITE <level> %clalinea | ucn | set %controla1 9 | stanic $1
  ...Auto Kick:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Cambia el nivel a partir del que se podrá usar el comando AKICK, pon /msg CHaN LEVELS <#canal> SET AKICK <level> %clalinea | ucn | set %controla1 9 | stanic $1
  ...Cambiar niveles canal:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Para poder cambiar los niveles de un canal es necesario el comando SET, cambia el nivel para usar este comando con /msg CHaN LEVELS <#canal> SET SET <level> %clalinea | ucn | set %controla1 9 | stanic $1
  ...Clear:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Puedes cambiar el nivel para acceder al comando CLEAR, pon /msg CHaN LEVELS <#canal> SET CLEAR <level> %clalinea | ucn | set %controla1 9 | stanic $1
  ...Quitar ban:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Para cambiar el nivel para usar el UNBAN pon /msg CHaN LEVELS <#canal> SET UNBAN <level> %clalinea | ucn | set %controla1 9 | stanic $1
  ...OP/DEOP:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Puedes cambiar el nivel para dar y quitar Op atraves de 0,2CHaN, para ello pon /msg CHaN LEVELS <#canal> SET OPDEOP <level> %clalinea | ucn | set %controla1 9 | stanic $1
  ...Lista Registros:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Puedes cambiar el nivel minimo para ver la lista de registrados de un canal, pon /msg CHaN LEVELS <#canal> SET ACC-LIST <level> %clalinea | ucn | set %controla1 9 | stanic $1
  ...Cambiar registros:dicebott 2 | set %clalinea   | cn1 $1 | say %cn El nivel minimo para poder añadir o borrar registros del canal puede ser cambiado con /msg CHaN LEVELS <#canal> SET ACC-CHANGE <level> %clalinea | ucn | set %controla1 9 | stanic $1
  ...Leer memo:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Si quieres cambiar el nivel a partir del cual un usuario podra leer los memos enviados al canal pon /msg CHaN LEVELS <#canal> SET MEMO <level> %clalinea | ucn | set %controla1 9 | stanic $1
  ..Auto kick
  ...Añadir AKICK:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Para añadir a alguien a la lista de akick pon /msg CHaN AKICK <#canal> ADD <nick | mascara> <razón>, con esto cada vez que entre ese usuario chan lo banea y lo hecha del canal. %clalinea | ucn | set %controla1 7 | stanic $1
  ...Borrar AKICK:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Borra a un usuario de la lista de akick con /msg CHaN AKICK <#canal> DEL <nick | mascara> %clalinea | ucn | set %controla1 7 | stanic $1
  ...Lista AKICK:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Si quieres ver la lista de akick de un canal usa este comando /msg CHaN AKICK <#canal> LIST %clalinea | ucn | set %controla1 7 | stanic $1
  ..Cancelar registro canal:set %clalinea   | cn1 $1 | say %cn Si quieres eliminar el registro de un canal debes ser el fundador de dicho canal; debe ser dropado por un OPERador de los servicios de red, los encontraras en #opers_help o poniendo /msg CHaN Ircops %clalinea | ucn | set %controla1 8 | stanic $1
  ..Info de canal:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Puedes ver bastante informacion sobre un canal (email, url, topic...) poniendo /msg CHaN INFO <#canal> %clalinea | ucn
  ..Lista canales registrados:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Chan guarda la lista con los canales registrados, puedes verla con /msg CHaN LIST <especificaciones> Listara los canales que coincidan con las especificaciones, pero los canales con la opcion PRIVATE activada no saldrán. %clalinea | ucn
  ..AutoInvitar:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Puedes autoinvitarte a canales en los que estes registrado con cierto nivel, y asi poder entrar cuando el canal esta en solo invitados pon /msg CHaN INVITE <#canal> %clalinea | ucn | set %controla1 7 | stanic $1
  ..OP/DEOP:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Para que 0,2CHaN de op, o quite op, a algun usuario o a ti mismo pon /msg CHaN OP/DEOP <#canal> <nick> %clalinea | ucn | set %controla1 7 | stanic $1
  ..Quitar ban:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Si quieres quitar tu ban de un canal pon /msg CHaN UNBAN <#canal> %clalinea | ucn | set %controla1 7 | stanic $1
  ..Reiniciar canal
  ...Modos:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Para reiniciar los modos de un canal usa /msg CHaN CLEAR <#canal> MODES %testoc %clalinea | ucn | set %controla1 6 | stanic $1
  ...Baneos:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Puedes borrar la lista completa de banes de un canal con /msg CHaN CLEAR <#canal> BANS %testoc %clalinea | ucn | set %controla1 6 | stanic $1
  ...OPS:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Si quieres quitarle a todos el estado de Ops del canal pon /msg CHaN CLEAR <#canal> OPS %testoc %clalinea | ucn | set %controla1 6 | stanic $1
  ...Voz +v:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Para quitarle a todos los usuarios el estado de voz (+) usa /msg CHaN CLEAR <#canal> VOICES %testoc %clalinea | ucn | set %controla1 6 | stanic $1
  ...AKICK:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Para que chan expulse a todos los usuarios del canal pon /msg CHaN CLEAR <#canal> USERS %testoc %clalinea | ucn | set %controla1 6 | stanic $1
  ..Buscar IRCop:dicebott 2 | set %clalinea   | cn1 $1 | say %cn Para encontrar IRCops u OPERS debes poner /msg CHaN IRCOPS Tambien puedes encontrarlos en #Opers_help %clalinea | ucn
  .Ayuda de MeMo
  ..Enviar memo:dicebott 3 | set %clalinea   | cn1 $1 | say %cn Para enviar un MeMo a otro usuario, debeis tener los dos el nick registrado (tambien se puede enviar a un canal) si es asi pon /msg MeMo SEND <nick | #canal> <elmensaje> %clalinea | ucn | set %controla1 5 | stanic $1
  ..Leer memo:dicebott 3 | set %clalinea   | cn1 $1 | say %cn Cuando recibas un memo lo puedes leer poniendo /msg MeMo READ <nº | Last> Eligiendo el nº de memo o con Last para leer el último. %clalinea | ucn | set %controla1 4 | stanic $1
  ..Borrar memo:dicebott 3 | set %clalinea   | cn1 $1 | say %cn Si quieres borrar un memo debes poner /msg MeMo DEL <nº | All> Con nº borras ese numero de memo y con ALL borras todos. %clalinea | ucn | set %controla1 4 | stanic $1
  ..Lista memos:dicebott 3 | set %clalinea   | cn1 $1 | say %cn Puedes ver la lista de memos que tienes con /msg MeMo LIST <NEW> %clalinea | ucn | set %controla1 4 | stanic $1
  ..Opciones memo
  ...Notifica memo:dicebott 3 | set %clalinea   | cn1 $1 | say %cn Si quieres que cada vez que te llegue un memo te avise pon /msg MeMo SET NOTIFY <ON | LOGON | NEW | OFF> %clalinea | ucn | set %controla1 4 | stanic $1
  ...Limite de memos:dicebott 3 | set %clalinea   | cn1 $1 | say %cn Para limitar el nº de memos que puede recibir un canal pon /msg MeMo SET LIMIT <#canal> <límitedememos> %clalinea | ucn | set %controla1 4 | stanic $1
  ..-
  ..Más Ayuda:dicebott 3 | set %clalinea   | cn1 $1 | say %cn Si necesitas más ayuda sobre el bot de mensajeria puedes verla con /msg MeMo HELP %clalinea | ucn | set %controla1 4 | stanic $1

  .Ayuda de CReG
  ..Apoyos
  ...Recibidos (canal): { dicebott 4 | set %clalinea   | cn1 $1
    if (( %cn == $null ) || ( %opcionaddon == OFF )) { set %mennik , asegurate de tener puesto el nick con el que pediste el registro y de estar identificado. }
  say %cn Para saber los apoyos que ha recibido tu canal debes poner /msg CReg APOYOS <#canal> %mennik %clalinea | unset %mennik | ucn | set %controla1 2 | stanic $1 }
  ...Emitidos (nick):dicebott 4 | set %clalinea   | cn1 $1 | say %cn Si quieres saber a que canales has apoyado simplemente pon /msg CReG APOYOS %cn2 , sólo puedes ver los de tu nick. %clalinea | ucn | set %controla1 1 | stanic $1
  ..Estado canal
  ...Ver estado:dicebott 4 | set %clalinea   | cn1 $1 | say %cn Con este comando /msg CReG ESTADO <#canal> puedes ver el estado de un canal %clalinea | ucn
  ...Pendiente:set %clalinea   | cn1 $1 | say %cn 0,2Pendiente El canal no ha recivido todavia los 9 apoyos necesarios. %clalinea | ucn
  ...En Registro:set %clalinea   | cn1 $1 | say %cn 0,2En Registro Los administradores de canales de la red estan revisando si se le concede o no el registro al canal. Suele tardar 1 dia o 2 %clalinea | ucn
  ...Aprobado:set %clalinea   | cn1 $1 | say %cn 0,2Aprobado La peticion de registro a sido aprobada. Ya tienes canal! %clalinea | ucn
  ...Denegado:set %clalinea   | cn1 $1 | say %cn 0,2Denegado La petición de registro a sido denegada, es posible por varias razones. %clalinea | ucn
  ...Registrado:set %clalinea   | cn1 $1 | say %cn 0,2Registrado El canal ya esta actualmente registrado, por lo que no hay posibilidad de registrarlo de nuevo. %clalinea | ucn
  ...Prohibido:set %clalinea   | cn1 $1 | say %cn 0,2Prohibido El canal no se puede registrar debido a que ha sido prohibido por la administración de la red, esto puede ser debido a que el canal incumpla alguna de las normas para registro de canales o que ya estubiese registrado anteriormente pero sus usuarios o temática fueran contra estas normas. %clalinea | ucn
  ...Dropado:set %clalinea   | cn1 $1 | say %cn 0,2Dropado El registro del canal ha sido retirado por la administracion de la red. La causa puede ser la petición del fundador o que inclumpliese alguna norma de la red Hispano. %clalinea | ucn
  ...Sin Registrar:set %clalinea   | cn1 $1 | say %cn 0,2Sin Registrar El canal no esta registrado ni pendiente de registro...Todo a tu disposición. %clalinea | ucn
  ..Y ahora?:set %clalinea   | cn1 $1 | say %cn Después de tener los 9 apoyos debes esperar entre 24 y 48 horas a que revisen si el canal cumple las normas. %clalinea
  ..Apoyar canal:dicebott 4 | set %clalinea   | cn1 $1 | say %cn Para apoyar en el registro de un canal debes poner /msg CReG APOYA <#canal>. Si estas seguro de querer apoyar el canal sigue las instrucciones de 0,2CReG. %clalinea | ucn | set %controla1 3 | stanic $1
  ..-
  ..No me registrarón...
  ...Mal Comportamiento:set %clalinea   | cn1 $1 | say %cn Hay usuarios a los que se les ha negado el registro de canales debido a su reiterado mal comportamiento en la red. A ser buenos 5=12:4þ  %clalinea | ucn
  ...Omisión Descripción:set %clalinea   | cn1 $1 | say %cn Se omitio el dato referido a la descripción del canal, este dato es necesario ya que sin él los usuarios no pueden saber de que tratará el canal.  %clalinea | ucn
  ...Cachondeo Nicks:set %clalinea   | cn1 $1 | say %cn El registro de un canal puede ser rechazado si en los apoyos se encuentran los de varios nicks registrados al mismo email %clalinea | ucn
  ...No hubo apoyos:set %clalinea   | cn1 $1 | say %cn Si anteriormente se pidio el registro de un canal pero no se consiguieron los 9 apoyos en una semana, para poder pedir el registro de ese canal es necesario hablar con un administrador de red, los encontraras poniendo /msg CHaN IRcops o en #Opers_help %clalinea | ucn
  ..No te deja hablarle:set %clalinea   | cn1 $1 | say %cn Si 0,2CReG no te deja abrirle un querry es debido a que no tienes el nick registrado o no lo has autentificado, y para usar el bot 0,2CReG es necesario tenerlo registrado y autentificado. %clalinea | ucn
  ..No puedo apoyar:set %clalinea   | cn1 $1 | say %cn Cada nick puede emitir 1 apoyo cada 24 horas siendo este a un canal distinto cada dia ; /msg CReG APOYOS <nick>, solo puedes ver los apoyos del nick que estas usando %clalinea | ucn
  ..No puedo Registrar:set %clalinea   | cn1 $1 | say %cn 0,2CReG sólo admite 1 registro por nick y dia.  %clalinea | ucn
  ..-
  ..Más ayuda:dicebott 4 | set %clalinea   | cn1 $1 | say %cn Si necesitas más ayuda sobre el registro de canales puedes verla toda poniendo /msg CReG HELP %clalinea | ucn | set %controla1 10 | stanic $1
  .-
  .Registrar Nick:dicebott 1 | set %clalinea   | cn1 $1 | say %cn Pon /msg Nick REGISTER <tuemail>, no cambies la palabra nick es el nombre del bot, se registra el nick que tengas puesto. No son validos email del tipo hotmail o mixmail. %clalinea | ucn | set %nomestado 1 | stanic $1
  .Registrar Canal: { dicebott 4 | set %clalinea   | cn1 $1
    if (( %cn == $null ) || ( %opcionaddon == OFF )) { set %mennick Debes tener el nick registrado }
  say %cn Pon /msg CReG REGISTRA <#canal> <password> <descripción> %mennick Tienes una semana para conseguir 9 apoyos, para que lo apoyen deben poner /msg Creg APOYA <#canal> %clalinea | unset %mennick | ucn | set %controla1 0 | stanic $1 }
  .-
  .Avisos ( %opcionaddon ): {
    if ( %opcionaddon == OFF ) { set %opcionaddon Notice }
    elseif ( %opcionaddon == Canal ) { set %opcionaddon OFF }
  elseif ( %opcionaddon == Notice ) { set %opcionaddon Canal } }
  .Info Addon : addon2
  unset %cn
}
#mirastatus off
on ^*:OPEN:*:STATUS*(*): {
  if ( $nick == NiCK ) {
    if (( %add.noreg isin $1- ) && ( %controla1 == 9 )) { %accadd Solo el fundador del canal puede utilizar estos comandos }
    if (( %add.noreg isin $1- ) && ( %controla1 == 8 )) { %accadd Tu nick no esta registrado no puedes tener un canal }
    if (( %add.noreg isin $1- ) && ( %controla1 == 7 )) { %accadd %testoc Tu nick no esta registrado en el IRC pon /msg NiCK REGISTER <tu@email> y podran registrate en canales }
    if (( %add.noreg isin $1- ) && ( %controla1 == 6 )) { %accadd Tu nick no esta registrado en el IRC pon /msg NiCK REGISTER <tu@email> y podran registrate en canales }
    if (( %add.noreg isin $1- ) && ( %controla1 == 5 )) { %accadd Antes de usar a 0,2MeMo regista tu nick con /msg NiCK REGISTER <tu@email> donde pone nick, deja nick }
    if (( %add.noreg isin $1- ) && ( %controla1 == 4 )) { %accadd Si no tienes el nick registrado no puedes utilizar el bot 0,2MeMo. }
    if (( %add.noreg isin $1- ) && ( %controla1 == 2 )) { %accadd Sólo puedes ver los apoyos con el nick que pediste el registro del canal }
    if (( %add.noreg isin $1- ) && ( %controla1 == 1 )) { %accadd No tienes el nick registrado, no puedes haber dado apoyos }
    if (( %add.noreg isin $1- ) && (( %controla1 == 0 ) || (( %controla1 == 3 ) || ( %controla1 == 10 )))) { %accadd Antes debes registrar tu nick, pon /msg NiCK REGISTER <tu@email> donde pone nick, deja nick }
    if (( %add.noide isin $1- ) && ( %controla1 != 10)) { %accadd Antes identificate con /msg NiCK IDENTIFY <password> }
    if ( %add.susp isin $1- ) { %accadd 4Tienes el nick suspendido, asi no puedes registrar ni apoyar canales }
  }
  gestorgrupo
  set %opensi 1
  halt
}
on ^*:TEXT:STATUS*(*):?: {
  if (( $nick == NiCK ) && ( %opensi == $null )) {
    if (( %add.noreg isin $1- ) && ( %controla1 == 9 )) { %accadd Solo el fundador del canal puede utilizar estos comandos }
    if (( %add.noreg isin $1- ) && ( %controla1 == 8 )) { %accadd Tu nick no esta registrado no puedes tener un canal }
    if (( %add.noreg isin $1- ) && ( %controla1 == 7 )) { %accadd %testoc Tu nick no esta registrado en el IRC pon /msg NiCK REGISTER <tu@email> y podran registrate en canales }
    if (( %add.noreg isin $1- ) && ( %controla1 == 6 )) { %accadd Tu nick no esta registrado en el IRC pon /msg NiCK REGISTER <tu@email> y podran registrate en canales }
    if (( %add.noreg isin $1- ) && ( %controla1 == 5 )) { %accadd Antes de usar a 0,2MeMo regista tu nick con /msg NiCK REGISTER <tu@email> donde pone nick, deja nick }
    if (( %add.noreg isin $1- ) && ( %controla1 == 4 )) { %accadd Si no tienes el nick registrado no puedes utilizar el bot 0,2MeMo. }
    if (( %add.noreg isin $1- ) && ( %controla1 == 2 )) { %accadd Sólo puedes ver los apoyos con el nick que pediste el registro del canal }
    if (( %add.noreg isin $1- ) && ( %controla1 == 1 )) { %accadd No tienes el nick registrado, no puedes haber dado apoyos }
    if (( %add.noreg isin $1- ) && (( %controla1 == 0 ) || (( %controla1 == 3 ) || ( %controla1 == 10 )))) { %accadd Antes debes registrar tu nick, pon /msg NiCK REGISTER <tu@email> donde pone nick, deja nick }
    if (( %add.noide isin $1- ) && ( %controla1 != 10)) { %accadd Antes identificate con /msg NiCK IDENTIFY <password> }
    if ( %add.susp isin $1- ) { %accadd Tienes el nick suspendido, asi no puedes registrar ni apoyar canales }
  }
  gestorgrupo
  unset %niquery %controla1 %canaladdo
  halt
}
gestorgrupo
#mirastatus end
on 1:LOAD: addon2 | testoci

alias addon2 {
  echo -s 15,15·14,14·0,2 Ayuda Irc & Bots add on 14,14·15,15·
  echo -s 2 Versión:12 4.1       Fecha:12 27-06-2000
  echo -s 2 Autor:12 Celsiuss
  echo -s 2 Email:12 Si tienes alguna sugerencia hazmela saber en addon@celsiuss.8m.com
  echo -s 2 Web:12 http://celsiuss.8m.com o www.arede.com/informatica/celsiuss
  echo -s 2 Distribuye libremente este AddOn pero por favor no cambies los datos
  echo -s 2 Puedes encontarme en 7#Ayuda_irc2 del hispano.org
}
