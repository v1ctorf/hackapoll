#!/bin/sh

get_params()
{
    LINE=$1
    echo $(awk NR==$LINE params)
}

loop_server_list()
{
    LCOUNTRIES=$1
    LMAXSVR=$2
    LURI=$3

    for run in $LCOUNTRIES
    do
        for (( svr=1; svr <= $LMAXSVR; ++svr ))
        do
            printf "\ntrying server $run#$svr...\n"

            if sudo protonvpn c "$run#$svr" -p tcp | grep "Connected!"
            then
                LPARAMS=$(get_params 1)
                printf "\nsending POST request with params:\n=> ${LPARAMS}\n"
                curl -d "${LPARAMS}" "${LURI}" -m 30.0 --connect-timeout 30.0
                printf "\ndisconnecting...\n"
                sudo protonvpn disconnect
            else
                printf "connection server $run#$svr failed or does not exist.\n"
            fi

        done
    done
}

COUNTRIES="BG AR AU AT BE BR BF CA CZ CR DK EE FI FR DE GR HK IS IN IE IL IT JP JP-FREE KR LV LT LU MD MX"
COUNTRIES="${COUNTRIES} NL-FREE NZ NO PL PT RO RU RS SG SK ZA ES SE CH TW TR UA AE UK US-FREE"
COUNTRIES_XL="NL US-CA US-FL US-GA US-IL US-NJ US-NY US-TX US-UT US-VA US-GA"

printf "\nenter endpoint:\n"
read URI

loop_server_list "${COUNTRIES}" 40 "${URI}"
loop_server_list "${COUNTRIES_XL}" 150 "${URI}"
