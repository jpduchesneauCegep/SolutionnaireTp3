# Travail pratique 3
# Auteur : Jean-Pierre Duchesneau
# Date : décembre 2021

# ===========================================================================

Clear-Host # Avoir un écran propre !
Set-Location -Path e:\  # Pour faciliter le travail 
$EmplacementFichier = "E:\420-W12-SF-4394\"
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
# ====
foreach ($NomEtudiant in Get-Content $Fichier )
{

    $NomUsager = $NomEtudiant.split(' ')[1].ToLower()  
    $NomUsager = $NomEtudiant[0] + $NomUsager
    $NomUsager = $NomUsager.ToLower()

    Get-LocalUser -Name $NomUsager  | Remove-LocalUser 
    
}

Get-LocalGroup -Name $NomGroupe | Remove-LocalGroup
Get-Item -path E:\Entreprise | Remove-Item -Recurse
