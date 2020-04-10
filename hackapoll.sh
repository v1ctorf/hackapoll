#!/bin/sh

COUNTRIES="AR AU AT BE BR BG BF CA CZ CR DK EE FI FR DE GR HK IS IN IE IL IT JP JP-FREE KR LV LT LU MD MX NL NZ NO"
COUNTRIES="${COUNTRIES} PL PT RO RU RS SG SK ZA ES SE CH TW TR UA AE UK US-FREE US-CA US-FL US-GA US-IL US-NJ"
COUNTRIES="${COUNTRIES} US-NY US-TX US-UT US-VA US-GA"

for run in $COUNTRIES
do
    for svr in {1..120}
    do
        echo "server $run#$svr..."
        if sudo protonvpn c "$run#$svr" -p tcp | grep "Connected!"; then
          sudo protonvpn status;
          curl -d "action=polls&view=process&poll_id=6&poll_6=18&poll_6_nonce=2e73782227" https://vidadestra.org/wp-admin/admin-ajax.php;
          sudo protonvpn disconnect;
        fi
    done
done