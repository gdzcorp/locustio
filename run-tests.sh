#!/bin/sh
LOCUST="/usr/bin/locust"
LOCUST_OPTS="-f /locust/locustfile.py --host=$TARGET_HOST"
LOCUST_MODE=${LOCUST_MODE:-standalone}

if [[ "$LOCUST_MODE" = "master" ]]; then
    LOCUST_OPTS="$LOCUST_OPTS --master"
elif [[ "$LOCUST_MODE" = "worker" ]]; then
    LOCUST_OPTS="$LOCUST_OPTS --slave --master-host=$LOCUST_MASTER"
fi

$LOCUST $LOCUST_OPTS