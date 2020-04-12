#!/bin/sh

loop_server_list()
{
    LCOUNTRIES=$1
    LMAXSVR=$2
    LURI=$3
    LPARAMS=$4

    for run in $LCOUNTRIES
    do
        for (( svr=2; svr <= $LMAXSVR; ++svr ))
        do
            printf "\ntrying server $run#$svr... "

            if sudo protonvpn c "$run#$svr" -p tcp | grep "Connected!"
            then
                printf "\nsending POST request...\n"
                curl -d "${LPARAMS}" "${LURI}"
                printf "\ndisconnecting...\n"
                sudo protonvpn disconnect
            else
                printf "\nconnection server $run#$svr failed or does not exist.\n"
            fi

        done
    done
}

COUNTRIES="AR AU AT BE BR BG BF CA CZ CR DK EE FI FR DE GR HK IS IN IE IL IT JP JP-FREE KR LV LT LU MD MX"
COUNTRIES="${COUNTRIES} NL-FREE NZ NO PL PT RO RU RS SG SK ZA ES SE CH TW TR UA AE UK US-FREE"
COUNTRIES_XL="NL US-CA US-FL US-GA US-IL US-NJ US-NY US-TX US-UT US-VA US-GA"

#sudo protonvpn init
#sudo bash hackapoll.sh

printf "\nenter uri:\n"
read URI

printf "\nenter params:\n"
read PARAMS

loop_server_list "${COUNTRIES_XL}" 150 "${URI}" "${PARAMS}"
loop_server_list "${COUNTRIES}" 40 "${URI}" "${PARAMS}"
