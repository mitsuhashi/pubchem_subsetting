#!/bin/sh
#set -euo pipefail

# 変更される可能性がある変数 
ENDPOINT=https://rdfportal.org/pubchem/sparql
EBI_ENDPOINT=https://rdfportal.org/ebi/sparql
FINAL_DESTINATION=/mnt/nas05/togodx/pubchem/2024-02-20
WORK_DIR=/tmp/pubchem_fdaapproved_neighbours

# 変更が不要と思われる変数
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OUT_DIR=FDA_ChEBI-cids
TIMESTAMP=$(date -I)
CURL=/usr/bin/curl
PERL=/usr/bin/perl
XARGS=/usr/bin/xargs
SORT=/usr/bin/sort
FIND=/usr/bin/find
RAPPER=/usr/bin/rapper
GREP=/usr/bin/grep
SED=/usr/bin/sed
TIMESTAMP=2024-02-20
LIMIT=1000000
CID_LIST=FDA_ChEBI_cids_${TIMESTAMP}.txt
CID_FROM_CHEMBL_LIST=cids_from_ChEMBL_${TIMESTAMP}.txt
CID4SUBSET=cids4subset_${TIMESTAMP}.txt

mkdir -p $FINAL_DESTINATION

cd $WORK_DIR

#mv skos_concept_${TIMESTAMP}.nt ${OUT_DIR}/
#cp -p skos_concept_${TIMESTAMP}.nt ${OUT_DIR}/
echo "AAA"
#$FIND ${OUT_DIR}-attrs -type f -name \*.ttl | $XARGS -P20 -i sh -c "F=\$(basename {} .ttl); $RAPPER -i turtle -o ntriples {} 2> /dev/null > ${OUT_DIR}/\${F}.nt"
$FIND ${OUT_DIR}-attrs -type f -name \*.ttl | $XARGS -P20 -i sh -c "F=\$(basename {} .ttl); $RAPPER -i turtle -o ntriples {} > ${OUT_DIR}/\${F}.nt"
date
echo "BBB"
$FIND ${OUT_DIR} -type f -exec cat "{}" \; | sort --parallel=20 --compress-program=gzip -S12G -u | gzip -9c > ${FINAL_DESTINATION}/pubchem_subset_slim_${TIMESTAMP}.nt.gz
echo "CCC"
