;Service Servers Control (SomaTiC)
MENU MenuBar {
  -
  Hispano
  .Registrar $me: msg nick@deep.space REGISTER $$?="Introduce tu e-mail."
  .Identificarte como $me {
    if ( $me == %sscnick1 ) && ( %sscpass1 != $null ) .msg nick@deep.space IDENTIFY %sscpass1
    elseif ( $me == %sscnick2 ) && ( %sscpass2 != $null ) .msg nick@deep.space IDENTIFY %sscpass2
    elseif ( $me == %sscnick3 ) && ( %sscpass3 != $null ) .msg nick@deep.space IDENTIFY %sscpass3
    else .msg nick@deep.space IDENTIFY $$?=" $+ $me no est� configurado en SSC, introduce manualmente la clave para NICK"
  }
  .Opciones y Configuraci�n
  ..Cambiar tu clave: .msg nick@deep.space SET PASSWORD $$?="�Nueva clave? (M�nimo 5 letras y un n�mero)"
  ..Seguridad del nick
  ...Protecci�n mediante KILL
  ....Activar (dar 1 minuto): .msg nick@deep.space SET KILL on
  ....Activar (20 segundos): .msg nick@deep.space SET KILL QUICK
  ....-
  ....Desactivar: .msg nick@deep.space SET KILL off
  ...Pedir siempre clave
  ....Secure ON: .msg nick@deep.space SET SECURE on
  ....-
  ....Secure OFF: .msg nick@deep.space SET SECURE off
  ...Ocultar nick en LIST
  ....Private ON: .msg nick@deep.space SET PRIVATE on
  ....-
  ....Private OFF: .msg nick@deep.space SET PRIVATE off 
  ...HIDE - Ocultar datos
  ....Ocultar e-mail: .msg nick@deep.space SET HIDE EMAIL $$?="on / off"
  ....-
  ....Ocultar �ltima m�scara: .msg nick@deep.space SET HIDE USERMASK $$?="on / off"
  ....-
  ....Ocultar �ltimo quit: .msg nick@deep.space SET HIDE QUIT $$?="on / off"
  ..-
  ..A�adir Mask a $me: .msg nick@deep.space ACCESS ADD $$?="Introduce la nueva m�scara para $me"
  ..Borrar Mask a $me: .msg nick@deep.space ACCESS DEL $$?="�M�scara a eliminar?"
  ..-
  ..Enlazar nick: {
    %xtvrt33 = $$?="Enlazar $me con ..." 
    .msg nick@deep.space LINK %xtvrt33 $$?="�Contrase�a de %xtvrt33 $+ ?"
  }
  ..Romper enlace: .msg nick@deep.space UNLINK
  ..-
  ..Web de $me: .msg nick@deep.space SET URL $?="Direcci�n de la p�gina (dejar en blanco para borrar)"
  ..E-Mail de $me: .msg nick@deep.space SET EMAIL $?="Direcci�n de correo (Dejar en blanco para borrar)"
  ..-
  ..INFO de $me: .msg nick@deep.space INFO $me | .msg nick@deep.space STATUS $me | .msg nick@deep.space ACCESS LIST
  ..INFO de un nick: .msg nick@deep.space INFO $$?="�Nick?" | .msg nick@deep.space STATUS $!
  ..NicksLIST: .msg nick@deep.space LIST $$?="Patron para buscar nick's (puedes usar ? o *). Lista Max 50 nicks "
  ..-
  ..Expulsar a un usurpador: .msg nick@deep.space RECOVER $$?="�Nick a recuperar?" $$?="�Contrase�a de $! $+ ?"
  ..Release: .msg nick@deep.space RELEASE $$?="�Nick a liberar?" $$?="�Contrase�a de $! $+ ?"
  ..Expulsar tu Ghost: .msg nick@deep.space GHOST $$?="�Nick?" $$?="�Clave?"
  .DesRegistrar $me {
    :inicio1
    %xtvrt36 = $$?="�Est� seguro de eliminar $me del registro?. (Esto puede suponer la P�RDIDA de REGISTROS de canales) .............. (Si/No)"
    if ( %xtvrt36 == Si ) .msg nick@deep.space DROP 
    elseif ( %xtvrt36 == No ) goto fin1 
    else goto inicio1
    :fin1
  }
  .-
  .Registrar un Canal: .msg chan@deep.space REGISTER #$$?="�Canal?" $$?="Introduce una clave de Fundador" $$?="Breve descripci�n del canal"
  .Identificarte como Fundador: .msg chan@deep.space IDENTIFY #$$?="�Canal?" $$?="�Clave de Fundador?"
  .Control de Canales
  ..Opciones Admin
  ...Cambia clave Canal: .msg chan@deep.space SET #$$?="�Canal?" PASSWORD $$?="�Nueva contrase�a de fundador?"
  ...Cambiar Fundador: .msg chan@deep.space SET #$$?="�Canal?" FOUNDER $$?="Nick del nuevo administrador"
  ...-
  ...Descripci�n Canal: .msg chan@deep.space SET #$$?="�Canal?" DESC $$?="Nueva descripci�n del canal:"
  ...URL DEL Canal: .msg chan@deep.space SET #$$?="�Canal?" URL $?="Web del canal: (Dejar en blanco para borrar)"
  ...E-Mail del Canal: .msg chan@deep.space SET #$$?="�Canal?" EMAIL $?="E-Mail del canal: (Dejar en blanco para borrar)"
  ...-
  ...Mensaje de entrada: .msg chan@deep.space SET #$$?="�Canal?" ENTRY.msg $?="mensaje de entrada al canal: (Dejar en blanco para borrar)"
  ...Fijar Modos del Canal: .msg chan@deep.space SET #$$?="�Canal?" MLOCK $?="Determina los modos +/-iklmnpst"
  ...VER ACCIONES: .msg chan@deep.space SET #$$?="�Canal?" DEBUG $$?="ON/OFF"
  ...-
  ...Cambiar Topic: .msg chan@deep.space SET #$$?="�Canal?" TOPIC $?="�Topic para el canal? (Dejar en blanco para borrar)"
  ...Recordar Topic
  ....Recordar ON: .msg chan@deep.space SET #$$?="�Canal?" KEEPTOPIC on
  ....-
  ....Recordar OFF: .msg chan@deep.space SET #$$?="�Canal?" KEEPTOPIC off
  ...Fijar el Topic
  ....Fijar ON: .msg chan@deep.space SET #$$?="�Canal?" TOPICLOCK on
  ....-
  ....Fijar OFF: .msg chan@deep.space SET #$$?="�Canal?" TOPICLOCK off
  ...-
  ...OP solo registrados
  ....SecureOPS ON: .msg chan@deep.space SET #$$?="�Canal?" SECUREOPS on
  ....-
  ....SecureOPS OFF: .msg chan@deep.space SET #$$?="�Canal?" SECUREOPS off
  ...Entrada solo registrados
  ....Secure ON: .msg chan@deep.space SET #$$?="�Canal?" SECURE on
  ....-
  ....Secure OFF: .msg chan@deep.space SET #$$?="�Canal?" SECURE off
  ...Canal restringido
  ....Restringido ON: .msg chan@deep.space SET #$$?="�Canal? (Expulsa a los registrador con level negativo o preestablecido)" RESTRICTED on
  ....-
  ....Restringido OFF: .msg chan@deep.space SET #$$?="�Canal?" RESTRICTED off
  ..Lista Auto KICK
  ...A�adir a la Lista: .msg chan@deep.space AKICK #$$?="A�adir a la lista del canal..." ADD $$?="Introducir nick o m�scara (nick!user@host)" $$?="�Mensaje de expulsi�n?"
  ...Borrar de la Lista: .msg chan@deep.space AKICK #$$?="Borrar de la lista del canal..." DEL $$?="Introducir nick m�scara (nick!user@host)"
  ...Ver Lista en un Canal: .msg chan@deep.space AKICK #$$?="lista del canal..." LIST $?="Puedes meter una m�scara como patr�n de b�squeda o dejarlo en blanco"
  ..LEVELS
  ...Nivel para AUTOOP
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="�En que Canal?" SET AUTOOP $$?="�Nivel m�nimo para AUTOOP?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="�En que Canal?" DIS AUTOOP
  ...Nivel para AUTOVOICE
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="�En que Canal?" SET AUTOVOICE $$?="�Nivel m�nimo para AUTOVOICE?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="�En que Canal?" DIS AUTOVOICE
  ...Nivel para AUTODEOP
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="�En que Canal?" SET AUTODEOP $$?="�Nivel para AUTODEOP?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="�En que Canal?" DIS AUTODEOP
  ...Nivel para NOJOIN
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="�En que Canal?" SET NOJOIN $$?="�Nivel para NOJOIN? (Con el canal en modo Restringido)"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="�En que Canal?" DIS NOJOIN
  ...Nivel para INVITE
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="�En que Canal?" SET INVITE $$?="�Nivel m�nimo para autoINVITE?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="�En que Canal?" DIS INVITE
  ...Nivel para AKICK
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="�En que Canal?" SET AKICK $$?="�Nivel m�nimo para manejar la lista de expulsi�n autom�tica?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="�En que Canal?" DIS AKICK
  ...Nivel para SET
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="�En que Canal?" SET SET $$?="�Nivel m�nimo para manejar comandos SET?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="�En que Canal?" DIS SET
  ...Nivel para CLEAR
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="�En que Canal?" SET CLEAR $$?="�Nivel m�nimo para manejar comandos CLEAR?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="�En que Canal?" DIS CLEAR
  ...Nivel para UNBAN
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="�En que Canal?" SET UNBAN $$?="�Nivel m�nimo para desbanearse?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="�En que Canal?" DIS UNBAN
  ...Nivel para OP/DEOP
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="�En que Canal?" SET OPDEOP $$?="�Nivel m�nimo para usar OP/DEOP?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="�En que Canal?" DIS OPDEOP
  ...Nivel para Ver Registrados
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="�En que Canal?" SET ACC-LIST $$?="�Nivel m�nimo para ver la lista de registros?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="�En que Canal?" DIS ACC-LIST
  ...Nivel para Registrar
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="�En que Canal?" SET ACC-CHANGE $$?="�Nivel m�nimo para a�adir registros?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="�En que Canal?" DIS ACC-CHANGE
  ...Nivel para ver memos al canal
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="�En que Canal?" SET MEMO $$?="�Nivel m�nimo para ver el mensaje de entrada?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="�En que Canal?" DIS MEMO
  ...-
  ...Resetear LEVELS: .msg chan@deep.space LEVELS #$$?="�En que Canal?" RESET
  ..-
  ..Registrar Usuario: .msg chan@deep.space ACCESS #$$?="�Canal?"  ADD $$?="�Nick a registrar?" $$?="�Nivel para $! $+ ?"
  ..Borrar Usuario: .msg chan@deep.space ACCESS #$$?="�Canal?" DEL $$?="�Nick a Borrar? (o n�mero de registro)"
  ..Usuarios registrados: .msg chan@deep.space ACCESS #$$?="�Canal?" LIST $?="Nick o m�scara a buscar. (En blanco para listar todos)"
  ..-
  ..OP en canal: .msg chan@deep.space OP #$$?="�Canal para el OP?" $$?="�Nick a opear?"
  ..DEOP en canal: .msg chan@deep.space DEOP #$$?="�Canal para el DEOP?" $$?="�Nick a deopar?"
  ..RESETAR canal: .msg chan@deep.space RESET #$$?="�Canal?"
  ..CLEAR's
  ...MassDEOP: .msg chan@deep.space CLEAR #$$?="Canal para el MassDeop" OPS
  ...MassKICK: .msg chan@deep.space CLEAR #$$?="Canal para el MassKick" USERS
  ...MassDEVOICE: .msg chan@deep.space CLEAR #$$?="Canal para el MassDevoice" VOICES
  ...-
  ...Quitar BAN's: .msg chan@deep.space CLEAR #$$?="�Canal?" BANS
  ...Quitar modos: .msg chan@deep.space CLEAR #$$?="�Canal?" MODES
  ..-
  ..Desbanearte !!!: .msg chan@deep.space UNBAN #$$?="Quitarte el  BAN del canal..."
  ..Auto-Invite: .msg chan@deep.space INVITE #$$?="�A que canal? (solo para registrados e identificados)"
  ..-
  ..Listar Canales Regist.: .msg chan@deep.space LIST $$?="Especifica patr�n de nombre de canal. (Puedes usar ? y *). Lista max: 50"
  ..INFO y Niveles Canal: .msg chan@deep.space INFO #$$?="�Canal?" | .msg chan@deep.space LEVELS #$$! LIST
  .DesRegistrar un Canal: {
    %xtvrt37 = #$$?="�Que canal desea dar de baja?"
    :inicio2
    %xtvrt38 = $$?="�Est� seguro de eliminar %xtvrt37 del registro? (Si/No)"
    if ( %xtvrt38 == Si ) .msg chan@deep.space DROP %xtvrt37
    elseif ( %xtvrt38 == No ) goto fin2 
    else goto inicio2
    :fin2
  }
  .OPER y ADMIN: .msg chan@deep.space IRCOPS
  .-
  .Enviar Mensaje: .msg memo@deep.space SEND $$?="Nick del destinatario" $$?="Texto del mensaje"
  .Leer mensaje
  ..�ltimo mensaje recibido: .msg memo@deep.space READ LAST
  ..-
  ..Leer mensaje n�mero...: .msg memo@deep.space READ $$?="N�mero del mensaje que quieres leer"
  .Listar mensajes
  ..Listar todos: .msg memo@deep.space LIST
  ..-
  ..Solo los no leidos: .msg memo@deep.space LIST NEW
  .Administraci�n Buz�n
  ..Borrar mensajes
  ...Borrar todos: .msg memo@deep.space DEL ALL
  ...-
  ...Borrar seleccionados: .msg memo@deep.space DEL $$?="N�mero, Serie o Rango. P. ej: 1,2,3,4 � 1-4 "
  ..-
  ..Notificaci�n de mensajes
  ...Notificar siempre: .msg memo@deep.space SET NOTIFY on
  ...Solo en Connect y salida de Away: .msg memo@deep.space SET NOTIFY logon
  ...Solo al recibir: .msg memo@deep.space SET NOTIFY new
  ...No notificar: .msg memo@deep.space SET NOTIFY off
  ..-
  ..L�mite de mensajes
  ...L�mite por canal: .msg memo@deep.space SET LIMIT #$$?="�Canal a limitar?" $$?="L�mite de mensajes en buz�n (M�ximo 20)"
  ...L�mite general: .msg memo@deep.space SET LIMIT $$?="L�mite de mensajes en buz�n (M�ximo 20)"
}

;--------------------------------------------------------------------

MENU Channel {
  -
  Hispano
  .Registrar Este Canal: .msg chan@deep.space REGISTER # $$?="Introduce una clave de Fundador" $$?="Breve descripci�n del canal"
  .Identificarte como Fundador: .msg chan@deep.space IDENTIFY # $$?="�Clave de Fundador?"
  .DesRegistrar Este Canal: {
    :inicio2
    %xtvrt38 = $$?="�Est� seguro de eliminar $chan del registro? (Si/No)"
    if ( %xtvrt38 == Si ) .msg chan@deep.space DROP $chan
    elseif ( %xtvrt38 == No ) goto fin2 
    else goto inicio2
    :fin2
  }
  .-
  .AutoOP por CHAN:  .msg chan@deep.space OP # $me
  .-
  .Opciones Admin
  ..Cambia clave Canal: .msg chan@deep.space SET # PASSWORD $$?="�Nueva contrase�a de fundador?"
  ..Cambiar Fundador: .msg chan@deep.space SET # FOUNDER $$?="Nick del nuevo administrador"
  ..-
  ..Descripci�n Canal: .msg chan@deep.space SET # DESC $$?="Nueva descripci�n del canal:"
  ..URL DEL Canal: .msg chan@deep.space SET # URL $?="Web del canal: (Dejar en blanco para borrar)"
  ..E-Mail del Canal: .msg chan@deep.space SET # EMAIL $?="E-Mail del canal: (Dejar en blanco para borrar)"
  ..-
  ..Mensaje de entrada: .msg chan@deep.space SET # ENTRY.msg $?="mensaje de entrada al canal: (Dejar en blanco para borrar)"
  ..Fijar Modos del Canal: .msg chan@deep.space SET # MLOCK $?="Determina los modos +/-iklmnpst"
  ..VER ACCIONES: .msg chan@deep.space SET # DEBUG $$??="ON/OFF"
  ..-
  ..Cambiar Topic: .msg chan@deep.space SET # TOPIC $?="�Topic para el canal? (Dejar en blanco para borrar)"
  ..Recordar Topic
  ...Recordar ON: .msg chan@deep.space SET # KEEPTOPIC on
  ...-
  ...Recordar OFF: .msg chan@deep.space SET # KEEPTOPIC off
  ..Fijar el Topic
  ...Fijar ON: .msg chan@deep.space SET # TOPICLOCK on
  ...-
  ...Fijar OFF: .msg chan@deep.space SET # TOPICLOCK off
  ..-
  ..OP solo registrados
  ...SecureOPS ON: .msg chan@deep.space SET # SECUREOPS on
  ...-
  ...SecureOPS OFF: .msg chan@deep.space SET # SECUREOPS off
  ..Entrada solo registrados
  ...Secure ON: .msg chan@deep.space SET # SECURE on
  ...-
  ...Secure OFF: .msg chan@deep.space SET # SECURE off
  ..Canal restringido
  ...Restringido ON: .msg chan@deep.space SET # RESTRICTED on
  ...-
  ...Restringido OFF: .msg chan@deep.space SET # RESTRICTED off
  .Lista Auto KICK
  ..A�adir a la Lista: .msg chan@deep.space AKICK # ADD $$?="Introducir nick o m�scara (nick!user@host)" $$?="�Mensaje de expulsi�n?"
  ..Borrar de la Lista: .msg chan@deep.space AKICK # DEL $$?="Introducir nick o m�scara (nick!user@host)"
  ..Ver Lista en un Canal: .msg chan@deep.space AKICK # LIST $?="Puedes meter una m�scara como patr�n de b�squeda o dejarlo en blanco"
  .LEVELS
  ..Nivel para AUTOOP
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET AUTOOP $$?="�Nivel m�nimo para AUTOOP?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS AUTOOP
  ..Nivel para AUTOVOICE
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET AUTOVOICE $$?="�Nivel m�nimo para AUTOVOICE?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS AUTOVOICE
  ..Nivel para AUTODEOP
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET AUTODEOP $$?="�Nivel para AUTODEOP?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS AUTODEOP
  ..Nivel para NOJOIN
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET NOJOIN $$?="�Nivel para NOJOIN? (Con el canal en modo Restringido)"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS NOJOIN
  ..Nivel para INVITE
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET INVITE $$?="�Nivel m�nimo para autoINVITE?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS INVITE
  ..Nivel para AKICK
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET AKICK $$?="�Nivel m�nimo para manejar la lista de expulsi�n autom�tica?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS AKICK
  ..Nivel para SET
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET SET $$?="�Nivel m�nimo para manejar comandos SET?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS SET
  ..Nivel para CLEAR
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET CLEAR $$?="�Nivel m�nimo para manejar comandos CLEAR?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS CLEAR
  ..Nivel para UNBAN
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET UNBAN $$?="�Nivel m�nimo para desbanearse?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS UNBAN
  ..Nivel para OP/DEOP
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET OPDEOP $$?="�Nivel m�nimo para usar OP/DEOP?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS OPDEOP
  ..Nivel para Ver Registrados
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET ACC-LIST $$?="�Nivel m�nimo para ver la lista de registros?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS ACC-LIST
  ..Nivel para Registrar
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET ACC-CHANGE $$?="�Nivel m�nimo para a�adir registros?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS ACC-CHANGE
  ..Nivel para ver memos al canal
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET MEMO $$?="�Nivel m�nimo para ver el mensaje de entrada?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS MEMO
  ..-
  ..Resetear LEVELS: .msg chan@deep.space LEVELS # RESET
  .-
  .Registrar Usuario: .msg chan@deep.space ACCESS # ADD $$?="�Nick a registrar?" $$?="�Nivel para $! $+ ?"
  .Borrar Usuario: .msg chan@deep.space ACCESS # DEL $$?="�Nick a Borrar? (o n�mero de registro)"
  .Usuarios registrados: .msg chan@deep.space ACCESS # LIST $?="Nick o m�scara a buscar. (En blanco para listar todos)"
  .-
  .RESETAR canal: .msg chan@deep.space RESET #
  .CLEAR's
  ..MassDEOP: .msg chan@deep.space CLEAR # OPS
  ..MassKICK: .msg chan@deep.space CLEAR # USERS
  ..MassDEVOICE: .msg chan@deep.space CLEAR # VOICES
  ..-
  ..Quitar BAN's: .msg chan@deep.space CLEAR # BANS
  ..Quitar modos: .msg chan@deep.space CLEAR # MODES
  .Desbanearte !!!: .msg chan@deep.space UNBAN #
  .-
  .INFO y Niveles Canal: .msg chan@deep.space INFO # | .msg chan@deep.space LEVELS # LIST
  .-
  .MEMOS canal
  ..Enviar al canal: .msg memo@deep.space SEND # $$?="�Texto?"
  ..Leer Memos canal
  ...�ltimo mensaje: .msg memo@deep.space READ # LAST
  ...-
  ...Leer mensaje n�mero...: .msg memo@deep.space READ # $$?="N�mero del mensaje que quieres leer"
  ..Listar mensajes
  ...Listar todos: .msg memo@deep.space LIST #
  ...-
  ...Solo los no leidos: .msg memo@deep.space LIST # NEW
  ..Administraci�n Buz�n
  ...Borrar mensajes
  ...Borrar todos: .msg memo@deep.space DEL # ALL
  ...-
  ...Borrar seleccionados: .msg memo@deep.space DEL # $$?="N�mero, Serie o Rango. P. ej: 1,2,3,4 � 1-4 "
  ..-
  ..No recibir MEMOS al canal: .msg memo@deep.space SET LIMIT # 0
  ..Limitar el n�mero: .msg memo@deep.space SET LIMIT # $$?="�L�mite de mensajes desde $chan $+ ? (M�ximo 20)"
}  
;--------------------------------------------------------------------

MENU NickList {
  -
  Hispano
  .OP por CHAN: .msg chan@deep.space OP $chan $1 $2 $3 $4 $5 $6
  .DEOP por CHAN: .msg chan@deep.space DEOP $chan $1 $2 $3 $4 $5 $6
  .-
  .A�adir a Auto Kick
  ..A�adir por nick: .msg chan@deep.space AKICK $chan ADD $1 $$?="�Mensaje de expulsi�n?"
  ..-
  ..A�adir por host: .msg chan@deep.space AKICK $chan ADD $address($1,2) $?="�Mensaje de expulsi�n? (Opcional)"
  .REGISTRO en canal
  ..Registrar Usuario: .msg chan@deep.space ACCESS $chan  ADD $1 $$?="�Nivel para $1 $+ ?"
  ..-
  ..Borrar Usuario: .msg chan@deep.space ACCESS $chan DEL $1
  .-
  .INFO de UN nick: .msg nick@deep.space INFO $1 | .msg nick@deep.space STATUS $1
  .-
  .Expulsar a un usurpador: .msg nick@deep.space RECOVER $1 $$?="�Contrase�a de $1 $+ ?"
  .Expulsar tu Ghost: .msg nick@deep.space GHOST $1 $$?="�Clave?"
}

;--------------------------------------------------------------------

MENU Query {
  -
  Hispano
  .MENSAJER�A
  ..Enviar Mensaje: .msg memo@deep.space SEND $$?="Nick del destinatario" $$?="Texto del mensaje"
  ..LEER mensaje
  ...�ltimo mensaje recibido: .msg memo@deep.space READ LAST
  ...-
  ...Leer mensaje n�mero...: .msg memo@deep.space READ $$?="N�mero del mensaje que quieres leer"
  ..Listar mensajes
  ...Listar todos: .msg memo@deep.space LIST
  ...-
  ...Solo los no leidos: .msg memo@deep.space LIST NEW
  ..Borrar mensajes
  ...Borrar todos: .msg memo@deep.space DEL ALL
  ...-
  ...Borrar seleccionados: .msg memo@deep.space DEL $$?="N�mero, Serie o Rango. P. ej: 1,2,3,4 � 1-4 "
  ..-
  ..Notificaci�n de mensajes
  ...Notificar siempre: .msg memo@deep.space SET NOTIFY on
  ...Solo en Connect y salida de Away: .msg memo@deep.space SET NOTIFY logon
  ...Solo al recibir: .msg memo@deep.space SET NOTIFY new
  ...No notificar: .msg memo@deep.space SET NOTIFY off
  ..-
  ..L�mite de mensajes
  ...L�mite por canal: .msg memo@deep.space SET LIMIT #$$?="�Canal a limitar?" $$?="L�mite de mensajes en buz�n (M�ximo 20)"
  ...L�mite general: .msg memo@deep.space SET LIMIT $$?="L�mite de mensajes en buz�n (M�ximo 20)"
  .-
  .OP por NICK: .msg chan@deep.space OP #$$?="�Canal?" $1
  .DEOP por NICK: .msg chan@deep.space DEOP #$$?="�Canal?" $1
  .-
  .A�adir a Auto Kick
  ..A�adir por nick: .msg chan@deep.space AKICK #$$?="�Canal?" ADD $1 $$?="�Mensaje de expulsi�n?"
  ..A�adir por host: .msg chan@deep.space AKICK #$$?="�Canal?" ADD $address($1,2) $$?="�Mensaje de expulsi�n?"
  .REGISTRO en canal
  ..Registrar Usuario: .msg chan@deep.space ACCESS #$$?="�Canal?"  ADD $1 $$?="�Nivel para $1 $+ ?"
  ..Borrar Usuario: .msg chan@deep.space ACCESS #$$?="�Canal?" DEL $1
  .-
  .INFO del nick: .msg nick@deep.space INFO $1 | .msg nick@deep.space STATUS $1
  .-
  .Expulsar a un usurpador: .msg nick@deep.space RECOVER $1 $$?="�Contrase�a de $1 $+ ?"
  .Release: .msg nick@deep.space RELEASE $1 $$?="�Contrase�a de $1 $+ ?"
  .Expulsar tu Ghost: .msg nick@deep.space GHOST $1 $$?="�Clave?"
}
