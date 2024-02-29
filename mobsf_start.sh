#!/bin/bash

Help()
{
   # Display Help
   echo "Script to run the mobsf docker container."
   echo
   echo "usage: mobsf_start.sh [option]"
   echo "options:"
   echo "-d ADB_DEVICE   : Start with dynamic analysis for ADB device identifier."
   echo "-s              : DEFAULT - start docker container in static analysis only mode."
   echo "-h              : Print this Help."
   echo
}


while getopts ':d:hs' OPTION; do
    case $OPTION in
        d )
            docker run -it --rm --name mobsf -p 8000:8000 -p 1337:1337 -e MOBSF_ANALYZER_IDENTIFIER=$OPTARG -v mobsf:/home/mobsf/.MobSF opensecurity/mobile-security-framework-mobsf:latest
            exit;;
        h )
            Help
            exit;;
        s )
            docker run -it --rm --name mobsf -p 8000:8000 -v mobsf:/home/mobsf/.MobSF opensecurity/mobile-security-framework-mobsf:latest
            exit;; 
        : )
            echo error "Option -$OPTARG requires an argument."
            exit 1;;
        \? )
            echo "Usage: $(basename $0) [-d] [-h] [-s]"
            exit 1;;
    esac
done

if (( $OPTIND == 1 )); then
   docker run -it --rm --name mobsf -p 8000:8000 -v mobsf:/home/mobsf/.MobSF opensecurity/mobile-security-framework-mobsf:latest
   exit
fi



