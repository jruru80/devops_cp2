# devops_cp2

Ejecutar desde nuestro shell (dentro de la carpeta terraform):
terraform init
terraform fmt 
terraform validate
terraform plan -out myplan
terraform apply "myplan"

El fichero inventory generado dentro de terradorm es el que devemos copiar a la carpeta ansible

Para obtener las credenciales de acr (su nombre lo cogemos del inventory, que se ha generado desde terraform)
az acr credential show --name <name_acr>
como por ejemplo
    az acr credential show --name jrurudevopsEQD1Lm2nl2

Cogemos sus valores y las instanciamos en el fichero /ansible/credentials.yml


NOTA: METER EN EL ROL DE DESPLIEGUE EN AKS -> DEBO ESCRIBIR POR SHELL Y SOBREESCRIBIR
(Hecho, comprobar que funcione bien)
az aks get-credentials --resource-group rg-devops-cp2 --name aks_cp2          

despues de realizar  todo lo anterior, nos vamos a la carpeta ansible y ejecutamos
(con el último parametro nos pide el password de sudo)
ansible-playbook -i inventory playbook.yml --connection=local --ask-become-pass

Si todo va bien, despues de ejecutar mi comando de ansible, voy a mi azure -> aks -> services y ahí puedo ver la external ip. Si lo pincho, veo la aplicación de perros y gatos

NOTA PARA APUNTAR EN EL DOC
Para el rol de app y la tarea de kubernates, he debido hacer por mi terminal
pipx inject ansible kubernetes