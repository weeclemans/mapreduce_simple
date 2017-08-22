#!/bin/bash


NUM_COLUMNS=`awk 'END {print NF}' $1`
#printf $NUM_COLUMNS

rm -f /tmp/testpipe*

for cpipes in `seq 1 $NUM_COLUMNS`;
do mkfifo /tmp/testpipe_r_${cpipes}; mkfifo /tmp/testpipe_w_${cpipes};
done;

awk '{ for (i = 1; i <= NF; i++) { out="/tmp/testpipe_r_"i; print $i > out } }' $1 >/dev/null 2>&1 &
pids="$!"

for cpipes in `seq 1 $NUM_COLUMNS`;
do ./increment.sh /tmp/testpipe_r_${cpipes} /tmp/testpipe_w_${cpipes} >/dev/null 2>&1 &
pids="$pids $!"
done;

pipes_w=`seq 1 ${NUM_COLUMNS} | xargs -I {} echo "/tmp/testpipe_w_{}"`
#echo $pipes_w
paste -d' ' $pipes_w
wait $pids






