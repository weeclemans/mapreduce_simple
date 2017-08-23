#!/bin/bash


NUM_COLUMNS=`head -1 $1 | awk 'END {print NF}'`
#printf $NUM_COLUMNS

rm -f /tmp/testpipe*

#echo Stage 0

for cpipes in `seq 1 $NUM_COLUMNS`;
do mkfifo /tmp/testpipe_r_${cpipes}; mkfifo /tmp/testpipe_w_${cpipes};
done;

#echo Stage 1

#awk '{ for (i = 1; i <= NF; i++) { out="/tmp/testpipe_r_"i; print $i > out } }' $1 >/dev/null 2>&1 &
(printf "{ "; for ((i=1;i<=NUM_COLUMNS;i++)); do printf "print \$$i > \"/tmp/testpipe_r_$i\"; "; done; printf "}\n") > threads.awk 
awk -f threads.awk $1 >/dev/null 2>&1 &
pids="$!"

#echo Stage 2

for cpipes in `seq 1 $NUM_COLUMNS`;
do
 #./increment.sh /tmp/testpipe_r_${cpipes} /tmp/testpipe_w_${cpipes} >/dev/null 2>&1 &
 ./increment < /tmp/testpipe_r_${cpipes} >> /tmp/testpipe_w_${cpipes} 2>/dev/null &
 pids="$pids $!"
done;

#echo Stage 3

pipes_w=`seq 1 ${NUM_COLUMNS} | xargs -I {} echo "/tmp/testpipe_w_{}"`
#echo $pipes_w

paste -d' ' $pipes_w
wait $pids

rm -f ./threads.awk /tmp/testpipe*

