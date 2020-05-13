;Service Servers Control (SomaTiC)
MENU MenuBar {
  -
  Hispano
  .Registrar $me: msg nick@deep.space REGISTER $$?="Introduce tu e-mail."
  .Identificarte como $me {
    if ( $me == %sscnick1 ) && ( %sscpass1 != $null ) .msg nick@deep.space IDENTIFY %sscpass1
    elseif ( $me == %sscnick2 ) && ( %sscpass2 != $null ) .msg nick@deep.space IDENTIFY %sscpass2
    elseif ( $me == %sscnick3 ) && ( %sscpass3 != $null ) .msg nick@deep.space IDENTIFY %sscpass3
    else .msg nick@deep.space IDENTIFY $$?=" $+ $me no está configurado en SSC, introduce manualmente la clave para NICK"
  }
  .Opciones y Configuración
  ..Cambiar tu clave: .msg nick@deep.space SET PASSWORD $$?="¿Nueva clave? (Mínimo 5 letras y un número)"
  ..Seguridad del nick
  ...Protección mediante KILL
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
  ....Ocultar última máscara: .msg nick@deep.space SET HIDE USERMASK $$?="on / off"
  ....-
  ....Ocultar último quit: .msg nick@deep.space SET HIDE QUIT $$?="on / off"
  ..-
  ..Añadir Mask a $me: .msg nick@deep.space ACCESS ADD $$?="Introduce la nueva máscara para $me"
  ..Borrar Mask a $me: .msg nick@deep.space ACCESS DEL $$?="¿Máscara a eliminar?"
  ..-
  ..Enlazar nick: {
    %xtvrt33 = $$?="Enlazar $me con ..." 
    .msg nick@deep.space LINK %xtvrt33 $$?="¿Contraseña de %xtvrt33 $+ ?"
  }
  ..Romper enlace: .msg nick@deep.space UNLINK
  ..-
  ..Web de $me: .msg nick@deep.space SET URL $?="Dirección de la página (dejar en blanco para borrar)"
  ..E-Mail de $me: .msg nick@deep.space SET EMAIL $?="Dirección de correo (Dejar en blanco para borrar)"
  ..-
  ..INFO de $me: .msg nick@deep.space INFO $me | .msg nick@deep.space STATUS $me | .msg nick@deep.space ACCESS LIST
  ..INFO de un nick: .msg nick@deep.space INFO $$?="¿Nick?" | .msg nick@deep.space STATUS $!
  ..NicksLIST: .msg nick@deep.space LIST $$?="Patron para buscar nick's (puedes usar ? o *). Lista Max 50 nicks "
  ..-
  ..Expulsar a un usurpador: .msg nick@deep.space RECOVER $$?="¿Nick a recuperar?" $$?="¿Contraseña de $! $+ ?"
  ..Release: .msg nick@deep.space RELEASE $$?="¿Nick a liberar?" $$?="¿Contraseña de $! $+ ?"
  ..Expulsar tu Ghost: .msg nick@deep.space GHOST $$?="¿Nick?" $$?="¿Clave?"
  .DesRegistrar $me {
    :inicio1
    %xtvrt36 = $$?="¿Está seguro de eliminar $me del registro?. (Esto puede suponer la PÉRDIDA de REGISTROS de canales) .............. (Si/No)"
    if ( %xtvrt36 == Si ) .msg nick@deep.space DROP 
    elseif ( %xtvrt36 == No ) goto fin1 
    else goto inicio1
    :fin1
  }
  .-
  .Registrar un Canal: .msg chan@deep.space REGISTER #$$?="¿Canal?" $$?="Introduce una clave de Fundador" $$?="Breve descripción del canal"
  .Identificarte como Fundador: .msg chan@deep.space IDENTIFY #$$?="¿Canal?" $$?="¿Clave de Fundador?"
  .Control de Canales
  ..Opciones Admin
  ...Cambia clave Canal: .msg chan@deep.space SET #$$?="¿Canal?" PASSWORD $$?="¿Nueva contraseña de fundador?"
  ...Cambiar Fundador: .msg chan@deep.space SET #$$?="¿Canal?" FOUNDER $$?="Nick del nuevo administrador"
  ...-
  ...Descripción Canal: .msg chan@deep.space SET #$$?="¿Canal?" DESC $$?="Nueva descripción del canal:"
  ...URL DEL Canal: .msg chan@deep.space SET #$$?="¿Canal?" URL $?="Web del canal: (Dejar en blanco para borrar)"
  ...E-Mail del Canal: .msg chan@deep.space SET #$$?="¿Canal?" EMAIL $?="E-Mail del canal: (Dejar en blanco para borrar)"
  ...-
  ...Mensaje de entrada: .msg chan@deep.space SET #$$?="¿Canal?" ENTRY.msg $?="mensaje de entrada al canal: (Dejar en blanco para borrar)"
  ...Fijar Modos del Canal: .msg chan@deep.space SET #$$?="¿Canal?" MLOCK $?="Determina los modos +/-iklmnpst"
  ...VER ACCIONES: .msg chan@deep.space SET #$$?="¿Canal?" DEBUG $$?="ON/OFF"
  ...-
  ...Cambiar Topic: .msg chan@deep.space SET #$$?="¿Canal?" TOPIC $?="¿Topic para el canal? (Dejar en blanco para borrar)"
  ...Recordar Topic
  ....Recordar ON: .msg chan@deep.space SET #$$?="¿Canal?" KEEPTOPIC on
  ....-
  ....Recordar OFF: .msg chan@deep.space SET #$$?="¿Canal?" KEEPTOPIC off
  ...Fijar el Topic
  ....Fijar ON: .msg chan@deep.space SET #$$?="¿Canal?" TOPICLOCK on
  ....-
  ....Fijar OFF: .msg chan@deep.space SET #$$?="¿Canal?" TOPICLOCK off
  ...-
  ...OP solo registrados
  ....SecureOPS ON: .msg chan@deep.space SET #$$?="¿Canal?" SECUREOPS on
  ....-
  ....SecureOPS OFF: .msg chan@deep.space SET #$$?="¿Canal?" SECUREOPS off
  ...Entrada solo registrados
  ....Secure ON: .msg chan@deep.space SET #$$?="¿Canal?" SECURE on
  ....-
  ....Secure OFF: .msg chan@deep.space SET #$$?="¿Canal?" SECURE off
  ...Canal restringido
  ....Restringido ON: .msg chan@deep.space SET #$$?="¿Canal? (Expulsa a los registrador con level negativo o preestablecido)" RESTRICTED on
  ....-
  ....Restringido OFF: .msg chan@deep.space SET #$$?="¿Canal?" RESTRICTED off
  ..Lista Auto KICK
  ...Añadir a la Lista: .msg chan@deep.space AKICK #$$?="Añadir a la lista del canal..." ADD $$?="Introducir nick o máscara (nick!user@host)" $$?="¿Mensaje de expulsión?"
  ...Borrar de la Lista: .msg chan@deep.space AKICK #$$?="Borrar de la lista del canal..." DEL $$?="Introducir nick máscara (nick!user@host)"
  ...Ver Lista en un Canal: .msg chan@deep.space AKICK #$$?="lista del canal..." LIST $?="Puedes meter una máscara como patrón de búsqueda o dejarlo en blanco"
  ..LEVELS
  ...Nivel para AUTOOP
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" SET AUTOOP $$?="¿Nivel mínimo para AUTOOP?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" DIS AUTOOP
  ...Nivel para AUTOVOICE
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" SET AUTOVOICE $$?="¿Nivel mínimo para AUTOVOICE?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" DIS AUTOVOICE
  ...Nivel para AUTODEOP
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" SET AUTODEOP $$?="¿Nivel para AUTODEOP?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" DIS AUTODEOP
  ...Nivel para NOJOIN
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" SET NOJOIN $$?="¿Nivel para NOJOIN? (Con el canal en modo Restringido)"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" DIS NOJOIN
  ...Nivel para INVITE
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" SET INVITE $$?="¿Nivel mínimo para autoINVITE?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" DIS INVITE
  ...Nivel para AKICK
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" SET AKICK $$?="¿Nivel mínimo para manejar la lista de expulsión automática?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" DIS AKICK
  ...Nivel para SET
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" SET SET $$?="¿Nivel mínimo para manejar comandos SET?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" DIS SET
  ...Nivel para CLEAR
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" SET CLEAR $$?="¿Nivel mínimo para manejar comandos CLEAR?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" DIS CLEAR
  ...Nivel para UNBAN
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" SET UNBAN $$?="¿Nivel mínimo para desbanearse?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" DIS UNBAN
  ...Nivel para OP/DEOP
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" SET OPDEOP $$?="¿Nivel mínimo para usar OP/DEOP?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" DIS OPDEOP
  ...Nivel para Ver Registrados
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" SET ACC-LIST $$?="¿Nivel mínimo para ver la lista de registros?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" DIS ACC-LIST
  ...Nivel para Registrar
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" SET ACC-CHANGE $$?="¿Nivel mínimo para añadir registros?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" DIS ACC-CHANGE
  ...Nivel para ver memos al canal
  ....Establecer nivel: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" SET MEMO $$?="¿Nivel mínimo para ver el mensaje de entrada?"
  ....-
  ....Desactivar: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" DIS MEMO
  ...-
  ...Resetear LEVELS: .msg chan@deep.space LEVELS #$$?="¿En que Canal?" RESET
  ..-
  ..Registrar Usuario: .msg chan@deep.space ACCESS #$$?="¿Canal?"  ADD $$?="¿Nick a registrar?" $$?="¿Nivel para $! $+ ?"
  ..Borrar Usuario: .msg chan@deep.space ACCESS #$$?="¿Canal?" DEL $$?="¿Nick a Borrar? (o número de registro)"
  ..Usuarios registrados: .msg chan@deep.space ACCESS #$$?="¿Canal?" LIST $?="Nick o máscara a buscar. (En blanco para listar todos)"
  ..-
  ..OP en canal: .msg chan@deep.space OP #$$?="¿Canal para el OP?" $$?="¿Nick a opear?"
  ..DEOP en canal: .msg chan@deep.space DEOP #$$?="¿Canal para el DEOP?" $$?="¿Nick a deopar?"
  ..RESETAR canal: .msg chan@deep.space RESET #$$?="¿Canal?"
  ..CLEAR's
  ...MassDEOP: .msg chan@deep.space CLEAR #$$?="Canal para el MassDeop" OPS
  ...MassKICK: .msg chan@deep.space CLEAR #$$?="Canal para el MassKick" USERS
  ...MassDEVOICE: .msg chan@deep.space CLEAR #$$?="Canal para el MassDevoice" VOICES
  ...-
  ...Quitar BAN's: .msg chan@deep.space CLEAR #$$?="¿Canal?" BANS
  ...Quitar modos: .msg chan@deep.space CLEAR #$$?="¿Canal?" MODES
  ..-
  ..Desbanearte !!!: .msg chan@deep.space UNBAN #$$?="Quitarte el  BAN del canal..."
  ..Auto-Invite: .msg chan@deep.space INVITE #$$?="¿A que canal? (solo para registrados e identificados)"
  ..-
  ..Listar Canales Regist.: .msg chan@deep.space LIST $$?="Especifica patrón de nombre de canal. (Puedes usar ? y *). Lista max: 50"
  ..INFO y Niveles Canal: .msg chan@deep.space INFO #$$?="¿Canal?" | .msg chan@deep.space LEVELS #$$! LIST
  .DesRegistrar un Canal: {
    %xtvrt37 = #$$?="¿Que canal desea dar de baja?"
    :inicio2
    %xtvrt38 = $$?="¿Está seguro de eliminar %xtvrt37 del registro? (Si/No)"
    if ( %xtvrt38 == Si ) .msg chan@deep.space DROP %xtvrt37
    elseif ( %xtvrt38 == No ) goto fin2 
    else goto inicio2
    :fin2
  }
  .OPER y ADMIN: .msg chan@deep.space IRCOPS
  .-
  .Enviar Mensaje: .msg memo@deep.space SEND $$?="Nick del destinatario" $$?="Texto del mensaje"
  .Leer mensaje
  ..Último mensaje recibido: .msg memo@deep.space READ LAST
  ..-
  ..Leer mensaje número...: .msg memo@deep.space READ $$?="Número del mensaje que quieres leer"
  .Listar mensajes
  ..Listar todos: .msg memo@deep.space LIST
  ..-
  ..Solo los no leidos: .msg memo@deep.space LIST NEW
  .Administración Buzón
  ..Borrar mensajes
  ...Borrar todos: .msg memo@deep.space DEL ALL
  ...-
  ...Borrar seleccionados: .msg memo@deep.space DEL $$?="Número, Serie o Rango. P. ej: 1,2,3,4 ó 1-4 "
  ..-
  ..Notificación de mensajes
  ...Notificar siempre: .msg memo@deep.space SET NOTIFY on
  ...Solo en Connect y salida de Away: .msg memo@deep.space SET NOTIFY logon
  ...Solo al recibir: .msg memo@deep.space SET NOTIFY new
  ...No notificar: .msg memo@deep.space SET NOTIFY off
  ..-
  ..Límite de mensajes
  ...Límite por canal: .msg memo@deep.space SET LIMIT #$$?="¿Canal a limitar?" $$?="Límite de mensajes en buzón (Máximo 20)"
  ...Límite general: .msg memo@deep.space SET LIMIT $$?="Límite de mensajes en buzón (Máximo 20)"
}

;--------------------------------------------------------------------

MENU Channel {
  -
  Hispano
  .Registrar Este Canal: .msg chan@deep.space REGISTER # $$?="Introduce una clave de Fundador" $$?="Breve descripción del canal"
  .Identificarte como Fundador: .msg chan@deep.space IDENTIFY # $$?="¿Clave de Fundador?"
  .DesRegistrar Este Canal: {
    :inicio2
    %xtvrt38 = $$?="¿Está seguro de eliminar $chan del registro? (Si/No)"
    if ( %xtvrt38 == Si ) .msg chan@deep.space DROP $chan
    elseif ( %xtvrt38 == No ) goto fin2 
    else goto inicio2
    :fin2
  }
  .-
  .AutoOP por CHAN:  .msg chan@deep.space OP # $me
  .-
  .Opciones Admin
  ..Cambia clave Canal: .msg chan@deep.space SET # PASSWORD $$?="¿Nueva contraseña de fundador?"
  ..Cambiar Fundador: .msg chan@deep.space SET # FOUNDER $$?="Nick del nuevo administrador"
  ..-
  ..Descripción Canal: .msg chan@deep.space SET # DESC $$?="Nueva descripción del canal:"
  ..URL DEL Canal: .msg chan@deep.space SET # URL $?="Web del canal: (Dejar en blanco para borrar)"
  ..E-Mail del Canal: .msg chan@deep.space SET # EMAIL $?="E-Mail del canal: (Dejar en blanco para borrar)"
  ..-
  ..Mensaje de entrada: .msg chan@deep.space SET # ENTRY.msg $?="mensaje de entrada al canal: (Dejar en blanco para borrar)"
  ..Fijar Modos del Canal: .msg chan@deep.space SET # MLOCK $?="Determina los modos +/-iklmnpst"
  ..VER ACCIONES: .msg chan@deep.space SET # DEBUG $$??="ON/OFF"
  ..-
  ..Cambiar Topic: .msg chan@deep.space SET # TOPIC $?="¿Topic para el canal? (Dejar en blanco para borrar)"
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
  ..Añadir a la Lista: .msg chan@deep.space AKICK # ADD $$?="Introducir nick o máscara (nick!user@host)" $$?="¿Mensaje de expulsión?"
  ..Borrar de la Lista: .msg chan@deep.space AKICK # DEL $$?="Introducir nick o máscara (nick!user@host)"
  ..Ver Lista en un Canal: .msg chan@deep.space AKICK # LIST $?="Puedes meter una máscara como patrón de búsqueda o dejarlo en blanco"
  .LEVELS
  ..Nivel para AUTOOP
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET AUTOOP $$?="¿Nivel mínimo para AUTOOP?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS AUTOOP
  ..Nivel para AUTOVOICE
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET AUTOVOICE $$?="¿Nivel mínimo para AUTOVOICE?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS AUTOVOICE
  ..Nivel para AUTODEOP
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET AUTODEOP $$?="¿Nivel para AUTODEOP?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS AUTODEOP
  ..Nivel para NOJOIN
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET NOJOIN $$?="¿Nivel para NOJOIN? (Con el canal en modo Restringido)"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS NOJOIN
  ..Nivel para INVITE
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET INVITE $$?="¿Nivel mínimo para autoINVITE?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS INVITE
  ..Nivel para AKICK
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET AKICK $$?="¿Nivel mínimo para manejar la lista de expulsión automática?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS AKICK
  ..Nivel para SET
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET SET $$?="¿Nivel mínimo para manejar comandos SET?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS SET
  ..Nivel para CLEAR
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET CLEAR $$?="¿Nivel mínimo para manejar comandos CLEAR?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS CLEAR
  ..Nivel para UNBAN
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET UNBAN $$?="¿Nivel mínimo para desbanearse?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS UNBAN
  ..Nivel para OP/DEOP
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET OPDEOP $$?="¿Nivel mínimo para usar OP/DEOP?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS OPDEOP
  ..Nivel para Ver Registrados
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET ACC-LIST $$?="¿Nivel mínimo para ver la lista de registros?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS ACC-LIST
  ..Nivel para Registrar
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET ACC-CHANGE $$?="¿Nivel mínimo para añadir registros?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS ACC-CHANGE
  ..Nivel para ver memos al canal
  ...Establecer nivel: .msg chan@deep.space LEVELS # SET MEMO $$?="¿Nivel mínimo para ver el mensaje de entrada?"
  ...-
  ...Desactivar: .msg chan@deep.space LEVELS # DIS MEMO
  ..-
  ..Resetear LEVELS: .msg chan@deep.space LEVELS # RESET
  .-
  .Registrar Usuario: .msg chan@deep.space ACCESS # ADD $$?="¿Nick a registrar?" $$?="¿Nivel para $! $+ ?"
  .Borrar Usuario: .msg chan@deep.space ACCESS # DEL $$?="¿Nick a Borrar? (o número de registro)"
  .Usuarios registrados: .msg chan@deep.space ACCESS # LIST $?="Nick o máscara a buscar. (En blanco para listar todos)"
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
  ..Enviar al canal: .msg memo@deep.space SEND # $$?="¿Texto?"
  ..Leer Memos canal
  ...Último mensaje: .msg memo@deep.space READ # LAST
  ...-
  ...Leer mensaje número...: .msg memo@deep.space READ # $$?="Número del mensaje que quieres leer"
  ..Listar mensajes
  ...Listar todos: .msg memo@deep.space LIST #
  ...-
  ...Solo los no leidos: .msg memo@deep.space LIST # NEW
  ..Administración Buzón
  ...Borrar mensajes
  ...Borrar todos: .msg memo@deep.space DEL # ALL
  ...-
  ...Borrar seleccionados: .msg memo@deep.space DEL # $$?="Número, Serie o Rango. P. ej: 1,2,3,4 ó 1-4 "
  ..-
  ..No recibir MEMOS al canal: .msg memo@deep.space SET LIMIT # 0
  ..Limitar el número: .msg memo@deep.space SET LIMIT # $$?="¿Límite de mensajes desde $chan $+ ? (Máximo 20)"
}  
;--------------------------------------------------------------------

MENU NickList {
  -
  Hispano
  .OP por CHAN: .msg chan@deep.space OP $chan $1 $2 $3 $4 $5 $6
  .DEOP por CHAN: .msg chan@deep.space DEOP $chan $1 $2 $3 $4 $5 $6
  .-
  .Añadir a Auto Kick
  ..Añadir por nick: .msg chan@deep.space AKICK $chan ADD $1 $$?="¿Mensaje de expulsión?"
  ..-
  ..Añadir por host: .msg chan@deep.space AKICK $chan ADD $address($1,2) $?="¿Mensaje de expulsión? (Opcional)"
  .REGISTRO en canal
  ..Registrar Usuario: .msg chan@deep.space ACCESS $chan  ADD $1 $$?="¿Nivel para $1 $+ ?"
  ..-
  ..Borrar Usuario: .msg chan@deep.space ACCESS $chan DEL $1
  .-
  .INFO de UN nick: .msg nick@deep.space INFO $1 | .msg nick@deep.space STATUS $1
  .-
  .Expulsar a un usurpador: .msg nick@deep.space RECOVER $1 $$?="¿Contraseña de $1 $+ ?"
  .Expulsar tu Ghost: .msg nick@deep.space GHOST $1 $$?="¿Clave?"
}

;--------------------------------------------------------------------

MENU Query {
  -
  Hispano
  .MENSAJERÍA
  ..Enviar Mensaje: .msg memo@deep.space SEND $$?="Nick del destinatario" $$?="Texto del mensaje"
  ..LEER mensaje
  ...Último mensaje recibido: .msg memo@deep.space READ LAST
  ...-
  ...Leer mensaje número...: .msg memo@deep.space READ $$?="Número del mensaje que quieres leer"
  ..Listar mensajes
  ...Listar todos: .msg memo@deep.space LIST
  ...-
  ...Solo los no leidos: .msg memo@deep.space LIST NEW
  ..Borrar mensajes
  ...Borrar todos: .msg memo@deep.space DEL ALL
  ...-
  ...Borrar seleccionados: .msg memo@deep.space DEL $$?="Número, Serie o Rango. P. ej: 1,2,3,4 ó 1-4 "
  ..-
  ..Notificación de mensajes
  ...Notificar siempre: .msg memo@deep.space SET NOTIFY on
  ...Solo en Connect y salida de Away: .msg memo@deep.space SET NOTIFY logon
  ...Solo al recibir: .msg memo@deep.space SET NOTIFY new
  ...No notificar: .msg memo@deep.space SET NOTIFY off
  ..-
  ..Límite de mensajes
  ...Límite por canal: .msg memo@deep.space SET LIMIT #$$?="¿Canal a limitar?" $$?="Límite de mensajes en buzón (Máximo 20)"
  ...Límite general: .msg memo@deep.space SET LIMIT $$?="Límite de mensajes en buzón (Máximo 20)"
  .-
  .OP por NICK: .msg chan@deep.space OP #$$?="¿Canal?" $1
  .DEOP por NICK: .msg chan@deep.space DEOP #$$?="¿Canal?" $1
  .-
  .Añadir a Auto Kick
  ..Añadir por nick: .msg chan@deep.space AKICK #$$?="¿Canal?" ADD $1 $$?="¿Mensaje de expulsión?"
  ..Añadir por host: .msg chan@deep.space AKICK #$$?="¿Canal?" ADD $address($1,2) $$?="¿Mensaje de expulsión?"
  .REGISTRO en canal
  ..Registrar Usuario: .msg chan@deep.space ACCESS #$$?="¿Canal?"  ADD $1 $$?="¿Nivel para $1 $+ ?"
  ..Borrar Usuario: .msg chan@deep.space ACCESS #$$?="¿Canal?" DEL $1
  .-
  .INFO del nick: .msg nick@deep.space INFO $1 | .msg nick@deep.space STATUS $1
  .-
  .Expulsar a un usurpador: .msg nick@deep.space RECOVER $1 $$?="¿Contraseña de $1 $+ ?"
  .Release: .msg nick@deep.space RELEASE $1 $$?="¿Contraseña de $1 $+ ?"
  .Expulsar tu Ghost: .msg nick@deep.space GHOST $1 $$?="¿Clave?"
}
