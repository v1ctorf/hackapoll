#!/bin/sh

COUNTRIES="AR AU AT BE BR BG BF CA CZ CR DK EE FI FR DE GR HK IS IN IE IL IT JP JP-FREE KR LV LT LU MD MX"
COUNTRIES="${COUNTRIES} NL NL-FREE NZ NO PL PT RO RU RS SG SK ZA ES SE CH TW TR UA AE UK US-FREE US-CA US-FL"
COUNTRIES="${COUNTRIES} US-GA US-IL US-NJ US-NY US-TX US-UT US-VA US-GA"

#sudo protonvpn init

printf "\nenter uri:\n"
read URI

printf "\nenter params:\n"
read PARAMS

for run in $COUNTRIES
do
    for svr in {1..120}
    do
        printf "\ntrying server $run#$svr...\n"

        if sudo protonvpn c "$run#$svr" -p tcp | grep "Connected!"
        then
            printf "\nsending POST request...\n"
            curl -d "${PARAMS}" "${URI}"
            printf "\ndisconnecting...\n"
            sudo protonvpn disconnect
        else
            printf "\nconnection server $run#$svr failed or does not exist.\n"
        fi

    done
done