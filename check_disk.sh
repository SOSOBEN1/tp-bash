#!/bin/bash

# Seuil : 1er argument, sinon 80 par défaut
SEUIL=${1:-80}

# % d'utilisation de la partition /, sans le symbole %
UTILISATION=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$UTILISATION" -ge "$SEUIL" ]; then
    echo "ALERTE : disque utilisé à ${UTILISATION}% (seuil : ${SEUIL}%)"
    exit 1
fi

echo "OK : disque utilisé à ${UTILISATION}% (seuil : ${SEUIL}%)"
exit 0
EOF