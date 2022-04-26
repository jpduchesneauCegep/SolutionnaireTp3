# Travail pratique 3
# Auteur : Jean-Pierre Duchesneau
# Date : décembre 2021

# ===========================================================================

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

$NomGroupe= "Entreprise"
$NomRepertoire= "Entreprise"
$NomFichier = "nom.csv"
$Fichier = $EmplacementFichier + $NomFichier


# Création des objets : 

# Création du répertoire : 
try {
    Get-Item $NomRepertoire
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

# Boucle 
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