
export JOBNAME=$parsl.localprovider.1626121882.662812
set -e
export CORES=$(getconf _NPROCESSORS_ONLN)
[[ "1" == "1" ]] && echo "Found cores : $CORES"
WORKERCOUNT=1
FAILONANY=0
PIDS=""

CMD() {
process_worker_pool.py --debug  -a Veds-MacBook-Pro.local,73.211.248.63,192.168.1.6 -p 0 -c 1 -m None --poll 100 --task_port=54809 --result_port=54538 --logdir=/Users/vedkommalapati/Documents/GitHub/Parsl/runinfo/002/htex_Local --block_id=0 --hb_period=2  --hb_threshold=5 --cpu-affinity none 
}
for COUNT in $(seq 1 1 $WORKERCOUNT); do
    [[ "1" == "1" ]] && echo "Launching worker: $COUNT"
    CMD $COUNT &
    PIDS="$PIDS $!"
done

ALLFAILED=1
ANYFAILED=0
for PID in $PIDS ; do
    wait $PID
    if [ "$?" != "0" ]; then
        ANYFAILED=1
    else
        ALLFAILED=0
    fi
done

[[ "1" == "1" ]] && echo "All workers done"
if [ "$FAILONANY" == "1" ]; then
    exit $ANYFAILED
else
    exit $ALLFAILED
fi
