#!/vendor/bin/sh

BIN_DIR="/vendor/bin"

LOG="${BIN_DIR}/log"

DEFAULT_RES="0x7e"
OTS_PATH="/mnt/vendor/persist/ots"
RES_CONFIG_PATH="/sys/devices/platform/soc/soc:qcom,bg-rsb/enable"

DEBUG_TAG="RSB_CALIB"

logi ()
{
        ${LOG} -t "${DEBUG_TAG}" -p i "${1}"
}

loge ()
{
        ${LOG} -t "${DEBUG_TAG}" -p e "${1}"
}

logi "Reading rsb persist data"
str=$(cat ${OTS_PATH})
logi "OTS RES : ${str}"

calibrated=(${str:0:1})
logi "OTS Calibrated : ${calibrated}"

if [[ $calibrated = "0" ]]; then
	res_x=(${DEFAULT_RES:2:2})
	logi "Not Calibrated. res_x=0x${res_x}"
elif [[ $calibrated = "1" ]]; then
	res_x=(${str:2:2})
	logi "Calibrated. res_x=0x${res_x}"
else
	res_x=(${DEFAULT_RES:2:2})
	echo "Unknown status. res_x=0x${res_x}"
fi

res_x=$((num=16#$res_x))
logi "Write initial resolution: res_x = ${res_x}(in DEC)"
echo 2:7:${res_x} > ${RES_CONFIG_PATH}

sleep 1; logi "Calibration success !!"

exit 0
