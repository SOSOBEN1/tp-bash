#!/bin/bash
# Vérifie l'espace disque utilisé sur / et alerte si le seuil est dépassé
# Usage : ./check_disk.sh [seuil]   (80 par défaut)

SEUIL=${1:-80}
USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$USAGE" -ge "$SEUIL" ]; then
    echo "ALERTE : disque utilisé à ${USAGE}% (seuil : ${SEUIL}%)"
    exit 1
fi

echo "OK : disque utilisé à ${USAGE}% (seuil : ${SEUIL}%)"
exit 0
