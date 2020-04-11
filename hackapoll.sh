#!/bin/sh

COUNTRIES="AR AU AT BE BR BG BF CA CZ CR DK EE FI FR DE GR HK IS IN IE IL IT JP JP-FREE KR LV LT LU MD MX NL NZ NO"
COUNTRIES="${COUNTRIES} PL PT RO RU RS SG SK ZA ES SE CH TW TR UA AE UK US-FREE US-CA US-FL US-GA US-IL US-NJ"
COUNTRIES="${COUNTRIES} US-NY US-TX US-UT US-VA US-GA"

#sudo protonvpn init

echo "enter uri:"
read URI
# https://vidadestra.org/wp-admin/admin-ajax.php

echo "enter params:"
read PARAMS
# action=polls&view=process&poll_id=6&poll_6=18&poll_6_nonce=2e73782227

for run in $COUNTRIES
do
    for svr in {1..120}
    do
        sudo protonvpn status;
        echo "trying server $run#$svr..."

        if sudo protonvpn c "$run#$svr" -p tcp | grep "Connected!"
        then
            curl -d "${PARAMS}" "${URI}";
            sudo protonvpn disconnect;
        else
            echo "connection server $run#$svr failed or does not exist."
        fi

    done
done