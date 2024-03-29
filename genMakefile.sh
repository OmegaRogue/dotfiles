#!/bin/sh

CURRENT_DIR=$(dirname -- "$( readlink -f -- "$0"; )";)
CURRENT_DIR_PATH=${CURRENT_DIR//${HOME}/\$\{HOME\}}
PROFILE_PREFIX="profile_"
CONFIG_PREFIX="config_"
PROFILE_SCRIPT="${CURRENT_DIR}/install-profile"
CONFIG_SCRIPT="${CURRENT_DIR}/install-standalone"
PROFILE_DIR="${CURRENT_DIR}/meta/profiles"
CONFIG_DIR="${CURRENT_DIR}/meta/configs"
PROFILE_NAME_REPLACER="PROFILENAMEHERE"
CONFIG_NAME_REPLACER="CONFIGNAMEHERE"
HELP_NAME_SEPERATOR=", "
HELP_TEXT=$(printf "default: gen\n\t@echo 'profiles: ${PROFILE_NAME_REPLACER}'\n\t@echo 'configs: ${CONFIG_NAME_REPLACER}'\n")
GEN_SECTION=$(printf "gen:\n\t@${CURRENT_DIR//${HOME}/\$\{HOME\}}/genMakefile.sh")
CONFIGS_SECTION=""
PROFILES_SECTION=""
for config in $(command ls ${CONFIG_DIR})
do
	config=${config%.*}
	HELP_TEXT="${HELP_TEXT//${CONFIG_NAME_REPLACER}/${config}${HELP_NAME_SEPERATOR}${CONFIG_NAME_REPLACER}}"
	CONFIGS_SECTION=$(printf "${CONFIGS_SECTION}\n${CONFIG_PREFIX}${config}: gen\n\t${CONFIG_SCRIPT//${HOME}/\$\{HOME\}} ${config}")
done

HELP_TEXT="${HELP_TEXT//${HELP_NAME_SEPERATOR}${CONFIG_NAME_REPLACER}/}"

for profile in $(command ls ${PROFILE_DIR})
do
	HELP_TEXT="${HELP_TEXT//${PROFILE_NAME_REPLACER}/${profile}${HELP_NAME_SEPERATOR}${PROFILE_NAME_REPLACER}}"
	PROFILES_SECTION=$(printf "${PROFILES_SECTION}\n${PROFILE_PREFIX}${profile}: gen\n\t${PROFILE_SCRIPT//${HOME}/\$\{HOME\}} ${profile}")
done

HELP_TEXT="${HELP_TEXT//${HELP_NAME_SEPERATOR}${PROFILE_NAME_REPLACER}/}"

printf "${GEN_SECTION}\n${HELP_TEXT}\n${PROFILES_SECTION}\n${CONFIGS_SECTION}" > ${CURRENT_DIR}/Makefile
printf "${CURRENT_DIR}" >${CURRENT_DIR}/.dirname
