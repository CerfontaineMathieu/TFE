function CmdLetName()
{
    param(
        [parameter(Mandatory=$true,HelpMessage="Name.")][string]$Name
    )
    
    DynamicParam{
        # Création des paramètres dynamiques

        # Donner au paramètre "FirstName" son label.
        $ParameterName = 'FirstName'            

        # Créer le dictionnaire de paramètres.
        $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        # Créer une collection d'attributs
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            
        # Créer des attributs pour le paramètre comme "Mandatory" ou "HelpMessage"
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $true                        
        $ParameterAttribute.HelpMessage = "Firstname."

        # Ajouter les attributs à la collection d'attributs
        $AttributeCollection.Add($ParameterAttribute)

        # Générer un ValidateSet pour le nouveau paramètre dépendant du paramètre "Name".
        $arrSet = @()
        if($Name -eq "Armstrong")
        {
           $arrSet+='Lance'
           $arrSet+='Neil'
           $arrSet+='Louis'
        }
        
        if($arrSet.Length -gt 0){
           # Créer l'objet ValidateSet et l'initialiser avec le tableau.
           $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)            

           # Ajouter l'objet ValidateSet à la collection d'attributs.
           $AttributeCollection.Add($ValidateSetAttribute)

           # Créer un objet représentant le paramètre dynamique, lui donner le nom du paramètre, son type et sa collection d'attributs.
           $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AttributeCollection)

           # Ajouter l'objet au dictionnaire des paramètres.
           $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
           return $RuntimeParameterDictionary
        }
    }
    
    process{
        #Corps de la fonction
        $FirstName = $RuntimeParameterDictionary.FirstName.value
        Write-Verbose -Message "My name is $Name and my firstname is $FirstName." -Verbose         
    }
}