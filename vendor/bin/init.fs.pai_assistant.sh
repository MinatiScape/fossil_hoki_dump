#!/vendor/bin/sh
#
# Copyright (c) 2022 Fossil Group, Inc.
# All Rights Reserved.
# Confidential and Proprietary - Fossil Group, Inc.
#

BIN_DIR="/vendor/bin"
LOG="${BIN_DIR}/log"

DEBUG_TAG="FS_PAI_ASSISTANT"

SETPROP="${BIN_DIR}/setprop"
GETPROP="${BIN_DIR}/getprop"

SKU_PROP="ro.vendor.oem.sku"
BRAND_PROP="ro.vendor.oem.brand"
PAI_PROP="ro.vendor.oem.key1"

FOSSIL_VENTURE="FTW4068 FTW4068V FTW4068I"

FOSSIL_WELLNESS_4069="FTW4069 FTW4069I FTW4069V"
FOSSIL_WELLNESS_4070="FTW4070 FTW4070I FTW4070V"
FOSSIL_WELLNESS_4071="FTW4071 FTW4071I FTW4071V"
FOSSIL_WELLNESS_4072="FTW4072SET FTW4072SETI FTW4072SETV"
FOSSIL_WELLNESS_4073="FTW4073SET FTW4073SETI FTW4073SETV"
FOSSIL_WELLNESS_4074="FTW4074SET FTW4074SETR FTW4074SETV"
FOSSIL_WELLNESS_4075="FTW4075SET FTW4075SETR FTW4075SETV"

FOSSIL_X_RAZER="FTW4065SET FTW4065VSET"

logi ()
{
        ${LOG} -t "${DEBUG_TAG}" -p i "${1}"
}

loge ()
{
        ${LOG} -t "${DEBUG_TAG}" -p e "${1}"
}

__fossil_processing__()
{
	B="${1}"
	S="${2}"

	if [ "$(echo ${FOSSIL_VENTURE} | grep -cw "${S}")"  -ge "1" ]; then

		logi "FOSSIL_VENTURE # key1: FossilFTW4068"
		eval "${SETPROP} ${PAI_PROP} "FossilFTW4068"" || loge "setprop ${PAI_PROP} was failured."

	elif [ "$(echo ${FOSSIL_WELLNESS_4069} | grep -cw "${S}")"  -ge "1" ]; then

		logi "FOSSIL_WELLNESS_4069 # key1: FossilFTW4069"
		eval "${SETPROP} ${PAI_PROP} "FossilFTW4069"" || loge "setprop ${PAI_PROP} was failured."

	elif [ "$(echo ${FOSSIL_WELLNESS_4070} | grep -cw "${S}")"  -ge "1" ]; then

		logi "FOSSIL_WELLNESS_4070 # key1: FossilFTW4070"
		eval "${SETPROP} ${PAI_PROP} "FossilFTW4070"" || loge "setprop ${PAI_PROP} was failured."

	elif [ "$(echo ${FOSSIL_WELLNESS_4071} | grep -cw "${S}")"  -ge "1" ]; then

		logi "FOSSIL_WELLNESS_4071 # key1: FossilFTW4071"
		eval "${SETPROP} ${PAI_PROP} "FossilFTW4071"" || loge "setprop ${PAI_PROP} was failured."

	elif [ "$(echo ${FOSSIL_WELLNESS_4072} | grep -cw "${S}")"  -ge "1" ]; then

		logi "FOSSIL_WELLNESS_4072 # key1: FossilFTW4072"
		eval "${SETPROP} ${PAI_PROP} "FossilFTW4072"" || loge "setprop ${PAI_PROP} was failured."

	elif [ "$(echo ${FOSSIL_WELLNESS_4073} | grep -cw "${S}")"  -ge "1" ]; then

		logi "FOSSIL_WELLNESS_4073 # key1: FossilFTW4073"
		eval "${SETPROP} ${PAI_PROP} "FossilFTW4073"" || loge "setprop ${PAI_PROP} was failured."

	elif [ "$(echo ${FOSSIL_WELLNESS_4074} | grep -cw "${S}")"  -ge "1" ]; then
		logi "FOSSIL_WELLNESS_4074 # key1: FossilFTW4074"
		eval "${SETPROP} ${PAI_PROP} "FossilFTW4074"" || loge "setprop ${PAI_PROP} was failured."

	elif [ "$(echo ${FOSSIL_WELLNESS_4075} | grep -cw "${S}")"  -ge "1" ]; then
		logi "FOSSIL_WELLNESS_4075 # key1: FossilFTW4075"
		eval "${SETPROP} ${PAI_PROP} "FossilFTW4075"" || loge "setprop ${PAI_PROP} was failured."

	else
		logi "Not Specific SKU from Fossil brand"
		logi "Fossil brand: key1: ${B}${S:0:5}xx"
		eval "${SETPROP} ${PAI_PROP} ${B}${S:0:5}xx" || loge "setprop ${PAI_PROP} was failured."
	fi

}

__razer_processing__()
{
	B="${1}"
        S="${2}"

        if [ "$(echo ${FOSSIL_X_RAZER} | grep -cw "${S}")"  -ge "1" ]; then
                logi "FOSSIL_X_RAZER: - key1: FossilxRazer40xx"
                eval "${SETPROP} ${PAI_PROP} "FossilxRazer40xx"" || loge "setprop ${PAI_PROP} was failured."
	else
		logi "Not Specific SKU from FossilxRazer brand"
		logi "FossilxRazer brand: key1: ${B}${S:3:2}xx"
		eval "${SETPROP} ${PAI_PROP} ${B}${S:3:2}xx" || loge "setprop ${PAI_PROP} was failured."
	fi
}

__citizen_processing__()
{
	B="${1}"
        S="${2}"

	logi "Citizen brand: key1: ${B}${S:0:5}0xx"
	eval "${SETPROP} ${PAI_PROP} ${B}${S:0:5}0xx" || loge "setprop ${PAI_PROP} was failured."

}

__common_processing__()
{
	B="${1}"
        S="${2}"

	logi "Common brand: key1: ${B}${S:0:5}xx"
	eval "${SETPROP} ${PAI_PROP} ${B}${S:0:5}xx" || loge "setprop ${PAI_PROP} was failured."
}

BRAND=$(${GETPROP} ${BRAND_PROP})
SKU=$(${GETPROP} ${SKU_PROP})

logi "SKU: ${SKU}"
logi "BRAND: ${BRAND}"

case "${BRAND}" in
	"Fossil")		logi "Detected brand: Fossil"
				__fossil_processing__ "${BRAND}" "${SKU}"
				;;
	"FossilxRazer")		logi "Detected brand: FossilxRazer"
				__razer_processing__ "${BRAND}" "${SKU}"
				;;
	"MK")			logi "Detected brand: MK"
				__common_processing__ "${BRAND}" "${SKU}"
				;;
	"DS")			logi "Detected brand: DS"
				__common_processing__ "${BRAND}" "${SKU}"
				;;
	"SK")			logi "Detected brand: SK"
				__common_processing__ "${BRAND}" "${SKU}"
				;;
	"CZ" | "CTZ")		logi "Detected brand: CZ"
				__citizen_processing__ "${BRAND}" "${SKU}"
				;;
	*)			loge "Can not detected brand: ${BRAND}"
				exit 1;;
esac

exit 0
