# EBICSBOX - Startanleitung

## Zugriff

- **Web UI**: https://ebics.kreckler.shop (nach DNS-Konfiguration)
- **ERPNext intern**: http://ebicsbox-web-1:5000 (über Docker-Netzwerk)

## Starten

```bash
cd /srv/ebicsbox
docker-compose -f docker-compose.production.yml up -d --build
```

## Status prüfen

```bash
docker-compose -f docker-compose.production.yml ps
docker-compose -f docker-compose.production.yml logs -f web
```

## Stoppen

```bash
docker-compose -f docker-compose.production.yml down
```

## DNS Konfiguration

Erstelle einen A-Record oder CNAME für `ebics.kreckler.shop` der auf diesen Server zeigt.
Traefik wird automatisch ein Let's Encrypt Zertifikat generieren.

## Wichtige Dateien

- `.env` - Konfiguration mit Secrets (BACKUP!)
- `docker-compose.production.yml` - Docker Konfiguration mit Traefik

## ERPNext Konfiguration

In ERPNext unter **Banking Settings**:
- **ebicsbox URL**: `https://ebics.kreckler.shop` (oder intern `http://ebicsbox-web-1:5000`)
- **ebicsbox Access Token**: Muss in ebicsbox UI generiert werden
- **Enable EBICS**: aktivieren

## Sicherheitshinweise

1. **PASSPHRASE sichern**: Diese wird zur Verschlüsselung der Bankdaten verwendet
2. **Access Token**: Nach erstem Start in ebicsbox UI unter Management erstellen
