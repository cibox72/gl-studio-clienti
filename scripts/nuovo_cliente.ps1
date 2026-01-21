$nome = Read-Host "Nome e Cognome (es. Mario Rossi)"
$cognome = Read-Host "Cognome (se non incluso sopra, altrimenti premi INVIO)"
$tel = Read-Host "Telefono (solo numeri, es. 3451234567)"
$email = Read-Host "Email"
$indirizzo = Read-Host "Indirizzo"
$servizio = Read-Host "Tipo servizio (Matrimonio/Battesimo/Eventi)"

if ($cognome -and $nome -notlike "* *") { $nomeCompleto = "$nome $cognome" } else { $nomeCompleto = $nome }
$nomeFile = $nomeCompleto.ToLower() -replace ' ', '_'
$anno = Get-Date -Format "yyyy"
$data = Get-Date -Format "yyyy-MM-dd"
$nomeBreve = ($nomeCompleto -split ' ')[0]

$mdContent = @"
# $nomeCompleto

- **Telefono**: +39 $tel  
- **Email**: $email  
- **Indirizzo**: $indirizzo  
- **Data inserimento**: $data  
- **Stato**: Nuovo  

## Richiesta
Organizzazione $servizio$(if ($indirizzo) { " presso $indirizzo" }).

## Documenti
- [Preventivo](../documenti/$nomeFile/preventivo_$anno.pdf)
- [Contratto](../documenti/$nomeFile/contratto_$anno.pdf)

## Invio WhatsApp
- [💬 Apri chat WhatsApp con $nomeCompleto](https://wa.me/39$tel?text=Ciao%20$nomeBreve,%20ti%20invio%20il%20preventivo.%20Grazie!)

> ⏱️ Ultimo aggiornamento: $data
"@

New-Item -ItemType Directory -Path "documenti/$nomeFile" -Force | Out-Null
Set-Content -Path "clienti/$nomeFile.md" -Value $mdContent -Encoding UTF8

Write-Host "✅ Scheda creata: clienti/$nomeFile.md"
Write-Host "📁 Cartella documenti: documenti/$nomeFile/"
