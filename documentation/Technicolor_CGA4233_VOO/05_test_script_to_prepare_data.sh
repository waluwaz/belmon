#!/bin/sh

cat  03_json_raw.json | jq '.data.USTbl' | sed s/PowerLevel/TxPwr/ | sed s/ChannelID/TxChannelID/ | sed s/id/01Discard/ | sed s/Frequency/02Discard/ | sed s/ChannelType/03Discard/ | sed s/SymbolRate/04Discard/ | sed s/Modulation/05Discard/ | sed s/LockStatus/06Discard/ > shstatsfile_ust

cat  03_json_raw.json | jq '.data.DSTbl' | sed s/PowerLevel/RxPwr/  | sed s/ChannelID/RxChannelID/ | sed s/Correcteds/TxT3Out/ | sed s/Frequency/TxT4Out/ | sed s/Uncorrectables/RxPstRs/ | sed s/SNRLevel/RxSnr/ | sed s/id/01Discard/  | sed s/Frequency/02Discard/ | sed s/Modulation/03Discard/ | sed s/Octets/04Discard/ | sed s/LockStatus/05Discard/ | sed s/ChannelType/06Discard/ > shstatsfile_dst

cat shstatsfile_ust shstatsfile_dst | sed 's/MHz//' | sed 's/dBmV//' | sed 's/dB//' | sed 's/"//g' | sed 's/:/,,/' | sed 's/ //g' | grep "^[A-Za-z]"  > 06_prepared_data_sample.txt

# rm -f shstatsfile_dst
# rm -f shstatsfile_ust


# 	/usr/sbin/curl -fs --retry 3 --connect-timeout 15 'http://192.168.100.1/api/v1/modem/exUSTbl,exDSTbl,USTbl,DSTbl,ErrTbl' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:98.0) Gecko/20100101 Firefox/98.0' -H 'Accept: */*' -H 'X-CSRF-TOKEN: 2d39f236c2776485efc99f15d411b5f5' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' -H 'Cookie: lang=fr; PHPSESSID=42degahqbb8u5kikpbfiid5s6n; auth=2d39f236c2776485efc99f15d411b5f5'  > /tmp/shstats_curl.csv


#cat  /tmp/shstats_curl.csv | jq '.data.USTbl' | sed s/PowerLevel/TxPwr/ | sed s/ChannelID/TxChannelID/ | sed s/id/01Discard/ | sed s/Frequency/02Discard/ | sed s/ChannelType/03Discard/ | sed s/SymbolRate/04Discard/ | sed s/Modulation/05Discard/ | sed s/LockStatus/06Discard/ > shstatsfile_ust.csv

#cat  /tmp/shstats_curl.csv | jq '.data.DSTbl' | sed s/PowerLevel/RxPwr/  | sed s/ChannelID/RxChannelID/ | sed s/Correcteds/TxT3Out/ | sed s/Frequency/TxT4Out/ | sed s/Uncorrectables/RxPstRs/ | sed s/SNRLevel/RxSnr/ | sed s/id/01Discard/  | sed s/Frequency/02Discard/ | sed s/Modulation/03Discard/ | sed s/Octets/04Discard/ | sed s/LockStatus/05Discard/ | sed s/ChannelType/06Discard/ > shstatsfile_dst.csv

#cat shstatsfile_ust.csv shstatsfile_dst.csv | sed 's/MHz//' | sed 's/dBmV//' | sed 's/dB//' | sed 's/"//g' | sed 's/:/,,/' | sed 's/ //g' | grep "^[A-Za-z]"  > 06_prepared_data_sample.txt