#!/bin/bash
#Copyright IBM Corp. 2017. All Rights Reserved.
#Licensed under "The MIT License (MIT)"
echo sleeping 30

sleep 30

dbserver=$2
org=$3
cat=$4

resp=$(curl -k https://${dbserver}/$org/$cat/throttling-unittest_stamp/test --verbose)
success=$(echo $resp | grep "\"remaining\":0, \"timeToReset\"" | wc -l )
exitFlag=0;
if [ $success -eq 1 ] ;
then
  echo Test1 Passed
else
  echo Test1 Failed - $success - $resp
  exitFlag=1;
fi

#resetting timer
sleep 20

resp_one=$(curl -k https://${dbserver}/$org/$cat/throttling-unittest_stamp/test --verbose)
resp_two=$(curl -k https://${dbserver}/$org/$cat/throttling-unittest_stamp/test --verbose)
resp_three=$(curl -k https://${dbserver}/$org/$cat/throttling-unittest_stamp/test --verbose)

echo $resp_one
echo $resp_two
echo $resp_three

success=$(echo $resp_one | grep "\"remaining\":0, \"timeToReset\"" | wc -l )
exitFlag=0;
if [ $success -eq 1 ] ;
then
  echo Test2a Passed
else
  echo Test2a Failed -  $success - $resp_one
  exitFlag=1;
fi
if [ "$resp_two" == '{ "httpCode":"429", "httpMessage":"Maximum through put is hit message being rejected. ", "moreInformation":"" }' ]  ;
then
  echo Test2b Passed
else
  echo Test2b Failed - '{ "httpCode":"429", "httpMessage":"Maximum through put is hit message being rejected. ", "moreInformation":"" }'  - $resp_two
  exitFlag=1;
fi
if [ "$resp_three" == '{ "httpCode":"429", "httpMessage":"Maximum through put is hit message being rejected. ", "moreInformation":"" }' ]  ;
then
  echo Test2b Passed
else
  echo Test2b Failed - '{ "httpCode":"429", "httpMessage":"Maximum through put is hit message being rejected. ", "moreInformation":"" }'  - $resp_three
  exitFlag=1;
fi
exit $exitFlag
