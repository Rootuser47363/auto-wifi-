# Verifica la versión de PowerShell y que se está ejecutando en un equipo con Windows
if ($PSVersionTable.PSVersion.Major -lt 3) {
    Write-Host "Este script requiere PowerShell 3.0 o posterior." -ForegroundColor Red
    return
}

if (-not (Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion")) {
    Write-Host "Este script solo se puede ejecutar en un equipo con Windows." -ForegroundColor Red
    return
}

# Cambiar el nombre del archivo de salida aquí:
$nombre_archivo = "Auto-wifi.txt"

# Verificar si el archivo de salida ya existe y pedir confirmación antes de sobrescribirlo
if (Test-Path -Path $nombre_archivo) {
    $confirm = Read-Host "El archivo $nombre_archivo ya existe. ¿Desea sobrescribirlo? (S/N)"
    if ($confirm -ne 'S') {
        Write-Host "Operación cancelada." -ForegroundColor Yellow
        return
    }
    else {
        # Leer las contraseñas ya existentes en el archivo y guardarlas en una variable
        $contrasenas_existentes = Get-Content $nombre_archivo
    }
}

# Ejecutar el comando netsh para obtener la información de las redes WiFi y guardarlas en una variable
$redes_wifi = netsh wlan show profile
$contrasenas_wifi = foreach ($red in $redes_wifi) {
    $nombre_red = $red -replace ".:\s(.*)", '$1'
    $info_red = netsh wlan show profile name="$nombre_red"
    $contrasena_red = ( $info_red | Select-String "Contenido de la clave" | ForEach-Object { $_.ToString().Split(":")[1].Trim() }) -join ''
    $tipo_seguridad = ( $info_red | Select-String "Tipo de seguridad" | ForEach-Object { $_.ToString().Split(":")[1].Trim() }) -join ''
    if ($contrasena_red) {
        "${nombre_red}: ${contrasena_red} (Seguridad: ${tipo_seguridad})"
    }
}

# Combinar las contraseñas ya existentes con las nuevas, y ordenarlas alfabéticamente por nombre de red
if ($contrasenas_existentes) {
    $todas_contraseñas = $contrasenas_existentes + $contrasenas_wifi
    $todas_contraseñas = $todas_contraseñas | Sort-Object
}
else {
    $todas_contraseñas = $contrasenas_wifi | Sort-Object
}

# Escribir todas las contraseñas en el archivo de salida
try {
    $todas_contraseñas | Out-File -FilePath $nombre_archivo -Encoding utf8
    Write-Host "Contraseñas guardadas exitosamente en $nombre_archivo"
} catch {
    Write-Host "Error al escribir en el archivo: $($_.Exception.Message)" -ForegroundColor Red
}
