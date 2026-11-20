# REPONSES - TP N°2 Linux & Scripting Bash

## Exercice 2.1 - Que donne chmod 644 sur un script ?
`644` donne `rw-r--r--` : lecture et écriture pour le propriétaire, lecture seule pour le groupe et les autres. Il n'y a aucun droit d'exécution (`x`), donc `./script.sh` renvoie « Permission denied ». C'est le droit habituel d'un fichier de données ou de configuration, pas d'un script à lancer. Pour un script réservé au propriétaire, on utilise `chmod 700` (`rwx------`).

## Exercice 2.3 - Que se passe-t-il sans set -Eeuo pipefail si tar échoue ?
Sans `set -Eeuo pipefail`, si `tar` échoue (disque plein, droits insuffisants...), le script continue à tort : il affiche « Archive créée » alors qu'elle n'existe pas ou est corrompue, puis supprime les anciennes sauvegardes. On peut ainsi perdre les vieilles sauvegardes valides sans en avoir de nouvelle. Avec `set -e`, le script s'arrête dès l'échec de `tar`. De plus, `-u` détecte les variables non définies et `pipefail` les erreurs au milieu d'un pipe.

## Exercice 2.5 - Transformer ci.sh en vrai pipeline CI

**Étapes à ajouter :**
- Déclenchement automatique à chaque push (webhook ou GitHub Actions).
- Installation des dépendances (`npm ci`, `pip install -r requirements.txt`).
- Vrais tests unitaires et d'intégration, plus un linter (ShellCheck, ESLint).
- Build du projet (compilation, image Docker).
- Notification (mail, Discord) en cas d'échec.
- Déploiement automatique (CD) avec possibilité de rollback.
- Gestion des secrets (variables d'environnement) et archivage des artefacts.

**Points de défaillance à gérer avec des codes de retour :**
- Argument manquant ou invalide (`exit 1`).
- Échec du `git clone` / `git pull` : URL fausse, réseau coupé, droits insuffisants.
- Échec de l'installation des dépendances.
- Échec des tests : le pipeline doit s'arrêter avec un code différent de 0.
- Échec du build ou du déploiement : disque plein, serveur injoignable.
- Erreur au milieu d'un pipe (`pipefail`).

Chaque étape doit renvoyer un code non nul en cas d'échec, pour que l'étape suivante ne s'exécute pas à tort.