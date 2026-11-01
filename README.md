<div align="center">

# mIRCScripting
### The Jimmy_RAY Archive

**A time capsule from the Spanish IRC scripting scene (2000–2007)**
**Una cápsula del tiempo de la escena española del scripting para IRC (2000–2007)**

![mIRC](https://img.shields.io/badge/mIRC-5.8%20%E2%86%92%206.x-2d5d9f?style=flat-square)
![Language](https://img.shields.io/badge/mSL-mIRC%20Scripting%20Language-8a2be2?style=flat-square)
![Era](https://img.shields.io/badge/era-2000--2007-f39c12?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)

[🇬🇧 English](#english) · [🇪🇸 Español](#español)

</div>

---

<a name="english"></a>
## 🇬🇧 English

Everything in this repo was written, collected or hosted by **Jimmy_RAY** (Juan Gestal) back when IRC-Hispano was the place to be and mIRC 5.8 was state of the art. Full scripts, addOns, the websites of the `#scripting` and `#100scripts` channels, a live scripting talk transcript and a handful of third-party scripts from the same era.

It is published as-is, for nostalgia and for anyone curious about how mIRC Scripting Language (mSL) was used to build full clients on top of mIRC: dialogs, sockets, DLLs, themes, games and more.

### 📂 What's inside

```
.
├── AddOns/          Stand-alone .mrc addOns, each with its own readme
├── Scripts/         Full mIRC scripts (complete client bundles)
├── Webs/            The channel and personal websites, as they were
├── Other Scripts/   Third-party scripts and installers from the era
└── Other Stuff/     Talk transcript and a review from mIRCScripts.org
```

### 🧩 AddOns

Small, self-contained addOns. Drop the `.mrc` file into your mIRC folder and load it:

```
/load -rs antiban.mrc
```

| AddOn | What it does | Command |
|-------|--------------|---------|
| **Antiban** | Protects you from bans on your channels | auto |
| **BaTSmS** | Sends SMS to Spanish mobile carriers from IRC, via their email gateways | `/batsms` |
| **FloodBots** | Flood-bot manager with a server list (`fbsrv.dat`) | `/floodbots` |
| **NoFlood** | *BaT No Flood! 1.0*, the original channel flood protection | `/load -rs loadme.mrc` |
| **NoFlood-e** | *BaCKBEAT No Flood!*, the later English edition with per-channel configs and kick messages | auto |
| **Snake** | The classic snake game, inside mIRC. Reviewed on mIRCScripts.org | `/snake` |
| **Telnet Client** | A telnet client built on mIRC sockets | `/telnet host port` |
| **VisorImagenes** | Image viewer dialog | `/vs` |
| **VisorLogs** | Log reader 2.0 with a browsing dialog | `/logs` |

### 🖥️ Full scripts

| Script | Year | Notes |
|--------|------|-------|
| **BaT Project** | ~2000 | *BravoS AssAulT TeaM* script, made with Fulg0re. Themes (BaT, DarkBaT, BitchX) and MDX dialogs |
| **BackbeatScript 2.1** | ~2000 | Ships with mIRC 5.81, optional help addOns, flood-bots, Spanish ID letter calculator |
| **BackbeatScript 3.2** | 2001–2007 | The big one: themes, trivia bot (Pstrivial), anti-spam, anti-virus, away system, nick completion, SMTP mail, crypt DLL, custom `mOTFv.dll` (source included). Final release made it fully free |

Each bundle includes its original `mirc32.exe`, so the folder is a complete snapshot of the client as it was distributed.

### 🌐 Webs

Static mirrors of the sites, including graphics, downloads and the original HTML.

- **100Scripts**: website of the `#100scripts` channel. Includes the *Cursillo de Scripting*, a step-by-step course (popups, aliases, if-then-else, remotes, custom windows, identifiers), a sockets tutorial, tips, reviews (IRcap, Akelarre, Arcano, taboFTP), interviews and 20+ downloadable addOns.
- **Web-CanalScripting**: website of the `#scripting` channel. Downloads, photos, the full scripting talk and the BaT section.
- **JimmyRay**: Jimmy_RAY's personal page with screenshots of every addOn.

### 📦 Other Scripts

Third-party scripts and installers kept for historical reference: IRcap 8.72, 7th Sphere 3.0 and tools, PnP 4.22, Phanatic, AIRC, K-Zombie, xcrypt and the mIRC 6.2 installer. These are 20-year-old Windows binaries from unknown sources. Treat them as archive material, not as something to run.

### 📜 Other Stuff

- `charla-IRC.txt`: transcript of a live scripting talk given in `#SCRiPTiNG` on 29 April 2001 to ~80 people. Aliases, identifiers, remotes and common mistakes, all explained live.
- `mIRCScripts_Org-Snake-Review.pdf`: the Snake addOn review from mIRCScripts.org. *"An exact replication of snakes on mIRC, with user levels, high score and smooth graphics."*

### ▶️ Running it today

mIRC still runs on modern Windows and most of this code still loads. Expect breakage anywhere that depends on dead services: SMS gateways, news feeds, server lists, old DLLs on 64-bit systems. On macOS or Linux, Wine works well enough for a nostalgia trip.

### ⚖️ License

Released under the [MIT License](LICENSE). Third-party scripts under `Other Scripts/` keep their original licenses and authors. Original readmes inside each folder are preserved untouched.

---

<a name="español"></a>
## 🇪🇸 Español

Todo lo que hay en este repo lo escribió, recopiló o alojó **Jimmy_RAY** (Juan Gestal) cuando IRC-Hispano era el sitio donde había que estar y el mIRC 5.8 era lo más. Scripts completos, addOns, las webs de los canales `#scripting` y `#100scripts`, la transcripción de una charla en directo y unos cuantos scripts de terceros de la misma época.

Se publica tal cual, por nostalgia y para quien tenga curiosidad por cómo se usaba el mIRC Scripting Language (mSL) para construir clientes completos sobre mIRC: diálogos, sockets, DLLs, themes, juegos y más.

### 📂 Qué hay dentro

```
.
├── AddOns/          AddOns .mrc independientes, cada uno con su leeme
├── Scripts/         Scripts completos de mIRC (clientes enteros)
├── Webs/            Las webs de los canales y la personal, tal como eran
├── Other Scripts/   Scripts e instaladores de terceros de la época
└── Other Stuff/     Transcripción de la charla y una review de mIRCScripts.org
```

### 🧩 AddOns

AddOns pequeños y autocontenidos. Copia el `.mrc` a tu carpeta del mIRC y cárgalo:

```
/load -rs antiban.mrc
```

| AddOn | Qué hace | Comando |
|-------|----------|---------|
| **Antiban** | Te protege de bans en tus canales | auto |
| **BaTSmS** | Envía SMS a las operadoras españolas desde el IRC, a través de sus pasarelas de email | `/batsms` |
| **FloodBots** | Gestor de flood-bots con lista de servidores (`fbsrv.dat`) | `/floodbots` |
| **NoFlood** | *BaT No Flood! 1.0*, la protección antiflood original | `/load -rs loadme.mrc` |
| **NoFlood-e** | *BaCKBEAT No Flood!*, la edición posterior en inglés con configuración por canal y mensajes de kick | auto |
| **Snake** | El clásico juego de la serpiente, dentro del mIRC. Reseñado en mIRCScripts.org | `/snake` |
| **Telnet Client** | Un cliente telnet construido con sockets de mIRC | `/telnet host puerto` |
| **VisorImagenes** | Diálogo visor de imágenes | `/vs` |
| **VisorLogs** | Lector de logs 2.0 con diálogo de navegación | `/logs` |

### 🖥️ Scripts completos

| Script | Año | Notas |
|--------|-----|-------|
| **BaT Project** | ~2000 | Script del *BravoS AssAulT TeaM*, hecho con Fulg0re. Themes (BaT, DarkBaT, BitchX) y diálogos MDX |
| **BackbeatScript 2.1** | ~2000 | Incluye mIRC 5.81, addOns de ayuda opcionales, flood-bots y calculadora de la letra del DNI |
| **BackbeatScript 3.2** | 2001–2007 | El grande: themes, bot de trivial (Pstrivial), antispam, antivirus, sistema de away, nick completion, correo SMTP, DLL de cifrado y la `mOTFv.dll` propia (con fuente). La última versión lo hizo totalmente libre |

Cada paquete incluye su `mirc32.exe` original, así que la carpeta es una foto completa del cliente tal como se distribuía.

### 🌐 Webs

Espejos estáticos de las webs, con gráficos, descargas y el HTML original.

- **100Scripts**: web del canal `#100scripts`. Incluye el *Cursillo de Scripting*, un curso paso a paso (popups, alias, if-then-else, remotes, ventanas personalizadas, identificadores), un tutorial de sockets, trucos, reviews (IRcap, Akelarre, Arcano, taboFTP), entrevistas y más de 20 addOns descargables.
- **Web-CanalScripting**: web del canal `#scripting`. Descargas, fotos, la charla completa y la sección del BaT.
- **JimmyRay**: la página personal de Jimmy_RAY con capturas de todos los addOns.

### 📦 Other Scripts

Scripts e instaladores de terceros guardados como referencia histórica: IRcap 8.72, 7th Sphere 3.0 y sus tools, PnP 4.22, Phanatic, AIRC, K-Zombie, xcrypt y el instalador del mIRC 6.2. Son binarios de Windows de hace 20 años y de origen desconocido. Trátalos como material de archivo, no como algo para ejecutar.

### 📜 Other Stuff

- `charla-IRC.txt`: transcripción de una charla de scripting en directo en `#SCRiPTiNG` el 29 de abril de 2001 ante unas 80 personas. Alias, identificadores, remotes y errores típicos, todo explicado sobre la marcha.
- `mIRCScripts_Org-Snake-Review.pdf`: la review del addOn Snake en mIRCScripts.org. *"An exact replication of snakes on mIRC, with user levels, high score and smooth graphics."*

### ▶️ Ejecutarlo hoy

mIRC sigue funcionando en Windows moderno y la mayoría de este código todavía carga. Espera fallos en todo lo que dependa de servicios muertos: pasarelas de SMS, lectores de noticias, listas de servidores, DLLs antiguas en sistemas de 64 bits. En macOS o Linux, Wine va lo bastante bien para un viaje nostálgico.

### ⚖️ Licencia

Publicado bajo la [licencia MIT](LICENSE). Los scripts de terceros en `Other Scripts/` conservan sus licencias y autores originales. Los leeme originales dentro de cada carpeta se mantienen intactos.

---

<div align="center">

*BravoS AssAulT TeaM RooLZ!*

</div>
