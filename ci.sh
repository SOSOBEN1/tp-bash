#!/bin/bash
# Mini pipeline CI : clone/pull d'un dépôt, "tests", journalisation horodatée
# Usage : ./ci.sh <url_du_depot> [dossier]   (dossier : workspace par défaut)

set -Eeuo pipefail
export GIT_TERMINAL_PROMPT=0   # pas de demande de mot de passe si l'URL est fausse

URL=${1:-}
DIR=${2:-workspace}
LOG="ci.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$1] $2" | tee -a "$LOG"
}

trap 'log ERROR "Échec à la ligne $LINENO, pipeline interrompu"; exit 1' ERR

recuperer_depot() {
    if [ -d "$DIR/.git" ]; then
        log INFO "Mise à jour du dépôt dans $DIR"
        git -C "$DIR" pull 2>&1 | tee -a "$LOG"
    else
        log INFO "Clonage de $URL dans $DIR"
        git clone "$URL" "$DIR" 2>&1 | tee -a "$LOG"
    fi
}

lancer_tests() {
    local echecs=0
    for fichier in "$DIR"/*.sh; do
        [ -e "$fichier" ] || continue
        if bash -n "$fichier"; then
            log INFO "Test syntaxe OK : $fichier"
        else
            log ERROR "Test syntaxe KO : $fichier"
            echecs=$((echecs + 1))
        fi
    done
    return "$echecs"
}

if [ -z "$URL" ]; then
    echo "Usage : $0 <url_du_depot> [dossier]" >&2
    exit 1
fi

log INFO "=== Début du pipeline ==="
recuperer_depot

if lancer_tests; then
    log INFO "=== Pipeline réussi ==="
    exit 0
else
    log ERROR "=== Pipeline échoué : des tests ont échoué ==="
    exit 1
fi
