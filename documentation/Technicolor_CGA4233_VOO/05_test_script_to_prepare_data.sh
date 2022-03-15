#!/bin/sh

cat  03_json_raw.json | jq '.data.USTbl' | sed s/PowerLevel/TxPwr/ | sed s/ChannelID/TxChannelID/ | sed s/id/01Discard/ | sed s/Frequency/02Discard/ | sed s/ChannelType/03Discard/ | sed s/SymbolRate/04Discard/ | sed s/Modulation/05Discard/ | sed s/LockStatus/06Discard/ > shstatsfile_ust

cat  03_json_raw.json | jq '.data.DSTbl' | sed s/PowerLevel/RxPwr/  | sed s/ChannelID/RxChannelID/ | sed s/Correcteds/TxT3Out/ | sed s/Frequency/TxT4Out/ | sed s/Uncorrectables/RxPstRs/ | sed s/SNRLevel/RxSnr/ | sed s/id/01Discard/  | sed s/Frequency/02Discard/ | sed s/Modulation/03Discard/ | sed s/Octets/04Discard/ | sed s/LockStatus/05Discard/ | sed s/ChannelType/06Discard/ > shstatsfile_dst

cat shstatsfile_ust shstatsfile_dst | sed 's/MHz//' | sed 's/dBmV//' | sed 's/dB//' | sed 's/"//g' | sed 's/:/,,/' | sed 's/ //g' | grep "^[A-Za-z]"  > 06_prepared_data_sample.txt

# rm -f shstatsfile_dst
# rm -f shstatsfile_ust
