#!/bin/bash
echo
apt-get install -qq bc
curl -s -C - -o dolarhoje https://www.dolarhoje.com.br/dolar-comercial
dolarCOMERCIAL=$(grep 'class="peq"' dolarhoje | cut -d '>' -f4 | cut -d ' ' -f3 | tr , .)
dolarCOMERCIALdata=$(grep "Atualizado" dolarhoje | cut -d '>' -f2 | cut -d '<' -f1 | cut -d ' ' -f1,2,3,5)
rm dolarhoje
curl -s -C - -o dolarhoje https://www.dolarhoje.com.br/dolar-turismo
dolarTURISMO=$(grep 'class="peq"' dolarhoje | cut -d '>' -f4 | cut -d ' ' -f3 | tr , .)
dolarTURISMOdata=$(grep "Atualizado" dolarhoje | cut -d '>' -f2 | cut -d '<' -f1 | cut -d ' ' -f1,2,3,5)
rm dolarhoje
echo "==={ DOLAR COMERCIAL }==="
echo '$1.00 equivale a R$'"$dolarCOMERCIAL"
echo "$dolarCOMERCIALdata"
echo
echo "==={ DOLAR TURISMO }==="
echo '$1.00 equivale a R$'"$dolarTURISMO"
echo "$dolarTURISMOdata"
echo
echo "(1) Comprar Dolar Comercial"
echo "(2) Comprar Dolar Turismo"
read -p "Comprar: " ESCOLHA
echo
case $ESCOLHA in
1)
read -p "Quanto de Dolar Comercial deseja comprar? " qtddDOLARCOMERCIAL
total=$(echo $dolarCOMERCIAL*$qtddDOLARCOMERCIAL | bc)
echo '$'"$qtddDOLARCOMERCIAL"' custam R$'"$total"
echo
echo "Deseja salvar esses dados em algum lugar?"
echo "Caso não deseje, apenas deixe em branco e pressione Enter."
echo "Seu caminho atual de padrao esta em $PWD"
read -p "Local onde quer salvar/nome do arquivo: " LOCAL
test "$LOCAL" = "" && exit
echo >> $LOCAL
echo "==={ DOLAR COMERCIAL }===" >> $LOCAL
echo "$dolarCOMERCIALdata" >> $LOCAL
echo '$'"$qtddDOLARCOMERCIAL"' custam R$'"$total" >> $LOCAL
exit
;;
2)
read -p "Quanto de Dolar Turismo deseja comprar? " qtddDOLARTURISMO
total=$(echo $dolarTURISMO*$qtddDOLARTURISMO | bc)
echo '$'"$qtddDOLARTURISMO"' custam R$'"$total"
echo
echo "Deseja salvar esses dados em algum lugar?"
echo "Caso não deseje, apenas deixe em branco e pressione Enter."
echo "Seu caminho atual de padrao esta em $PWD"
read -p "Local onde quer salvar/nome do arquivo: " LOCAL
test "$LOCAL" = "" && exit
echo >> $LOCAL
echo "==={ DOLAR TURISMO }===" >> $LOCAL
echo "$dolarTURISMOdata" >> $LOCAL
echo '$'"$qtddDOLARTURISMO"' custam R$'"$total" >> $LOCAL
exit  
;;
*)
echo "Escolha errada."
;;
esac
