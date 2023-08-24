# Auto-Wifi

Este script de PowerShell permite obtener y guardar en un archivo de texto las contraseñas de las redes wifi a las que ha accedido previamente un equipo con Windows. Es una versión beta inspirada en este de Cadeleon [script](https://github.com/Cedaleon/wifi-password.ps1). 

## Requisitos

- PowerShell 3.0 o posterior.
- Windows.

## Uso

1. Descarga el archivo `auto-wifi.ps1`.
2. Abre una ventana de PowerShell.
3. Navega hasta la carpeta donde se encuentra el archivo `auto-wifi.ps1`.
4. Ejecuta el script escribiendo en la terminal: `.\auto-wifi.ps1`.
5. El script generará un archivo de texto en la misma carpeta donde se encuentra el archivo `auto-wifi.ps1` con el nombre "Auto-wifi.txt".
6. Abre el archivo de texto para ver las contraseñas de las redes wifi guardadas.

## Advertencias

- El script solo puede ejecutarse en equipos con Windows.
- Este script muestra las contraseñas de las redes wifi guardadas en el equipo sin necesidad de autenticación, por lo que cualquier persona que tenga acceso al archivo de texto puede ver las contraseñas. Se recomienda mantener el archivo de texto en un lugar seguro y eliminarlo una vez se haya terminado de usar.

## Contribuir

Si deseas contribuir a este proyecto, por favor haz un pull request o crea un issue.

**Palabras clave para motores de búsqueda:** PowerShell, Windows, contraseñas, wifi, script, seguridad.
