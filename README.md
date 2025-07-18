# devops_cp2

Ejecutar desde nuestro shell (dentro de la carpeta terraform):
terraform init
terraform fmt 
terraform validate
terraform plan -out myplan
terraform apply "myplan"

despues de ejecutar los comandos anteriores, nos vamos a la carpeta ansible y ejecutamos
(con el último parametro nos pide el password de sudo)
ansible-playbook -i inventory playbook.yml --connection=local --ask-become-pass

Para obtener las credenciales de acr (su nombre lo cogemos del inventory, que se ha generado desde terraform) y con esto ya tenemos los valores del credentials
az acr credential show --name jrurudevopsIATcTyzaGp

Para el rol de app y la tarea de kubernates, he debido hacer por mi terminal
pipx inject ansible kubernetes