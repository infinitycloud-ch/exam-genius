import os

def save_python_scripts_to_file(directory, output_filename="scripts_summary.txt"):
    """
    Parcours un répertoire donné pour collecter tous les scripts Python (.py)
    et les enregistre dans un fichier texte avec le nom et le contenu de chaque script.

    Args:
        directory (str): Le chemin absolu du répertoire à analyser.
        output_filename (str): Le nom du fichier de sortie (par défaut: scripts_summary.txt).
    """
    # Vérification du répertoire
    if not os.path.isdir(directory):
        print(f"Erreur : Le chemin spécifié n'est pas un répertoire valide : {directory}")
        return
    
    # Chemin absolu pour le fichier de sortie
    output_path = os.path.join(directory, output_filename)
    
    # Initialisation du contenu à écrire
    content = []
    
    # Parcourir tous les fichiers dans le répertoire et ses sous-répertoires
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".swift"):  # Vérifier si c'est un fichier Python
                script_path = os.path.join(root, file)
                try:
                    with open(script_path, "r") as script_file:
                        code = script_file.read()
                    
                    # Ajouter le nom du script et son contenu
                    relative_path = os.path.relpath(script_path, directory)
                    content.append(f"### Script: {relative_path}\n")
                    content.append(code)
                    content.append("\n\n")  # Séparation entre les scripts
                except Exception as e:
                    print(f"Erreur lors de la lecture du fichier {script_path}: {e}")
    
    # Écrire le contenu dans le fichier de sortie
    with open(output_path, "w") as output_file:
        output_file.writelines(content)
    
    print(f"Les scripts Python ont été enregistrés dans {output_path}")

# Exemple d'appel
# Remplacez le chemin par le répertoire que vous voulez analyser
directory_to_scan = "/Users/panda/cbtgenius"
save_python_scripts_to_file(directory_to_scan)
