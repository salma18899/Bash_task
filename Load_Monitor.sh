#! /bin/bash

        ############# Monitor the average load of the system ################

LOAD1MIN=$(uptime | awk '{ print $8 }'| awk 'BEGIN{FS=","} {print $1}') ### select the 1 minute average load
LOAD5MIN=$(uptime | awk '{ print $9 }'| awk 'BEGIN{FS=","} {print $1}') ### select the 5 minute average load
LOAD15MIN=$(uptime | awk '{ print $10 }'| awk 'BEGIN{FS=","} {print $1}') ### select the 15 minute average load

        ###########check if there is high load (increases)#############################

if  [ `echo "${LOAD1MIN} > ${LOAD5MIN}" | bc` == 1 ] || [ `echo "${LOAD1MIN} > ${LOAD15MIN}" | bc` == 1 ]

then
        ################# Add the load , and date to a log file /var/log/systemLoad ################

echo | awk "{ print \"The load average over the last one minute is \" \"${LOAD1MIN}\"; print \"\nThis event happened at $(date)\"}" > /var/log/systemLoad

        ################# write event to an event file /tmp/events #######################

echo | awk "{ print \"Subject: Server $(hostname -I)load\nBody:\n\tDear,\";print \"\n\t\tThe system $(hostname) runs with IP $(hostname -I)has a load of\"; print \"\t\t1MIN load:\" ${LOAD1MIN}; print \"\t\t5MIN load:\" ${LOAD5MIN};print \"\t\t15MIN load:\" ${LOAD15MIN};print \"\tThank you.\" }" > /tmp/events

fi
