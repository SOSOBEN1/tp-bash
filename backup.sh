#!/bin/bash
# Archive un dossier, horodate l'archive et supprime les sauvegardes de plus de 7 jours
# Usage : ./backup.sh [dossier] [destination]   (défaut : data et backups)

set -Eeuo pipefail

DOSSIER=${1:-data}
DEST=${2:-backups}
DATE=$(date +%Y-%m-%d_%H-%M-%S)

if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : le dossier '$DOSSIER' n'existe pas" >&2
    exit 1
fi

mkdir -p "$DEST"
ARCHIVE="$DEST/backup_${DATE}.tar.gz"

tar -czf "$ARCHIVE" "$DOSSIER"
echo "Archive créée : $ARCHIVE"

# Suppression des sauvegardes de plus de 7 jours
for fichier in "$DEST"/backup_*.tar.gz; do
    [ -e "$fichier" ] || continue
    if [ -n "$(find "$fichier" -mtime +7)" ]; then
        rm "$fichier"
        echo "Ancienne sauvegarde supprimée : $fichier"
    fi
done

exit 0
