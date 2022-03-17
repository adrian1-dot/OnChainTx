
export WALLET_ID_1=`curl -s -d '' http://localhost:9080/wallet/create | jq '.wiWallet.getWalletId'`
sleep 1
export WALLET_ID_2=`curl -s -d '' http://localhost:9080/wallet/create | jq '.wiWallet.getWalletId'`
sleep 2
INSTANCE_ID1=`curl -s -H "Content-Type: application/json" --request POST --data '{"caID": "GameContract", "caWallet":{"getWalletId": '$WALLET_ID_1'}}' http://localhost:9080/api/contract/activate | jq -r '.unContractInstanceId'`
sleep 1
INSTANCE_ID2=`curl -s -H "Content-Type: application/json" --request POST --data '{"caID": "GameContract", "caWallet":{"getWalletId": '$WALLET_ID_2'}}' http://localhost:9080/api/contract/activate | jq -r '.unContractInstanceId'`

sleep 2

curl -H "Content-Type: application/json" \
  --request POST \
  --data '{"amount":{"getValue":[[{"unCurrencySymbol":""},[[{"unTokenName":""},90]]]]},"secretWord":"eagle"}' \
  http://localhost:9080/api/contract/instance/$INSTANCE_ID1/endpoint/lock

sleep 2 

curl -H "Content-Type: application/json" \
  --request POST \
  --data '{"guessWord": "eagle"}' \
  http://localhost:9080/api/contract/instance/$INSTANCE_ID2/endpoint/guess

printf "\n Change to the pab terminal and press ENTER"

printf "\n You should now see the last OnChainTx"
