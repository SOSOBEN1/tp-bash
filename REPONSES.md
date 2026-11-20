# REPONSES - TP N°2 Linux & Scripting Bash

## Exercice 2.0 - Mise en place du dépôt
- Dépôt GitHub `tp-bash` créé sans README, puis cloné avec `git clone`.
- Ajout d'un `.gitignore`, puis commit et push.

## Exercice 2.1 - Navigation, recherche et permissions

### 1. Arborescence
```bash
mkdir -p logs data
```

### 2. Lister les fichiers .log
```bash
ls -lh logs/*.log
```
-rw-rw-r-- 1 sosodev sosodev 14 nov.  20 23:55 logs/app1.log
-rw-rw-r-- 1 sosodev sosodev 29 oct.  27 15:41 logs/fichier1.log
-rw-rw-r-- 1 sosodev sosodev 28 oct.  27 15:41 logs/fichier2.log

### 3. Fichiers modifiés il y a plus de 7 jours
```bash
find . -type f -mtime +7
```
./.git/hooks/pre-receive.sample
./.git/hooks/prepare-commit-msg.sample
./.git/hooks/pre-applypatch.sample
./.git/hooks/pre-merge-commit.sample
./.git/hooks/fsmonitor-watchman.sample
./.git/hooks/commit-msg.sample
./.git/hooks/post-update.sample
./.git/hooks/update.sample
./.git/hooks/sendemail-validate.sample
./.git/hooks/pre-commit.sample
./.git/refs/remotes/origin/main
./.git/refs/heads/main
./.git/config
./.gitignore
./data/test.sh
./logs/fichier2.log
./logs/fichier1.log

### 4. Recherche du mot « erreur »
Avant l'ajout :
```bash
grep -ri "erreur" --include="*.log" .
```
(aucun résultat)

Après `echo "erreur" >> logs/app1.log` :
logs/app1.log:erreur
logs/app1.log:erreur
logs/app1.log:erreur

### 5. Script exécutable uniquement par le propriétaire
```bash
chmod 700 test.sh
ls -l test.sh
```
-rwx------ 1 sosodev sosodev 27 nov.   3 15:13 test.sh


## Exercice 2.2 - Vérification d'espace disque


```bash
chmod +x check_disk.sh
./check_disk.sh
```
OK : disque utilisé à 78% (seuil : 80%)

```bash
./check_disk.sh 10
```
ALERTE : disque utilisé à 78% (seuil : 10%)


