# Travail pratique 3

**Résumons rapidement le travail**

1. Nos variables
 	- Groupe
 	- Repertoire racine

   - Certaines variables seront placé dans notre boucle. 
       - Repertoire usager
       - Usager
       - Fichier
 	    - Contenu fichier
   
1. Lecture de fichiers

1. Boucles
   - pour chaque usager faire :
       - Créer usager
       - Ajouter au groupe
       - Créer dossier
       - Crer message de bienvee

1. Les tests
    
   - Comment vérifier si un object exsite ?
   - Est-que le répertoire racine existe ?
   - Est-ce que le groupe existe ?
   - Est-que l’usager existe ?
   
<hr>

## Début de script et déclaration des variables :

<details>

```PowerShell
Clear-Host # Avoir un écran propre !
Set-Location -Path D:\  # Pour faciliter le travail 
$EmplacementFichier = "D:\420-W12-SF-4393\"
# Récupéartion du dépôt contenant le fichier
# Vérification de la présence du dépot :
$ErrorActionPreference = "Stop"  #Pour utiliser le try catch
try {
    Get-Item -Path $EmplacementFichier
}
catch {
    git clone  git@github.com:jpduchesneauCegep/420-W12-SF-4393.git
}

$NomFichier = "nom.csv"
$Fichier = $EmplacementFichier + $NomFichier
$ContenuFichier= Get-Content $Fichier
$NomGroupe= "Entreprise"
$NomRepertoire= "Entreprise"

```

</details>

### Avant d'allez plus loing on test les variables 

<details>

```PowerShell

Write-Host $EmplacementFichier
Write-host $NomFichier
Write-Host $Fichier
Write-Host $ContenuFichier
Write-Host $NomGroupe 

```
</details>

## Création des objects : 

<details>

```PowerShell

# Création du répertoire : 
try {
    Get-Item "Entreprise"
}
catch {
    New-Item -ItemType "directory"  -Name $NomRepertoire
}
# Création du groupe local
try {
    Get-LocalGroup -Name $NomGroupe
}
catch {
    New-LocalGroup -Name $NomGroupe
}


```

</details>

### Première boucle sur le contenu du fichier

<details>

```PowerShell
# Boucle 1
foreach ($NomEtudiant in Get-Content $Fichier )
{
     Write-Host $nomEtudiant
}
```

</details>

### La boucle pour le nom 

<details>

```PowerShell
# Boucle pour le nom user
foreach ($NomEtudiant in Get-Content $Fichier )
{
   $nomusager = $NomEtudiant.split(' ')[1].ToLower()  # Exemple d'usager Abdul Meyers - meyers
   $nomusager = $NomEtudiant[0] + $nomusager  # = A + meyers
   $nomusager = $nomusager.ToLower()
    Write-host $nomusager # Résultat ameyers
}


```
</details>

## La boucle final

<details>

```PowerShell
# Boucle final 

foreach ($NomEtudiant in Get-Content $Fichier )
{

    $NomUsager = $NomEtudiant.split(' ')[1].ToLower()  
    $NomUsager = $NomEtudiant[0] + $NomUsager
    $NomUsager = $NomUsager.ToLower()
    $DateExpires = (get-date).AddYears(2)
    $Description = "Création script TP3 JPD pour l'étudiant $($NomEtudiant)"
    $emplacementBienvenue = "$($NomRepertoire)\$($NomUsager)"
    $fileName = "Bienvenue $($NomUsager).txt"

    New-LocalUser -Name $NomUsager -AccountExpires $DateExpires -Description $Description -FullName $NomEtudiant -NoPassword
    Add-LocalGroupMember -name $NomGroupe -Member $NomUsager

    New-Item -Name $NomUsager -Path $emplacementDossier -ItemType "directory"
    New-Item -Name $fileName -path $emplacementBienvenue -ItemType "file" -Value "Bienvenue parmis nous, $(NomEtudiant) !"
}

```
</details>